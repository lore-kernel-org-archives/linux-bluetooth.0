Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A75FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 20:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243158AbiBOUu0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 15:50:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbiBOUuZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 15:50:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B78BC11
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 12:50:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so4258889pja.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 12:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nKLYIGEYGqdYWyeeLA6YY5IvzAix8ZYXy6/QGARpfbk=;
        b=Qg3+8JBSr9fG4rraHiygrgEI+BTyUhbEOMyVyzGZ5de424LTzONI01s1xtplVgD1WG
         fYSNPwq9wiozXlZn66jSdfvn6FClKeBnCNgiGziF9LFNeKQ2y6G6gldePl0pA8ljyeYY
         nbpxDRYTTTrArUzDiXXQKxBT0h1qvfCmKZh9cZLtqv49wi0DTfb5d7No9gLVPntjIXem
         52qvMUDen0pTuiPA2iGcpWhuvzzvjsnsWtddrvE1gcnFTkAJzy0VsgbioY7+WLoLlXgG
         ztcRvaNJu+5ONHbqg7e4/vfDmGjAJm8uuIkMokHrgddXhMbBVfjrDhTcJ/QYSmLDgEk6
         VLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nKLYIGEYGqdYWyeeLA6YY5IvzAix8ZYXy6/QGARpfbk=;
        b=CGLNTCozab5IARSD7aCtJ3z91R3DWCvpN/wnu8jXDGzTpwGwrRsP7vCFnZbEiAAxqn
         hYmzMnJpc2Y0hubEZ5gF3POIjpvdSwuIe2Dcxg5CGBrq36U4XiEUaxECRE3SKe5AZDg0
         P0mBDgcSCfzybuAZPdfkgrPbKfWyDSLL2HAG+VEi+NHqhpSuTTXKfAvyMoNWfyPTsUp5
         rPEtlRxb11s9CaffY8tHsTVzNMQUwzacyzBJk3s6YwcUdHJlbQA4O1ntAx4mkyIaS79/
         KLXPXZBV1JwLZNPz9Lauh/nLDxUpC5yhoQROaG/HDmTTc4qBOU6HwEJxChDo+bMdBpEj
         Z5fQ==
X-Gm-Message-State: AOAM530bU21mMMvrdz1n9SAwBVqvCm1Gp6P59UEMNZef8ngtgQpfkEDU
        pzMmBNdnJg49z9ku9IzGuDQtfAv6+hjn+g==
X-Google-Smtp-Source: ABdhPJwnVhnq8JjF+URPbti8aBoydvNLGWQAVLgCzb4ILFGHt/NJjYZa2TgShyNAMgduATDb3GpTFg==
X-Received: by 2002:a17:90a:c598:: with SMTP id l24mr689136pjt.175.1644958213404;
        Tue, 15 Feb 2022 12:50:13 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q32sm3500251pgm.26.2022.02.15.12.50.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 12:50:13 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] player: Fix Track being emitted with empty metadata
Date:   Tue, 15 Feb 2022 12:50:12 -0800
Message-Id: <20220215205012.2130772-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sometimes causes the Track to be schedule while some metadata are
still pending.

Fixes: https://github.com/bluez/bluez/issues/291
---
 profiles/audio/player.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index d34b39168..687614b49 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1308,9 +1308,14 @@ void media_player_set_duration(struct media_player *mp, uint32_t duration)
 
 	g_hash_table_replace(mp->track, g_strdup("Duration"), value);
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+	/* If metadata is pending wait for it */
+	if (mp->process_id)
+		return;
+
+	g_dbus_emit_property_changed_full(btd_get_dbus_connection(),
 					mp->path, MEDIA_PLAYER_INTERFACE,
-					"Track");
+					"Track",
+					G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
 }
 
 void media_player_set_position(struct media_player *mp, uint32_t position)
-- 
2.34.1

