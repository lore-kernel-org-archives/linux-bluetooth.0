Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A05C0015E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 22:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjGMWnK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 18:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjGMWnI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 18:43:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45084271C
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 15:43:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-668711086f4so794491b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 15:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689288185; x=1691880185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujGPO1ISGimR9OdwCY8sWPzAFBpmN+XxPTpRfopQtgQ=;
        b=qzk9kv08D7hSlWRmjAn11rFfPsABbnAuo311lshA7jV4fou7ab2bL0GwRgOcCMn+vS
         amNVifFB3OgHQvAy/eP4WYyUbFa8DnpENI8svzQX9iuLNLUV9/Zx55EBUs6d3tUr6Lif
         +6n6N4CjVyFxWzDrCdT2sfw6y76lggx25xF0KDBdgUxnyQTyFj6RHQj4C44gXWR7f+/V
         Rwui46rqybt7HVRjlitI3VxaJNuaEbH+O1LGSLcSY+LEkaklfMDTYHRzzhlVES5qQl2i
         g77a5hZmeEAABrQzTS97lwklJOAI45Q6FerhC21BWcw6NuMw7U+5qLx3s2+v+MEWCxgp
         5Z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689288185; x=1691880185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujGPO1ISGimR9OdwCY8sWPzAFBpmN+XxPTpRfopQtgQ=;
        b=ZUxM5wUfi6CO1w9a8xlQ+l0gRPabB4WSNXsY6+FJUNsS4mjSElG4Nk05MqLgB2zlCS
         uoWzOj4jw7bCfFqnPS9R6EM7+0xJKZVbXW2bbfq+q4N9JzZ5NWDeemgIiSVXtE48ucjo
         nf8Ut2gpPaONPZkZW3kL+N9iTxspxz0ZhEfmj/HhkW3Ig2gzPu5qOBMdUHUeo44QgiXf
         TJXoWiGxWKBK7VP1/gmf7zDu0XYvYpDTjIl4G2TFjQ2kzMVpsjCutpScTUvm/oG0E7Vv
         mr7PTjf/duGFDJlihLOFAnJgrpFeChAA6MNmaAIcVb+iazG04N9lgrLzCvNGsLflZzD9
         m/iA==
X-Gm-Message-State: ABy/qLYDikk8Z+gDrPHPKd4UrSdCF6X0fZ3tFLJrEDD2l3B89PCf3nJ+
        5URfwFXDtZRUiUSsiAnrockqghJzeTM=
X-Google-Smtp-Source: APBJJlFeK/No/L7QXpYbAUgdxWbV38FUPu2YO4sXGZBsIa9Vc31IYqbmeH7lWe4xeH6j/C8KouPqjg==
X-Received: by 2002:a05:6a20:430f:b0:10b:764b:a942 with SMTP id h15-20020a056a20430f00b0010b764ba942mr1208952pzk.11.1689288185020;
        Thu, 13 Jul 2023 15:43:05 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id t12-20020a63b24c000000b0055bf13811f5sm2568433pgo.15.2023.07.13.15.43.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 15:43:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] iso-tester: Add test for BT_PKT_STATUS sockopt
Date:   Thu, 13 Jul 2023 15:43:00 -0700
Message-Id: <20230713224300.2286788-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713224300.2286788-1-luiz.dentz@gmail.com>
References: <20230713224300.2286788-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a test for setting BT_PKT_STATUS sockopt and checks if
BT_SCM_PKT_STATUS is properly received.
---
 tools/iso-tester.c | 89 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 7140f83b2236..8f43d7becf16 100644
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

