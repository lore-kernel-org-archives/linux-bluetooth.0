Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F33EC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 16:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349751AbiFJQin (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 12:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349835AbiFJQih (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 12:38:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5063E5932E
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 09:38:31 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 485D46601724
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 17:38:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654879110;
        bh=TYvfHpLsV7jiR7wDzcPhKTa6mm+IINJaaS2N4SEONZk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=N+0Ft4mZcptdzYRn5+BhECekLeSbamM7ZTFjdBbAti4EVw60q/188IBvCQ9QREsET
         Ralw7auDHDy9hAL86KV4dHN66gtHEio292QalrQb2sB2eZri+ZRQDQL6yF72G6SYgw
         zrm6PrUpo3dPf3RFiafv+wmxRvAk4hrdV1dz/YNnCruarGbZYcJsYC9WDSbDOBThod
         48Ri8m7gUJ5XDUIS0BTGIGRT3Jlt4zTGO9ylcb7ye44BHiF73dE3pSU8nc/cDQJTUq
         M6/e9i9RQ+WXluBoLCNvC8VXwCFjx2eEQCKW/iYv8U0jqmyKyKxWvkzc3zfak80aJm
         L39kXwrf0/oTQ==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/4] doc/test-runner: Add audio config options
Date:   Fri, 10 Jun 2022 18:38:18 +0200
Message-Id: <20220610163820.79105-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610163820.79105-1-frederic.danis@collabora.com>
References: <20220610163820.79105-1-frederic.danis@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

List the build options for an AC97 audio card necessary for test with
audio daemon.
---
 doc/test-runner.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index 683c622a2..019c23188 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -54,6 +54,11 @@ For Bluetooth functionality:
 
 	CONFIG_UHID=y
 
+For Audio functionality:
+	CONFIG_SYSVIPC=y
+	CONFIG_SOUND=y
+	CONFIG_SND=y
+	CONFIG_SND_INTEL8X0=y
 
 These options should be installed as .config in the kernel source directory
 followed by this command.
-- 
2.25.1

