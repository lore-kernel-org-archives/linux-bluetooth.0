Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75DAC282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F7F206DA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="IRJHlE2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgAHVBR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:01:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36262 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAHVBR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 16:01:17 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so4829797ljg.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 13:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5EtCJNiKvI9R+Z9KSzJ1QI4ki2LmyFbXNK+qFj7+fg=;
        b=IRJHlE2eIUIQC4et2+pykwZ7CdAPdYGL06aTt0Uwhs3BWdkGZaphYxcO2U4bMbO5iW
         ES3kdKjDZXZWT7qSev2pjJmFftggOZD3zVnlp0QZLi5jK+puSLywKtw/yIWClIYNilZN
         zB0YQBZxSjvOmNCGoBZ2Pl6CtHALQCtm4P3jhpGBVHHGI9mmb63S56/VupbCFhCmhrsF
         v7l1DX6rzYts/cZ8OxB0gr3LHzSlJBFwDCMtTbnZPKuicf2o3PMQ/tM2f5LpFiKQpEbq
         DgBmBCesHviprL84EoDBEQlT2XQ1rPXx7tgSZdHIVBpgWGRIbrF0T0nkj5HUwGHJYlzq
         ykBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5EtCJNiKvI9R+Z9KSzJ1QI4ki2LmyFbXNK+qFj7+fg=;
        b=Zo5DbJO8qJmea5/HeVGQ0VefNSfu2bGVUVXChHMzfNjW0ZB6ssXycVLiNfuAhD3ix8
         QnCCizlPr+VZch3PYW8mwsDlVlczxT7vLur+fO5bMfF4LKi5rekBstHtp4S/h8ChZcVs
         kNCDvw+RepdcL2QpNAZaaYRK2GFEmd/RWeN7rbNqWzH2XFlNCLzTDN/nPj305Eo6x/IS
         FNWDsQtWXewmNjWMR/oF6lbPQN0n0He+0ChyrOWycpFUyxq715gJUwnpRgpBLGiklk3U
         XrDE/vBY+uzsWjqOfTouYHfmuzc9KkiJgbO2T/aJ+FTQEbBSETvJ3ssU8Ad1Xo92DbvM
         qNSA==
X-Gm-Message-State: APjAAAUQHFOXwTzi4XleCsgR/dRAUEZgo4oGiMzoF34x9lY6IHZweluu
        NZBtu+ZQ7gSuw9sef/KyiMsGRm0BAfc=
X-Google-Smtp-Source: APXvYqz7W6/lkX2E+ktdg0yEhuYBbTC1nZypu6t4eGFjas+Bw7qqPqJIyCeaqIPFS5jSE9L2eVgmyg==
X-Received: by 2002:a2e:a404:: with SMTP id p4mr3897140ljn.234.1578517274662;
        Wed, 08 Jan 2020 13:01:14 -0800 (PST)
Received: from kynes.internet.domowy (apn-37-7-124-67.dynamic.gprs.plus.pl. [37.7.124.67])
        by smtp.gmail.com with ESMTPSA id w19sm1951773lfl.55.2020.01.08.13.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 13:01:14 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Gajda?= <rafal.gajda@silvair.com>
Subject: [PATCH BlueZ v2 2/2] mesh: Remove local_iv_index and local_ivu aliases
Date:   Wed,  8 Jan 2020 22:01:03 +0100
Message-Id: <20200108210103.32220-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200108210103.32220-1-michal.lowas-rzechonek@silvair.com>
References: <20200108210103.32220-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Rafał Gajda <rafal.gajda@silvair.com>

---
 mesh/net.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index d7ce5493d..0a4d2e72c 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2607,14 +2607,7 @@ static void update_kr_state(struct mesh_subnet *subnet, bool kr, uint32_t id)
 static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 								bool ivu)
 {
-	uint32_t local_iv_index;
-	bool local_ivu;
-
-	/* Save original settings to differentiate what has changed */
-	local_iv_index = net->iv_index;
-	local_ivu = net->iv_update;
-
-	if ((iv_index - ivu) > (local_iv_index - local_ivu)) {
+	if ((iv_index - ivu) > (net->iv_index - net->iv_update)) {
 		/* Don't accept IV_Index changes when performing SAR Out */
 		if (l_queue_length(net->sar_out))
 			return;
@@ -2638,23 +2631,24 @@ static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 		}
 	} else if (ivu) {
 		/* Ignore beacons with IVU if they come too soon */
-		if (!local_ivu && net->iv_upd_state == IV_UPD_NORMAL_HOLD) {
+		if (!net->iv_update &&
+				net->iv_upd_state == IV_UPD_NORMAL_HOLD) {
 			l_error("Update attempted too soon");
 			return;
 		}
 
-		if (!local_ivu) {
+		if (!net->iv_update) {
 			l_info("iv_upd_state = IV_UPD_UPDATING");
 			net->iv_upd_state = IV_UPD_UPDATING;
 			net->iv_update_timeout = l_timeout_create(
 					IV_IDX_UPD_MIN, iv_upd_to, net, NULL);
 		}
-	} else if (local_ivu) {
+	} else if (net->iv_update) {
 		l_error("IVU clear attempted too soon");
 		return;
 	}
 
-	if ((iv_index - ivu) > (local_iv_index - local_ivu))
+	if ((iv_index - ivu) > (net->iv_index - net->iv_update))
 		mesh_net_set_seq_num(net, 0);
 
 	if (ivu != net->iv_update || iv_index != net->iv_index) {
-- 
2.23.0

