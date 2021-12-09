Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E0FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Dec 2021 20:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhLIUEU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhLIUEU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Dec 2021 15:04:20 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6732FC061746
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Dec 2021 12:00:46 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 137so6068035pgg.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Dec 2021 12:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hecw4i2vOFzzT01kaZmExEeD/Cwln5Dk1yTzeSTlUWw=;
        b=Hzmlos02gZC8WNrZQ9rzx1LshbWy6nHUMhHpLcdNo03NZX8QVl1vkrDYRXZrRglcGR
         UvnRSAdWSupnVkil8i9TSuA492A3cUJUwGmoe6diWP37Ozn7reisdbpviIlZDjZUazJa
         edQrcsL85RO/VNmHXN7GHPQhVNHkgUxQ5Y8HUZb0x+/QsOuCaucelruFs0F9FM+JdLAo
         4Rdms7YlrKLKJw7i15LgRg1t95whtVdTv6RETooAEEQ83gPD4Dz+Oj/wNPrYM14d9D38
         T95FPOwZ0lEsID4HwHMjgkiOjLnh5YSqohHE+ruO+G3KE696eu9pPQ90wX5eehtfFsmx
         gjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hecw4i2vOFzzT01kaZmExEeD/Cwln5Dk1yTzeSTlUWw=;
        b=mIC09NfAhZLtcoJQaZY7fOP/WiACeB31vlZGPeDiIcU8D9BTuYENGNOlXXv1LEt8n9
         XhGvb7ohgELqOorG+JCWHgxJ/4aXH7LSMwGScZSCJ7TIkiTMEr3f/aEZbzhvtbzJHEQE
         rm01q6O301z0IJZXpBYzqAKo7mnj9L3xWh5npzgER614Il3JyUyqItaSdlnx3J0wePuL
         Jt5eOdQIRj11gbRnnDtmfFCHcNtwEYVbE1Sgd3z6+g2VpwAzer19sDzMHCClRqGR2XmC
         4vTJfKdME5SKPEmCZ3yM4zybu1n9TYAk1KqjeM10tpxSDY11UkqfBdcXXzRMCs5u48KB
         XcQg==
X-Gm-Message-State: AOAM533dviXZnoC1Bmj0Ufl2T+tbbutlz7BJ0CdXRl4pg5IWZA9gscmu
        Hj4e1mLC0Uus9kgnQyhCWnPM/CiC+NE=
X-Google-Smtp-Source: ABdhPJwKkcsHV8xFWMwkTQcRRx31MDlO1QYMMIMuoXyDNCG+YNhowlJSMJfM72BYV3rJCAWPITjQ9w==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr1973227pge.24.1639080045629;
        Thu, 09 Dec 2021 12:00:45 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:d0d6:ba5:fd1c:15de])
        by smtp.gmail.com with ESMTPSA id b2sm531440pfv.198.2021.12.09.12.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:00:45 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH DNM 1/3] Bluetooth: Do Not Merge: The First Test Patch
Date:   Thu,  9 Dec 2021 12:00:40 -0800
Message-Id: <20211209200042.737140-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This is test patch 1

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 README | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/README b/README
index 669ac7c32292..87ad45d6a609 100644
--- a/README
+++ b/README
@@ -16,3 +16,11 @@ several of them using the Restructured Text markup notation.
 Please read the Documentation/process/changes.rst file, as it contains the
 requirements for building and running the kernel, and information about
 the problems which may result by upgrading your kernel.
+
+THIS IS TEST DO NOT MERGE THIS IS TEST DO NOT MERGE THIS IS TEST DO NOT MERGE
+THIS IS TEST DO NOT MERGE THIS IS TEST DO NOT MERGE THIS IS TEST DO NOT MERGE
+THIS IS TEST DO NOT MERGE THIS IS TEST DO NOT MERGE THIS IS TEST DO NOT MERGE
+THIS IS TEST DO NOT MERGE THIS IS TEST DO NOT MERGE THIS IS TEST DO NOT MERGE
+
+
+
-- 
2.25.1

