Return-Path: <SRS0=oxy1=EJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3633EC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 23:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69DC223EA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 23:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4z2eriG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgKCXTu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Nov 2020 18:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbgKCXTu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Nov 2020 18:19:50 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE92DC0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2020 15:19:49 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r10so14910896pgb.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2020 15:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=keox1HEiUoj/RxUdrmJZB4KSQqLdljvvXfph5b9xClc=;
        b=U4z2eriGV4fAWZfadf2PE9x8Jl2Sr0VvN2anrPe7zhGpsgk0C3jwvxS+9xHcG8DmXk
         Wrxm+9ywktScd/ySpsnh/wZ+h9VGmhVr9Xjt0ILhBoN66++Reegrk5KS443KfxORANNd
         SUht5U0tNuL2D/EU5OSECtxzQGBMSZBaOGf0FXRuGCoq7nWec0valvOeQ9RB2r9+SCVL
         nxrN396kSyBghvsfakACEx/pHlD9pNzyJTNbGqBYzW9rMYZTWEYaN6gROcG943DQmrpW
         +3+05nZkXkDILkjw/9ADtzyvwUFxDf+2T0sDM+TQyhB9vpBscziSnmJpdM3bs3MMLOOL
         yXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=keox1HEiUoj/RxUdrmJZB4KSQqLdljvvXfph5b9xClc=;
        b=dy5dIJiuoIhIYAzN+q90xImeRwRmYfja0pwRRALR0+waGv6GRu2aqw7Pn9Dd6KrZlf
         R8afrkORWHr7hlOyL1A6KeKee2qtYTc6+75UANURB2pocdhq55+wQJwt6IvYTPqrNbj0
         26MOAwoqUbJGG4XcMlnUUOdGCDEgOv5knZDGeiEKpryUofARcOkyxon+eunTr+Ds+BLi
         XlL1BknTfjghLXyVJ8jbCXh7iL4+fs/HBA4RRKAxwmc+qQbblIpDHGmMUfsurVmFgZh0
         okloWX4KY8+GlBAyXtdFLmD1GlGZ/etX/NTxdXZQPI78LWWhLZWF/2xiWod7XbLDQHGw
         oQGQ==
X-Gm-Message-State: AOAM532yp0YJ96q5vdPKy7MRTbYlFumfMytiRw5MErX9gBLLyfIZKCdI
        wjeiqCMMdU5xN/MRFo49gyrlPPH2Kmsf9A==
X-Google-Smtp-Source: ABdhPJzhKSbxTfNj/8p5IZLRhngCXIEX5ZeoQpJZL4coa8nwyptTORiOVOMNV0qtejaJTnpIm6NDxw==
X-Received: by 2002:a05:6a00:16c7:b029:163:ce86:1d5d with SMTP id l7-20020a056a0016c7b0290163ce861d5dmr27060681pfc.80.1604445589196;
        Tue, 03 Nov 2020 15:19:49 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f7sm182185pfd.111.2020.11.03.15.19.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 15:19:48 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] doc: Add tester.config
Date:   Tue,  3 Nov 2020 15:19:46 -0800
Message-Id: <20201103231947.2053274-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds tester.config which can be used as a reference to create
kernel images to be run with test-runner.
---
 doc/tester.config | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 doc/tester.config

diff --git a/doc/tester.config b/doc/tester.config
new file mode 100644
index 000000000..e90899714
--- /dev/null
+++ b/doc/tester.config
@@ -0,0 +1,48 @@
+CONFIG_VIRTIO=y
+CONFIG_VIRTIO_PCI=y
+
+CONFIG_NET=y
+CONFIG_INET=y
+
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
+
+CONFIG_9P_FS=y
+CONFIG_9P_FS_POSIX_ACL=y
+
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TMPFS_XATTR=y
+
+CONFIG_DEVTMPFS=y
+CONFIG_DEBUG_FS=y
+
+CONFIG_BT=y
+CONFIG_BT_BREDR=y
+CONFIG_BT_RFCOMM=y
+CONFIG_BT_BNEP=y
+CONFIG_BT_HIDP=y
+CONFIG_BT_LE=y
+
+CONFIG_BT_HCIVHCI=y
+
+CONFIG_CRYPTO_CMAC=y
+CONFIG_CRYPTO_USER_API=y
+CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_CRYPTO_USER_API_SKCIPHER=y
+
+CONFIG_UNIX=y
+
+CONFIG_UHID=y
+
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_LOCKDEP=y
+CONFIG_DEBUG_MUTEXES=y
-- 
2.26.2

