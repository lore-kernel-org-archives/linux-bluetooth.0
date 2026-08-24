Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74D2366DA3
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584920; cv=none; b=CpOluaB0aqIqeCb+iAiKiMSEZMeFIUMj/foScCJea/OJxJWw9Gm1nTjSTPKmVIKgGw45XhnECpqKrp+XHEiAJcs1g10AYmzL3rmvKZROnrBxPK1MkuAxtEPZZfoEj/qNxqSnNYuJAglf4O7ZLbJCLznt2AjKESULhj8xCOo+NDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584920; c=relaxed/simple;
	bh=pIC3r4syPnvC5T8zqryBB41lfcvEpANBo2W4yI+XINs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PR0vhXOYudiXhS26ZXLIvROUxoTERSJchRnPoZRlgW3B+MCMXZnNj1l/krh+/r2KyOHhFB7NjaKK8Dnups4MX0WG/p0ENEOAFUtDcgLpoiAxITEJlxIMyWpjWC4oF3lvJRIH1+T2mWS1rRaDAbcb91MSNWYnWNuZQDUrq8CbTR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Xo8YFBJU; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Xo8YFBJU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787584917;
	bh=2QhFG93YzkJG41A9Rj+f3rbg+BjN09DrT0yxkApq0fs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Xo8YFBJUjR/nX9tuOjEMdSKmp7nRiJmX62JS/0IsS4Sj/OfEFqupzVvZtQQvhWdwE
	 fYDM5xh8qhi1m39SPhfayZiz2kqNStRgx55NfZPW/9kz5iPxDPPTDf5Mtj4+Pfsb/A
	 +M/C6yCCgC89RwRTwIB2hEzLB+UXyz2TpFoVLjLQ=
Received: from github.com (hubbernetes-node-042e7e1.ac4-iad.github.net [10.52.160.27])
	by smtp.github.com (Postfix) with ESMTPA id AC1BF4042B
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 08:21:57 -0700 (PDT)
Date: Mon, 24 Aug 2026 08:21:57 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c73fa2-df8f08@github.com>
Subject: [bluez/bluez] 381b5d: eir: Fix stack buffer overflow when parsing the
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 381b5d0d208972586282116d333865ba93b8dec2
      https://github.com/bluez/bluez/commit/381b5d0d208972586282116d33386=
5ba93b8dec2
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


  Commit: 784203160e2fb906090059336d86a24f28349b02
      https://github.com/bluez/bluez/commit/784203160e2fb906090059336d86a=
24f28349b02
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


  Commit: debd432ef13c5ea9ffab9ffcbfcb45372946920f
      https://github.com/bluez/bluez/commit/debd432ef13c5ea9ffab9ffcbfcb4=
5372946920f
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


  Commit: 3ad832a3c2a989ed9f14586cd3b56f40ad608679
      https://github.com/bluez/bluez/commit/3ad832a3c2a989ed9f14586cd3b56=
f40ad608679
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


  Commit: 11081f60d95f641ddbca4a53922d886972c87aa1
      https://github.com/bluez/bluez/commit/11081f60d95f641ddbca4a53922d8=
86972c87aa1
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


  Commit: 74c56dff2aa5d5f3cf41e446a0afeebb21ffc4e4
      https://github.com/bluez/bluez/commit/74c56dff2aa5d5f3cf41e446a0afe=
ebb21ffc4e4
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


  Commit: 8c81ab108b09154b884b1b0549dc9c23ffe3ec6f
      https://github.com/bluez/bluez/commit/8c81ab108b09154b884b1b0549dc9=
c23ffe3ec6f
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


  Commit: 2bf8286c4ebe6256b152c3adab6ea0fed8a834d9
      https://github.com/bluez/bluez/commit/2bf8286c4ebe6256b152c3adab6ea=
0fed8a834d9
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


  Commit: bef0faa312eeb83344bb2bead5bbbd0b538414e5
      https://github.com/bluez/bluez/commit/bef0faa312eeb83344bb2bead5bbb=
d0b538414e5
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


  Commit: f0e40c5b3e6af6974c44077ccd0cdc01a2172f30
      https://github.com/bluez/bluez/commit/f0e40c5b3e6af6974c44077ccd0cd=
c01a2172f30
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


  Commit: df8f0873a16ff1c6725806a44d8e36324d64e23f
      https://github.com/bluez/bluez/commit/df8f0873a16ff1c6725806a44d8e3=
6324d64e23f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-24 (Mon, 24 Aug 2026)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  tools/iso-tester: fix GIOChannel refcounting

iso_defer_accept_* consume the reference passed in.  g_io_add_watch gets
a reference.

Fix the refcounting accordingly. Also clear data->io_queue immediately
after the test, so the sockets get closed.

Not leaking references makes "ISO Connect Close - Success" to work
correctly again.


Compare: https://github.com/bluez/bluez/compare/c73fa2f9ae2d...df8f0873a1=
6f

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
