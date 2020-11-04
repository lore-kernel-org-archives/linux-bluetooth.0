Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31C1C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921052075E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL7oTEut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbgKDXmp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732679AbgKDXmc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 18:42:32 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A108C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 15:42:32 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id x13so188716pgp.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 15:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=keox1HEiUoj/RxUdrmJZB4KSQqLdljvvXfph5b9xClc=;
        b=KL7oTEutdBAmQSFspMK+43DssP9YRs2tNlVpu6IfsBTUmQt6HFXxbR4x1CRlD3DkG8
         Pb2T6XflWXynCl252YVidx8cHf4ZE7ZLgxkkmiL5BZglNpJCpblY9J0utFfelis176Ma
         YEZb4igSH2DvFkXDd1COMf5tYCq4PbkPeAJ2uGS9oB9DvcEl9gZ8MsNx7RNC1+fxBy8M
         zwFA3xRwR5dkF2GsbAdY3AcMrNREkVTkJrHwJgoeSD6I+amXUYM9jmVK1nueRRS/BIg5
         f79vCgpRoSrqh6lyu4Sd1Mqkdio/JVC2cEuQoPpVmRKdw1kAqeVBq/DU5Mms6ik/EyC9
         JY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=keox1HEiUoj/RxUdrmJZB4KSQqLdljvvXfph5b9xClc=;
        b=qAQ0L3ckLMStT+vg/bqqSy3KnSx/DgzRiJGI0ZF30iDPXShQ1ltH+m9EdJBy/bqrG/
         WCbteIbZEmIqr8noLfHKDf8ZwGObPQC9x9Zb7r+wBDb4Vr+lckiqPAhuGtOP2PxjLHKQ
         RLD5/qOZ5jzCLgFH90HcowU3Z37KyopdZyKmys/sJotfKJrBasNCplxdQuDI7665q8gn
         DwzcXg2Dbqnz39bu0yhSyZVTW8jMvdV/6uznR3IpYfh7A2d5SrgF2MKt/pY+xC4VJEmd
         CNjQC8u0vUXHeNGc4SFayN3tLi1Bnck3odBuMVFjqlFK44Pi5m8lUh/odsTq9vJmkjUa
         kIEQ==
X-Gm-Message-State: AOAM5327AK/S126a7BXHQkJfCzHhFxNmaNsZNiqKYm5zhZr7fajwYzua
        CNspP/w1nsDxoOsO3Y6jszKq0NQnaoXD3g==
X-Google-Smtp-Source: ABdhPJwNT778/FKTEqF0bBs/X0dLj45S07xMXrWir9kKc4PoIgpm72u+aDMMa47HVU1USUFY2yaKEQ==
X-Received: by 2002:a17:90a:8c89:: with SMTP id b9mr354705pjo.34.1604533351271;
        Wed, 04 Nov 2020 15:42:31 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 30sm3361513pgl.45.2020.11.04.15.42.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:42:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/8] doc: Add tester.config
Date:   Wed,  4 Nov 2020 15:42:21 -0800
Message-Id: <20201104234228.2257427-1-luiz.dentz@gmail.com>
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

