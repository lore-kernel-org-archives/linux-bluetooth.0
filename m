Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1469FC74A5B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 17:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjCOR0X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCOR0U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 13:26:20 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150EC25E1F
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 10:26:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id z18so767820pgj.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678901174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=It02UyW2f2ZA/0vpvxYAhLaJMnV6tE3GwBT/VOn+yi4=;
        b=Yj2BedTbwF5NlPBMSt30EL6RRLqTji9wPD4H36TdNzJX9eviWxtygiNj0bU3RpleMT
         RTgEpSWxwoX0TgJ1Otx3YIFWnu/Ed/wHtASo+gQxjofXo4vOuw20Hc/1TNJnzX23RaJd
         oT47QjSAKk224pgiPLYgA6QAx9V9LJskoI/1uNf/T0LiCZopx8JLo3MephIKdG85zdQ1
         Ewol4Lh5PSAF4//9XN14wEuRz7YADKGvQn05Owbuhdd8wK4M4biTMtorO2TJ/pQmThp0
         lxwnaRVMVbFEwOaEa0aSa5d+Mea3zfr6UAZZ5SmrCIhP/Olm+hP2NBvoUKx6Jm8048ZL
         2gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678901174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=It02UyW2f2ZA/0vpvxYAhLaJMnV6tE3GwBT/VOn+yi4=;
        b=z1l3QLjA8sTFc+YHt9h2JE+e9A0dsbHwHHsSRQ/nfAFo9KbascuNaUiigpzk5CyN48
         rlKI1/ZqhWz0I2xOg6RP+QWmxYNFwk2A+j+u9cHilfQr7QQhkvm0qWaMBiLR5XrZzY8o
         c6SFx80G7Qtl81z+zZSeLNLtnE+eYp3WM8zFyrDre5tpp+V+nRs99qDiXQdg93aKevy6
         d9LmbjgnUOjgRpiediUDRZipWwAd60fqaEYlnfMXFOEazY1Ds1Tyh134EjEtOdZQI6kO
         z1Z14ymq1qJy0V4WTOwrD52ykgImd185Gi4Ky2bA2/HvuTKVMwlua9OTEP3OVO7HdbQJ
         UcRQ==
X-Gm-Message-State: AO0yUKW2iOrJb5d8aHV91kY58ctljwhK3HzQaygN65kqQhOsancwTXGZ
        qBCHaF5EwOL8Ez6l98iosrrhq9nrcQI=
X-Google-Smtp-Source: AK7set/RRFK0zQOIEcmTuleOj8p7U2JtTQ6nDtBFcVkkBOKXG8Qd8VQ/RJJALdBEe5/8HFcweR3bBg==
X-Received: by 2002:a62:4e51:0:b0:5cd:81a7:41cc with SMTP id c78-20020a624e51000000b005cd81a741ccmr292783pfb.13.1678901174115;
        Wed, 15 Mar 2023 10:26:14 -0700 (PDT)
Received: from zbook.. (97-113-12-200.tukw.qwest.net. [97.113.12.200])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78198000000b00592417157f2sm3930971pfi.148.2023.03.15.10.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:26:13 -0700 (PDT)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, brian.gix@gmail.com, inga.stotland@intel.com
Subject: [PATCH BlueZ 2/2] mesh: Make MGMT mesh-io less noisy
Date:   Wed, 15 Mar 2023 10:26:10 -0700
Message-Id: <20230315172610.13796-2-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315172610.13796-1-brian.gix@gmail.com>
References: <20230315172610.13796-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove excessive logging traffic
---
 mesh/mesh-io-mgmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mesh/mesh-io-mgmt.c b/mesh/mesh-io-mgmt.c
index 65994f058..f1385edcc 100644
--- a/mesh/mesh-io-mgmt.c
+++ b/mesh/mesh-io-mgmt.c
@@ -227,7 +227,7 @@ static void process_rx(uint16_t index, struct mesh_io_private *pvt, int8_t rssi,
 static void send_cmplt(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
-	print_packet("Mesh Send Complete", param, length);
+	/* print_packet("Mesh Send Complete", param, length); */
 }
 
 static void event_device_found(uint16_t index, uint16_t length,
@@ -506,7 +506,7 @@ static void send_cancel(struct mesh_io_private *pvt)
 
 	if (pvt->handle) {
 		remove.handle = pvt->handle;
-		l_debug("Cancel TX");
+		/* l_debug("Cancel TX"); */
 		mesh_mgmt_send(MGMT_OP_MESH_SEND_CANCEL, pvt->send_idx,
 						sizeof(remove), &remove,
 						NULL, NULL, NULL);
@@ -560,7 +560,7 @@ static void send_pkt(struct mesh_io_private *pvt, struct tx_pkt *tx,
 
 	mesh_mgmt_send(MGMT_OP_MESH_SEND, index,
 			len, send, send_queued, tx, NULL);
-	print_packet("Mesh Send Start", tx->pkt, tx->len);
+	/* print_packet("Mesh Send Start", tx->pkt, tx->len); */
 	pvt->tx = tx;
 }
 
-- 
2.39.2

