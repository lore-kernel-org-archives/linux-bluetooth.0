Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D88FECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 20:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiH3Uy2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiH3UyX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 16:54:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3438672F
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 13:54:22 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C3AA56601DDB
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 21:54:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661892860;
        bh=C6OUOHXNHpu4Tz4UaptT6NPb9XXLiHH4PdT77NztCmc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DUCcq1d8ezJ9UdQh/SE8sj/36RLkj5rxJvDC2d5QCVomqcPbDu4uUFFAlU210mVI/
         yubgt3zROcYeo9sagpaskv3rd4rwAq0aVfPgR2ZfNh9zdP+5o9u1lSfoNfcb7S5p6q
         GbMsWvKV2w79zTcYWvuIBK+Aoafep/LH3lMkRUjFsDzmqdRjI3bd/EaR2ZDjZ6+ldt
         +b+xE8lbkvthAQ3wVRKv0VjO/nt66/Na1XvMggvOwC9xpZmf5gGdanuA/mPy6rPxbZ
         9S/sO7enMNPW+RmFm7QnDJL/yy/IPdbbUAM4cMXZASn/wEhTFy3rkVQSLgRG/LrkT8
         DBQ5SyBcy/M/w==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/3] doc: Add remote endpoint path to SelectProperties
Date:   Tue, 30 Aug 2022 22:54:10 +0200
Message-Id: <20220830205411.68299-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830205411.68299-1-frederic.danis@collabora.com>
References: <20220830205411.68299-1-frederic.danis@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/media-api.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 9cd211355..847f8bee7 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -601,8 +601,10 @@ Methods		void SetConfiguration(object transport, dict properties)
 		dict SelectProperties(dict properties)
 
 			Select preferable properties from the supported
-			properties. Refer to SetConfiguration for the list of
-			possible properties.
+			properties:
+				object Endpoint [ISO only]
+				Refer to SetConfiguration for the list of
+					other possible properties.
 
 			Returns propeties which can be used to setup
 			a transport.
-- 
2.25.1

