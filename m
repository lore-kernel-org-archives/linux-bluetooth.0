Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59527353A8D
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250649; cv=none; b=MZv61/SyyxpvPL5gY35Lhx26bC+j15qA/jnf95vappPqMDzEi9BL9Sa/kKcSrPIXOpSDVLHiWIcTfgFXijmla7VM13wT5o/QXPmlwuw3T0hO7eHjVwCaX96S7Fe2jcWIACPd41mCXqxX/V0lWaLWSe+bplwAH5cxRafiA4Df9A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250649; c=relaxed/simple;
	bh=4TKJYRWa22snzQ49BJGAvC7KS/djquCWDpv5FkgNHg0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jT+yw6gicGz3cpLxH6qBoONyNQw20AjEvkF9XBVBHM8o9anx42b+k0UWngRbUGoKTGXuLr3EDmJIBLKg8rVgnETg06UXePGzAm7bFVjuVWKgqM2fQmPAWApisfTn/APYqmlGaGgwW1/CcN7Po8T1YFRgkevfb6dlVlLPP36OiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVWyan0d; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVWyan0d"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso132090e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787250647; x=1787855447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Xhkd1E1bISrwSae0D1yWIHIUOnRSBMvqCWFG+tTSys=;
        b=NVWyan0dH8pW3a1JajEfCAUk5YSYRd3V0cIi6T2baqYP9yQWWmr7mE8VPGDEALoHfx
         dNc9niCAJwetkYsmuGOgKLt9DgJZUtmCgqZL9u/f3CQhbmv2++Ib+8yBfmutLHlP0jC0
         VNKBnBWHed6b8oqzzpMV2n6BMQULeirGZirsmwjlX3iWvayjcDxyIKm4eEIa9HwObnve
         5mYGLb9234KeElFBLmP+7CJDMQC4vIC4mbWpNGgliDYJpUUCsXRKWstwGVrQ3w8K5Izl
         aRbbkUBblXHlW+NdAJfXUSFhK/DQZNTZHiZpEaLHTOq/FNV8EBYx7DEGs0zEn4/lfsZu
         JSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250647; x=1787855447;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Xhkd1E1bISrwSae0D1yWIHIUOnRSBMvqCWFG+tTSys=;
        b=bsWXOvs4MNymLcLlfNAGBmdyMMznlBTHXSNSS1Hnl1mJHEhZ14+teGJyoDSXK8OqGS
         UXRYLqE54QEie0RevElwUI1QE9jAbJ2nuVlrEVAyJNUKNDTx5Zo7zOQD8Z4+Dp1KBZmV
         KIWUc3GxLyH7NfktX0nsfunZ8yFB7XZ9T8PlHT5oqSEa1e8bADCesMzS/GNkxZ97yd+D
         9AKX8Z5IAj8xzTFw03JVxfxBArvBubn4wXPimt7fUTypof650fKUpCOCaXuBGb8BCu/K
         mwFaUPr2LGtwsS8uf2cukw4KecvDGgjqEWZoa9tjHbVjDtoyL23qEP96JjQZ1u8w39YZ
         wwSw==
X-Gm-Message-State: AFuF++lyMecZKNUNudDn7vxAYWJxkcYA95P8aEt3CSq6dnc87LJ4fmr2
	5CS5Q+MBnUwEPss+rucmAnDYU+cpyDDYvEECsP1vNjKYq7RgDlWPpIY+HfBdDb7H
X-Gm-Gg: AR+sD10ejIp5Nf4gKamJSM1B1HYHRc0qEh6Q0VrLPznow4E2L4UrbG9yJOMgvfgqhPv
	j1CpHjKF3cvz38UZSjUh+PIom23VdK1IytQFZqQaL1ZRugqNOoq5NFJWmmfsq/cfM9WFWdVlB8n
	S3sUcfXdTR0c1gBEapFFHHLjXER9psQx8FqL+lzxdrVRKhDUMsulMkHg4RK9HlUi+IABqz0uU8y
	XEQxxXcQrnRp2hvmeaF4nfhGOb6fBsInqXxOrn/5UCt21wKVmJfwIj/QEAosMzGTfEsZfaxmTOr
	ljeJesGPhgzTeHYxaburHv5YeFbyHomjM6gmjF3lVzpEpoEQwOS3EHrUt/yTItpaKvmQjmK0mth
	ANts597uzB5pCk2FdxAc8nqEQYP2uu7WmqRR5UGNO0JUkFgN7WTu6EqNe/jeO+C1ck8G0R+EkOC
	yirtPlhEuVD78sDCpDamdTrdvt1wKM+dfJbajEsQvLq3p3m9r5oTckwrrKz7RHwaOYhxaJV9neH
	yGGH4EhdxCH3uv+yxzRB4DPhoP8KVLCOrgW9ejAAlUJb5yJTId8xpCz3wK8eSROkg==
X-Received: by 2002:a05:6122:330e:b0:5bd:aba5:3830 with SMTP id 71dfb90a1353d-5c5fecaf70cmr462480e0c.0.1787250646959;
        Thu, 20 Aug 2026 11:30:46 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e276d416sm6840662e0c.12.2026.08.20.11.30.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:30:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 00/10] Replace the name2utf8 copies with str2utf8
Date: Thu, 20 Aug 2026 14:30:27 -0400
Message-ID: <20260820183037.2713973-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There are five near copies of the same helper turning a remote name into
a UTF-8 string, in monitor/att.c, profiles/audio/mcp.c,
profiles/gap/gas.c, src/eir.c and src/shared/ad.c, and none of them
agree with each other.

The copy in src/eir.c does not clamp the length before copying into a
fixed size stack buffer, and eir_parse() can hand it 253 bytes for a 250
byte buffer, so a remote device can overflow it with a long name in an
advertising report. That is fixed first and on its own so it can be
backported.

The rest replaces the copies with a single str2utf8() in src/shared/util
and drops around 120 lines.

Three things change behaviour and are worth a look:

- Most of the copies truncated the name at the first ill-formed
  sequence, throwing the rest away, and the monitor replaced every
  non-ASCII byte with a space, mangling the valid part of the name.
  str2utf8() replaces only the ill-formed sequences with U+FFFD, so a
  name is no longer cut short by one bad byte in the middle. The
  unit/test-eir expectations are updated to match.

- strnlenutf8(), and with it strisutf8() and strtoutf8(), only checked
  the shape of the bytes, so it accepted overlong encodings, UTF-16
  surrogates and code points past U+10FFFF. Those reach D-Bus, which
  does validate UTF-8 and rejects them. It now validates as per table
  3-7 of the Unicode Standard.

- btd_device_set_name() cut the name at 248 bytes with strncpy(),
  without regard for where the characters start and end, so a longer
  name could be left with a partial sequence and be rejected by D-Bus.
  It now truncates on a character boundary. It also loses the doubled
  "device" in its name.

str2utf8() and strtoutf8() were checked against Python's UTF-8 decoder
over every one and two byte sequence, a sample of the three byte ones
and 200000 random inputs, with no mismatch.

Changes in v2:

- Add unit/test-eir tests for the longest local names eir_parse() can be
  handed. Nothing covered a name anywhere near the size of the buffer it
  is copied into, which is why the missing clamp went unnoticed. Run
  against the code before the first patch, the 253 byte one dies with
  "*** buffer overflow detected ***".

- Add a fix for ad_replace_name() reading past the name it copied, which
  those new tests turned up. It clamps the copy to HCI_MAX_NAME_LENGTH
  but then hands the unclamped length to strisutf8() and strtoutf8(), so
  a 253 byte name has both reading 3 bytes past the same buffer.

- Clamp the name in eir_parse() to HCI_MAX_NAME_LENGTH rather than to
  the size of the buffer, so that it agrees with ad_replace_name() and
  the new tests can expect the same name out of both.

- Add the Fixes tag to the first patch.

Luiz Augusto von Dentz (10):
  eir: Fix stack buffer overflow when parsing the remote name
  shared/ad: Fix reading past the name that was copied
  unit/test-eir: Add tests for the longest local names
  shared/util: Make strnlenutf8 reject ill-formed sequences
  shared/util: Add str2utf8
  unit/test-util: Add str2utf8 tests
  Replace the name2utf8 copies with str2utf8
  device: Fix the name truncation splitting UTF-8 sequences
  device: Rename btd_device_device_set_name to btd_device_set_name
  unit/test-util: Cover strtoutf8 with the str2utf8 tests

 monitor/att.c        |  66 +++++++--------------
 plugins/neard.c      |   2 +-
 plugins/sixaxis.c    |   2 +-
 profiles/audio/mcp.c |  24 +-------
 profiles/gap/gas.c   |  22 +------
 src/adapter.c        |   4 +-
 src/device.c         |  14 ++++-
 src/device.h         |   2 +-
 src/eir.c            |  20 +------
 src/shared/ad.c      |  20 +++----
 src/shared/util.c    | 136 ++++++++++++++++++++++++++++++++++---------
 src/shared/util.h    |   7 +++
 unit/test-eir.c      |  69 +++++++++++++++++++++-
 unit/test-util.c     | 121 ++++++++++++++++++++++++++++++++++++++
 14 files changed, 356 insertions(+), 153 deletions(-)

-- 
2.54.0

