Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2C54278
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560931; cv=none; b=nm2BzCS1wvYckWswwz7mocwBOJHZA3V7dYTiSBiEDe6gykZ54lkwpyWS7BQZamyaj1Wk89GfLCwzSvttfzPxsLEZrxQjOVcvFoIz56lC0+ps2T+ISnDYcKvemefFSCRWc5dp33aUghfs6vOYlop2XXt25lhLKsov2qtGsmQPRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560931; c=relaxed/simple;
	bh=hzJPxNb8Oqikg7QeWocFKZ08fGRugycSlDrKFzIiWmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qui/wAzlWI4kk2le4q415u4un518B/EBBSMaZrAPWg6mU9glwSE1AqeFcbacnrpHJBs/Wl9v6yq2eW/MrvtYSnTatoCkh81IFYDjdNNmf5VCBZGnkCOv7hzIBuc1ZzsRF7e/7g9rLYYK3eKNtnH9HkBEkHTHwvwxlGohyQps7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=J0F3pOhh; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="J0F3pOhh"
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 3E2AC100007;
	Mon, 29 Jan 2024 23:42:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3E2AC100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706560925;
	bh=vHEAGbu1C2lZSlpX+mRsbhFmyhhvQ+2s6XKh915JP3U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=J0F3pOhhkdEU5HueCAYKFQD+0cPN2HveMBJIVeaIa424qQsA0pbdYwlGq+1NCdv4O
	 zKpUncOnmB+BoZdg7niJfFeeOIGzgm/6mOc7eaBYBRyO9gv3xJL3Z7SK9ioxKqbCig
	 xM8So+1uQpaGlrIjVzFt/ikdjgmK9Z9L6SnPW9UVNYXrtkYxdB0q7wyhc+2N2XkJxs
	 tQ0lD91Ssb+QUiEtsAt69P57tMTmjNjuIiGP010d41WvnsR1nm59UCbCOwVMnpExuJ
	 Vrw+PzQ9iuC4FxRYXoyKbkzZQTj2a3WPmXxrziDfJQYOCx0AUOBT5Tr5r9CAOyD8uM
	 uCHWPhcpgQrWg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 29 Jan 2024 23:42:05 +0300 (MSK)
Received: from cab-wsm-0026722.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 23:42:04 +0300
From: Victor Pushkarev <VAnPushkarev@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <VAnPushkarev@salutedevices.com>, <sdfw_system_team@salutedevices.com>,
	<corvinus.v@gmail.com>
Subject: [PATCH BlueZ v1 2/2] a2dp: Reject connection when the channel limit is exceeded
Date: Mon, 29 Jan 2024 23:41:54 +0300
Message-ID: <20240129204154.95773-3-VAnPushkarev@salutedevices.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240129204154.95773-1-VAnPushkarev@salutedevices.com>
References: <20240129204154.95773-1-VAnPushkarev@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183024 [Jan 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: vanpushkarev@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/29 16:27:00 #23447558
X-KSMG-AntiVirus-Status: Clean, skipped

Reject incoming connection when the configured limit
for A2DP channels is exceeded.

Signed-off-by: Victor Pushkarev <VAnPushkarev@salutedevices.com>
---
 profiles/audio/a2dp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index b43161a13..117b27db3 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2549,6 +2549,14 @@ static void confirm_cb(GIOChannel *io, gpointer data)
 	if (!chan)
 		goto drop;
 
+	if (btd_opts.a2dp.channels &&
+				queue_length(server->channels) > btd_opts.a2dp.channels) {
+		device_request_disconnect(device, NULL);
+		DBG("Reject current connection, A2DP channel limit exceeded: %d",
+						btd_opts.a2dp.channels);
+		goto drop;
+	}
+
 	chan->auth_id = btd_request_authorization(&src, &dst,
 							ADVANCED_AUDIO_UUID,
 							auth_cb, chan);
-- 
2.39.3 (Apple Git-145)

