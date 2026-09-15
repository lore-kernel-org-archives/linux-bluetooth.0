Received: from out-2.smtp.github.com (out-2.smtp.github.com [192.30.252.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D0470EA0
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467815; cv=none; b=dEU7vE9OJuvQD3wFGZs6GEb1gba0gpPis7MwPztUgsRAZ/QaJzGJDKq4E8+Qdh6l/XiWInOBSHuFgIKrZPJi5dFE95IkbGKFPbBgTrb8RdBSuBWNsIgZ+gxyq9rdD27a0KRkNjKE/rL+JjxFaxTlQMQUyBYEBw2uY9rcCf7f1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467815; c=relaxed/simple;
	bh=iZRLvQm1qgerCQC1224BIIqUBSyVRhgjPgWmHOOlaJ8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LPtiIdj6cg2gVrbTbsZgAWQBc97mV+nS55eufeRUZSmct237PCtaICn0uhEc0vVcriHy0WIQi3pdElkYAdDWdvHqb+z/yhn+DwGkejaqiXXmZTE6tIlUYc+duEr8Xxjqctl6+mfvhVpr6tbzTwEMp0QWqzokrNAKBiZAsop9ko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ie9AVGVe; arc=none smtp.client-ip=192.30.252.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ie9AVGVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789467813;
	bh=K5zVhhGOXCGMIW1buFZa6ZxqpWALLZxvV0z+wNGMgUU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ie9AVGVerKvg6ayfxI5m6LpYXhNqSrutWwE1+47Bdwf0opmDhMC2nO0lUae8az34D
	 52BiwtoZxyC3KeIt7LayqkOESu79n6qnGjiAJN+y090o0+viNojmgDVBKfxtk2ng0Z
	 o+UisX4X/lbWxcV0tra96dIFSM7Ogf/QlGT/Wc1A=
Received: from github.com (hubbernetes-node-71acab3.va3-iad.github.net [10.48.75.86])
	by smtp.github.com (Postfix) with ESMTPA id F16C6341130
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 03:23:32 -0700 (PDT)
Date: Tue, 15 Sep 2026 03:23:32 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1165307/000000-03af6b@github.com>
Subject: [bluez/bluez] 28529f: monitor: Fix btmon heap-buffer-overflow
 triggered ...
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

  Branch: refs/heads/1165307
  Home:   https://github.com/bluez/bluez
  Commit: 28529f966cefe97f6efc277ed7f0dccdef11ca5b
      https://github.com/bluez/bluez/commit/28529f966cefe97f6efc277ed7f0dccdef11ca5b
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

  Changed paths:
    M monitor/control.c

  Log Message:
  -----------
  monitor: Fix btmon heap-buffer-overflow triggered by HCI devcoredump

Kernel HCI devcoredump can accumulate a large amount of dump data from MANY
packets, then send it as a SINGLE DIAG packet to the monitor channel, so
cause payload length @len in the header exceed BTSNOOP_MAX_PACKET_SIZE, but
btmon uses @len to access the payload in @buf without validating that
@len fits within @buf, causing a heap-buffer-overflow.

Kernel:
include/net/bluetooth/hci_mon.h
struct hci_mon_hdr {
	__le16  opcode;
	__le16  index;
	__le16  len;
} __packed;

BlueZ:
src/shared/btsnoop.h
#define BTSNOOP_MAX_PACKET_SIZE            (1486 + 4)
monitor/control.c
struct control_data {
	uint16_t channel;
	int fd;
	unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
	uint16_t offset;
};

The heap-buffer-overflow Issue:
ERROR: AddressSanitizer: heap-buffer-overflow on address 0x51b00000065c at pc 0x7f50b987a029 bp 0x7ffde88dc8d0 sp 0x7ffde88dc088
READ of size 17916 at 0x51b00000065c thread T0
    #0 0x7f50b987a028 in write ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:1096
    #1 0x5b4f3443ae3a in btsnoop_write ../src/shared/btsnoop.c:289
    #2 0x5b4f3429cbf0 in data_callback ../monitor/control.c:969
    #3 0x5b4f3444fa9d in mainloop_run ../src/shared/mainloop.c:104
    #4 0x5b4f34451da6 in mainloop_run_with_signal ../src/shared/mainloop-notify.c:196
    #5 0x5b4f342953fc in main ../monitor/main.c:303
    #6 0x7f50b8c2a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
    #7 0x7f50b8c2a28a in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x5b4f34295ed4 in _start (/usr/bin/btmon+0x29fed4) (BuildId: b41caafb24db693946c283eaea48112186863d2d)

Fix by clamping @len to the amount of data received before accessing
@buf.


  Commit: 03af6baa172f0ff8e22c3b92f261cd42c06df0d2
      https://github.com/bluez/bluez/commit/03af6baa172f0ff8e22c3b92f261cd42c06df0d2
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

  Changed paths:
    M tools/btmon-logger.c

  Log Message:
  -----------
  tools: Fix btmon-logger heap-buffer-overflow triggered by HCI devcoredump

Kernel HCI devcoredump can accumulate a large amount of dump data from MANY
packets, then send it as a SINGLE DIAG packet to the monitor channel, so
cause payload length @len in the header exceed BTSNOOP_MAX_PACKET_SIZE, but
btmon-logger uses @len to access the payload in @buf without validating that
@len fits within @buf, causing a heap-buffer-overflow.

Kernel:
include/net/bluetooth/hci_mon.h
struct hci_mon_hdr {
	__le16  opcode;
	__le16  index;
	__le16  len;
} __packed;

BlueZ:
src/shared/btsnoop.h
#define BTSNOOP_MAX_PACKET_SIZE            (1486 + 4)
tools/btmon-logger.c
uint8_t buf[BTSNOOP_MAX_PACKET_SIZE];

Fix by clamping the payload length to the amount of data received before
accessing @buf.


Compare: https://github.com/bluez/bluez/compare/28529f966cef%5E...03af6baa172f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
