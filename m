Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B85E381B07
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455849; cv=none; b=khReTPBUxo8zuuV5TGKLNiu3mXUwuzhJcA1FpCpGb19+jPqq0NymQHD0oQOrVyy0djW7qc4/cNW9ICDwBiv5nBUWyfm0/7j5DRORomHy0u1k4EbdSLGUS+7Qok/QGNeK2WvoMELqRqZ9YIAJ2u5OFnbcuzX+nTxr98MSYRJAHno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455849; c=relaxed/simple;
	bh=0eOa92viTL3Jg6aRzKVX2XM6Wony0W4M1UExBqkyHFE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=j8ATMcvx2j48VEjPtVvQZZvEbwB4HhPUwvJcdwY7vyt/02BbW/Y5cwxpDGVgoLZyUvilcF4kPXWbhVgeP2ieZs2p2hmE7uRIbssWdiDLpvX67C/POusZ0J140hCvRRBnZDZgku5XfpJvxidXEswFPKwcqxwisqRkHEy4C9hbMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=B00wuYWg; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="B00wuYWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779455847;
	bh=HDRBLsL0LnyhcHNVKV5zCWL+tGTvGyNxk7Dr1ToyAJM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=B00wuYWgSYbv9pgw+vSkzmL+nc7TXlDN+JTK8TFjxkG1NuL0wZRQUrErw0WCIgVsu
	 kyV60h8Ai3nDhc3VpgDM3IuKlGqwhHWFzqzeoczB7MpyiqZR4djez5qiY9BpXAv+zZ
	 GP3+mR2x86WKckQZHQJzsP/pooJKV2JkWSgUONE8=
Received: from github.com (hubbernetes-node-5998cc5.ac4-iad.github.net [10.52.14.23])
	by smtp.github.com (Postfix) with ESMTPA id 629CA740B99
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 06:17:27 -0700 (PDT)
Date: Fri, 22 May 2026 06:17:27 -0700
From: apusaka <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1099306/000000-6e45cd@github.com>
Subject: [bluez/bluez] 6e45cd: monitor: Add support for HCI Event Encryption
 Chan...
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

  Branch: refs/heads/1099306
  Home:   https://github.com/bluez/bluez
  Commit: 6e45cdbb18850e9043d2bf73c5735849a0e217cc
      https://github.com/bluez/bluez/commit/6e45cdbb18850e9043d2bf73c5735849a0e217cc
  Author: Archie Pusaka <apusaka@chromium.org>
  Date:   2026-05-22 (Fri, 22 May 2026)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for HCI Event Encryption Change v2

> HCI Event: Encryption Change v2 (0x59) plen 5
        Status: Success (0x00)
        Handle: 256 (BR-ACL) Address: 00:11:22:34:56:78
        Encryption: Enabled with E0 (0x01)
        Key size: 16



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
