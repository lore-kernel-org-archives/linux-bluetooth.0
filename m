Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53687C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Oct 2021 21:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD6160F9C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Oct 2021 21:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhJ1Vjr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Oct 2021 17:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhJ1Vjl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Oct 2021 17:39:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572F6C061570
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Oct 2021 14:37:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k2-20020a17090ac50200b001a218b956aaso5837299pjt.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Oct 2021 14:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9q8/8cWYGDlUxjpOjI4gtMX2EcSDwoIHty/Bgp6hkcc=;
        b=jqv/xWl/qIIfOGdlquB93WYRy3y2l9V50A1loA2mhiQSqLbCvBfRRIEP8Xc1aTPsO0
         +w8cromM7Liwg0kaoosmROo37BIKZrqyyeQu0sA2LSnqnT1P4HaRamOUjjZ5qxenABL6
         IA5E0Vx76ijn3ci9FtpEcumysK6sJ5fIb7AfQEyu3wA0u7FOUT8AB3XhGFZnvq+IwWo9
         UaUN6BrcjTbuKc7Q5CG6UujLTS0x+JDJuE9+yP6Im/F55K2WkeGqrFoCdlzuYHX/jIjH
         kEVKAAF6HDKWHrzdV/pAjMPuR5AQhpfXk5e6SgnrTUAc6ive0xFplWWfklDACfU3whmZ
         vO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9q8/8cWYGDlUxjpOjI4gtMX2EcSDwoIHty/Bgp6hkcc=;
        b=6WW11DBLogYqEVKPPf6Vh9jwYew1povedujhXMRScYYUe6BbXZ2GSXoH/cvCU8GT54
         GschOljUg1PMkTXXBOjUYyHxhTbgZbsbP4KyU0JhVwMzGvEzlCBLCHPMy458pLG3vuRh
         dDe5bnmrp/QvoBnL2i+2ZXlX2ssiHfY5S67e64DPebDHfxfFNHkKH6bcJnoTCC5S6BqD
         cMN9sboaoB6kstq3VRtXaEZFsTxwyPs20xH+JONgj2WcVKYnzE/SnFSe50x1iSBfgzjH
         C21dDFyZK5Tdad2N3TdlOK/8UgYKnBee1T64MzBMpoVkOaEEebeMR+wsdcPNhuE5B5Wx
         xVcQ==
X-Gm-Message-State: AOAM5335lynUU//FC8lNJDHP3QqQ9h1KXVq4tnl1BoU2J1yS7PHE/XSq
        7LElfQCSGBpnCytAF0OBfvAKL58gayg=
X-Google-Smtp-Source: ABdhPJzEU4YrkyglUoOo7WDxGQ4IJ43Q6GjsQFKXoZKVgYACES/vm3e0hbgnxUZ46UoYd3w6A8ZLGA==
X-Received: by 2002:a17:90b:3b85:: with SMTP id pc5mr7209618pjb.74.1635457033420;
        Thu, 28 Oct 2021 14:37:13 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h2sm3793414pjk.44.2021.10.28.14.37.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:37:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ] device: Fix not clearing error on update_bredr_services
Date:   Thu, 28 Oct 2021 14:37:12 -0700
Message-Id: <20211028213712.2045457-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When trying to loads contents from file using g_key_file_load_from_file
it may cause an error which needs to be cleared since the gerr is
reused, also make sure the file is always created upfront to avoid
having such error when storage has not been initialized.
---
 src/device.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/device.c b/src/device.c
index 8ad338419..fdc2d50a4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4998,22 +4998,28 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 
 	snprintf(sdp_file, PATH_MAX, STORAGEDIR "/%s/cache/%s", srcaddr,
 								dstaddr);
+	create_file(sdp_file, 0600);
 
 	sdp_key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(sdp_key_file, sdp_file, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", sdp_file,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
+		g_key_file_free(sdp_key_file);
+		sdp_key_file = NULL;
 	}
 
 	snprintf(att_file, PATH_MAX, STORAGEDIR "/%s/%s/attributes", srcaddr,
 								dstaddr);
+	create_file(att_file, 0600);
 
 	att_key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(att_key_file, att_file, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", att_file,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
+		g_key_file_free(att_key_file);
+		att_key_file = NULL;
 	}
 
 	for (seq = recs; seq; seq = seq->next) {
@@ -5068,12 +5074,11 @@ next:
 	if (sdp_key_file) {
 		data = g_key_file_to_data(sdp_key_file, &length, NULL);
 		if (length > 0) {
-			create_file(sdp_file, 0600);
 			if (!g_file_set_contents(sdp_file, data, length,
 								&gerr)) {
 				error("Unable set contents for %s: (%s)",
 						sdp_file, gerr->message);
-				g_error_free(gerr);
+				g_clear_error(&gerr);
 			}
 		}
 
@@ -5084,12 +5089,11 @@ next:
 	if (att_key_file) {
 		data = g_key_file_to_data(att_key_file, &length, NULL);
 		if (length > 0) {
-			create_file(att_file, 0600);
 			if (!g_file_set_contents(att_file, data, length,
 								&gerr)) {
 				error("Unable set contents for %s: (%s)",
 						att_file, gerr->message);
-				g_error_free(gerr);
+				g_clear_error(&gerr);
 			}
 		}
 
-- 
2.31.1

