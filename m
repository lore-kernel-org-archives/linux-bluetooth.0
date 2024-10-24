Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB41E1A1D
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780869; cv=none; b=fyxIPs9tQLXFBJfm9DzWw9kWuMekGnycSkmy9olJpVRW0Z5jSz5Cb39aY76ygmShYpyGn4OiIPFwd7q5PqCRto8xrRymxb7tq+6e0iszqI7NWNIHPEK8nO8QS0fDrZu+bohnYOSZlQvdcRJxGivzdV8S/tf+8a4uIPCd/Y7RWag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780869; c=relaxed/simple;
	bh=F9Am4+e9h1cieN/cttJJglI3X94RQEr+fd2NBo6ZGz8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PKA8V0Gr2Gtq3yOkbYuW6mlQzikRhsGWS3E964NmJNhem1yZJgzmQkp7zaO/A+appek/0sr7UllXaYP8hx1+Osk0apGzsjKQamdNeodiyrh0yUij5Wc6E26v1f+xrgk/MrFXvfAfW4Ztc7Yb0HMZtJlccW2QrOhbff9y20uZlZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MPfH3Kkq; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MPfH3Kkq"
Received: from github.com (hubbernetes-node-e5d6c39.ash1-iad.github.net [10.56.167.42])
	by smtp.github.com (Postfix) with ESMTPA id 0387B1412AE
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1729780867;
	bh=m2SQk6qeZ73SvyMLXPD9To5HLuXjk10/eY2ekYQhqm4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MPfH3KkqG4AMXb6laBXkegvNfULIVYefZc87BUAaDlL8RUONFdJM6jRPYk1cOfHND
	 XPxjLT8+pwH10mYzPhwEeKCLb9ke1iuweNNZgqCaAMSng5QVsFBa9NGfiJIv43kajG
	 j9dYduPr7G5lW4ktJy/8qhbYlcETfJFAxng/NRFc=
Date: Thu, 24 Oct 2024 07:41:07 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ba98be-d35bae@github.com>
Subject: [bluez/bluez] f93a73: shared/bap: Fix crash on bt_bap_stream_disable
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
  Commit: f93a73b2a54c8b742f601bd3e15b6fb8407e4f44
      https://github.com/bluez/bluez/commit/f93a73b2a54c8b742f601bd3e15b6fb8407e4f44
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-10-24 (Thu, 24 Oct 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix crash on bt_bap_stream_disable

Calls to bt_bap_stream_disable with unicast stream shall result in
stream_disable if when acting as a server (!stream->client) otherwise it
may lead to the following trace:

bluetoothd[104990]: src/shared/bap.c:bap_queue_req() req 0x555555732470 (op 0x05) queue 0x55555571e850
bluetoothd[104990]: src/gatt-database.c:send_notification_to_device() GATT server sending notification
bluetoothd[104990]: src/shared/bap.c:stream_notify_state() stream 0x55555571b7f0
bluetoothd[104990]: src/shared/bap.c:stream_notify_qos() stream 0x55555571b7f0
bluetoothd[104990]: src/gatt-database.c:send_notification_to_device() GATT server sending notification
bluetoothd[104990]: src/shared/bap.c:bap_process_queue()
bluetoothd[104990]: src/shared/bap.c:bap_send() req 0x555555732470 len 3

Program received signal SIGSEGV, Segmentation fault.
bap_send (bap=bap@entry=0x555555730c50, req=req@entry=0x555555732470) at src/shared/bap.c:1490

Fixes: https://github.com/bluez/bluez/issues/991


  Commit: d35bae15152bb61008f4ca5643184377ef31c7ff
      https://github.com/bluez/bluez/commit/d35bae15152bb61008f4ca5643184377ef31c7ff
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2024-10-24 (Thu, 24 Oct 2024)

  Changed paths:
    M gobex/gobex.c

  Log Message:
  -----------
  obex: Resolve SRM issue for PTS testcases

Add check for unknown/undefined srm value.

This fix is required to pass the below the PTS testcases :
1. OPP/SR/GOEP/SRM/BI-02-C
2. FTP/SR/GOEP/SRM/BI-02-C
3. PBAP/PSE/GOEP/SRM/BI-05-C

Description - Verify that the Server ignores a SRM header with an
invalid value in the PUT/GET request and carries on with the
PUT/GET operation with SRM disabled.

Current Behaviour - Server is sending SRM enable in the response even
though receiving the unknown SRM value.

To fix this, I have added the check to verify the valid SRM values
before continuing with SRM enable.


Compare: https://github.com/bluez/bluez/compare/ba98be035621...d35bae15152b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
