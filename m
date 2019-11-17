Return-Path: <SRS0=tHDW=ZJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E05BC432C0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Nov 2019 22:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E02820700
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Nov 2019 22:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybtor7VY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfKQWwq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Nov 2019 17:52:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45407 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfKQWwq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Nov 2019 17:52:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so17239993wrs.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Nov 2019 14:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=ZooYqaZd0afWn2wcHg01anX+McZA6MwmgMAGR/Ya9gs=;
        b=Ybtor7VYCYTfSu/9UmbmRjpP/zOMeJxlf/DF1LmKFsRf35StN6fVPS2PkIwU4Gms/1
         mp/ex+KEJ6tdhP/pr1buGJNBncx/qyxcpEzgNminH/hGAMUUe1AqDVI50PmgGVV2z4PN
         28vPfFSpBhKILaAlfDU1UIIrae+Jfo7D8DdYVXoywyfZi/xwxJGeFrdKI1uyaKZuM5Sk
         xrGZhgEQjEUPAuT+8FIMCdnpsVcon26v8hMKTk6EQEdeWp1sg5KSq+iBYDSzQ0L46is/
         UCQfX7gmiyvVlXRIF49Ej0k7KtPg8IgZ2lDCnUXiQHg8AOn3cP5/wfJy99h82NCU7GGF
         Fzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=ZooYqaZd0afWn2wcHg01anX+McZA6MwmgMAGR/Ya9gs=;
        b=hs995xgG9X4W8nTdvYd0n9eUxZ4wtHPNQ812XXp5Hy6kYr5qclHukgHWcUQAyeBBhg
         hAUGFOrTIN6kkhUEyWEg19gpDjGHGMES4WjbmImBk/rqLoVoSVKtmqpcJZuEfiBahY1v
         UzgSCb84j70Rek2+WXkkg/BJ3LfJ7FIDADVFD8v5l32bnHwaMALnXoSHlfDcsKf6rRCU
         J9C2QKV8P9BXnZKII2h7pIqvwRsmltoDq/HXian3Z0/aEfbvnufdp96iWL3jr+7VNcR6
         M3OzPlLv5I1MDc4frvUnRH7RoYB4/ycjqQgHwVWPbM28aUphAEQi7Bhx/4lMfNvz1rX1
         G8yQ==
X-Gm-Message-State: APjAAAWkmXfCrqAgHtTjWw59+2HffeRaUNPDEOgj8qG6C9n51M/J7Q5L
        itCvYE12a3JTAoVKg2o0t4q1+DTZ
X-Google-Smtp-Source: APXvYqwTUltxS02vqClbh5FZbNS6csy711bMf3RPTq4WdH1JwMxdcEb1KH7igJhB6IhBqCKstOuw4Q==
X-Received: by 2002:adf:9527:: with SMTP id 36mr26093281wrs.398.1574031162944;
        Sun, 17 Nov 2019 14:52:42 -0800 (PST)
Received: from sambook (adtp124.neoplus.adsl.tpnet.pl. [79.185.227.124])
        by smtp.gmail.com with ESMTPSA id t14sm20364429wrw.87.2019.11.17.14.52.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 14:52:42 -0800 (PST)
Date:   Sun, 17 Nov 2019 23:51:46 +0100
From:   "Arkadiusz (Arkq) Bokowy" <arkadiusz.bokowy@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] profile: Default SDP settings for HSP Headset
Message-ID: <20191117235146.633141f7@sambook>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add default SDP record for HSP Headset, so one can use this profile
in a similar fashion to HFP Headset profile - no user configuration
required. Without proper SDP record, connection with HSP Headset might
not work properly.
---
 src/profile.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index 192fd0245..821d09bff 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -56,6 +56,7 @@
 
 #define DUN_DEFAULT_CHANNEL	1
 #define SPP_DEFAULT_CHANNEL	3
+#define HSP_HS_DEFAULT_CHANNEL	6
 #define HFP_HF_DEFAULT_CHANNEL	7
 #define OPP_DEFAULT_CHANNEL	9
 #define FTP_DEFAULT_CHANNEL	10
@@ -155,6 +156,43 @@
 		</attribute>						\
 	</record>"
 
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
@@ -1761,6 +1799,14 @@ static char *get_hfp_ag_record(struct ext_profile *ext, struct ext_io *l2cap,
 						ext->name, ext->features);
 }
 
+static char *get_hsp_hs_record(struct ext_profile *ext, struct ext_io *l2cap,
+							struct ext_io *rfcomm)
+{
+	const char *volume_control = ext->features ? "true" : "false";
+	return g_strdup_printf(HSP_HS_RECORD, rfcomm->chan, ext->version,
+						ext->name, volume_control);
+}
+
 static char *get_hsp_ag_record(struct ext_profile *ext, struct ext_io *l2cap,
 							struct ext_io *rfcomm)
 {
@@ -1993,6 +2039,16 @@ static struct default_settings {
 		.auto_connect	= true,
 		.get_record	= get_hsp_ag_record,
 		.version	= 0x0102,
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
 		.uuid		= OBEX_OPP_UUID,
 		.name		= "Object Push",
-- 
2.23.0

