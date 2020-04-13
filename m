Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D336C2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD8E20692
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586795149;
	bh=DQjlPiY6Eyps/1NaA+933ltNVayJQeghPvUr9J64T3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HBrHERGMRqe21kqizIIdDGxDvclEVazqWTZLIPoN/daF1oBXoxdgXmRNfqpndo1pl
	 45x6ZJxZ6oLKFa+znrP0mo0SGSEHojvrGFqWy5Uk2lCm3dU51J0CGm7jhT3ZcIYafe
	 02ImIHKHFrLJ9mRH9y+YplbIHBUkpbj1k3YTLQXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbgDMQZs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731527AbgDMQZq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 12:25:46 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DD0320692;
        Mon, 13 Apr 2020 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586795145;
        bh=DQjlPiY6Eyps/1NaA+933ltNVayJQeghPvUr9J64T3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwiyIM6xM9dsU2m458n3T+6DFcucp6Yo89yPhcAcB5GMQdTF2XBsK6WCOGCv+/am3
         +4LaxfXYJVom95S7+xhekj18F2qSr9Cio+FgG0RNYdWnOL7kFEveo2tgCbnrvV69Kp
         ZdTS0ozVqcHlFQlqbNl0f0lSi7ZAA/9IirQrPpOA=
Received: by pali.im (Postfix)
        id C6489895; Mon, 13 Apr 2020 18:25:43 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH 3/3] src/profile: Add default SDP record for Headset role of HSP 1.2 profile with Erratum 3507
Date:   Mon, 13 Apr 2020 18:25:13 +0200
Message-Id: <20200413162513.2221-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200413162513.2221-1-pali@kernel.org>
References: <20200321195404.fvyku5hmcuqxt7sg@pali>
 <20200413162513.2221-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This would allow DBus agents to implement HS role of HSP profile.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 src/profile.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index 3b7e08f26..09627fbbd 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -56,6 +56,7 @@
 
 #define DUN_DEFAULT_CHANNEL	1
 #define SPP_DEFAULT_CHANNEL	3
+#define HSP_HS_DEFAULT_CHANNEL	6
 #define HFP_HF_DEFAULT_CHANNEL	7
 #define OPP_DEFAULT_CHANNEL	9
 #define FTP_DEFAULT_CHANNEL	10
@@ -155,6 +156,49 @@
 		</attribute>						\
 	</record>"
 
+/* SDP record for Headset role of HSP 1.2 profile with Erratum 3507 */
+#define HSP_HS_RECORD							\
+	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>			\
+	<record>							\
+		<attribute id=\"0x0001\">				\
+			<sequence>					\
+				<uuid value=\"0x1108\" />		\
+				<uuid value=\"0x1131\" />		\
+				<uuid value=\"0x1203\" />		\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0004\">				\
+			<sequence>					\
+				<sequence>				\
+					<uuid value=\"0x0100\" />	\
+				</sequence>				\
+				<sequence>				\
+					<uuid value=\"0x0003\" />	\
+					<uint8 value=\"0x%02x\" />	\
+				</sequence>				\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0005\">				\
+			<sequence>					\
+				<uuid value=\"0x1002\" />		\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0009\">				\
+			<sequence>					\
+				<sequence>				\
+					<uuid value=\"0x1108\" />	\
+					<uint16 value=\"0x%04x\" />	\
+				</sequence>				\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0100\">				\
+			<text value=\"%s\" />				\
+		</attribute>						\
+		<attribute id=\"0x0302\">				\
+			<boolean value=\"%s\" />			\
+		</attribute>						\
+	</record>"
+
 #define HSP_AG_RECORD							\
 	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>			\
 	<record>							\
@@ -1789,6 +1833,16 @@ static char *get_hfp_ag_record(struct ext_profile *ext, struct ext_io *l2cap,
 				ext->have_features ? ext->features : 0x9);
 }
 
+static char *get_hsp_hs_record(struct ext_profile *ext, struct ext_io *l2cap,
+							struct ext_io *rfcomm)
+{
+	/* HSP 1.2: By default Remote Audio Volume Control is off */
+	return g_strdup_printf(HSP_HS_RECORD, rfcomm->chan, ext->version,
+				ext->name,
+				(ext->have_features && (ext->features & 0x1))
+				? "true" : "false");
+}
+
 static char *get_hsp_ag_record(struct ext_profile *ext, struct ext_io *l2cap,
 							struct ext_io *rfcomm)
 {
@@ -2012,6 +2066,16 @@ static struct default_settings {
 		.auto_connect	= true,
 		.get_record	= get_hfp_ag_record,
 		.version	= 0x0107,
+	}, {
+		.uuid		= HSP_HS_UUID,
+		.name		= "Headset unit",
+		.priority	= BTD_PROFILE_PRIORITY_HIGH,
+		.remote_uuid	= HSP_AG_UUID,
+		.channel	= HSP_HS_DEFAULT_CHANNEL,
+		.authorize	= true,
+		.auto_connect	= true,
+		.get_record	= get_hsp_hs_record,
+		.version	= 0x0102,
 	}, {
 		.uuid		= HSP_AG_UUID,
 		.name		= "Headset Voice gateway",
-- 
2.20.1

