Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3219CECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 14:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiH3OsA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiH3Or6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 10:47:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A417D31E9
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 07:47:56 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CDF286601E7E
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 15:47:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661870875;
        bh=C6OUOHXNHpu4Tz4UaptT6NPb9XXLiHH4PdT77NztCmc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bj+neXRislsjQBtZq/aptYbp75VcV+UmvKosQowI9Fio3rbTeJZGtcaB5PPppYk1b
         EouTyhgBPiIDk8OglX5paXMJvtCC6P4pveyLm/6plne4V52u20ahVRKTzriMocfi9E
         VoJKtQnp+D+IXIcO63XdsXWgQdXorkFw9HFVHI0gU+W5PT7lyEv2uHuPOFImpSGDCa
         NuSEpQ3IMmnS7iP1CM6icQouyBlLdctcehjehyTqtSZwL9f5bJpt8AUtJ+83O9LqLv
         MaGNfh/3a8yB0ali2B2WrSw6BLVDWr87azU9uqh9P/a8TfH+GWbwgAgbRmEMN22azX
         1LjIommKTusMQ==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] doc: Add remote endpoint path to SelectProperties
Date:   Tue, 30 Aug 2022 16:47:33 +0200
Message-Id: <20220830144734.55263-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830144734.55263-1-frederic.danis@collabora.com>
References: <20220830144734.55263-1-frederic.danis@collabora.com>
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

