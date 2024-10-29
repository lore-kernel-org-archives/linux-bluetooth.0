Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3EA18C936
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215129; cv=none; b=RTuR5A/ITVZ8l0KBLG/86H7A7rSnQyHeKtcm5yOv6vNp8kSRJQF3R2CsQ85PgQEPtEtdPBKXFndlHqBBovJD/CygUuiCec0x9a5xjQxAdDnToJcs8UZTFsJXLJGHAzSCcTXyiz+KcQx4X4H9LWitbaSfiy1Kp2qWANlF6CaL/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215129; c=relaxed/simple;
	bh=nYx6AKOpoOnB5cpjrC+eqj8Y7Nyc3HtSMTDhA0e2JoA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FSTLwZQVBkiNbEiPOvmoovWAjlmyKq7NlUeETfmWffLRXDqGf6iJ7XkA+dXABl4E7cODcHHvXxHGeUty9NFbjBAGb5w1SVRp/cLOzgtSUzVxQM46JdfhPieGVMpWmwl2+vqs7Nl0u35jg2+AN3+vyhtCxcCtpZcBzfkiGWCQyX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kUXsPYkR; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kUXsPYkR"
Received: from github.com (hubbernetes-node-d77acae.va3-iad.github.net [10.48.139.20])
	by smtp.github.com (Postfix) with ESMTPA id 99D1CE0435
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1730215126;
	bh=u1k5eZkv0OPF8REnv4cD36A0dhq1aPKv+ZI+xJicXfI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kUXsPYkRNSyQZ9UuIPuKH2qK+3MmLJAHHX0FsTz4QmrKirOF4XYA5+MlzWl7HLHgJ
	 qpudSw+9FbqPWDdPX6vqQHYHnm+3s54GJvs3zG8I9qo8t0/k4IiFr8/x9+4BASIqwm
	 A4VLVvDefonn+xo0V+N0RDwShL6XZtKrJev44ybg=
Date: Tue, 29 Oct 2024 08:18:46 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d7bb2a-6d55c7@github.com>
Subject: [bluez/bluez] 6d55c7: device: Fix Device.Pair using wrong address
 type
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
  Commit: 6d55c7d7fd0da6bea7adbabac09cae2023a62fcd
      https://github.com/bluez/bluez/commit/6d55c7d7fd0da6bea7adbabac09cae2023a62fcd
  Author: Cheng Jiang <quic_chejiang@quicinc.com>
  Date:   2024-10-29 (Tue, 29 Oct 2024)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix Device.Pair using wrong address type

For a BLE-only device, if the device is already paired and the upper
layer attempts to pair it again, the bdaddr_type will be set to
BDADDR_BREDR since the LE connection is already bonded. This causes the
device to use the BR/EDR bearer, which stalls the pairing procedure and
requires waiting for the pairing timeout.

The bluetoothctl log below shows the error result:

[bluetooth]# pair ED:8E:0E:B3:85:C1
Attempting to pair with ED:8E:0E:B3:85:C1
Pairing successful
[RAPOO BleMouse]# disconnect ED:8E:0E:B3:85:C1
Attempting to disconnect from ED:8E:0E:B3:85:C1
[RAPOO BleMouse]#
[bluetooth]# devices Paired
Device ED:8E:0E:B3:85:C1 RAPOO BleMouse
[bluetooth]# scan le
SetDiscoveryFilter success
Discovery started
[CHG] Controller 8C:FD:F0:21:84:17 Discovering: yes
[CHG] Device ED:8E:0E:B3:85:C1 RSSI: -38
[bluetooth]# scan off
Discovery stopped
[bluetooth]# pair ED:8E:0E:B3:85:C1
Attempting to pair with ED:8E:0E:B3:85:C1
[bluetooth]#
Failed to pair: org.freedesktop.DBus.Error.NoReply



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
