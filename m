Return-Path: <SRS0=WgJd=VX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38F0C76190
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 04:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD64722C7C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 04:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="grDOm/5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfGZEaw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jul 2019 00:30:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36351 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZEav (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jul 2019 00:30:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so50154079ljj.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 21:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JGxJmieYOix4+RuQSzS7pNS7Bmi2Vqyp+QqBBM+1g5U=;
        b=grDOm/5O46Rj8Y4O28TwuZaWyg6IX1GxMzJ21pPqqBXZe9RgusDe6X/uvjgVPGp4IS
         mVFpfQHGUzqBMK5JMqvhc1T/SPlqVJRgjMyDyCgctOdMYeb35/BkJ7d3YPBtlctiXyFM
         YgMSKFPe70xfnAMi+Fbsag/vTLMwAlK2rtY1FemJAvu/4a25/VjmSkXnkHdDl6dE+cqQ
         JyeuoZF2+Hd+4Eaatg4GCK9NR1bfa5aMljTP0AvvvTTpmwt+LkNHpTSaXFAzDfnnBmLx
         cMTwqO0/0bx0JzUMP6keqMVNranfNv1G59trZpr2BmTciTUCuYmL1AEFhcbm1qNFWxMR
         QcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGxJmieYOix4+RuQSzS7pNS7Bmi2Vqyp+QqBBM+1g5U=;
        b=q1Rsev606EWm2p8jsGbZVnsOEUiIqPRKgqxIfImq0hKNwmICd0JI8CNTNyVvLV9ZfZ
         CsdPWS2JbMk+QLcdMNlFpkdbJDN7wSynmiVYg0u+Jh8GH1yYrNx3Dvs+frYHtFBCRvcU
         eLXX5qAFTmlVapV3V/cvwqJlKUBNkk2LPfQdkBZMk8mq1jg5YsJbWlRtr///E7z84V9T
         LgWAyW3fsfbNJS/ZBWrZ2MZSFDbPz/q91CnhehZ96gry3V1NsojateBYnyoWW23MrfIL
         Pg7uAAxP08YUJ8leMYQKjBb+W1aicOwZUNwE6AgRpnRRiKKF6pgCDxtwQ8O2Kk3c+t/J
         /RZQ==
X-Gm-Message-State: APjAAAVzrDGOUtO8cQvfxxmNhQ0GNvdm7pa3SyrLVNfU3VbzvCmMP/QP
        YaLqvNe0yfsXjM8KGMeyYI5MFBYTF4A=
X-Google-Smtp-Source: APXvYqz7KXBYEwfyCZA5B4EsXYq6n290ig7f1H9wbMmAFw+Hpij0V2DAYxNR1LLjzBCbmLb3KfyYlg==
X-Received: by 2002:a2e:8741:: with SMTP id q1mr47629843ljj.144.1564115448896;
        Thu, 25 Jul 2019 21:30:48 -0700 (PDT)
Received: from kynes.internet.domowy (apn-95-40-32-72.dynamic.gprs.plus.pl. [95.40.32.72])
        by smtp.gmail.com with ESMTPSA id g5sm9792735ljj.69.2019.07.25.21.30.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 21:30:48 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 4/5] mesh: Check that element indexes are consecutive
Date:   Fri, 26 Jul 2019 06:30:34 +0200
Message-Id: <20190726043035.9417-5-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726043035.9417-1-michal.lowas-rzechonek@silvair.com>
References: <20190726043035.9417-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/node.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mesh/node.c b/mesh/node.c
index 86676bf20..f937fe361 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -898,6 +898,7 @@ uint8_t node_friend_mode_get(struct mesh_node *node)
 uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
 {
 	uint16_t n, features;
+	uint16_t num_ele = 0;
 	const struct l_queue_entry *ele_entry;
 
 	if (!node || !node->comp || sz < MIN_COMP_SIZE)
@@ -935,6 +936,11 @@ uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
 		uint8_t num_s = 0, num_v = 0;
 		uint8_t *mod_buf;
 
+		if (ele->idx != num_ele)
+			return 0;
+
+		num_ele++;
+
 		/* At least fit location and zeros for number of models */
 		if ((n + 4) > sz)
 			return n;
@@ -997,6 +1003,9 @@ element_done:
 
 	}
 
+	if (!num_ele)
+		return 0;
+
 	return n;
 }
 
-- 
2.22.0

