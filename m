Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9523B3C14
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259880; cv=none; b=k/PN8/WgCl6Ka66kxtPKjr8EZ3F8e7o3sv5Y0PIHEDYIMT403m0XuidKd91ZMU3bCSq9O+blVsVSdnM5tBsXNj6lytChwY+IrNSbPCPmNAq1K03vH7VFSxjpMaw6JLA9vJYiHRvBTqAnQaNX1jPicQFLC4eYwYEnGxI4EZKHx0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259880; c=relaxed/simple;
	bh=/yNTDu7+DtEb67POLl3M5dBPE//qSs0C+LEQiicNnmg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KXEjwuyRo74tgvijBGXUmrZy8gK6eSz+ivlpJ1Y/xSB7Jnhecopspvz8Jf6GsoEhmL31BuLy62ZcQSsyYOeDqXrlm+phsgvrMiLeZOhXTUJ7ZGMPqn/FWb3stvMGkPySCeNKHmkifIBH+bA0dbkk9g19Kxg6qmFwW91iqOm0XFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=G0ig+eDQ; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="G0ig+eDQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790259878;
	bh=ZAcQrCAuguGBNcj0e7yBSnGV0XeFiSASUqIqx7F11YA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=G0ig+eDQWsoAgW+TSS3i0hEpmlh4KNB8dF5CSr9Vt06PZ1A6nfAmaHMJX4uBCUwNj
	 6MQF1vzgcAnMXyUu3PrvUhuSDh5J8vEoQ2m+K0oFDB76eIr8qszc/pyM/M/zjYAV61
	 CL6f4WzM68UZii9jJ1kZT0cDDmkSqrES1x+rEGEQ=
Received: from github.com (hubbernetes-node-26cab26.va3-iad.github.net [10.48.86.27])
	by smtp.github.com (Postfix) with ESMTPA id 66DE028140E
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 07:24:38 -0700 (PDT)
Date: Thu, 24 Sep 2026 07:24:38 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173024/000000-476cbe@github.com>
Subject: [bluez/bluez] 476cbe: monitor: Fix stack-buffer-overflow in
 packet_hci_s...
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

  Branch: refs/heads/1173024
  Home:   https://github.com/bluez/bluez
  Commit: 476cbe9a5a86f0763addd45d0a17b52dfc2af874
      https://github.com/bluez/bluez/commit/476cbe9a5a86f0763addd45d0a17b52dfc2af874
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-09-24 (Thu, 24 Sep 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix stack-buffer-overflow in packet_hci_scodata()

Fix below handle_str[] OOB by:
- Increase buffer size.
- Use snprintf() instead of sprintf().
Also access SCO header fields after validating header size.

AddressSanitizer: stack-buffer-overflow on address 0x7bd1443dedba at pc 0x7bd1474ced69 bp 0x7ffdb0324880 sp 0x7ffdb0324010
WRITE of size 40 at 0x7bd1443dedba thread T0
    #0 0x7bd1474ced68 in vsprintf ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:1671
    #1 0x7bd1474d0643 in __sprintf_chk ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:1719
    #2 0x5f5c39d02ea7 in sprintf /usr/include/x86_64-linux-gnu/bits/stdio2.h:30
    #3 0x5f5c39d02ea7 in handle_str_append_addr ../monitor/packet.c:14995
    #4 0x5f5c39d58f19 in packet_hci_scodata ../monitor/packet.c:15125
    #5 0x5f5c39d5eaf9 in packet_monitor ../monitor/packet.c:4841
    #6 0x5f5c39cc4094 in data_callback ../monitor/control.c:991
    #7 0x5f5c39e7fa7d in mainloop_run ../src/shared/mainloop.c:104
    #8 0x7bd1474e81d86 in mainloop_run_with_signal ../src/shared/mainloop-notify.c:196
    #9 0x5f5c39cbbb4c in main ../monitor/main.c:315
    #10 0x7bd14662a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
    #11 0x7bd14662a28a in __libc_start_main_impl ../sysdeps/nptl/libc-start.c:360
    #12 0x5f5c39cbc664 in _start (/usr/bin/btmon+0x2b2664) (BuildId: 370a6386c9fceae18f9a456c0c029ac378b0b070)

Fixes: 611f84a0ff0e ("monitor: Annotate ACL/SCO/ISO data with device address")



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
