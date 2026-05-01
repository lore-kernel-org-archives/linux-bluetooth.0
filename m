Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8338DD3
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644260; cv=none; b=aJNGpxWhr1oADkVG1fYzuq/Y3tn3rMsEy2UWt/sE0wo6q4/6wyVknxw2P1uvrv18AJXeB4Q/LI5Xgbm04zNWw1S0FBYrFRwLcEuQwjp9VwKjtyaimuBiE1eh2RnploCAm2sKgKblj4avsPRRbZz+3z0EouLpUFerofVMc/qyIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644260; c=relaxed/simple;
	bh=iWGOCBpsOyAsQ0OtFdyhBPiAZW1zYxlmwFBl5ScrUyU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SZCeGkuViSjpklugFJxiIoCYoM+gCWOvtQd15WhA2QDGA/ZCB+MSo4DWFHXw2LpXvR4xWSPuzX8jXWHhaGYJGyVSfg/72FUsxz7MZ0ciEUJTblg/X7dIoYmGH/DnmxGJiGrscqDyUY6dP3S+gfNHNdv0Kok1nr/MIDgDAjIvfSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=b1egKg43; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="b1egKg43"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777644258;
	bh=9lgKS8gm/KjyRn6ZUGm7FwWNDxNAj3kt/o7bw/PZlvA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=b1egKg433XhLc58B+wrJiKANXLTvmh891a+buqB+2i03GdVwR54LWHB9jwJM8FyR9
	 FZSQGnk4Csla5Iq1Awq21eFha6npZDn7ZRF4ohHxZCmXd35o4cHCDIaLF9Amwn4IQ7
	 CnuLtY9QhZnrLyxm+8JcVbuEoghKt4ypN+PX++5k=
Received: from github.com (hubbernetes-node-70381f8.ash1-iad.github.net [10.56.226.81])
	by smtp.github.com (Postfix) with ESMTPA id AF5AF181033
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 07:04:18 -0700 (PDT)
Date: Fri, 01 May 2026 07:04:18 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d01616-31e4fb@github.com>
Subject: [bluez/bluez] 2128e1: shared/util: Add decoding support for HIDS 1.1
 UUIDs
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 2128e1c73ff0c0dffc4869b52a8664cac7560455
      https://github.com/bluez/bluez/commit/2128e1c73ff0c0dffc4869b52a8664cac7560455
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-30 (Thu, 30 Apr 2026)

  Changed paths:
    M src/shared/util.c

  Log Message:
  -----------
  shared/util: Add decoding support for HIDS 1.1 UUIDs

This adds support for HIDS 1.1 SCI UUIDs:

HID SCI Mode(0x2c39)
HID SCI Information(0x2c3a)


  Commit: 31e4fb1498f47dfbf18b414acbbbeac26dcda366
      https://github.com/bluez/bluez/commit/31e4fb1498f47dfbf18b414acbbbeac26dcda366
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-30 (Thu, 30 Apr 2026)

  Changed paths:
    M monitor/att.c
    M src/main.conf

  Log Message:
  -----------
  monitor: Add decoding support for HIDS 1.1 flags and attributes

This adds support for HIDS 1.1 SCI flags and attributes:

> LE-ACL: Handle 2048 flags 0x02 dlen 9
      ATT: Read Response (0x0b) len 4
        Handle: 0x0021 Type: HID Information (0x2a4a)
        Value[4]:
        11 01 00 0f                                      ....
            bcdHID: 0x0111
            bCountryCode: 0x00
            Flags: 0x0f
            RemoteWake (0x01)
            NormallyConnectable (0x02)
            SCI Supported (0x04)
            SCI Low Power Mode Supported (0x08)
< LE-ACL: Handle 2048 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x003d Type: HID SCI Information (0x2c3a)
> LE-ACL: Handle 2048 flags 0x02 dlen 19
      ATT: Read Response (0x0b) len 14
        Handle: 0x003d Type: HID SCI Information (0x2c3a)
        Value[14]:
        08 02 0a 00 14 00 0a 00 08 00 08 00 08 00        ..............
            Minimum Supported Connection Interval: 1.000 ms (0x08)
            Number of Supported Subgroups: 2
              Minimum Connection Interval[0]: 1.250 ms (0x000a)
              Maximum Connection Interval[0]: 2.500 ms (0x0014)
              Connection Interval Stride[0]: 1.250 ms (0x000a)
              Minimum Connection Interval[1]: 1.000 ms (0x0008)
              Maximum Connection Interval[1]: 1.000 ms (0x0008)
              Connection Interval Stride[1]: 1.000 ms (0x0008)
< LE-ACL: Handle 2048 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x003f Type: HID SCI Mode (0x2c39)
> LE-ACL: Handle 2048 flags 0x02 dlen 6
      ATT: Read Response (0x0b) len 1
        Handle: 0x003f Type: HID SCI Mode (0x2c39)
        Value[1]:
        00                                               .
            Mode: None (0x00)


Compare: https://github.com/bluez/bluez/compare/d01616f0c276...31e4fb1498f4

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
