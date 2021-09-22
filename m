Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EDAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 21:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B5F60F13
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 21:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbhIVVfh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbhIVVfg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 17:35:36 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D322C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Sep 2021 14:34:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k17so3852406pff.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Sep 2021 14:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A1BV8yc+WIVMTyKQmRATYHHHU1eqohBieG5PCWeCseE=;
        b=C31y1csEvJJyddwNkKs6HY4pQIRKFYIR5Ma/0N4kBZDLta0xnahd3tbr3tTEyUlBT0
         YMtzZPaoirdJPkOHEadqqYUIg0hGFrxKGR3R1/vICDU6e1Pe1eyXOuqx873Mb89cFu7W
         PbqSi1xHN58crOnxgQdnTxRxpbtut/TVo0fEYAVbVmF5k+v2ubDrLuIY7vS0yspZRjSq
         ni98kAkG0F6imDqBhyxhdywQRLrhpY4RQWfkzxIa2y4PAnioyuV7zuD/IAoGhYz6W+WO
         4B4b7FCbDN2u6keHUR2J9ZWwl6cVFav2GL9C0DVv0oz3L6AMZk/CxgXy/RaLNPlwl05K
         44Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1BV8yc+WIVMTyKQmRATYHHHU1eqohBieG5PCWeCseE=;
        b=XXANZtyttYLnaACclXXEO0+NL/YBoMPepvppm+9uNvuEJftUc5GBD95lxBeZ39+wrk
         An/X4qzTaMk8U+c4kT5gTGFUCNiYMAH3Za47AYO8WT5tW9t/TZb0fTGPWsFPlvRvGRrg
         hs7E3214Lnxt0iea1BcOW9IHCmIl6KzfGSIiap92PJZFH9z+su8lb8d+CCYPAtFDtwbt
         /2kSKWNM4DG4Z9UfkfzdnzVi0tlxM1RgVYRQIGKxuNm03X35oo6r0LX8GUxmxI3x/Wlk
         D/p4/z0ND0jQ8DtLtZyEW+DHcD9Stu2itMbmlwoZWzXZRHOcuFVzzVHxmBIv89DG+VFh
         r7kg==
X-Gm-Message-State: AOAM5314XEHGA0gPFcwEIOslh043x5a8x9WvGQLM0WzdBRMSuMSBV3U/
        2IsVk8ovRjWBmnpgBzzwqtERLtMOeOw=
X-Google-Smtp-Source: ABdhPJx9doWyv+jXCGZ+Mn1t5w5cmszDM86UbA64R2dfPmPtFsW8smwT1aIRRca0ThHkmVaytC92EQ==
X-Received: by 2002:a63:5fd8:: with SMTP id t207mr27567pgb.123.1632346445069;
        Wed, 22 Sep 2021 14:34:05 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i12sm6378596pjv.19.2021.09.22.14.34.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:34:04 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] shared/mgmt: Add mgmt_get_mtu
Date:   Wed, 22 Sep 2021 14:34:01 -0700
Message-Id: <20210922213402.1978215-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210922213402.1978215-1-luiz.dentz@gmail.com>
References: <20210922213402.1978215-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds mgmt_get_mtu function which can be used to query the
transport MTU.
---
 src/shared/mgmt.c | 8 ++++++++
 src/shared/mgmt.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index cec8993e7..41457b430 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -963,3 +963,11 @@ bool mgmt_unregister_all(struct mgmt *mgmt)
 
 	return true;
 }
+
+uint16_t mgmt_get_mtu(struct mgmt *mgmt)
+{
+	if (!mgmt)
+		return 0;
+
+	return mgmt->mtu;
+}
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index 808bf4c7f..56add613d 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -76,3 +76,5 @@ unsigned int mgmt_register(struct mgmt *mgmt, uint16_t event, uint16_t index,
 bool mgmt_unregister(struct mgmt *mgmt, unsigned int id);
 bool mgmt_unregister_index(struct mgmt *mgmt, uint16_t index);
 bool mgmt_unregister_all(struct mgmt *mgmt);
+
+uint16_t mgmt_get_mtu(struct mgmt *mgmt);
-- 
2.31.1

