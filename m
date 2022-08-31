Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47434ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 00:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiHaAFy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 20:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaAFx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 20:05:53 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC287B794
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 17:05:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so9790618pjc.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 17:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=MvWqD1pP/rgYOvjjncP29bd23ybKXs3SzSL4U0FmG2o=;
        b=gnrxhfgj+LsXFr2/YNIdjyfCQughTBmc9OVgkv/9SuCJjQVDlg0QK78INiBtsSh5WE
         LllSIiS163Vpo+bcT4ogMkx4L3kFdTwTLM1iQLkqLji5BDvmlsW6EqiRnr75/JkcdkHt
         LjFV94z0wOrvRZtxUWIw9QmDfxqVWswKvuhdtC0ZqlcLuiKjMuA6PkwifdSuS5CpRmjL
         nDKE8ldNb7QuNQty24PaV8euAKF3nGRrM266lDcqh5egjAmqoCVLQRsc68KDOmDzVeN0
         rEMFhTphUNhbBd7gp3da0bRoYRKujGjoWIblfoc2USTR928UByD58AJhjMQREfYXVxjC
         sYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=MvWqD1pP/rgYOvjjncP29bd23ybKXs3SzSL4U0FmG2o=;
        b=3sigRklaSuCFUV7wUgjpei+sX7nCHXwMF1pLeL5YWRpGLpS383TaVuCtPI9N+P0X8I
         LmB4CViSQSp1l0LaDakDCpfECseyOZZtSH++zMd8+4hcIW6jPsKNlyWm/H8KjH/EH/O3
         uvhvbTij8CENvyF9csUbEINqxttVsU7bIPFrNNZusRPqNYoW5HQ5rv1pVgaAlKDMAeQC
         1aQHVbP5uN9KSWwOvuLFPfXob7s7PM77nWKtCddr502zG/JOPHwy0t2jUU64Do1WIahD
         EU35410FpIQcl26l5Q1AhlVIYSMkZcsgg95W+5eD88ZPzYIL1fcP2BHhiq7+0bUscXjm
         OzUQ==
X-Gm-Message-State: ACgBeo3/MHRN+nQkd5yloaplBiB45K/fEqIlb7COLvZsDlMQb5RiJ0qW
        I1lY4kiKYXior4Lh6IWcwPbW16Yk7kU=
X-Google-Smtp-Source: AA6agR7PoZTStsBC8BV/rp6mqeem9WXwWJhiAdt1Q1ihASB4NW2uC+2bxEtUmecOv3AzrgC6aAiUsg==
X-Received: by 2002:a17:90b:4c50:b0:1f5:36f6:6b16 with SMTP id np16-20020a17090b4c5000b001f536f66b16mr509120pjb.180.1661904350246;
        Tue, 30 Aug 2022 17:05:50 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b00172b87d97cbsm8357770plw.67.2022.08.30.17.05.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 17:05:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH V2] media: Fix scan-build warnings
Date:   Tue, 30 Aug 2022 17:05:48 -0700
Message-Id: <20220831000548.1222374-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warnings:

profiles/audio/media.c:1465:6: warning: 8th function call argument
is an uninitialized value
        if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:3012:3: warning: Use of memory after it is freed
                release_endpoint(adapter->endpoints->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:3015:3: warning: Use of memory after it is freed
                media_player_destroy(adapter->players->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 profiles/audio/media.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index a7fa85d60310..49d8fc2f5e53 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1440,7 +1440,7 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 	gboolean delay_reporting = FALSE;
 	uint8_t codec = 0;
 	struct bt_bap_pac_qos qos = {};
-	uint8_t *capabilities;
+	uint8_t *capabilities = NULL;
 	int size = 0;
 	int err;
 
@@ -3005,14 +3005,15 @@ static const GDBusPropertyTable media_properties[] = {
 static void path_free(void *data)
 {
 	struct media_adapter *adapter = data;
+	GSList *l;
 
 	queue_destroy(adapter->apps, app_free);
 
-	while (adapter->endpoints)
-		release_endpoint(adapter->endpoints->data);
+	for (l = adapter->endpoints; l; l = g_slist_next(l))
+		release_endpoint(l->data);
 
-	while (adapter->players)
-		media_player_destroy(adapter->players->data);
+	for (l = adapter->players; l; l = g_slist_next(l))
+		media_player_destroy(l->data);
 
 	adapters = g_slist_remove(adapters, adapter);
 
-- 
2.37.2

