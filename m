Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55226C77B61
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 18:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDMSPg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Apr 2023 14:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMSPf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Apr 2023 14:15:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A1465A0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 11:15:33 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o2so15827108plg.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681409732; x=1684001732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L96TuqCPzayM+tlF1Q2ojmcW/QrB7+fyLCbAl8Wxyug=;
        b=Lla8yE7bxbsZ1FDadZi+hPJLzFlHTV9TX7nmdlnlMi76Q9UVcry36UPHD4FzZS6sVX
         /P4O5QNc4+z2kN/PiTmbD/Ym1E0i0m3RWODGpe7B+huAKAfuXdFAODAy1jLpdkRy8Qp/
         4bXuUce7dylJKp3uDrD9KOW5IRgrjdPf5rdaPpFoGHSp/UVRJyBF9gPfIzL9ubFUywb6
         JSsJSWxmzA9rzwWcM76E2l7C+PbOh4G2d/7LmoLNFVK6n5eXdeGIqOxLKyOiMbXh5jYo
         suAr6npUGjgZXYKLtSrSRwGHdnUUGirz9P25n675tq7IM83IpYK3CKaQw3/gfAkmzVlU
         qiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681409732; x=1684001732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L96TuqCPzayM+tlF1Q2ojmcW/QrB7+fyLCbAl8Wxyug=;
        b=WOEfvpEfFOHgemA7S7DlRdettrWWcyp4ArUh3RNzxg7r6ZD5Q/HO52rbdQCXA3a7cl
         63q4vPBBgU9vdgbN2QJizW8w6PL8zXpp65ZRziATpbLg5nAu2P12DYZ3UvLY2h0n8e62
         M3XxEg2vRbecUTKgl4lIJR5G2FODFui2CxIaJL93geq9ozmuag15RT2w3FXVeO6JGVQb
         emDOKg7X4TOslTWWX7/LbIqiA+NeTzYrfapCYRXRYnvgZ43UPXWh4pHb2CuvWycNoNqJ
         zMlOJkpkbxIZGb5qRTKxNYBMSPGujffa+3+JnLWhNgpLzXwI4mwAr16Drfnmf2X6/T8i
         AeXQ==
X-Gm-Message-State: AAQBX9eSvyoUlYbP012H2b0Wrt1KRigVsfCeeGqXQqNN1nSyojGJNbdh
        z34zasuBKmYp6BFrzsEbvBReJ7/QjRPlWQ==
X-Google-Smtp-Source: AKy350YWQ4IXgZDK+MljilcmzUUuvFjwYAKN1HakfSvvpFpN+hiEePg+ZDjG9SW8v55eXo6Tyg1YPQ==
X-Received: by 2002:a17:902:d512:b0:1a6:8548:e0ac with SMTP id b18-20020a170902d51200b001a68548e0acmr2888302plg.34.1681409732138;
        Thu, 13 Apr 2023 11:15:32 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id jn15-20020a170903050f00b001a1a9a639c2sm151921plb.134.2023.04.13.11.15.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 11:15:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] iso-tester: Add BAP Audio Configuration tests
Date:   Thu, 13 Apr 2023 11:15:28 -0700
Message-Id: <20230413181528.860660-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413181528.860660-1-luiz.dentz@gmail.com>
References: <20230413181528.860660-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following tests based on BAP Audio Configurations:

ISO AC 1 & 4 - Success
ISO AC 2 & 10 - Success
ISO AC 3 & 5 - Success
ISO AC 6(i) - Success
ISO AC 6(ii) - Success
ISO AC 7(i) - Success
ISO AC 7(ii) - Success
ISO AC 8(i) - Success
ISO AC 8(ii) - Success
ISO AC 9(i) - Success
ISO AC 9(ii) - Success
ISO AC 11(i) - Success
ISO AC 11(ii) - Success
---
 tools/iso-tester.c | 270 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 262 insertions(+), 8 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 0f10f8940f0f..61013c2150be 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -69,6 +69,11 @@
 		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
 		QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
 
+#define QOS_1_2(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_FULL(0x01, 0x02, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
+
 #define QOS_OUT(_interval, _latency, _sdu, _phy, _rtn) \
 	QOS_FULL(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
 		{}, QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
@@ -81,9 +86,22 @@
 	QOS_FULL(0x01, 0x01, \
 		{}, QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
 
+#define QOS_OUT_1_2(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_FULL(0x01, 0x02, \
+		{}, QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
+
 #define QOS_IN(_interval, _latency, _sdu, _phy, _rtn) \
 	QOS_FULL(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
 		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), {})
+#define QOS_IN_1(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_FULL(0x01, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), {})
+#define QOS_IN_1_1(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_FULL(0x01, 0x01, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), {})
+#define QOS_IN_1_2(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_FULL(0x01, 0x02, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), {})
 
 /* QoS Configuration settings for low latency audio data */
 #define QOS_8_1_1 QOS(7500, 8, 26, 0x02, 2)
@@ -122,6 +140,80 @@
 #define QOS_48_5_2 QOS_OUT(7500, 75, 117, 0x02, 13)
 #define QOS_48_6_2 QOS_OUT(10000, 100, 155, 0x02, 13)
 
+/* One unidirectional CIS. Unicast Server is Audio Sink */
+#define AC_1_4 QOS_OUT(10000, 10, 40, 0x02, 2)
+/* One unidirectional CIS. Unicast Server is Audio Source. */
+#define AC_2_10 QOS_IN(10000, 10, 40, 0x02, 2)
+/* One bidirectional CIS. Unicast Server is Audio Sink and Audio Source. */
+#define AC_3_5 QOS(10000, 10, 40, 0x02, 2)
+/* Two unidirectional CISes. Unicast Server is Audio Sink.
+ * #1 - CIG 1 CIS 1 (output)
+ * #2 - CIG 1 CIS 2 (output)
+ */
+#define AC_6i_1 QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
+#define AC_6i_2 QOS_OUT_1_2(10000, 10, 40, 0x02, 2)
+/* Two Unicast Servers. Unicast Server 1 is Audio Sink. Unicast Server 2 is
+ * Audio Sink.
+ * #1 - CIG 1 CIS auto (output)
+ * #2 - CIG 1 CIS auto (output)
+ */
+#define AC_6ii_1 QOS_OUT_1(10000, 10, 40, 0x02, 2)
+#define AC_6ii_2 QOS_OUT_1(10000, 10, 40, 0x02, 2)
+/* Two unidirectional CISes. Unicast Server is Audio Sink and Audio Source.
+ * #1 - CIG 1 CIS 1 (input)
+ * #2 - CIG 1 CIS 2 (output)
+ */
+#define AC_7i_1 QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
+#define AC_7i_2 QOS_IN_1_2(10000, 10, 40, 0x02, 2)
+/* Two Unidirectional CISes. Two Unicast Servers. Unicast Server 1 is Audio
+ * Sink. Unicast Server 2 is Audio Source.
+ * #1 - CIG 1 CIS auto (output)
+ * #2 - CIG 1 CIS auto (output)
+ */
+#define AC_7ii_1 QOS_OUT_1(10000, 10, 40, 0x02, 2)
+#define AC_7ii_2 QOS_IN_1(10000, 10, 40, 0x02, 2)
+/* One bidirectional CIS and one unidirectional CIS. Unicast Server is Audio
+ * Sink and Audio Source.
+ * #1 - CIG 1 CIS 1 (output)
+ * #2 - CIG 1 CIS 2 (input/output)
+ */
+#define AC_8i_1 QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
+#define AC_8i_2 QOS_1_2(10000, 10, 40, 0x02, 2)
+/* One bidirectional CIS and one unidirectional CIS. Two Unicast Servers.
+ * Unicast Server 1 is Audio Sink and Audio Source. Unicast Server 2 is
+ * Audio Sink.
+ * #1 - CIG 1 CIS auto (input/output)
+ * #2 - CIG 1 CIS auto (output)
+ */
+#define AC_8ii_1 QOS_1(10000, 10, 40, 0x02, 2)
+#define AC_8ii_2 QOS_OUT_1(10000, 10, 40, 0x02, 2)
+/* Two unidirectional CISes. Unicast Server is Audio Source.
+ * #1 - CIG 1 CIS 1 (input)
+ * #2 - CIG 1 CIS 2 (input)
+ */
+#define AC_9i_1 QOS_IN_1_1(10000, 10, 40, 0x02, 2)
+#define AC_9i_2 QOS_IN_1_2(10000, 10, 40, 0x02, 2)
+/* Two unidirectional CISes. Two Unicast Servers. Unicast Server 1 is Audio
+ * Source. Unicast Server 2 is Audio Source.
+ * #1 - CIG 1 CIS auto (input)
+ * #2 - CIG 1 CIS auto (input)
+ */
+#define AC_9ii_1 QOS_IN_1(10000, 10, 40, 0x02, 2)
+#define AC_9ii_2 QOS_IN_1(10000, 10, 40, 0x02, 2)
+/* Two bidirectional CISes. Unicast Server is Audio Sink and Audio Source.
+ * #1 - CIG 1 CIS 1 (input/output)
+ * #2 - CIG 1 CIS 2 (input/output)
+ */
+#define AC_11i_1 QOS_1_1(10000, 10, 40, 0x02, 2)
+#define AC_11i_2 QOS_1_2(10000, 10, 40, 0x02, 2)
+/* Two bidirectional CISes. Two Unicast Servers. Unicast Server 1 is Audio Sink
+ * and Audio Source. Unicast Server 2 is Audio Sink and Audio Source.
+ * #1 - CIG 1 CIS auto (input/output)
+ * #2 - CIG 1 CIS auto (input/output)
+ */
+#define AC_11ii_1 QOS_1(10000, 10, 40, 0x02, 2)
+#define AC_11ii_2 QOS_1(10000, 10, 40, 0x02, 2)
+
 #define QOS_BCAST_FULL(_big, _bis, _in, _out) \
 { \
 	.bcast = { \
@@ -182,6 +274,7 @@ struct test_data {
 
 struct iso_client_data {
 	struct bt_iso_qos qos;
+	struct bt_iso_qos qos_2;
 	int expect_err;
 	const struct iovec *send;
 	const struct iovec *recv;
@@ -190,6 +283,7 @@ struct iso_client_data {
 	bool defer;
 	bool disconnect;
 	bool ts;
+	bool mcis;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -684,6 +778,91 @@ static const struct iso_client_data reconnect_16_2_1 = {
 	.disconnect = true,
 };
 
+static const struct iso_client_data connect_ac_1_4 = {
+	.qos = AC_1_4,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_ac_2_10 = {
+	.qos = AC_2_10,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_ac_3_5 = {
+	.qos = AC_3_5,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_ac_6i= {
+	.qos = AC_6i_1,
+	.qos_2 = AC_6i_2,
+	.expect_err = 0,
+	.mcis = true,
+};
+
+static const struct iso_client_data connect_ac_6ii= {
+	.qos = AC_6ii_1,
+	.qos_2 = AC_6ii_2,
+	.expect_err = 0,
+	.mcis = true,
+};
+
+static const struct iso_client_data connect_ac_7i= {
+	.qos = AC_7i_1,
+	.qos_2 = AC_7i_2,
+	.expect_err = 0,
+	.mcis = true,
+};
+
+static const struct iso_client_data connect_ac_7ii= {
+	.qos = AC_7ii_1,
+	.qos_2 = AC_7ii_2,
+	.expect_err = 0,
+	.mcis = true,
+};
+
+static const struct iso_client_data connect_ac_8i= {
+	.qos = AC_8i_1,
+	.qos_2 = AC_8i_2,
+	.expect_err = 0,
+	.mcis = true,
+};
+
+static const struct iso_client_data connect_ac_8ii= {
+	.qos = AC_8ii_1,
+	.qos_2 = AC_8ii_2,
+	.expect_err = 0,
+	.mcis = true,
+};
+
+static const struct iso_client_data connect_ac_9i= {
+	.qos = AC_9i_1,
+	.qos_2 = AC_9i_2,
+	.expect_err = 0,
+	.mcis = true,
+};
+
+static const struct iso_client_data connect_ac_9ii= {
+	.qos = AC_9ii_1,
+	.qos_2 = AC_9ii_2,
+	.expect_err = 0,
+	.mcis = true,
+};
+
+static const struct iso_client_data connect_ac_11i= {
+	.qos = AC_11i_1,
+	.qos_2 = AC_11i_2,
+	.expect_err = 0,
+	.mcis = true,
+};
+
+static const struct iso_client_data connect_ac_11ii= {
+	.qos = AC_11ii_1,
+	.qos_2 = AC_11ii_2,
+	.expect_err = 0,
+	.mcis = true,
+};
+
 static const struct iso_client_data bcast_16_2_1_send = {
 	.qos = QOS_OUT_16_2_1,
 	.expect_err = 0,
@@ -1018,16 +1197,28 @@ static int connect_iso_sock(struct test_data *data, uint8_t num, int sk)
 	const struct iso_client_data *isodata = data->test_data;
 	struct hciemu_client *client;
 	const uint8_t *client_bdaddr = NULL;
+	const struct bt_iso_qos *qos = &isodata->qos;
 	struct sockaddr_iso addr;
 	char str[18];
 	int err;
 
 	client = hciemu_get_client(data->hciemu, num);
 	if (!client) {
-		tester_warn("No client");
-		return -ENODEV;
+		if (!isodata->mcis) {
+			tester_warn("No client");
+			return -ENODEV;
+		}
+
+		client = hciemu_get_client(data->hciemu, 0);
+		if (!client) {
+			tester_warn("No client");
+			return -ENODEV;
+		}
 	}
 
+	if (num && isodata->mcis)
+		qos = &isodata->qos_2;
+
 	if (!isodata->bcast) {
 		client_bdaddr = hciemu_client_bdaddr(client);
 		if (!client_bdaddr) {
@@ -1045,8 +1236,7 @@ static int connect_iso_sock(struct test_data *data, uint8_t num, int sk)
 		}
 	}
 
-	err = setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &isodata->qos,
-						sizeof(isodata->qos));
+	err = setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, qos, sizeof(*qos));
 	if (err < 0) {
 		tester_warn("Can't set socket BT_ISO_QOS option : %s (%d)",
 							strerror(errno), errno);
@@ -1122,11 +1312,15 @@ static bool check_io_qos(const struct bt_iso_io_qos *io1,
 }
 
 static bool check_ucast_qos(const struct bt_iso_qos *qos1,
-				const struct bt_iso_qos *qos2)
+				const struct bt_iso_qos *qos2,
+				const struct bt_iso_qos *qos2_2)
 {
 	if (qos1->ucast.cig != BT_ISO_QOS_CIG_UNSET &&
 			qos2->ucast.cig != BT_ISO_QOS_CIG_UNSET &&
 			qos1->ucast.cig != qos2->ucast.cig) {
+		if (qos2_2)
+			return check_ucast_qos(qos1, qos2_2, NULL);
+
 		tester_warn("Unexpected CIG ID: 0x%02x != 0x%02x",
 				qos1->ucast.cig, qos2->ucast.cig);
 		return false;
@@ -1135,29 +1329,44 @@ static bool check_ucast_qos(const struct bt_iso_qos *qos1,
 	if (qos1->ucast.cis != BT_ISO_QOS_CIS_UNSET &&
 			qos2->ucast.cis != BT_ISO_QOS_CIS_UNSET &&
 			qos1->ucast.cis != qos2->ucast.cis) {
+		if (qos2_2)
+			return check_ucast_qos(qos1, qos2_2, NULL);
+
 		tester_warn("Unexpected CIS ID: 0x%02x != 0x%02x",
 				qos1->ucast.cis, qos2->ucast.cis);
 		return false;
 	}
 
 	if (qos1->ucast.packing != qos2->ucast.packing) {
+		if (qos2_2)
+			return check_ucast_qos(qos1, qos2_2, NULL);
+
 		tester_warn("Unexpected QoS packing: 0x%02x != 0x%02x",
 				qos1->ucast.packing, qos2->ucast.packing);
 		return false;
 	}
 
 	if (qos1->ucast.framing != qos2->ucast.framing) {
+		if (qos2_2)
+			return check_ucast_qos(qos1, qos2_2, NULL);
+
 		tester_warn("Unexpected QoS framing: 0x%02x != 0x%02x",
 				qos1->ucast.framing, qos2->ucast.framing);
 		return false;
 	}
 
 	if (!check_io_qos(&qos1->ucast.in, &qos2->ucast.in)) {
+		if (qos2_2)
+			return check_ucast_qos(qos1, qos2_2, NULL);
+
 		tester_warn("Unexpected Input QoS");
 		return false;
 	}
 
 	if (!check_io_qos(&qos1->ucast.out, &qos2->ucast.out)) {
+		if (qos2_2)
+			return check_ucast_qos(qos1, qos2_2, NULL);
+
 		tester_warn("Unexpected Output QoS");
 		return false;
 	}
@@ -1404,9 +1613,10 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
-	if (!isodata->bcast)
-		ret = check_ucast_qos(&qos, &isodata->qos);
-	else if (!isodata->server)
+	if (!isodata->bcast) {
+		ret = check_ucast_qos(&qos, &isodata->qos,
+				      isodata->mcis ? &isodata->qos_2 : NULL);
+	} else if (!isodata->server)
 		ret = check_bcast_qos(&qos, &isodata->qos);
 
 	if (!ret) {
@@ -1549,8 +1759,13 @@ static void setup_connect(struct test_data *data, uint8_t num, GIOFunc func)
 static void test_connect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct iso_client_data *isodata = test_data;
 
 	setup_connect(data, 0, iso_connect_cb);
+
+	/* Check if configuration requires multiple CIS setup */
+	if (!isodata->bcast && isodata->mcis)
+		setup_connect(data, 1, iso_connect2_cb);
 }
 
 static void setup_reconnect(struct test_data *data, uint8_t num, GIOFunc func)
@@ -2001,6 +2216,45 @@ int main(int argc, char *argv[])
 							setup_powered,
 							test_reconnect);
 
+	test_iso("ISO AC 1 & 4 - Success", &connect_ac_1_4, setup_powered,
+							test_connect);
+
+	test_iso("ISO AC 2 & 10 - Success", &connect_ac_2_10, setup_powered,
+							test_connect);
+
+	test_iso("ISO AC 3 & 5 - Success", &connect_ac_3_5, setup_powered,
+							test_connect);
+
+	test_iso("ISO AC 6(i) - Success", &connect_ac_6i, setup_powered,
+							test_connect);
+
+	test_iso2("ISO AC 6(ii) - Success", &connect_ac_6ii, setup_powered,
+							test_connect2);
+
+	test_iso("ISO AC 7(i) - Success", &connect_ac_7i, setup_powered,
+							test_connect);
+
+	test_iso2("ISO AC 7(ii) - Success", &connect_ac_7ii, setup_powered,
+							test_connect2);
+
+	test_iso("ISO AC 8(i) - Success", &connect_ac_8i, setup_powered,
+							test_connect);
+
+	test_iso2("ISO AC 8(ii) - Success", &connect_ac_8ii, setup_powered,
+							test_connect2);
+
+	test_iso("ISO AC 9(i) - Success", &connect_ac_9i, setup_powered,
+							test_connect);
+
+	test_iso2("ISO AC 9(ii) - Success", &connect_ac_9ii, setup_powered,
+							test_connect2);
+
+	test_iso("ISO AC 11(i) - Success", &connect_ac_11i, setup_powered,
+							test_connect);
+
+	test_iso2("ISO AC 11(ii) - Success", &connect_ac_11ii, setup_powered,
+							test_connect2);
+
 	test_iso("ISO Broadcaster - Success", &bcast_16_2_1_send, setup_powered,
 							test_bcast);
 	test_iso("ISO Broadcaster BIG 0x01 - Success", &bcast_1_16_2_1_send,
-- 
2.39.2

