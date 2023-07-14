Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141C6EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jul 2023 18:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbjGNSPe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjGNSP3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jul 2023 14:15:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDA62722
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 11:15:06 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68336d06620so2151316b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689358504; x=1691950504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJVdFSWCiQFyuKHB74EapuxZyjnN4YRnz/xUvxkXk0M=;
        b=PUdGa+3j3XrQmrX+yTo8XATd7JpGrmKlQ41E+r011+MQo4hjENbsJ0vHx0rxqvjqr4
         TRASTkDHMcQ99OdgbDBD8zbJ1tR61tUnOJb2C6Xngr4DxiP68cU9eDkyoZTIoS+9Unjg
         vGAyC3SwFCowiWfw9e6rCno/ZXAZXIi+UJJ5JgBrZHsyOwFyJxdJP60SA63gxsKf8SX4
         g0WrJ3xeKua03ceNHG5023W27lUdtrrw3jvpAJAKBMSccKMEcqa8v4k8d1oQO3KTi2Qc
         0FepLX40s2mIbAihrFsZqVGV1vE2pwPXg7LM1d00pmEjTtqeC7Q9zbNXeb+YZ6WYtncV
         CblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689358504; x=1691950504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJVdFSWCiQFyuKHB74EapuxZyjnN4YRnz/xUvxkXk0M=;
        b=XJaVX2vB/lDhhaO0vZVXWs100KZgOQpL+c05vlArAlvyYJYvC/cHfhD9nh4zekaq6Y
         vD0rTrnVY2VINTFaxtQrK1DDImcfCLjmu+dB0BAldJvhSrUsDSiQz6xHJQgrSdWJfugZ
         C0N4rLv8YLLlJN2TjUoBA6QuzHGRdGxCrC0oaby0+TP9E8R1ty/TVc4NaK2saAmXmp2+
         nD3BdL5yLeMPWiNuEToRhtZUSmSatbAOHM8uufjhlXRoR0eYOLGWs47LKVV2CIuYjfP2
         ZC82475l0MBHOEDZwF7h9Auz+cXGfgx647JqHzMGoWrl+QQFTJFT6kYMFBk92yV2eLBj
         N0uA==
X-Gm-Message-State: ABy/qLadwMSX4+48NbXsL2wo15UTmcBpg5gtX3vZ8MHDprIByBL6e+5Y
        OegaaWj3q46jsfLbd7boOTNCuo0+wbk=
X-Google-Smtp-Source: APBJJlGnP97MIk4BLjBKN9TkSvarz+n/odAUJJL/Oher5nsNgq/ECSzKoNoWvUyVlMiJ8BigasM4WQ==
X-Received: by 2002:a05:6a20:8e0a:b0:12f:bc36:4c67 with SMTP id y10-20020a056a208e0a00b0012fbc364c67mr6327739pzj.61.1689358504544;
        Fri, 14 Jul 2023 11:15:04 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id bt19-20020a632913000000b0054ff075fb31sm7800508pgb.42.2023.07.14.11.15.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:15:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] iso-tester: Add test for BT_PKT_STATUS sockopt
Date:   Fri, 14 Jul 2023 11:15:00 -0700
Message-Id: <20230714181500.2371014-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714181500.2371014-1-luiz.dentz@gmail.com>
References: <20230714181500.2371014-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a test for setting BT_PKT_STATUS sockopt and checks if
BT_SCM_PKT_STATUS is properly received.
---
 tools/iso-tester.c | 91 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index ae3eb684e830..8f43d7becf16 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -400,6 +400,7 @@ struct iso_client_data {
 	bool disconnect;
 	bool ts;
 	bool mconn;
+	uint8_t pkt_status;
 	const uint8_t *base;
 	size_t base_len;
 };
@@ -833,6 +834,14 @@ static const struct iso_client_data listen_16_2_1_recv_ts = {
 	.ts = true,
 };
 
+static const struct iso_client_data listen_16_2_1_recv_pkt_status = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+	.pkt_status = 0x02,
+};
+
 static const struct iso_client_data defer_16_2_1 = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -1322,6 +1331,7 @@ static void test_setsockopt(const void *test_data)
 	int sk, err;
 	socklen_t len;
 	struct bt_iso_qos qos = QOS_16_1_2;
+	int pkt_status = 1;
 
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO);
 	if (sk < 0) {
@@ -1350,6 +1360,26 @@ static void test_setsockopt(const void *test_data)
 		goto end;
 	}
 
+	err = setsockopt(sk, SOL_BLUETOOTH, BT_PKT_STATUS, &pkt_status,
+			 sizeof(pkt_status));
+	if (err < 0) {
+		tester_warn("Can't set socket BT_PKT_STATUS option: "
+				"%s (%d)", strerror(errno), errno);
+		tester_test_failed();
+		goto end;
+	}
+
+	len = sizeof(pkt_status);
+	memset(&pkt_status, 0, len);
+
+	err = getsockopt(sk, SOL_BLUETOOTH, BT_PKT_STATUS, &pkt_status, &len);
+	if (err < 0) {
+		tester_warn("Can't get socket option : %s (%d)",
+							strerror(errno), errno);
+		tester_test_failed();
+		goto end;
+	}
+
 	tester_test_passed();
 
 end:
@@ -1678,12 +1708,24 @@ static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 	struct test_data *data = user_data;
 	const struct iso_client_data *isodata = data->test_data;
 	int sk = g_io_channel_unix_get_fd(io);
+	unsigned char control[64];
 	ssize_t ret;
 	char buf[1024];
+	struct msghdr msg;
+	struct iovec iov;
 
 	data->io_id[0] = 0;
 
-	ret = read(sk, buf, isodata->recv->iov_len);
+	iov.iov_base = buf;
+	iov.iov_len = isodata->recv->iov_len;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = control;
+	msg.msg_controllen = sizeof(control);
+
+	ret = recvmsg(sk, &msg, MSG_DONTWAIT);
 	if (ret < 0 || isodata->recv->iov_len != (size_t) ret) {
 		tester_warn("Failed to read %zu bytes: %s (%d)",
 				isodata->recv->iov_len, strerror(errno), errno);
@@ -1691,6 +1733,35 @@ static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
+	if (isodata->pkt_status) {
+		struct cmsghdr *cmsg;
+		uint8_t pkt_status = 0;
+
+		for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL;
+					cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+			if (cmsg->cmsg_level != SOL_BLUETOOTH)
+				continue;
+
+			if (cmsg->cmsg_type == BT_SCM_PKT_STATUS) {
+				memcpy(&pkt_status, CMSG_DATA(cmsg),
+						sizeof(pkt_status));
+				tester_debug("BT_SCM_PKT_STATUS = 0x%2.2x",
+							pkt_status);
+				break;
+			}
+		}
+
+		if (isodata->pkt_status != pkt_status) {
+			tester_warn("isodata->pkt_status 0x%2.2x != 0x%2.2x "
+					"pkt_status", isodata->pkt_status,
+					pkt_status);
+			tester_test_failed();
+		} else
+			tester_test_passed();
+
+		return FALSE;
+	}
+
 	if (memcmp(buf, isodata->recv->iov_base, ret))
 		tester_test_failed();
 	else
@@ -1715,7 +1786,7 @@ static void iso_recv(struct test_data *data, GIOChannel *io)
 
 	host = hciemu_client_get_host(data->hciemu);
 	bthost_send_iso(host, data->handle, isodata->ts, sn++, 0,
-				0x00, isodata->recv, 1);
+				isodata->pkt_status, isodata->recv, 1);
 
 	data->io_id[0] = g_io_add_watch(io, G_IO_IN, iso_recv_data, data);
 }
@@ -2250,6 +2321,18 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 		return false;
 	}
 
+	if (isodata->pkt_status) {
+		int opt = 1;
+
+		if (setsockopt(new_sk, SOL_BLUETOOTH, BT_PKT_STATUS, &opt,
+							sizeof(opt)) < 0) {
+			tester_print("Can't set socket BT_PKT_STATUS option: "
+					"%s (%d)", strerror(errno), errno);
+			tester_test_failed();
+			return false;
+		}
+	}
+
 	return iso_connect(io, cond, user_data);
 }
 
@@ -2448,6 +2531,10 @@ int main(int argc, char *argv[])
 							setup_powered,
 							test_listen);
 
+	test_iso("ISO Receive Packet Status - Success",
+						&listen_16_2_1_recv_pkt_status,
+						setup_powered, test_listen);
+
 	test_iso("ISO Defer - Success", &defer_16_2_1, setup_powered,
 							test_defer);
 
-- 
2.40.1

