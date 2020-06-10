Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF730C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 16:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2D32072E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 16:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHUQk6UU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgFJQWm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgFJQWm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 12:22:42 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD80C03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 09:22:41 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id s20so2239224qvw.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lwEmk5yMC3JPpOEZ6ccnt+sY4ZT1gYgEGyt0eegtHZc=;
        b=UHUQk6UUzqVaTBdxYgo35XhMzjEcdoghS3bnDdPxSd0vQ/Vmk4OpRPmOrwT9IN63SA
         3doJ7WaDbggjBWmfoTfeWTOo2OxtDwdG7LEnvWOkhC+ljhZYm4cwoPG2Swr6JRdrBImI
         VVmw+KEOrGxFBWbh1aETveeqJNySpaDn9ndZJBoedMPLbR62sZFY3h3tZ+l3N/tJHy3O
         /71SY0nrNAtuiHTaUXCAnSl5Qys2XShDOxFcsViHc3yZ04dmR//c946+jOhebaOibvAC
         QLeZTHb3RMaFaOzPZRyb2U4VT8DcZfoAYsr9vQa0as0GmB6EWx1n1u+JyzK+Ec111Xaw
         CQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lwEmk5yMC3JPpOEZ6ccnt+sY4ZT1gYgEGyt0eegtHZc=;
        b=PcekEqvluRHwiwx9FscYlPUzAwyEfxfk5mRnzI4/qmcPOI+4YHnondRLVXp4d3cADH
         uamzjb12E3QhG92fMQH7/kopET5dXoUo5++vMsbOCO+DpHY41fgabyps0Iwx2OhGfGGs
         wBoOc2I3jHa+UBAGMljT8/8suoFwNsZ1vFXUR3odC077kE05VTSI0B5ZTMfKi43DDduY
         A7OnanKNEC/v2NMVu5EXPJqWh402ELYb7xBFhXg3rQX+txFsG6C7vPS3yeATG/8b68kj
         ReYwVq9XkWTE1azD6TnQ8jK4YNaG8M1tZIk93PN0xJNNVpKs/+W01Zg1mnm39WGCqH4e
         Fm8g==
X-Gm-Message-State: AOAM532XFrdDrjV+11ceBpPQOKX6N/6G6+IRkhus3qWRe9RYsp6CZd1C
        BKEmwmJ1OQQNkeSVBWn1MBO8cKNr9XhmhA==
X-Google-Smtp-Source: ABdhPJzKbxNKN4JC5fZTVaJMfci5L554hxXuRZOseec3SiyL9/EbuufrDacNil6y40sp0lxTAEHg4CFoRpvOvw==
X-Received: by 2002:ad4:4501:: with SMTP id k1mr3816641qvu.56.1591806159906;
 Wed, 10 Jun 2020 09:22:39 -0700 (PDT)
Date:   Wed, 10 Jun 2020 09:22:04 -0700
Message-Id: <20200610092045.BlueZ.1.I27c2620cfdc8ec07adf16dad54579cefcde65aea@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [BlueZ PATCH] Move HOG UUID definition to lib/uuid.h
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HOG UUID is defined at multiple places in the code. Move that
definition to lib/uuid.h where all other UUIDs are defined.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

 android/hidhost.c        | 2 --
 lib/uuid.h               | 1 +
 profiles/input/hog-lib.c | 1 -
 profiles/input/hog.c     | 2 --
 4 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index fe0ea2f61..7bc484f11 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -87,8 +87,6 @@
 /* HID Virtual Cable Unplug */
 #define HID_VIRTUAL_CABLE_UNPLUG	0x05
 
-#define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
-
 static bdaddr_t adapter_addr;
 
 static GIOChannel *ctrl_io = NULL;
diff --git a/lib/uuid.h b/lib/uuid.h
index ebdcf729c..c7e6269f1 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -88,6 +88,7 @@ extern "C" {
 #define HDP_SINK_UUID		"00001402-0000-1000-8000-00805f9b34fb"
 
 #define HID_UUID		"00001124-0000-1000-8000-00805f9b34fb"
+#define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
 
 #define DUN_GW_UUID		"00001103-0000-1000-8000-00805f9b34fb"
 
diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index a544e062c..e96c969b7 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -61,7 +61,6 @@
 #include "profiles/battery/bas.h"
 #include "profiles/input/hog-lib.h"
 
-#define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
 #define HOG_UUID16		0x1812
 
 #define HOG_INFO_UUID		0x2A4A
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 327a1d1c3..9335b7e8b 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -60,8 +60,6 @@
 #include "attrib/gatt.h"
 #include "hog-lib.h"
 
-#define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
-
 struct hog_device {
 	struct btd_device	*device;
 	struct bt_hog		*hog;
-- 
2.27.0.278.ge193c7cf3a9-goog

