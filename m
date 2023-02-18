Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FDFC05027
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Feb 2023 00:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBRAqt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Feb 2023 19:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjBRAqd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Feb 2023 19:46:33 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0826E657
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Feb 2023 16:45:57 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id jk12so3447094plb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Feb 2023 16:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8qvzdTSClXoAm36njtVG2qu/QDOlzHxw4ZVXm5PF+2o=;
        b=bCCWscyEGi28hp8D1o8bYyX4Gp9KZssx8Z0Eu6hCxTpvXju+uoBZunxXTyprVqgWqi
         Q9EYUIxCCZdOwLYeGp8cfHtVNPDuSg5Ews8860QbeelUmOay2HUtNVOck5T/pds/rDLQ
         pPfbxrFewFKbTIgeyC+/fLU/bllx+TKaSaH8ghoeU7hkNE4DQbCdgSG7b0avFgJMZoFy
         3/Wl2bgjiup9jZFT6JGa/7Gdf2HR+/4v/VnbhlhUrIj4m9/guWwBeYiUzTWu2nog6GsL
         KLsNyFM55Cx6ejogf8AzDt6fLyXNLETGCFsJKu9AjqC7BQm2EYUrdS2nYXCYwF6s4L0Y
         yFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qvzdTSClXoAm36njtVG2qu/QDOlzHxw4ZVXm5PF+2o=;
        b=Wpnq9+fUbuctd6p2ECqzHArCUZpgsCJ7/xwlKq8Hny8iomZOKVx1srewwjWG+Zlqp0
         AXq9TBzNuvVJf/0hSR3ec2zac8oc/g0LoNAmVOiuI6LTE7/gQO/p+JL5Ih234tn8lL29
         86uLNlhtd/obZ5DGNVRZAJs0to3sWMKQvgcslN46PpKbGwcg9F5RoNqhfHzSlAKL+kMr
         RsDxUk/00+dEMmaxJ0QeBTKc9WNC2gOpg/nmq/rJAcNnNIZoDox4alF2gbCQ8crZ9KoR
         zN7lzc/oRLbDquzUiEOofhyvMMLxxWAHPZL0Vncsd0yiM2vMuTHneaihuwVPVpm+Gwsf
         5EZQ==
X-Gm-Message-State: AO0yUKWh8ZDUld+e1FheeJcM/+Eo/z545oOOYNuSwt3Hg3VTNGpGRpRr
        8hvq9I+ERK5VPGFSH8gfI1mOpTzFXGA=
X-Google-Smtp-Source: AK7set/vx1lZ9n9OYcBheiE0fOeCWQ1wKu0fe9QwvrBjY0P8TSy4okl3mdNsIdWsGYtSmSLB7GjHOQ==
X-Received: by 2002:a17:902:c412:b0:19a:98c9:8cea with SMTP id k18-20020a170902c41200b0019a98c98ceamr3678791plk.39.1676681156368;
        Fri, 17 Feb 2023 16:45:56 -0800 (PST)
Received: from fedora.hsd1.or.comcast.net ([2601:1c0:5e81:6f50::cb12])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b0019a88c1cf63sm3678874plo.180.2023.02.17.16.45.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 16:45:56 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] configure: Check ell path
Date:   Fri, 17 Feb 2023 16:45:55 -0800
Message-Id: <20230218004555.415122-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

If the 'enable-external-ell' is not specified in the configure parameter,
the build system assumes that the ELL source is located same level where
the bluez source is cloned. But the configure doens't check the folder
and user will get the build error while building the source.

This patch checks if the ELL source path if the 'enable-external-ell'
flag is not set and throws an error if the ELL doesn't exist.
---
 configure.ac | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure.ac b/configure.ac
index f9f0faf57..6e76133c2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -289,6 +289,10 @@ if (test "${enable_external_ell}" = "yes"); then
 	AC_SUBST(ELL_CFLAGS)
 	AC_SUBST(ELL_LIBS)
 fi
+if (test "${enable_external_ell}" != "yes"); then
+	AC_CHECK_FILE(../ell, dummy=yes,
+		AC_MSG_ERROR(ELL source is required at ../ell))
+fi
 AM_CONDITIONAL(EXTERNAL_ELL, test "${enable_external_ell}" = "yes" ||
 				(test "${enable_btpclient}" != "yes" &&
 						test "${enable_mesh}" != "yes"))
-- 
2.39.2

