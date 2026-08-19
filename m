Received: from out-40.smtp.github.com (out-40.smtp.github.com [192.30.252.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A81DDA18
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172337; cv=none; b=kblBP0D1ovtfUJpIm5nw7tOkucZTqHqq6Il2oEV7QYeCHjGsX3gdtVmvjj6NNG5MNm35250PaX5nzfooYqcm2YM0cB0G7Ii29tn9fEeBMIFX52C1n2RmAcB80onstF6UvVQBjX/jmzgKqDVWcKvy1/DGGC2j8o0McfKIuQhZHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172337; c=relaxed/simple;
	bh=/2h8cvQnrEVd6R4GLQqByk2NS48xTSGgLMbfxh7hHJs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WLnS9JkF39ULurD9wkKkyn/psOcAHvAC1xkGETvixTFBODcvpRqunszqSP5HZtrIbGHzFFJ6gsaf52uIEJlyEasRakzhf5OnfVxiL22uQZd+jB6lA3nkAIvObMUJhIm0I73lBfJABEbofNC+/pWdHHGklAgbJ0wuWp6KOO3O63M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HXGuUAKp; arc=none smtp.client-ip=192.30.252.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HXGuUAKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787172334;
	bh=4lt8sD5AyjCTOhhzN0+2VPZW7xctlCB6oe+WrDqjD2w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HXGuUAKp7iZ8TX6H/QQHQj3UQCcNsJAF8ELNWVAbuA2OWWlHvhCSubC27cSswTDlr
	 YzgJ+ByRzru5KtSZ8E0X1CQzj2NKmqUziDL7lW1CZR9JnHVfyDpjdWTrZW6kaeZ6Ys
	 ab90DvOG8K/xDzyqlW3Bqve6WAmSVl59KQvcp6GQ=
Received: from github.com (hubbernetes-node-bc77e5c.ash1-iad.github.net [10.56.206.36])
	by smtp.github.com (Postfix) with ESMTPA id 6BC7A920860
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 13:45:34 -0700 (PDT)
Date: Wed, 19 Aug 2026 13:45:34 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1148699/000000-d917c2@github.com>
Subject: [bluez/bluez] dcf17f: eir: Fix stack buffer overflow when parsing the
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

  Branch: refs/heads/1148699
  Home:   https://github.com/bluez/bluez
  Commit: dcf17f0d657b62052945e214d592a703388e8c2b
      https://github.com/bluez/bluez/commit/dcf17f0d657b62052945e214d592a=
703388e8c2b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

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

Clamp len like the other name2utf8() copies already do. Parsing a 253
byte EIR_NAME_COMPLETE field returned a 253 byte name before this
change, and returns a 249 byte one after it.

Assisted-by: Claude:claude-opus-5


  Commit: 187b0d78e5d3ac36b3be92b010384a0186f8ebd8
      https://github.com/bluez/bluez/commit/187b0d78e5d3ac36b3be92b010384=
a0186f8ebd8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

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


  Commit: f0fa6fffc5565880ab3a7e7dac534b824bc5024b
      https://github.com/bluez/bluez/commit/f0fa6fffc5565880ab3a7e7dac534=
b824bc5024b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

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


  Commit: 1977f8616adc6538ce255a00780878ab01a35b5d
      https://github.com/bluez/bluez/commit/1977f8616adc6538ce255a0078087=
8ab01a35b5d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

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


  Commit: 762585f48fe9da48602d49df89b364ce60d95236
      https://github.com/bluez/bluez/commit/762585f48fe9da48602d49df89b36=
4ce60d95236
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

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


  Commit: e60d89e101c246d132a67ce62fd9d1409b6bc420
      https://github.com/bluez/bluez/commit/e60d89e101c246d132a67ce62fd9d=
1409b6bc420
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

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


  Commit: abaab92606f10aa20e8db894d4aeb886f2c42511
      https://github.com/bluez/bluez/commit/abaab92606f10aa20e8db894d4aeb=
886f2c42511
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

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


  Commit: d917c24c7417773fd668336ffd9177ce8a1fc730
      https://github.com/bluez/bluez/commit/d917c24c7417773fd668336ffd917=
7ce8a1fc730
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

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


Compare: https://github.com/bluez/bluez/compare/dcf17f0d657b%5E...d917c24=
c7417

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
