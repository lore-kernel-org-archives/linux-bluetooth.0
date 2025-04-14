Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CF8259C94
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631476; cv=none; b=mF8aL4VSG2F8ffZ9sqjUdEPgW9Nlt2yYnnk2svZBxcjsQMJ3lkGzRVnzhElaGbMbHc4WZt3mP2OMLROhBTsyPRNwG4tLFjbOH5VIaaeXE66zA1jJOqR3xzZOBHOS9EEEgV4waXdY1cuy6mtLbYu8xhoP9DvXjHdC4QsCdNu7hV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631476; c=relaxed/simple;
	bh=m0IcW22nN/DOVQ6P90M2V8GXunNmZeAccFAgc+tLfHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XF93AXDOmtu5zDb0T1FImcB4zkGINhQJ1bFwTwLiS81IYX0hGJe2INUf0eTCbA8ZgUf1L2EYJSuV3AYjIDemVgn/Dxhz0UmDd5I0JjKtHRgdt4NI7ehZXMZ/rVCdeStlYo++WQaAea4Hl7Z+tmAUQ9z3M5FwUzTKInmcyaMhTsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=h8sxDTlT; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="h8sxDTlT"
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8A5E4100009
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 14:51:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8A5E4100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1744631469;
	bh=gqyUN6ittu5K1TjKypTDER8RoTOqxp8GGH1XWq963UM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=h8sxDTlTyfv9TleXjokPTTihtbRW5Ei24NDIrzS78/5GhTtXkcIjTfMFYdF3/+bXy
	 IScpvxJAud2fmYgZYUSF72WKfj8urd7MZuRMlf9iLQ7CDOarkKYcEhv/UpBWkrOGYY
	 r0yPwyAc1QR8NiLWcsgW3PtWsEm5MeXl4ec80fI7tj19b5nR2Ih/EIRkaDW9gC5KuN
	 B1Ug+k9DzYgZZfLV+tcNpP88kda6Fz+YCKm1GAPICxcNdG2yDemkQx38Qkblhoe8V2
	 I1YxHCBt0COQQSa59EL/CK9MM8GbX584IPmRDJ7FY7U4KDNamuprtcijbgJ658qst4
	 qC7onG78CyURw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 14:51:09 +0300 (MSK)
From: Oleg Lyovin <ovlevin@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Oleg Lyovin <ovlevin@salutedevices.com>
Subject: [PATCH BlueZ 1/1] device: Fix rare ERR_BREDR_CONN_BUSY during connect
Date: Mon, 14 Apr 2025 14:50:17 +0300
Message-ID: <20250414115017.116579-2-ovlevin@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414115017.116579-1-ovlevin@salutedevices.com>
References: <20250414115017.116579-1-ovlevin@salutedevices.com>
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

Disconnect may happen while the connection to the device is not
finished, leading to device->pending list is not being freed. As a
result, subsequent connection attempts leads to ERR_BREDR_CONN_BUSY
error, making it impossible to establish a connection.

This patch frees device->pending list in such case.
---
 src/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/device.c b/src/device.c
index b82a905f9..a6840440c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1907,6 +1907,10 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
 		device->connect = NULL;
+
+		/* Connection does not exists anymore, so free pending services */
+		g_slist_free(device->pending);
+		device->pending = NULL;
 	}
 
 	if (btd_device_is_connected(device) && msg)
-- 
2.34.1

