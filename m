Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5993793BB
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172023; cv=none; b=o0sW6IX5CZ+BKeKbPEf2IFkWgOkr2FnbZlEZQCV8EY3ISHEY/+xDA9D3BHfjg0liJpgdi6r1rh5eGSY9F9zrHj5PL4Qpa8q+lwGquba97Rt0dz9f7BXI1/Ii4yij6uxsY3APGwe8sGjIkxEbZ2jkk5jMDFUZDrzIxZ69WjaNv+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172023; c=relaxed/simple;
	bh=MiA3vt0cLlM0dmbz6JbJ7rVkeqTc4qTVycWqagYV8Gc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HjDio6QfIjF/BQkE2itiS4zs3esidOPRo2c6El3xHjocH/w8GNsJC0VAVHhI1wBhT8VnFkRH+D+gRG/rwUyDBbi/f6VqWEMWAq4I9QXvmul7K3jiBtVFh/+4VQ0x3HFkXGwfQu89LKeM12uORueMi9qj32jhTUJthtRCk5RvmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk8mIXR5; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk8mIXR5"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso661283e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787172018; x=1787776818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cTFTpgg6TXydJQfGJSh+kHIrSizvJWwyK9qKpRcf3F0=;
        b=Vk8mIXR5YUuYiqBevpUGnioTb/Jwna0xU+Ng5JI4Kjf/Bpbs2Jsf6A4X28Uu25SxRj
         dHjSkcYIwB/xrBkcz7AQN8Uox8K7pob3Fh/Fmsa61UE8IxHAwmD5zzQKPv/uN3KS0LYQ
         2BYRJrNMgTyhGooGYm3x+BSo8Qxy7Q7JL7imG9IPHXgiYA4Hq5kicsZAdKNG5KL9yWsa
         TLRXGl//W9Z7m7tNjkRQl4tITpPrW34gwRGPCXZ5mw0HRp5iteX14xCJXDp4fRFxKdS7
         AWdzca91w2Fiw93fAhuLpGf0H3S0zqWSh+F8xoG6/kCv/LpfqPr75cBVWBQjxTbuviwj
         VuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787172018; x=1787776818;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cTFTpgg6TXydJQfGJSh+kHIrSizvJWwyK9qKpRcf3F0=;
        b=UDcXS1Xt+F26cav7wAnmrZYwjOvggZqKGbwyfwYXJKjFUOAWgAl/x8H4LYCtrLLuEB
         rgHgUf4C0cD3klujTcURmhdRRJmx4FUJOk5KrW5K25Nh0epGGASK98ypqD8aFrJFds/B
         XzHNht4DpJQ2cZYl7epnW80oc+Ob2O1hcxtiGMPAQfzHZnGLTzFBlCZe94BziFJAZAJA
         E3Itx3DdKVRzu6nhzSZQmX8wVCvMFJFOBSSjls5Koz4lM9YTmVY0fG1qrLgDs36uy8NL
         7vC2x4fQEA/eiFlgs8xtd8C3LSsJcdwCjz7EXYUA/IYLvDRNziAyiig/G6s/esdp3nrF
         0PjA==
X-Gm-Message-State: AOJu0Ywe9ljWv3M+YLFxuOH7B2+wi/2IQma+ula3n7dVDtzOA0cX5OSR
	wQYRGMucTyqUnayxoHcMhZ4uIU1ycpRv4yTGKCCCufTzErmzSIJPJ5xIKMsPKHvKv1n1Bw==
X-Gm-Gg: AR+sD11M471NxwQ40I0ZTs//+7yMRpVLFvPZGApW2l/c4DrVYqAjmPlX51BwGivzxBU
	lYjU4eMlTzR9gUP2fy0XGfgSf9Nn00fXkxGV5mTuolK9xYS8oFFUTXiQL0H58P3gHcZc0QXDFit
	XNO/E1+3h4L1S5gRdgTH93egr7sIuOuriX5QBIeYo5QfCOihZEJGwdzGfD8xNrqIpPwXqDSaZEm
	VkdMROB1Ghkk0zrUdhJhTYRQaUe5XDtQ4TQzOoo9gw/ZMz7bptgwo8yapIYyifwcGTWT4oSz6sV
	I3UaQQCPX0k8T1uHYxqeRr5FTW4Kc4wlh0ybPfRTZJ2ZU8SB9Jg3oKD1qDySjbrKqydgfwXohs7
	8b+nsX6zkLNkHQAoWlom3XretlHgtNYmcEBrXXPQNj5TZTM5exp8voHW9uqlZWtKikIaWYIbcJZ
	nKmGAgZWrEjkdHl2NhE6t76u6XlOb6vHRhs4YovIXliKUiZ0qBJfLqZDW/TSDD2y9ZBgECssMDm
	0+BUyLSGAHMwQ1ly9tP5ZqJ3r47cOJez0hoHSVNSRkW9acCD7+3WHs=
X-Received: by 2002:a05:6122:1dac:b0:5bd:aba5:3830 with SMTP id 71dfb90a1353d-5c5e2eace7bmr3104199e0c.0.1787172018247;
        Wed, 19 Aug 2026 13:40:18 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e2486864sm3496404e0c.0.2026.08.19.13.40.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:40:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 0/8] Replace the name2utf8 copies with str2utf8
Date: Wed, 19 Aug 2026 16:40:00 -0400
Message-ID: <20260819204008.2292225-1-luiz.dentz@gmail.com>
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

Luiz Augusto von Dentz (8):
  eir: Fix stack buffer overflow when parsing the remote name
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
 unit/test-eir.c      |   7 ++-
 unit/test-util.c     | 121 ++++++++++++++++++++++++++++++++++++++
 14 files changed, 294 insertions(+), 153 deletions(-)

-- 
2.54.0

