Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C7EC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 07:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A1E20716
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 07:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="08IuF7hB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbgCLHbK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 03:31:10 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:35697 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387930AbgCLHbK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 03:31:10 -0400
Received: by mail-lj1-f179.google.com with SMTP id u12so5255580ljo.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lj8KYrAkhY4lhanvarZ7MbZFz58IFU5eW5iOkRBUsjo=;
        b=08IuF7hBEuUC5NR5pux0nxUgJFnoEE6BdNZ33hAFgR3Z3dRlrG2VkZbtLzEmVB0Fs/
         ZWy/VfSnycuroAmBdriv74hdSRBHS93HhaySJ7v78c6ugphp+oImewrb5old4ro81R13
         OUCq0SiXahpQsnLSqs+E5NPeDA8pM/a+sGMEcr0jzwA5+PReVmhO34R10GWl7V1fKAkS
         xOxpUDjn/TI7PQMahu9PwUu2J8CSTf24UkTdt0q6S5jInhluE2ErnjcgHg12DWSa/7dR
         /35QBGoHddP5Hr19UkWp14mAeq2palvF4QvyVGoaDEMyvoTFuY6gWDZWeGnjqLBziW24
         bnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lj8KYrAkhY4lhanvarZ7MbZFz58IFU5eW5iOkRBUsjo=;
        b=tna8uXKHX4d/m/m4fnJMVZVDtMBkra0DFiLOmF599eopQ/As1/yvldS+Mri4uOa0Y6
         sFmEgXUOsnfBc9cOKDO7GEjjFyjgtcgmtJO8O3BTDsA9QJsXamKE8hZskJY1AcWTjkwp
         MVWuI1jPn6ybsJPPl77V41/nxAShwcuS7xgAJFO1nVmZ6DdZhwqcWLAFQw84imaCp7pP
         Lmov5SanfRoMTzymrhNerxjDky/ulHSd9+e5Rt5229YqBqR/vtjOh0DwwZfV3OEjPF9z
         F8gu9pzlvnUrahRqaxdibgtsTqWBjvGH4Dc6Ejdza/G7PJfFrFmp9bgPDa6l9okl26eg
         cgSQ==
X-Gm-Message-State: ANhLgQ3JLKj2G7WEP0e92fPfWQZh57c3wm3ln+9HNdZQyICeKt3wDyBz
        22JGLRc3zUxiGxujrfxvv/q8wckiES4=
X-Google-Smtp-Source: ADFU+vvIsg7k5/YGqxxHyhGL6PwoETGk7/ExH4a9QQGZKJn4IlEY8G6H/jgoSYhNkpVE9b9dg3iGHA==
X-Received: by 2002:a2e:7018:: with SMTP id l24mr4370621ljc.128.1583998267860;
        Thu, 12 Mar 2020 00:31:07 -0700 (PDT)
Received: from rymek.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id t78sm10311829lff.27.2020.03.12.00.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 00:31:07 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ] monitor: Fix for incorrect len in L2CAP Enhanced Reconfigure
Date:   Thu, 12 Mar 2020 08:30:45 +0100
Message-Id: <20200312073045.26416-1-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 monitor/l2cap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 9409604c3..41c766863 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -1408,7 +1408,7 @@ static void sig_ecred_conn_rsp(const struct l2cap_frame *frame)
 	const struct bt_l2cap_pdu_ecred_conn_rsp *pdu = frame->data;
 	uint16_t dcid;
 
-	l2cap_frame_pull((void *)frame, frame, sizeof(pdu));
+	l2cap_frame_pull((void *)frame, frame, sizeof(*pdu));
 
 	print_field("MTU: %u", le16_to_cpu(pdu->mtu));
 	print_field("MPS: %u", le16_to_cpu(pdu->mps));
@@ -1426,7 +1426,7 @@ static void sig_ecred_reconf_req(const struct l2cap_frame *frame)
 	const struct bt_l2cap_pdu_ecred_reconf_req *pdu = frame->data;
 	uint16_t scid;
 
-	l2cap_frame_pull((void *)frame, frame, sizeof(pdu));
+	l2cap_frame_pull((void *)frame, frame, sizeof(*pdu));
 
 	print_field("MTU: %u", le16_to_cpu(pdu->mtu));
 	print_field("MPS: %u", le16_to_cpu(pdu->mps));
-- 
2.20.1

