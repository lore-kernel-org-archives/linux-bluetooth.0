Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A538A25F797
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101323; cv=none; b=qWEU4uyLlH97opujaeX4hG7/nLesOphcLYKo6pdodpcSduG3EJgIfXcqsJp4c/y57ASueGjFe63RKMHZpoOX9/qAAMGCqfysfokNv786dWPISTT5n97EhIIPzpNzqzrxaKi1B+onC6sGot79UleFHCoQDjn+y+MuxF/i2nVFaIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101323; c=relaxed/simple;
	bh=M0n+oPrk2VCqRF/UgWW+Bxx8okdRJyROLvfdA1jpchE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VAvpnbzPaq21fAhA6ApiyRpEfTReJ8poXLoe/ZV4VVYHiyaLyNbNjd21cbmJJSxb5kqigNLp8OwIBp5M2Gq8qVfcbhEQ0TGzJWyg+lr5CVDGsZFdLBLQt50UIOuT7ZfjCOanB5VcOa/s8rMeHqbVsvh4SB74r+o5UlINZomZ4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EjEyWKoh; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EjEyWKoh"
Received: from github.com (hubbernetes-node-332f0c4.ac4-iad.github.net [10.52.154.34])
	by smtp.github.com (Postfix) with ESMTPA id A78A26410A3
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 07:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1741101320;
	bh=7byGA8twETwRaJDJBSgROg5VDztETlODmFesKDKUXx0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EjEyWKohZ1zq5FJKwCLlBNXkBdKkG7/WjZG3iJPZGflVhMqUSSocefFIbfskh3Ebf
	 1pTVWIfW6pL1rC/qs2qEtp6RRi5OCrY1CdI+/PGGW2Y37WGk/iEH97e/Zqd5NTBrg5
	 ifUav6VfZb6ztOpKeD6Gkn+hkHxdrA9WRvaA6V74=
Date: Tue, 04 Mar 2025 07:15:20 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/524fa2-9a32b6@github.com>
Subject: [bluez/bluez] b71c53: configure.ac: check for stdio.h
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
  Commit: b71c5327926696223dba0d78f4c9fe36767d16ec
      https://github.com/bluez/bluez/commit/b71c5327926696223dba0d78f4c9fe36767d16ec
  Author: orbea <orbea@riseup.net>
  Date:   2025-03-04 (Tue, 04 Mar 2025)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  configure.ac: check for stdio.h

This fixes a configure failure for readline.h with slibtoolize which
depends on HAVE_STDIO_H being defined. With GNU libtoolize this check is
implicit and with slibtoolize it will fail instead.

  error: unknown type name 'FILE'

Since bluez depends on stdio.h itself there is no reason to not check
for it explicitly.

Gentoo-Issue: https://bugs.gentoo.org/950467


  Commit: 688f5ee80fca9ff06cdc1b1e51d4989e18147f1d
      https://github.com/bluez/bluez/commit/688f5ee80fca9ff06cdc1b1e51d4989e18147f1d
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-03-04 (Tue, 04 Mar 2025)

  Changed paths:
    M client/bluetoothctl-admin.rst
    M client/bluetoothctl-advertise.rst
    M client/bluetoothctl-assistant.rst
    M client/bluetoothctl-endpoint.rst
    M client/bluetoothctl-gatt.rst
    M client/bluetoothctl-hci.rst
    M client/bluetoothctl-mgmt.rst
    M client/bluetoothctl-monitor.rst
    M client/bluetoothctl-player.rst
    M client/bluetoothctl-scan.rst
    M client/bluetoothctl-transport.rst
    M doc/hci.rst
    M doc/l2cap.rst
    M doc/rfcomm.rst
    M mesh/bluetooth-meshd.rst.in
    M monitor/btmon.rst
    M src/bluetoothd.rst.in
    M tools/bdaddr.rst
    M tools/btattach.rst
    M tools/btmgmt.rst
    M tools/ciptool.rst
    M tools/hciattach.rst
    M tools/hciconfig.rst
    M tools/hcidump.rst
    M tools/hcitool.rst
    M tools/hid2hci.rst
    M tools/isotest.rst
    M tools/l2ping.rst
    M tools/rctest.rst
    M tools/rfcomm.rst
    M tools/sdptool.rst

  Log Message:
  -----------
  doc: Fix typo in the copyright header


  Commit: 9a32b6144d8a9d7aedfa696e0aa8572c13c58480
      https://github.com/bluez/bluez/commit/9a32b6144d8a9d7aedfa696e0aa8572c13c58480
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2025-03-04 (Tue, 04 Mar 2025)

  Changed paths:
    M obexd/plugins/mas.c
    M obexd/plugins/messages-dummy.c

  Log Message:
  -----------
  obex: Add messages_get_message() implementation for MAP plugin

GET Message() operation should be supported for passing below PTS
testcases -

1.MAP/MSE/MMB/BV-12-C
  Verify that the MSE can return an email message to the MCE.
2.MAP/MSE/MMB/BV-13-C
  Verify that the MSE can return a a*n* SMS message in native format
  to the MCE.
3.MAP/MSE/MMB/BV-14-C
  Verify that the MSE can return a SMS message with text trans-coded
  to UTF-8 to the MCE.

Currently get message operation is not implemented, hence above
testcases are failing.
Added code to send the complete bmessage in response to the get() request
for the requested message handle.

As per suggested in previous patch, mmap() is being used
for reading file.


Compare: https://github.com/bluez/bluez/compare/524fa22ed19e...9a32b6144d8a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
