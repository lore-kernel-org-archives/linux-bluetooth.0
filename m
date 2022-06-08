Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48A7C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jun 2022 06:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiFHG5f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jun 2022 02:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241703AbiFHGIj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jun 2022 02:08:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB02154350
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jun 2022 22:14:58 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 15so17397671pfy.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jun 2022 22:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+vseFj2SFtAgppL+WH1FRsDTUkpoJwy/aLLwga0CVfg=;
        b=lqZXJunWIeJO+Vlb5nkGG6a1UxzDMaSLM+MkQ9NwElTf+00+ZyQdsQFxpc+Ozu/t2q
         wuCVkOUQbr8yb2qcwJrflE5I9ntrsc9xC3LP2SJBN8FYe2de4GgQ8X6MfoHQvj6E+yyM
         b5+CbG6XkOZL0D1c7lgMKxvY0i6W7BrOqBYWal8es3JPF3MGwn6JkaxtFkVl7cJf43ek
         MNdrn9byHSJ3Dczdg2CHAg+KRm5VdSNOkt0UlCU8f1qyw6DMTEjnTFrIR/eqIc7rjvP+
         ajseE9/cwzQEe+XJBYrI5Ra06PNvykOqoFd+GPLTSk2gjM1SFAzk+ZIwhY4WI8qCtXc2
         3zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+vseFj2SFtAgppL+WH1FRsDTUkpoJwy/aLLwga0CVfg=;
        b=FHi+F1sKNUDIIyHI9HJOwCjzi0Q1aGUFkUZRv/2uj+OsHLqLvknUJgrvtDTaY3xFuZ
         If7jhfRUpP7wMANrhog1JzhU0wYNzLC8risAR33TiIVzA6On4D6o1NhKVsEDtRgLVobU
         THq8uRZIJ0fjy4SaqKzfLK3XOR9sDpSJgWbpvGqQgfbSWPgkx9lCvCDy1hXJU8+Yp3A4
         XBKi/QhDu/nDKhp6k1SAV3vrrnm60OkrMOSyEk1OhLWYOWjbnHNUjSATX+ghk5S3JG+u
         Gz2oh4zFxuXhd2V2QzQGObmvYNtaQb/z09NIzJlI+aSLEt9k91qw0xZWywJSFthGsAwH
         h4/Q==
X-Gm-Message-State: AOAM531Moipl8w7qNo7pf5Mkk/ch1U2B7f9ckoDoltcA6vaOUTWCQrgP
        SbQh1874lDgQl5/74pRDToyHW/6Sdy9hyg==
X-Google-Smtp-Source: ABdhPJyKPuJTQvwYd38DWxk033JwC+25u7n8brNUIyG2IWzEzJIibfEBpbVMDjFbqrECoKc8X4FGSQ==
X-Received: by 2002:a62:b515:0:b0:50a:3d51:671e with SMTP id y21-20020a62b515000000b0050a3d51671emr32918428pfe.48.1654665259516;
        Tue, 07 Jun 2022 22:14:19 -0700 (PDT)
Received: from han1-ubuntu-dev.cust.blueprintrf.com ([65.57.73.2])
        by smtp.gmail.com with ESMTPSA id z28-20020aa7991c000000b0050dc76281bdsm13806219pff.151.2022.06.07.22.14.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 22:14:19 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix not deleting the folder after removing the device
Date:   Tue,  7 Jun 2022 22:14:18 -0700
Message-Id: <20220608051418.197426-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the issue not deleting the device folder when the
device is removed.
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 0d7c62c9c..3da09578f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4278,7 +4278,7 @@ static void delete_folder_tree(const char *dirname)
 		if (entry->d_type == DT_UNKNOWN)
 			entry->d_type = util_get_dt(dirname, entry->d_name);
 
-		create_filename(filename, PATH_MAX, "%s/%s", dirname,
+		snprintf(filename, PATH_MAX, "%s/%s", dirname,
 				entry->d_name);
 
 		if (entry->d_type == DT_DIR)
-- 
2.25.1

