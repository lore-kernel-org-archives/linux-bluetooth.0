Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697DC19F133
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632037; cv=none; b=kOuhgkRFVsDPLA27udGvXaJ2o9d47XOjG8B8MvZxFWRmqGw8ONMhIxXsvEYlIBGcs0tcA3mGdHihnIhr3ZBGg2I4n/cMpMWFbWDQxkS/7ex4Jh0NeelyYAappHfObq+b18oB/7qjlg2Mm4eA/HM+txY3+PpxNQcM+ou6fepC9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632037; c=relaxed/simple;
	bh=3PBgQ1cR8kdEStlI+dzB1DIcq8ihf3Vgp971dz6Xxzc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ROvWsKLafnv08K7zhUPu7xbo/sfMjUM/dVDlht+URlUEp5nNfSlxg6qu84FGagZXfl9fp/e5O5Td9pqL+yXgqj8QF17AI/30TVFguWxJ6RrOc6bNzZWOkyy8oktb3kB1VuknxCwvFMpRxqO99jEOivDLoLVM8MGb3oHTUnp6nVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=c9Es8yci; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="c9Es8yci"
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2C293100003
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 14:50:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2C293100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1744631457;
	bh=QbJrurSnaheeNlXQCPoozzQUmwYPRkg80hSMyvfO7K8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=c9Es8yciEH4WlXMs4wdsSyftlaBHeArcXcn337fH0zQ9nPTgGtlDblMsVSO+InXXA
	 NNNqmo1sO9NDYnJmXj3kUkE8rPrAhTfA/J2jEVyQfruGHS2gfqIsLBNcxUCT5gy5DK
	 bTzNpryl+yvuYQ0ZOcyUJ/5gtbSXr0bOClkA2fNXAHp6GrCp5XeaOp6WgoaBL80Qow
	 aI1//aPaQ0lTaaFLuTPcSjlDqP/BNRV3e3iICl7sfWQpR2Wp2vxtQLBSwMThRK7Nuq
	 p7VcN/l5XEXXCw864JIOhJdRxlzx9W1nmwjyU91CXvUKMU05iTHgWi8pgoxdBqkf6A
	 xdzB8YISHOl7A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 14:50:57 +0300 (MSK)
From: Oleg Lyovin <ovlevin@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Oleg Lyovin <ovlevin@salutedevices.com>
Subject: [RFC PATCH BlueZ 0/1] device: Fix rare ERR_BREDR_CONN_BUSY during connect
Date: Mon, 14 Apr 2025 14:50:16 +0300
Message-ID: <20250414115017.116579-1-ovlevin@salutedevices.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-exch-cas-a-m1.sberdevices.ru (172.24.201.216) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 192610 [Apr 14 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: ovlevin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 54 0.3.54 464169e973265e881193cca5ab7aa5055e5b7016, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/04/14 08:03:00 #27884858
X-KSMG-AntiVirus-Status: Clean, skipped

Hello everyone,

While experimenting with a device acting as and A2DP Source, I have
encountered the following very rare case during connection to an
external speaker:

  1970-01-01 00:37:47 debug bluetoothd[240]: profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci0/dev_28_2B_B9_40_00_1B: SINK_STATE_CONNECTING -> SINK_STATE_DISCONNECTED
  1970-01-01 00:37:47 debug bluetoothd[240]: profiles/audio/avdtp.c:avdtp_unref() 0x17c1350: ref=1
  1970-01-01 00:37:47 debug bluetoothd[240]: profiles/audio/a2dp.c:channel_remove() chan 0x17ac468
  1970-01-01 00:37:47 debug bluetoothd[240]: profiles/audio/avdtp.c:avdtp_unref() 0x17c1350: ref=0
  1970-01-01 00:37:47 debug bluetoothd[240]: profiles/audio/avdtp.c:avdtp_free() 0x17c1350
  1970-01-01 00:37:50 debug bluetoothd[240]: src/shared/mgmt.c:can_read_data() [0x0000] event 0x000c
  1970-01-01 00:37:50 debug bluetoothd[240]: src/adapter.c:dev_disconnected() Device 28:2B:B9:40:00:1B disconnected, reason 2
  1970-01-01 00:37:50 debug bluetoothd[240]: src/adapter.c:adapter_remove_connection() 
  1970-01-01 00:37:50 debug bluetoothd[240]: src/device.c:device_remove_connection() connection removed while Connect() is waiting reply
  1970-01-01 00:37:50 debug bluetoothd[240]: plugins/policy.c:disconnect_cb() reason 2
  1970-01-01 00:37:50 debug bluetoothd[240]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 28:2B:B9:40:00:1B type 0 status 0xe
  1970-01-01 00:37:50 debug bluetoothd[240]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
  1970-01-01 00:37:50 debug bluetoothd[240]: src/device.c:device_bonding_failed() status 14

Subsequent attempts to connect using bluetoothctl lead to
"br-connection-busy":
  [bluetooth]# connect 28:2B:B9:40:00:1B
  Attempting to connect to 28:2B:B9:40:00:1B
  Failed to connect: org.bluez.Error.InProgress br-connection-busy

The reason is that "connect_profiles" does the following check:
  if (dev->pending || dev->connect || dev->browse)
    return btd_error_in_progress_str(msg, ERR_BREDR_CONN_BUSY);

In the above scenario, "dev->pending" is not NULL. I have prepared
the RFC patch that frees it when a disconnect occurs in the
"device_remove_connection" code path. I'm not sure if this is the
correct way to solve the issue, but with this patch it can no longer
be reproduced.

Oleg Lyovin (1):
  device: Fix rare ERR_BREDR_CONN_BUSY during connect

 src/device.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.34.1

