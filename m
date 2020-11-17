Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA301C63697
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 19:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4152222B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 19:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEMJaGMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgKQTGL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 14:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKQTGL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 14:06:11 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D69C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 11:06:11 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id k7so10775866plk.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 11:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VeMGBnMCGXz3qdo4X5Ap+2K1Yksldo/5tq28wxk7WRM=;
        b=bEMJaGMir+Ubf8RdWyrWGv2GuwRXRgbkiBh0rLV17FwJIqFzWDUWVxzHKM2wLE8qOr
         4OKtSinzSeEpiJA7P8wT3qkZSyJ3RzCUFOkQFE57TGLZ/WSzBw7TArFeEDba8EQy52qY
         GUxZOsY/PGRxkl3YiyAGIitMtNqRMyXFhUznTXXnFbwODDwwMaExNlAovkcmHI/SPJCx
         WPZNXxLVQhu6UaTr9xICVTLKH682wsPsLrzOfViGX6fuBuK+eObJwsHdt8s6tUfEXDrm
         o4jsU4JvEBmaJPdJNJWVwBBjuiNttMiPBTBdVeLP+0G8POAl76fZQ2XoMnOEOqXl6mCq
         G9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VeMGBnMCGXz3qdo4X5Ap+2K1Yksldo/5tq28wxk7WRM=;
        b=bnAjjsEBPseEO2HWh1R98x+R+Ss+iS82Mm+6YV8Fk1gSuyNDJcGi6TEg6LMql9y/jE
         akU02/XSrBhKCQPBRkYEYD5cXLC4tyyPopseTu8GKK/PR3qXEXgzUsZTBL2RuKrL5jVR
         LvHuhsOHV2+iDp4MyFo+0xdZE5cfIxsGcX3VBAauqacglDv+cOWdz2I8moFx4+FMEs/8
         RGo6C/aL8PEzCQZkegye0dlPZfFKMSO1m3dvMFyYu7LMVQ4jVDdIzzD6rOItoRRT7uy3
         NxZbQcx2b2z7iyQC5AI57mv/U/1JgdcbIQd7q1xBzfL2NPKyDTNvQSgIOEQhNqG3TDW/
         bLhA==
X-Gm-Message-State: AOAM530ayf1dkPO9HgvRQVNN1fHKueklAWHYIWwxXdtxq7zigFuygQCB
        pimFJZ5KMk/AorNkdttaxfNKHghhVVs=
X-Google-Smtp-Source: ABdhPJxg6GyzFEymjKqz87Pn2VhsMg4M5YSzHUXrQKHhfcBeU3dqVrD7VropcoKpAe8Gf3geTr+ztA==
X-Received: by 2002:a17:90b:14cf:: with SMTP id jz15mr511835pjb.160.1605639970794;
        Tue, 17 Nov 2020 11:06:10 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 194sm22122041pfz.142.2020.11.17.11.06.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:06:10 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] test-runner: Use multidevs=remap when mounting rootfs
Date:   Tue, 17 Nov 2020 11:06:07 -0800
Message-Id: <20201117190607.50483-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201117190607.50483-1-luiz.dentz@gmail.com>
References: <20201117190607.50483-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This avoid inode collisions when the host has multiple fs to be mapped
to the rootfs on the guest.
---
 tools/test-runner.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 0c5daf2d9..ee077ebcf 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -193,7 +193,8 @@ static char *const qemu_argv[] = {
 	"-no-acpi",
 	"-no-hpet",
 	"-no-reboot",
-	"-fsdev", "local,id=fsdev-root,path=/,readonly,security_model=none",
+	"-fsdev", "local,id=fsdev-root,path=/,readonly,security_model=none,"
+	"multidevs=remap",
 	"-device", "virtio-9p-pci,fsdev=fsdev-root,mount_tag=/dev/root",
 	"-chardev", "stdio,id=con,mux=on",
 	"-serial", "chardev:con",
-- 
2.26.2

