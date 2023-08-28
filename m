Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42738C83F12
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Aug 2023 19:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjH1TbJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Aug 2023 15:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjH1Ta4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Aug 2023 15:30:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EA0CE6
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 12:30:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bc3d94d40fso27761265ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 12:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693251013; x=1693855813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGWJcDPjL9D4nSkNVqkUs0DcAV6NDy05ftS4jofWyAc=;
        b=BYDp6R+YFZ1ZVmGLkJr7H8k9uDYNOTy1cysk9XzSGwVVNgyjBtP4r20vvUdyc+YiEY
         uepr/0SBMbbEsXQyov9I0QnkTuigCXdUCicVn1L2pK9k5izkFIRibanuiYWevvIWH2CU
         LjseRfL4lh+IotnfB4KJkM+Iq95HMPlZeoNzLaXR7GkFblDuVF44la3MP+Rpg/kmnfcs
         ktZ7AblLQ7HYH/vKEMphggGhabd5Z+P4AeBxJs7kF93S03P2uYkBQywb5m/MsJRUoRHF
         se+ZftsebLrtN16MgI49MyGdd8pHk2mYOYnhoRE6UErX2916lawjnLd9QDDSX5xx4D81
         420g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693251013; x=1693855813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGWJcDPjL9D4nSkNVqkUs0DcAV6NDy05ftS4jofWyAc=;
        b=RzyLVIDnqFf0gWyRv082Lx7Ffwsbu6LPdXKSJ7z6HfI3qttslfoYxM5Z2Igm5/SR9n
         tI2+CGltvL8SROQqBcroQl8ZuwTjh3VNMCrVFkvflFalKTJxkJYl1/kao4s9NupOOajm
         W6Ll+qqqy7qbwjSXHpXRE8+xuhUcQoz9wtJskoz2kS2bIHa42IOnUUxFoWaNScpDQh5A
         RCC+05IK2zJVfHO04/fQtQV0vBGFvggavWCoocArML9GSmE78xlqLk0Ut4Jc/A+oXCrU
         P/AZE2Gtd4rYkPOcGKKxdBTn4Zf4BZgAHHta6km1QwVH3VyX3fkH16/LtVCuRdjf3zcK
         18wA==
X-Gm-Message-State: AOJu0YyRXNS6gOVw0PTMc1dDqeY1Tj0/LJOtn9h8I3IGyjyR73r15eY0
        8csgvaRbYj0NfRYGhe+UAsrjTC+z0N4=
X-Google-Smtp-Source: AGHT+IFCzy4UehOzK42buijsFlt6pVpVIQ/h0kablj5AeYRuUJ1U2FUlxeN4Vi2wPaX2olWo84vOaQ==
X-Received: by 2002:a17:902:a389:b0:1bb:7f71:df43 with SMTP id x9-20020a170902a38900b001bb7f71df43mr23672420pla.34.1693251013467;
        Mon, 28 Aug 2023 12:30:13 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902d51000b00198d7b52eefsm7768771plg.257.2023.08.28.12.30.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 12:30:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] bap: Remove duplicated code
Date:   Mon, 28 Aug 2023 12:30:11 -0700
Message-ID: <20230828193011.551312-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bap_create_io already handle streams of differents types.
---
 profiles/audio/bap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index dfc71edf66e0..911cdd0a45be 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1714,11 +1714,6 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (ep && !ep->id) {
-			if
-			(bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK) {
-				bap_create_bcast_io(data, ep, stream, true);
-				return;
-			}
 			bap_create_io(data, ep, stream, true);
 			if (!ep->io) {
 				error("Unable to create io");
-- 
2.41.0

