Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73986394493
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252386; cv=none; b=KjB/koeeCAJyCquLJ+R+9+7bukfkjmjoN9sYd5ZyVVWKVasDL/+ub8oAiVFfORNyW/iDxxQxLg/PZyUVO1V6AAK9hNv0zCBYoKhp8jCATWxXoXoZ3XP1leSaciWBRKpYUwW33oQKW/B9/Lh8FpoW+E+9yt/+udU40OLurpD70v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252386; c=relaxed/simple;
	bh=PUOvt7FF7/I7gOCtkjI+A2v2hzwCRRFf0vp3upFyDek=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LUaiqaptpQ6WCTvc9I14xkSVxmSl1Lf7m8nuVRnXVBgkWArE1xPmgknsi3Y0TdO8ayaxmNlqJri7+Ves2327XzyU84KCjNaDUq5HWtDGceKCbWAdycLpbs7UCI5Jf/3b+9is8mbbQJ95pJ6cjcQ9+02+fSlVvKTSwlTzNMLA2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=T8W52P/Z; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="T8W52P/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787252383;
	bh=AYPlkapPtdEDNY6VUKM+FsGN7nip3HsK5SRCY0QGNmE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=T8W52P/ZbAPxRdMBwKpl2GxgXKwGc2Z0zVdi1tzVb9YBib2ZRYoBVKRq7A0rAmxc2
	 54TYfUJvu4/JPlGJ1hcCbJx6YmYz4RzUROvu3TrbVzKV1pbhPG5vMYIIhETwSfVQef
	 122z8wSwA5mvGfYkpAsfmGoIk8dPswJmmS/kMYjE=
Received: from github.com (hubbernetes-node-bdfe5d7.ac4-iad.github.net [10.52.172.39])
	by smtp.github.com (Postfix) with ESMTPA id 93F4FA061E
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:59:43 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:59:43 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149265/000000-4ae582@github.com>
Subject: [bluez/bluez] 215778: eir: Fix stack buffer overflow when parsing the
 re...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1149265
  Home:   https://github.com/bluez/bluez
  Commit: 215778b4c7a3cb0a91b883d14694173c5655cc4a
      https://github.com/bluez/bluez/commit/215778b4c7a3cb0a91b883d146941=
73c5655cc4a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M src/eir.c

  Log Message:
  -----------
  eir: Fix stack buffer overflow when parsing the remote name

name2utf8() copies len bytes into a HCI_MAX_NAME_LENGTH + 2, so 250,
byte stack buffer without clamping len first.

eir_parse() only rejects a field once it runs past the end of the EIR
data, and that data is up to 255 bytes, so field_len can be 254 and the
data_len passed to name2utf8() can reach 253. strncpy() then writes 253
bytes into the 250 byte buffer and leaves it unterminated, so the
following g_strstrip() and g_strdup() also read past the end.

The EIR data comes from a remote device, either in an extended inquiry
response or in an advertising report, so the length is attacker
controlled.

Clamp len to HCI_MAX_NAME_LENGTH, which is what the local name is
limited to anyway, and what ad_replace_name() already clamps to.

Fixes: https://github.com/bluez/bluez/security/advisories/GHSA-68h6-5qgp-=
3975
Assisted-by: Claude:claude-opus-5


  Commit: a804ade263f80131db49c8a58e2be1e6a934889c
      https://github.com/bluez/bluez/commit/a804ade263f80131db49c8a58e2be=
1e6a934889c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M src/shared/ad.c

  Log Message:
  -----------
  shared/ad: Fix reading past the name that was copied

ad_replace_name() copies at most HCI_MAX_NAME_LENGTH bytes of the name
into its buffer, but then hands the full iov_len to strisutf8() and
strtoutf8().

The advertising data is up to 255 bytes, so a complete local name field
can hold 253 of them, and both end up reading 253 bytes out of a 250
byte buffer, 3 of them past its end.

Use the same clamped length throughout.

Assisted-by: Claude:claude-opus-5


  Commit: 96b55d3d5b445e883fada9a8b7149c71d410d3c9
      https://github.com/bluez/bluez/commit/96b55d3d5b445e883fada9a8b7149=
c71d410d3c9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M unit/test-eir.c

  Log Message:
  -----------
  unit/test-eir: Add tests for the longest local names

Nothing covered a name anywhere near the size of the buffer it is copied
into, which is why the missing clamp went unnoticed.

Add two tests. The first uses a name of HCI_MAX_NAME_LENGTH bytes, the
longest one that fits, to pin the boundary down.

The second uses a name of 253 bytes, as large as eir_parse() can be
handed given the EIR length is a single byte, and which does not fit.
Run against the code before the previous patch, it dies with

  *** buffer overflow detected ***: terminated

Assisted-by: Claude:claude-opus-5


  Commit: f7fdb01677185f40d34283a3a926d11af6a585c2
      https://github.com/bluez/bluez/commit/f7fdb01677185f40d34283a3a926d=
11af6a585c2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M src/shared/util.c

  Log Message:
  -----------
  shared/util: Make strnlenutf8 reject ill-formed sequences

strnlenutf8() only checks the shape of the lead byte and that the
following bytes are continuation bytes, so it accepts sequences that are
not well-formed UTF-8:

  C0 80        overlong encoding of U+0000
  C0 AF        overlong encoding of '/'
  ED A0 80     UTF-16 surrogate U+D800
  F5 80 80 80  past the U+10FFFF limit

strisutf8() and strtoutf8() are built on it, so a remote name containing
any of those is considered valid and passed on unchanged, for instance
to D-Bus, which does validate UTF-8 strictly and rejects them.

Validate the sequences as defined by table 3-7 of the Unicode Standard
instead, which constrains the range of the second byte for the E0, ED,
F0 and F4 lead bytes and rejects the C0, C1 and F5 to FF ones outright.

The decoding is split out into a helper that also reports the size of
the maximal subpart of an ill-formed sequence, so that callers can skip
over it, as recommended by section 3.9 of the Unicode Standard.

Assisted-by: Claude:claude-opus-5


  Commit: 52c9fed403e32368dadac57ee49b33122fa04b2d
      https://github.com/bluez/bluez/commit/52c9fed403e32368dadac57ee49b3=
3122fa04b2d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Add str2utf8

There are five near copies of the same "turn a remote name into a UTF-8
string" helper, in monitor/att.c, profiles/audio/mcp.c, profiles/gap/gas.=
c,
src/eir.c and src/shared/ad.c, and they do not agree with each other.

Most truncate at the first ill-formed sequence, which throws away the
rest of the name, while the monitor replaces every non-ASCII byte with a
space, which mangles perfectly valid UTF-8 names as soon as one bad byte
appears. Most also copy into a fixed size stack buffer first, which is
what made the missing clamp in src/eir.c a buffer overflow.

Add a single helper they can share. It allocates the result, so there is
no truncation to a buffer size, and replaces each ill-formed sequence
with U+FFFD REPLACEMENT CHARACTER rather than dropping the rest of the
string, matching what g_utf8_make_valid() and the WHATWG Encoding
Standard do.

The result has been checked byte for byte against Python's
bytes.decode('utf-8', errors=3D'replace') over all one and two byte
sequences, a sample of the three byte ones and 200000 random inputs.

Assisted-by: Claude:claude-opus-5


  Commit: 6b92d26ec459c88cba798db9e8fe4280759d9db8
      https://github.com/bluez/bluez/commit/6b92d26ec459c88cba798db9e8fe4=
280759d9db8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M unit/test-util.c

  Log Message:
  -----------
  unit/test-util: Add str2utf8 tests

Cover the cases str2utf8() is meant to handle: well-formed input that
has to be left alone, whitespace stripping, input that is not NUL
terminated, and the ill-formed sequences that have to be replaced,
including the overlong encodings, the UTF-16 surrogates and the code
points past U+10FFFF.

Also check that a maximal subpart is replaced by a single U+FFFD rather
than one per byte, and that the result is always well-formed UTF-8.

Assisted-by: Claude:claude-opus-5


  Commit: f5461d4ff2c04c763af8821bceec7aacb4f2e773
      https://github.com/bluez/bluez/commit/f5461d4ff2c04c763af8821bceec7=
aacb4f2e773
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M monitor/att.c
    M profiles/audio/mcp.c
    M profiles/gap/gas.c
    M src/eir.c
    M src/shared/ad.c
    M unit/test-eir.c

  Log Message:
  -----------
  Replace the name2utf8 copies with str2utf8

monitor/att.c, profiles/audio/mcp.c, profiles/gap/gas.c and src/eir.c
each carried their own name2utf8(), and src/shared/ad.c open coded the
same thing in ad_replace_name(), with none of them agreeing.

Use the shared helper instead, which drops around 120 lines and gives
every caller the same behaviour.

Two things change as a result. The monitor used to replace every
non-ASCII byte with a space as soon as one bad byte appeared, mangling
the valid part of the name, and now only the ill-formed sequences are
replaced. Everything else used to truncate at the first ill-formed
sequence, throwing away the rest of the name, and now keeps it.

The unit/test-eir expectations are updated accordingly, and they show
the improvement: the name that used to be reported as "test =E0=A4=AA=E0=A4=
=B0=E0=A5=80" is now
reported as "test =E0=A4=AA=E0=A4=B0=E0=A5=80<U+FFFD>=E0=A5=8D=E0=A4=B7=E0=
=A4=BE invalid".

str2utf8() returns memory from malloc(), so the callers that used
g_free() now use free().

Assisted-by: Claude:claude-opus-5


  Commit: 98a29b131ff2f3a38b8664653b2ee751ec168c14
      https://github.com/bluez/bluez/commit/98a29b131ff2f3a38b8664653b2ee=
751ec168c14
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix the name truncation splitting UTF-8 sequences

btd_device_device_set_name() copies the name with

	strncpy(device->name, name, MAX_NAME_LENGTH);

which cuts at 248 bytes without any regard for where the UTF-8
characters start and end, so a longer name can be left with a partial
sequence. The result is no longer valid UTF-8 and D-Bus rejects it when
the Name property is emitted.

A name made of 249 U+FFFD characters is 747 bytes long and cutting it at
248 leaves a trailing "ef bf", two thirds of a character.

Truncate on a character boundary instead. The same name now ends up 246
bytes long and stays valid.

This also means a name that is not valid UTF-8 to begin with, as can be
had from the neard and sixaxis plugins, is now cut at the first
ill-formed sequence rather than passed on as is.

Assisted-by: Claude:claude-opus-5


  Commit: 9a651fb734167d46e40b4f3f5391dda6ed76722d
      https://github.com/bluez/bluez/commit/9a651fb734167d46e40b4f3f5391d=
da6ed76722d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M plugins/neard.c
    M plugins/sixaxis.c
    M profiles/gap/gas.c
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Rename btd_device_device_set_name to btd_device_set_name

The "device" was in there twice.

Assisted-by: Claude:claude-opus-5


  Commit: 4ae5822aec08e60db4a51df5df97a0f38fcf1554
      https://github.com/bluez/bluez/commit/4ae5822aec08e60db4a51df5df97a=
0f38fcf1554
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M unit/test-util.c

  Log Message:
  -----------
  unit/test-util: Cover strtoutf8 with the str2utf8 tests

strtoutf8() and str2utf8() are the two ways of dealing with a name that
is not valid UTF-8, so run them over the same inputs and keep the two
expected results side by side, which documents how they differ:
strtoutf8() truncates at the first ill-formed sequence and leaves the
whitespace alone, str2utf8() replaces the ill-formed sequences and
strips.

The expected results were checked against Python, taking the longest
prefix that decodes as strict UTF-8, over every one, two and three byte
sequence, 16646655 of them, with no mismatch.

Assisted-by: Claude:claude-opus-5


Compare: https://github.com/bluez/bluez/compare/215778b4c7a3%5E...4ae5822=
aec08

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
