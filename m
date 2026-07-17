Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEAB3FBEB3
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295330; cv=none; b=S0qKA2eSSxbEcV0rl6o7cvarKPRqQlS5yuXFF7Jvr1jZOCU8TnjYCyM3B/w3i4eyr/1a+sZYvq5+KVo/BgKZ9xBYyyePP2775xqz6KZvwCUzKTHGrigZsXTHg4MDOQ5AAIVmuqAwEh01zjd/bEIgg9Ht0iGObvpVtcHoSqBhO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295330; c=relaxed/simple;
	bh=MDZ4J2+IX6YDxvQw7pJ/1cKJpmI4EVw0j258XwRidwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXrMoysXi5vxuwjYqxq8KMkHPgaL/EBn9BZ3VC344DcnYTCf2C+Qc0LhfnAEzcgkRkvFBjNI6TwNaAjR0EmWaCWeF9/u1GxdNw39Sx4jnSKoLBQmm7xttCFL5JL+gfLfGBQIBbqWGKFmAY+C4BKdG8St1/UxymAIG60Sw5k7Foc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YsVziY6o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SsS08+FR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YsVziY6o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SsS08+FR"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCT5HB1619181
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pmTP0U4YXi1
	embJfeOuLS4RURxBzbN/rtRK4puMhA6E=; b=YsVziY6obUa2zYX/xi7rWR97a80
	KvNEvo5lPCMN5c9V778DVqJNVQyK88vvUW55B/tdJ97mAw+c5HhTp7sZ4bqnUdkW
	inhXjNYZ+TjisDpqjaNRpX1SbAIjZDEGuDI15ymaghZQiarElgLHQ4XDJwhLnLzp
	8sT0N6Fe7g1ZAwblcto+Y94nAnXAmPV7OxFgFsZ1rDATyzBwDKHAyHcGfdIP0BsD
	FDdV/Ey9YELHkOsobO6STK/8Ujwd/Yn8OQSxmRknIAH6tgT2VHUomb6knyFYg7dz
	sNuP5zvqpZCiY0SpKcWoIfpJp/0aR08ffAkQGGfmWhpnk+JUAV3HkPILw6w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fffag9fk5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:35:28 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8894570b58so3404995a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 06:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784295328; x=1784900128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pmTP0U4YXi1embJfeOuLS4RURxBzbN/rtRK4puMhA6E=;
        b=SsS08+FRlJIpTX9jC1HSurhmq/1iJqlJtjaEgbcvQqrZfs6WWj990qN/ofA+mrBbh3
         9+9998ZMisx4z4tR2bnqJDANToDnA8e4ZYOr4ZBMmOjDUdYRJIeiCsrhFJxAAUgLF2DC
         eIArHPrQIdOfbTOTvY9dBqLEyX5GttdRCCjjVci0TV+PRBEhx/kSBhvqZNmURQK97Yf/
         jbgCdhJlZ92uni7+blZINXqXBlmNm6PutWt1ujHjhH8ldAk7xoti/+pPJfmdlURJMihW
         i3aO2sZ31Rz4zqTEdcWpc1OtxBOS3pJprwO3hbsZ9yptShWFzbPhDgG1w2iYUDQ9A3bT
         q0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295328; x=1784900128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pmTP0U4YXi1embJfeOuLS4RURxBzbN/rtRK4puMhA6E=;
        b=Flc6Wk5APcRmT/dMKlDijinQMhHivoO2iSXZIFsOrwdj8zPwMEyPKJJMVKZOc3W9Ro
         VGY3qveV9Hm6avyAaf4m7AUD9Qv9iF4x3oEmX5+bKx7iUYnGseHzVcYrkYRSjUoG4IZp
         B4emkPzB/ZN6FltrYmRxMpL08le5uBifiBE4Fb41wiu14uRfgOLb/hLTGgQy/Ro1+lgK
         ACzolcA6mkyi4FGRurf1ELS+SN7IRNMKm+KP+c0fJbofxZswhxJMRp/XU5REI2jFLMtM
         qFZC9wYwgLsArKgDUXe6Y61iX4TaQQPvnfiJpVRWxuTv20VqFUMPpTbk2iEuCO2VZwjH
         7tTw==
X-Gm-Message-State: AOJu0YxJ0fWSRGB5SZoHr01zAGXlGmBgB+HSl8gtBUxyyDc3Hm6UDIj8
	x8fZuiyc/r1A4sVzE9duU8X09fozHXWBcZgGb21HpHPWvc9uGswPX89XN4m/iVsbnibWSd+Gb4m
	treyNtaC9e25+AMEjjCRMc5eLa0x7fH//GwcIZI6THO37M9Mi8K+GdmMr5m4mGvG5VhnGtWD5mr
	81wDQ=
X-Gm-Gg: AfdE7cnPOItO2C8qrHcR2+DtNv++SJRYlR9Zb7PxmKgVvaNyy5PDoth/T/QD6u6ouTY
	2Md6/9oKsXK3+2nTwlXoKrekOTp/XUaphwvadQZforI0KIisBkDDFBnaXyqp2oUMO1DPPUtzGdw
	1Zvhlz39MFPhYTUSygw4+iX5zXPHx8iuMJbDgg2K5qeovWSBLWGojdiioaztqDfH8Vp6IAobrX/
	/SxiPdLA3REZdYFAB9xfWCyTOO2Qw6y1QFqoFX1NAg0ZXOClyHr+c2fPl5viI/miXo3mA9gbF+N
	7YQga615mURWjTnm7ptpr2BF0ZUXrmnrzjXH44TpUBEISB0/5O/YK9Tu78YnobOvjilEuAKobb2
	rSTdnbwY81drSFT2Meq372LJC0QSt+A==
X-Received: by 2002:a17:90b:5104:b0:38d:66:5e6f with SMTP id 98e67ed59e1d1-38e4b3d0fe5mr2621708a91.3.1784295327314;
        Fri, 17 Jul 2026 06:35:27 -0700 (PDT)
X-Received: by 2002:a17:90b:5104:b0:38d:66:5e6f with SMTP id 98e67ed59e1d1-38e4b3d0fe5mr2621673a91.3.1784295326829;
        Fri, 17 Jul 2026 06:35:26 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fe4677sm6648774eec.11.2026.07.17.06.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:35:26 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 3/4] client: Add create_context CS config parameter
Date: Fri, 17 Jul 2026 19:05:02 +0530
Message-Id: <20260717133503.3711396-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717133503.3711396-1-naga.akella@oss.qualcomm.com>
References: <20260717133503.3711396-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzOCBTYWx0ZWRfXzsIP/CD/Ez60
 CersDftp9USyipK+C1ak/k3dqNLlihLBzpHoYCzMHvHC42oxuXWfncny9bX0L/WrfGv6d6YghKQ
 9MGPuGQWs4uJIu264Exlo1zjhdM4kyEZ6M+BFbuKjrUW+jOeaRmi+wOSZTCvSMmVpUl0irxvTd/
 cyjRVoiIDsNgaqRF+d98k7V5qS+qxz40Bn568H9PG3jzDPbiA1Ph+oV1nED+F/cUq1uLu/rro5Q
 ByP9OjrElTR//mupyYohohUXe3UyqzLssFvkCtATZvyV4xuC6+c2hzvXHL2TbAMFZ0pmSVJTPwS
 G0NIrut0XOYOndI0ehwxOOxcfYSNtCaI/6+wQiVeylle5gO8L2O04QfXMIDqaNxhpvvauXjSFfG
 cft2H5FnTiPF6FGld8kD7H8eVeQ+PotpXaZKK7sNKW+B5ACDvGn5mgOX3/MHbv859tkHomwtmrL
 qOPgKtRVq/feqldhKeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzOCBTYWx0ZWRfX405d4fk3HmEQ
 6hbbtERLEjdavVEIyPCd/AH5HLJ3wnFhCT6xUZbc7kg2r2b+jcadkmnUPXTsD5IbHxN7D+8a37S
 iwlVKYEOegHBUpDz7NkByGv/u+HJBvA=
X-Authority-Analysis: v=2.4 cv=KZfidwYD c=1 sm=1 tr=0 ts=6a5a2fa0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=eURh8m6ufyhiUoaTkDoA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: YAGEzF6fZtsYEBMFgaykjMMyPud0egp8
X-Proofpoint-ORIG-GUID: YAGEzF6fZtsYEBMFgaykjMMyPud0egp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170138

- Add the create_context field to the CS config parameter table so
bluetoothctl can control whether cs.start writes the CS configuration
to the local Controller only (0x00) or to both local and remote
Controllers via the CS Configuration procedure (0x01), matching the
Create_Context field of the LE CS Create Config HCI command
- Change the license in cs.c and cs.h.
- Drop RangingInterface support for now,
as it is still under discussion.
---
 client/cs.c | 109 +++++++++-------------------------------------------
 client/cs.h |   2 +-
 2 files changed, 19 insertions(+), 92 deletions(-)

diff --git a/client/cs.c b/client/cs.c
index 89251b502..9f069589d 100644
--- a/client/cs.c
+++ b/client/cs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1-or-later
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  BlueZ - Bluetooth protocol stack for Linux
  *
@@ -25,21 +25,6 @@
 
 static GList * cs_proxies;
 static GList **cs_device_list;
-static DBusConnection *dbus_conn;
-
-#define RANGING_INTERFACE "org.bluez.ChannelSoundingRanging1"
-#define RANGE_ESTIMATE     "RangeEstimate"
-
-/* One signal watch per device proxy, so each device's RangeEstimate
- * watch can be independently added/removed instead of clobbering a
- * single shared handle.
- */
-struct cs_watch {
-	GDBusProxy *proxy;
-	guint watch_id;
-};
-
-static GList *cs_watches;
 
 /* ---- Per-device active session ---- */
 
@@ -58,6 +43,7 @@ static uint8_t cs_sync_ant    = 0xFF;
 static int8_t  cs_max_tx_power = 0x14;
 
 static struct {
+	uint8_t create_context;
 	uint8_t config_id;
 	uint8_t main_mode_type;
 	uint8_t sub_mode_type;
@@ -75,6 +61,7 @@ static struct {
 	uint8_t channel_jump;
 	uint8_t companion_signal_enable;
 } cs_cfg = {
+	.create_context          = 0x01,
 	.config_id               = 0x00,
 	.main_mode_type          = 0x01,
 	.sub_mode_type           = 0xFF,
@@ -138,6 +125,10 @@ struct cs_param_desc {
 };
 
 static const struct cs_param_desc cs_param_table[] = {
+	{ .name = "create_context", .type = CS_PARAM_U8_RANGE,
+		.field = &cs_cfg.create_context, .min = 0, .max = 1,
+		.range_error = "create_context: 0x00=local only"
+				" 0x01=local and remote\n" },
 	{ .name = "sync_ant_sel", .type = CS_PARAM_U8, .field = &cs_sync_ant },
 	{ .name = "config_id", .type = CS_PARAM_U8,
 		.field = &cs_cfg.config_id },
@@ -195,74 +186,14 @@ static const struct cs_param_desc cs_param_table[] = {
 		.field = &cs_freq.snr_control_reflector },
 };
 
-static gboolean range_estimate_cb(DBusConnection *connection,
-					DBusMessage *msg, void *user_data)
-{
-	GDBusProxy *proxy = user_data;
-	DBusMessageIter iter;
-	double distance;
-	uint8_t confidence;
-
-	if (!dbus_message_iter_init(msg, &iter))
-		return TRUE;
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_DOUBLE)
-		return TRUE;
-
-	dbus_message_iter_get_basic(&iter, &distance);
-	dbus_message_iter_next(&iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BYTE)
-		return TRUE;
-
-	dbus_message_iter_get_basic(&iter, &confidence);
-
-	bt_shell_printf("[CS] %s Distance: %.3f m  Confidence: %u%%\n",
-			g_dbus_proxy_get_path(proxy), distance, confidence);
-
-	return TRUE;
-}
-
-static struct cs_watch *cs_find_watch(GDBusProxy *proxy)
-{
-	struct cs_watch *w;
-	GList *list;
-
-	for (list = g_list_first(cs_watches); list; list = g_list_next(list)) {
-		w = list->data;
-
-		if (w->proxy == proxy)
-			return w;
-	}
-
-	return NULL;
-}
-
 void cs_proxy_added(GDBusProxy *proxy)
 {
-	struct cs_watch *w;
-
 	cs_proxies = g_list_append(cs_proxies, proxy);
-
-	if (!dbus_conn)
-		dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
-
-	if (!dbus_conn)
-		return;
-
-	w = g_new0(struct cs_watch, 1);
-	w->proxy = proxy;
-	w->watch_id = g_dbus_add_signal_watch(dbus_conn, NULL,
-					g_dbus_proxy_get_path(proxy),
-					RANGING_INTERFACE, RANGE_ESTIMATE,
-					range_estimate_cb, proxy, NULL);
-	cs_watches = g_list_append(cs_watches, w);
 }
 
 void cs_proxy_removed(GDBusProxy *proxy)
 {
 	struct cs_session *s;
-	struct cs_watch *w;
 	GList *list;
 
 	cs_proxies = g_list_remove(cs_proxies, proxy);
@@ -277,13 +208,6 @@ void cs_proxy_removed(GDBusProxy *proxy)
 			break;
 		}
 	}
-
-	w = cs_find_watch(proxy);
-	if (w) {
-		g_dbus_remove_watch(dbus_conn, w->watch_id);
-		cs_watches = g_list_remove(cs_watches, w);
-		g_free(w);
-	}
 }
 
 /* Drop any active CS session for a device proxy path on disconnect. */
@@ -506,6 +430,8 @@ static void start_measurement_setup(DBusMessageIter *iter, void *user_data)
 	dict_append_byte(&dict, "max_tx_power",    tx);
 
 	/* CS config */
+	dict_append_byte(&dict, "create_context",
+			 cs_cfg.create_context);
 	dict_append_byte(&dict, "config_id",
 			 cs_cfg.config_id);
 	dict_append_byte(&dict, "main_mode_type",
@@ -951,6 +877,9 @@ static void cmd_cs_show(int argc, char *argv[])
 	bt_shell_printf("  max_tx_power   : %d dBm\n", cs_max_tx_power);
 
 	bt_shell_printf("\n=== CS Config Params ===\n");
+	bt_shell_printf("  create_context          : %u"
+			" (0=local only 1=local+remote)\n",
+			cs_cfg.create_context);
 	bt_shell_printf("  config_id               : %u\n",
 			cs_cfg.config_id);
 	bt_shell_printf("  main_mode_type          : 0x%02x\n",
@@ -1051,6 +980,12 @@ static const struct bt_shell_menu cs_menu = {
 				"Max TX power in dBm, signed (default 20)" },
 	{ "config_id", "<value>", cmd_cs_set,
 				"CS configuration identifier (default 0)" },
+	{ "create_context", "<0|1>", cmd_cs_set,
+				"0x00 writes the CS config to the local"
+				" Controller only; 0x01 also writes it to"
+				" the remote Controller via the CS"
+				" Configuration procedure (default 1)",
+				cs_bool_generator },
 	{ "main_mode_type", "<1|2|3>", cmd_cs_set,
 				"1 Mode 1 (RTT), 2 Mode 2 (PBR), 3 Both"
 				" (default 1)",
@@ -1144,14 +1079,6 @@ void cs_remove_submenu(void)
 	g_list_free_full(cs_sessions, g_free);
 	cs_sessions = NULL;
 
-	while (cs_watches) {
-		struct cs_watch *w = cs_watches->data;
-
-		g_dbus_remove_watch(dbus_conn, w->watch_id);
-		cs_watches = g_list_remove(cs_watches, w);
-		g_free(w);
-	}
-
 	g_list_free(cs_proxies);
 	cs_proxies = NULL;
 }
diff --git a/client/cs.h b/client/cs.h
index 8902c8143..243d2a72b 100644
--- a/client/cs.h
+++ b/client/cs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1-or-later
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  BlueZ - Bluetooth protocol stack for Linux
  *
-- 

