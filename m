Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B72C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 23:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiCVXvd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 19:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiCVXvc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 19:51:32 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7017B58813
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 16:50:03 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z128so706434pgz.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 16:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+L+IhbTrrqHQA3HA6gl2qhIP9q4q7ZvlDBtBdc+Krc=;
        b=Bx30kRtOX8g1f4KW0HEiwYq816igI39iN+3cm6gM1Lf8oKh9hMe3ty0r9Vh9MjvrXJ
         3h4jctSqZjNv0EgCKIvya9JEJqLHuNHxmN02oGM1sLLVJr5YHr4igRUzJnf084wuHKNf
         66uY1g59GY20pRghY+kR+Cw/LvFN8RkyKV13ULoUlLy0SBonHD2Ekt0tD6L3vC3gGczu
         qEgZfJlqcVDPG4hBtIWGROCAkRa0HiJFAOdVRBX0rmhXa0CW1AlmF50ynXtY1hxj2Zlz
         zavzoMuId/fJHmFqlS/n2kQGp7kWvLPbkyQQ4OjlN/tReInwxKdoA7ENDKTc6hc33THq
         f12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+L+IhbTrrqHQA3HA6gl2qhIP9q4q7ZvlDBtBdc+Krc=;
        b=ivlU2mtNbaCw2iF0YqyheTIt0DMHe53Yeto+Ltfyp6FiBZbecPYfLMzOGZAYHcx2C+
         iEpj1W89HtkGk5XGKxWgo6lRWBpAS6coRAHvVOPny76LgvSeKBzRnJ1L0XkW7wf13W7F
         0ZqE0Nwkb4TtoUnRsEiNfFduqJ7uEegcYKea9lRi2bdXToAnGsvTsMJ3SEWnt4V3i6lJ
         bQEGoa33jyeLFAebbM3cvV59CCB2ETD20LaiIadT+tNtLQxGZwOsS3ARj3mkLsqH7xZG
         hI0oeHxiDbvzYhPzw0LFcNSltr/2mFQh0tYLcs/3HL27qTRRMFCjuhZBMySCFdB7F7k+
         hEkA==
X-Gm-Message-State: AOAM530ulDfB1TRjWtRnjEFUz8AfJD7fuXXswfubLyk6A65yPrTJb/hX
        Iu/q3P1SkfGsKAu2+PWjwPhzyAayC+k=
X-Google-Smtp-Source: ABdhPJzlWiK0Ib/uNrqB7nx3PC3/sCrNr+XeyDlgGXNMPXk7nGjdWSOOZJwtvQr3Qca5BliCOi9osQ==
X-Received: by 2002:a63:4f61:0:b0:382:7676:bed0 with SMTP id p33-20020a634f61000000b003827676bed0mr10730227pgl.575.1647992997770;
        Tue, 22 Mar 2022 16:49:57 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b25-20020a637159000000b00381fda49d15sm16307251pgn.39.2022.03.22.16.49.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 16:49:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt-server: Limit the Server MTU based on the Client MTU
Date:   Tue, 22 Mar 2022 16:49:56 -0700
Message-Id: <20220322234956.3153209-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The spec is clear that the final ATT MTU is calculate using the minimum
of Client RX MTU and Server RX MTU but some peripherals seem to expect
the Server to already calculate the final MTU and not respond with its
own MTU.

Link: https://lore.kernel.org/linux-bluetooth/CABBYNZL-fjTd8JdmRRM5Y26d41KwDxvvuaED+j2+yPT-RBpMtw@mail.gmail.com/T/#t
---
 src/shared/gatt-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 2adb4afbf..d326782bf 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1499,7 +1499,7 @@ static void exchange_mtu_cb(struct bt_att_chan *chan, uint8_t opcode,
 	final_mtu = MAX(MIN(client_rx_mtu, server->mtu), BT_ATT_DEFAULT_LE_MTU);
 
 	/* Respond with the server MTU */
-	put_le16(server->mtu, rsp_pdu);
+	put_le16(final_mtu, rsp_pdu);
 	bt_att_chan_send_rsp(chan, BT_ATT_OP_MTU_RSP, rsp_pdu, 2);
 
 	/* Set MTU to be the minimum */
-- 
2.35.1

