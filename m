Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0294DC54E94
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 23:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjAXX7c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 18:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbjAXX7b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 18:59:31 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E6647423
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 15:59:26 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d3so16340981plr.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 15:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NOP5sc6GAk/5mEPeE8p07kGXaiP2fSMYAITGHTtqSyg=;
        b=E51nliTiVmyr6q7g7z8RojL9vPC1XdlNjq5b1kIQLsElLRKA8exjH6qbdHGCEc32gr
         Os8UbSYt4bsKFQ/l5Qtj/QDXaPmi3oppl5tcXhxfF4+15SVE4tzQtQIGATBi6dedQqP6
         kllD4FDtXEigTUqlgFhRPrCSYfqoRKhWh8R3UEYXqouJAhKHHchZxLN00eQuT9gFaqCx
         epcIsNmkp+T4SMj1qQRoJW9l61Jin/ktnRb3ndyNpzNnGYLPrwRQsOTbC933IT4xPW7c
         55KIC9fnTceJK3QH4LC2sKMAByNN7zsnr/19NdAmmMA3dWtmvrVSnMuFTB74mwtHmLV2
         L7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOP5sc6GAk/5mEPeE8p07kGXaiP2fSMYAITGHTtqSyg=;
        b=ikpjeI3bmuuL+xRI9dZ3YiILt+9fiXR6oPa+wEoUgT2J5x5m5DER2YuTEea2l5mal5
         W5+NuGYmtvuqgCRhXUjyttVA8bTz/H9moaTyOwAvs3YHWjmRONBFxPUn+Czv2NBC4Ujf
         O8BVyEDzzhYn4yq6tHcncffAmC4wnTMNcvoKCLeFlZQ74MZIKixUM9nuamDk+4TerW8T
         1d1+aSFE/+L0Wzyp1DHA2TkhCVGpu6Md3Yqv0n7UGWu5JxjDLM8MFNBeZBIVIICsKYa8
         4GkIwF2ZDd6qPJ5Cuzeo8kMs9qniRR1UMNuFWAUShxdH/sNIZCLjEm9Wu8sCyRtwRwNK
         yu1w==
X-Gm-Message-State: AFqh2krmwwWQv2PV0MmjoNSxlWf+NBuvgtPvN/bn/UNKiTpaQUW285oE
        iIuG68T55aTBK3wWPT/qpBtVDtWl6uU=
X-Google-Smtp-Source: AMrXdXtQeWcMoBm9cjG9nl4LlKtJcePhyBxyHmMtGVKML4ZcbvimLMlDtwaf7kJeDSrTRBpWiWd4lA==
X-Received: by 2002:a05:6a20:4a14:b0:b8:88ea:ca27 with SMTP id fr20-20020a056a204a1400b000b888eaca27mr30942736pzb.53.1674604764995;
        Tue, 24 Jan 2023 15:59:24 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id r3-20020aa79883000000b00585cb0efebbsm2242648pfl.175.2023.01.24.15.59.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 15:59:24 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] shared/bap: Fix not detaching streams when PAC is removed
Date:   Tue, 24 Jan 2023 15:59:21 -0800
Message-Id: <20230124235923.3623705-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When local PAC is removed we attempt to release the streams but we left
it still attached to the endpoint, so this makes sure the stream is
properly detached by setting its state to idle.

Fixes: https://github.com/bluez/bluez/issues/457
---
 src/shared/bap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index db7def7999b7..4ba65cbaa8f9 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2478,8 +2478,10 @@ static void remove_streams(void *data, void *user_data)
 	struct bt_bap_stream *stream;
 
 	stream = queue_remove_if(bap->streams, match_stream_lpac, pac);
-	if (stream)
+	if (stream) {
 		bt_bap_stream_release(stream, NULL, NULL);
+		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
+	}
 }
 
 bool bt_bap_remove_pac(struct bt_bap_pac *pac)
-- 
2.37.3

