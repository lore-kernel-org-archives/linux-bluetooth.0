Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A98C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Oct 2022 01:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJHBOT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 21:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJHBOS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 21:14:18 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949C9B56FC
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 18:14:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id a23so5991351pgi.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 18:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbF95eHZ2RUxmwb6nGp4/t/NK7QcVM0zQJIL6M3g4f0=;
        b=Q3oTVAP/UDd2j/4Wheoa9K4WH7sU+IdrlLU2+1sgMr1w/SDy3naiRzM3IKbkpbnlGI
         Na2+llm0VawdR1bz7WE+89JoJ4fbevISX0QAU8AsSUmMiJRASQ7bMZzmzA71qMo+0ScP
         qZCP3X06tWcDWsWyFxtlgFqjcSwvj7K2EBxRGPvrIwxbNnmKox9Am2lG7ogDMa3HYy1q
         cY4bQUVfB5tlsluWQYImLl+4NsTQ7xFxx+ST1x5NX4psaPdCMCbRJVhw8C5ca/R0rxqj
         kIY0GaynWa7KLiGY1XG9FwnvM1iKPVCSx3GAivjjkloiOQirjW3bFEcStTLNCvXj6mDK
         pg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbF95eHZ2RUxmwb6nGp4/t/NK7QcVM0zQJIL6M3g4f0=;
        b=JkoUCx+SLtEH3w3uCl7m4ZGkg4Q0SfAeqSbTBWmIx1l8jW6DiO9IpQVuyB2fGHb846
         sQHmp6jc9+tpXk3K1syf2kf/d/HvHA0Bw2/LA3r3JTY01zaiwteY/9eHgZHbo9MvSv2y
         yMlunobsXAd1Cx2LMyaw423aVc4n/7FNA3nPjJWl8HEMx0mMVJsPuAuhgqFEBzZ2yEBq
         U04V1nxlMJKCqXah9OYLA9s+2GSG8ol9XYcdwt8BlGo/lHhJi90ALr5FeIQDpjJWajk0
         Scd3pHab80TZo3QWmHEYWEz8tKUjKfjp9sSBEyhWnGGirG6JIdQ2/nzqv2pITpIdj22P
         c2rQ==
X-Gm-Message-State: ACrzQf0qAHSrMnIjEsiczDc8SGUoHJL30fwj9hFn3ImSZotdJZu9SmbW
        iWnfzxq6r6FDVGAFB8o0rLK/8uMHT2+0Fg==
X-Google-Smtp-Source: AMsMyM7E/lv1JHqAOBUY6uV2SKwOPkcCKRGdBdwLtetfGvG5ScpYdT7xoreejqrkzjee5Vq/6Oszow==
X-Received: by 2002:a63:186:0:b0:442:ee11:48a5 with SMTP id 128-20020a630186000000b00442ee1148a5mr6849845pgb.284.1665191653561;
        Fri, 07 Oct 2022 18:14:13 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 131-20020a621989000000b00561969ea721sm2291938pfz.147.2022.10.07.18.14.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 18:14:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] vhci: Add function to interact with force_static_address
Date:   Fri,  7 Oct 2022 18:14:09 -0700
Message-Id: <20221008011410.1907549-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221008011410.1907549-1-luiz.dentz@gmail.com>
References: <20221008011410.1907549-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds functions that can be used to set debugfs
force_static_address.
---
 emulator/vhci.c | 10 ++++++++++
 emulator/vhci.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/emulator/vhci.c b/emulator/vhci.c
index 4295e30ef980..a12b11e0f305 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -257,3 +257,13 @@ int vhci_set_emu_opcode(struct vhci *vhci, uint16_t opcode)
 {
 	return btdev_set_emu_opcode(vhci->btdev, opcode);
 }
+
+int vhci_set_force_static_address(struct vhci *vhci, bool enable)
+{
+	char val;
+
+	val = (enable) ? 'Y' : 'N';
+
+	return vhci_debugfs_write(vhci, "force_static_address", &val,
+							sizeof(val));
+}
diff --git a/emulator/vhci.h b/emulator/vhci.h
index c42e8bde1cd5..6da56cb589fe 100644
--- a/emulator/vhci.h
+++ b/emulator/vhci.h
@@ -28,3 +28,4 @@ int vhci_set_force_wakeup(struct vhci *vhci, bool enable);
 int vhci_set_msft_opcode(struct vhci *vhci, uint16_t opcode);
 int vhci_set_aosp_capable(struct vhci *vhci, bool enable);
 int vhci_set_emu_opcode(struct vhci *vhci, uint16_t opcode);
+int vhci_set_force_static_address(struct vhci *vhci, bool enable);
-- 
2.37.3

