Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2EE38B7C9
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579333; cv=none; b=CMGMd1afWo1s5mrEZuE0cKu7Xvo6QJPI9N3rvkFfyXpB1qupz2EHTNpYW29bX0QTpgdBoPydZuf4Wh64iOobBMr+/yRGhigBvjxEZdJ4NnutamMA7BGeVb18mIWxc9/3D/iBPKYMODda2e1CIwasKUeGEbxN8MHx48q2p99AV/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579333; c=relaxed/simple;
	bh=iOA5/DpbTvLI4e9vJCAL7P05rPAH2Gt7D3t6uj+cohA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CTDCWlRsSNVPobKoN18k2148eIr5l0+x0ZCj30d1gOrlGt84ZhqjOdKjtTHqeA/yVItpdsgGj8VH7rOz7nO4STeDXeWMr5/y1WvCQkzgJcb0D0DeE1DK+0SK+SYPnII6+JmD8xB8jTUFKWyuENH0sqOxDdSKT30w0D8BChNA9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=T4IraHsG; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="T4IraHsG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777579330;
	bh=51/tV5/HQ4wCAuE3n2P0zKMYJ4GN0D+w37qVMNl06oY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=T4IraHsGRSBDjiMf2Tv2YxIBwXCGwoA6oNtTDEr9KQYNd1gDZ52+QuCMEdInaKW5I
	 lwdH8fePTzZSSqHTWyhM6I5fZZuuofMT2Zm4f5QufGd7jz0xu/8cqwNpfBvcc64soB
	 w6NJ7Xa9ATgHDoRK67GI8j3az2j8zL8HMbUde5Aw=
Received: from github.com (hubbernetes-node-41b88f9.ash1-iad.github.net [10.56.212.57])
	by smtp.github.com (Postfix) with ESMTPA id 51C2136115A
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 13:02:10 -0700 (PDT)
Date: Thu, 30 Apr 2026 13:02:10 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1088308/000000-3bcc24@github.com>
Subject: [bluez/bluez] 9b90a4: shared/util: Add decoding support for HIDS 1.1
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

  Branch: refs/heads/1088308
  Home:   https://github.com/bluez/bluez
  Commit: 9b90a414b90a52815f2e73f4020722e668fb1afc
      https://github.com/bluez/bluez/commit/9b90a414b90a52815f2e73f4020722e668fb1afc
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


  Commit: 3bcc24e47bf1b2323f94d1ea9dee3de294e963aa
      https://github.com/bluez/bluez/commit/3bcc24e47bf1b2323f94d1ea9dee3de294e963aa
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


Compare: https://github.com/bluez/bluez/compare/9b90a414b90a%5E...3bcc24e47bf1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
