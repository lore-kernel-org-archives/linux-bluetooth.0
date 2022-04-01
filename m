Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E72EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 21:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352095AbiDAVkt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 17:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiDAVkt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 17:40:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DB96580A
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 14:38:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id f3so3787566pfe.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Apr 2022 14:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sXoAmg0PzME8vp61ME2csiD6uzcUiRDg6JTf6g5FEiw=;
        b=mR8U66jaSvrRYRxjXIIFfqqI/bBDEo2LIyxUTBv34AeXmTh3Ynhh5svcPXMDIxIaE0
         eHDypQtVVwNfKdshq5ESheg4hpWCXrs5ADXFbROdt5GvmLpjUH874Z1dfwdqDIGu2XuG
         tIjQHQ6biab1lgvuIV/6BXEzioHV4UZZwyRsVdc9WZEP93kBiI8ZLkSzVM3o95SMpvoC
         pCvdT2zOGPSJNMuiBArJKULtti70tWpVwU3ZhJqT1/q70JWqZN1Oafef0gg4oEpUGAT/
         602kMm627F6VPv/UeEPbbIhTE+KMHFjM1TrjOEDHyz4z4f03KIMoG2r2dHD9p809s+oW
         5NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sXoAmg0PzME8vp61ME2csiD6uzcUiRDg6JTf6g5FEiw=;
        b=W20n+j6RZF7396IDmQae+Hoqr3CSrkQZxKI1Y+0gdkjqvzNV8DyRL5K+lTf+hUETpe
         0jT1+LWHQfiUo7LReTeB8k3CtVf4MrY3Nsun2BexXa29iRFhFWC70Zj3zaS0HI9KNsfT
         ryYg4aTAXmZLeeyikYhiuXqnewDLbPMtEYAHQ4jCa6SOF9l4VynqBSv/NOU9g6xN88ap
         9OoJN4sGuSTvQr6DxuczsIY4nlucmcIX8lGot6XPvzc929gjQZztuM6WZgk3yPIk+A2B
         X+1uqaEqQYQ5P2e6l+Rey1z5CK4tqUoaWrdshgRMNKlxWB7aRJEIPWksd/a3AGYXNKxZ
         0AEA==
X-Gm-Message-State: AOAM530d7zQnMxKQsI+FFGSkpD5OsF+c78uDfCeuoJBP98FysXkzxRdB
        Mj0OyVgQn4GuYtIouLGvLkTZnByCYXk=
X-Google-Smtp-Source: ABdhPJzl/RXejkUaUgbtg73WsnkVr9updXrCmhAvRNPvzr1TPU7cBdCg9zopaRN3yCRhIa7TqK/qtg==
X-Received: by 2002:a63:10c:0:b0:36c:6dd0:44af with SMTP id 12-20020a63010c000000b0036c6dd044afmr16225556pgb.41.1648849138296;
        Fri, 01 Apr 2022 14:38:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a174800b001c7d8b160f0sm3337074pjm.51.2022.04.01.14.38.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 14:38:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-db: Fix gatt_db_attribute_get_index
Date:   Fri,  1 Apr 2022 14:38:57 -0700
Message-Id: <20220401213857.36738-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gatt_db_attribute_get_index was calculating the index based on
attrib->handle - service->attributes[0]->handle which doesn't work when
there are gaps in between handles.

Fixes: https://github.com/bluez/bluez/issues/326
---
 src/shared/gatt-db.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index be07cdbe4..4f5d10b57 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1537,12 +1537,12 @@ static int gatt_db_attribute_get_index(struct gatt_db_attribute *attrib)
 		return -1;
 
 	service = attrib->service;
-	index = attrib->handle - service->attributes[0]->handle;
-
-	if (index > (service->num_handles - 1))
-		return -1;
+	for (index = 0; index < service->num_handles; index++) {
+		if (service->attributes[index] == attrib)
+			return index;
+	}
 
-	return index;
+	return -1;
 }
 
 static struct gatt_db_attribute *
-- 
2.35.1

