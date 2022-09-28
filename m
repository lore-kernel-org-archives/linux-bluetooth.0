Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1126DC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Sep 2022 04:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiI1Exz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Sep 2022 00:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiI1Exy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Sep 2022 00:53:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E19AE848
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 21:53:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso2554467pjq.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 21:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=z0VmNoS4IqSO2wjmPc/8fNttFTA1tRb7id0xvRwawHI=;
        b=CPsrIazJN6eAvpAMUal3Mvq49moM7zEMvAEX3hBtrLXo/ZqV1kRHvkI2b2JtbztCqz
         3vlfgDOzalNCE3eime8LnEpKR9+P7xdSNskjpjS7YcUq49i52qqqlR2NJxl1tnKXNtpV
         yPOzlUA4DtJH9GUhL8gWf6tToudtmPD7WwlgOxmvXNBVDCOrVgljg5T7xBkZX2gcjT6o
         tWdnajcnuq+k40uRqsnjNXPM38iFhzyfARTRpHokWBtiUfFgp8x49QRIOsW72MdytOTk
         T0QxqoFjdCYTKgH7vDMeYhglKUgR96ugYaQi0+lARG7VBPubUT6DgEg6Qyw5vjx2WmEE
         NtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=z0VmNoS4IqSO2wjmPc/8fNttFTA1tRb7id0xvRwawHI=;
        b=Dg8sNdFmS/vTPT4X/bTQcjiHKP4jufgVNdz+RHv+hOid3L9o/nXv1+TDszvL4SmvkD
         BckA36onRhTcuWzyZTfteRtvZJbA8HNH5ZJCShctkDi0YkU8HrGrvcjqlebK7T1+zIAX
         P5fQbMEoetDYWlUQcphXOAbR7XFEc4KDhl7c/9lD6nKZg4ojzaWIQ5gpF1lUNYE7JICl
         rbslBV84ME3gGoZ5JMlJHOXwQpO8szbKed0xaoyuzqyObGvLL/8If8pFH5yzSACk+PT/
         4Gm6zbwEpl788uze97luUw7m886i6VnsZy0UWtylokyQwT0AJftEKCBmkZYTOAw95d7E
         EzKw==
X-Gm-Message-State: ACrzQf2CBEQplPN9L2U0k1N0m6HX4gzI5jeRxlCqWCrLxkS3BMdX39Wm
        olu8m6bkvavsJ1GxjytYJ8hoGZa97GE=
X-Google-Smtp-Source: AMsMyM6MRHZZaM2XgijawBbj3lFCH51mVW6J2iOJdDdW8gW6+wz1fQIFwo3uFk82+MDnVc5zGwmsnA==
X-Received: by 2002:a17:903:234c:b0:178:1a7c:28a5 with SMTP id c12-20020a170903234c00b001781a7c28a5mr29581093plh.32.1664340831284;
        Tue, 27 Sep 2022 21:53:51 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a80:cc40:b354:2fc2:b868:bbb7])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090a990400b00200aff02e90sm459321pjp.18.2022.09.27.21.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 21:53:50 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v2] Bluetooth: doc: test patch - DO NOT MERGE
Date:   Tue, 27 Sep 2022 21:53:48 -0700
Message-Id: <20220928045348.210835-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This is the test patch and do not merge.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 COPYING | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/COPYING b/COPYING
index a635a38ef940..9960087a95d8 100644
--- a/COPYING
+++ b/COPYING
@@ -18,3 +18,5 @@ In addition, other licenses may also apply. Please see:
 for more details.
 
 All contributions to the Linux Kernel are subject to this COPYING file.
+
+TEST LINE. DO NOT MERGE
-- 
2.34.1

