Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47438215C6D
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731017433; cv=none; b=KE2i+5e41wDcgY76xUug0hllYVrQg6VARXXbrJalcZvW7/sra/0nwmvEvZ0b1guZVUIV1Yuuh0FxC31eCd4uoL/94p9iuisxzk7Jn5GlP6kLMwXnw3TiR/z/J64AYyfKPMSG0jX9xao1RDvASTX4EVoE6cv6Jlx6M6QDhjNOCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731017433; c=relaxed/simple;
	bh=+ORDH0V3L+rdOqMv/DGYKl6/roIqDWPeI6SjQqpseYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIpBIQ2tTCle+rha0DY1Du+DZVeq1xLL0OKQgHAN/AIROAHfjAbTolw/FoK0NoYdDLjxRCFPO4EsWmKuY0yud0IjO+OB5IE/wkpY7/7NEcrvInpnMch/KYYo1BW6E0ZIxjAU5KxSGdMgc5e0XVUaTXz4b37QTyUxGZDYfViXffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ahfL/HmW; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ahfL/HmW"
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 69FCC120032;
	Fri,  8 Nov 2024 01:01:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 69FCC120032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731016906;
	bh=SWgkR9fhVPZ4h/1TCyD08IAmuTcMER+tqy9lZ8jnq/Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ahfL/HmW+QISTj7j6YJ7BSimMJm2U1gpM5uKTxDrIBYKejY6mrJ8bb+gNX+6gx9mG
	 QLvR9nVL4E5Ne6bkKAgIfXAH+jnCU65PMzwNI4sbwZtpAE5dfjR63JN+rvZHvTAlZL
	 JWhsLNARa1Ij4oviBvNsREMz4SpnOq2Kpwhly7oXVz/5YxVUlCdY4N4kTyvks3I7g9
	 15zUp2lnYR4n/jPfYVoDqkbC5aLIntelHbhqgkA8ld7u/lkRKPLeuwFAOk4d7MmGud
	 gg3DcJLxXYLblktGvtGsx/FmYEvX4k+D7nhGvsG8ouxWa6M223kmSSKwPCjZBGeuPO
	 4lew4LUsovS6Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri,  8 Nov 2024 01:01:46 +0300 (MSK)
From: Victor Pushkarev <VAnPushkarev@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <sdfw_system_team@salutedevices.com>, <corvinus.v@gmail.com>, Victor
 Pushkarev <VAnPushkarev@salutedevices.com>
Subject: [PATCH BlueZ 2/2] a2dp: Reject incoming connection when channel limit is exceeded
Date: Fri, 8 Nov 2024 01:01:20 +0300
Message-ID: <20241107220121.97417-3-VAnPushkarev@salutedevices.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241107220121.97417-1-VAnPushkarev@salutedevices.com>
References: <20241107220121.97417-1-VAnPushkarev@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189034 [Nov 07 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: vanpushkarev@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_phishing_log_reg_50_60}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/07 18:44:00 #26832432
X-KSMG-AntiVirus-Status: Clean, skipped

Add counting of active audio streams at MediaEndpoint level.

Reject incoming connection at the audio stream setting stage
when the configured A2DP channel limit is exceeded.

---
 profiles/audio/a2dp.c  |  9 +++++++++
 profiles/audio/media.c | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c97bd6e89..935873d07 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -716,6 +716,15 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 			return TRUE;
 		}
 
+		if (ret == -1) {
+			/* Reject connection from SEP
+			* and clear configuration.
+			*/
+			DBG("Reject connection from %s", device_get_path(setup->chan->device));
+			a2dp_sep->endpoint->clear_configuration(a2dp_sep, a2dp_sep->user_data);
+			device_request_disconnect(setup->chan->device, NULL);
+		}
+
 		setup_error_init(setup, AVDTP_MEDIA_CODEC,
 					AVDTP_UNSUPPORTED_CONFIGURATION);
 		setup_unref(setup);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 746e538fc..20b860f6a 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -33,6 +33,7 @@
 #include "src/dbus-common.h"
 #include "src/profile.h"
 #include "src/service.h"
+#include "src/btd.h"
 
 #include "src/uuid-helper.h"
 #include "src/log.h"
@@ -134,6 +135,7 @@ struct media_player {
 };
 
 static GSList *adapters = NULL;
+static unsigned int active_streams;
 
 static void endpoint_request_free(struct endpoint_request *request)
 {
@@ -302,6 +304,9 @@ done:
 
 static void clear_endpoint(struct media_endpoint *endpoint)
 {
+	if (active_streams > 0)
+		active_streams--;
+
 	media_endpoint_cancel_all(endpoint);
 
 	while (endpoint->transports != NULL)
@@ -659,6 +664,12 @@ static int set_config(struct a2dp_sep *sep, uint8_t *configuration,
 	struct media_endpoint *endpoint = user_data;
 	struct a2dp_config_data *data;
 
+	active_streams++;
+	if (active_streams > btd_opts.a2dp.channels) {
+		DBG("A2DP channel limit (%u) exceeded", btd_opts.a2dp.channels);
+		return -1;
+	}
+
 	data = g_new0(struct a2dp_config_data, 1);
 	data->setup = setup;
 	data->cb = cb;
-- 
2.39.3 (Apple Git-146)

