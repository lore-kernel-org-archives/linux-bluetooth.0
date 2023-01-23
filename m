Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9254AC25B50
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Jan 2023 21:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjAWVcQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Jan 2023 16:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjAWVcP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Jan 2023 16:32:15 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F1618B3C
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 13:32:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso7814722pjp.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 13:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NOP5sc6GAk/5mEPeE8p07kGXaiP2fSMYAITGHTtqSyg=;
        b=OGQX8oezHIRgho1SCiTVu+yoVAJO1fYqG41w9AnYGL1fr4zEak3W7w52Qf5vuEq3Ed
         G5/FalCeGFHWBt3t/sOqC3gE/iLiuTkuWe0SX9ugE0HyLJW52PNiTzvBLK0Am5/hx2yy
         MFWospgzzt0xqQ8OP8SO7KAgU/GrvxRVVi9v/meNoX8b4/pN3TdEFsUFyVk4xp6NguYC
         by3lmBECF1Fmz3+Uu3a3iwCRYkQNrU8qJDUVHmxsqcerhloRiTjHqtMAkgZj3BANsbtb
         ERhuV72iaORKlFqxWNo2Ohht4j6cBWnHcf4cR+UyipL8QhWQIavl0ffaO24v62s6Uix6
         qKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOP5sc6GAk/5mEPeE8p07kGXaiP2fSMYAITGHTtqSyg=;
        b=HEDE6JszfarxbVszozLUIQS7QGchnU+pCP91jjULDXQPL0fH+n9s+xWXYBRpWqEF/K
         vR3lY5CUmG+dHK3yb2rEqZWAUBwNVGM/v/PIcw3/P2UAhTpv4zZ8vpPJInnTZqBuEnK/
         DdMMPiynoST6X4mh4Fr1biI4nJcBKNilSP9ruYHqEWNY9+gkbCvzQzcV2Bb5ImVE15Qq
         0NreYYpGQsSv7qhqN3a1DzgTeqWfjKz4tUs4oS0Np/e7Tqxhj3GHkD/0JousJscz8ORU
         4jw4C7BVNOF6i4+4584Uk8w+Bm/KOmEoPQ1rnEVpU80kbjPFGj8Y+ootTsFuZitlpSy4
         XMKQ==
X-Gm-Message-State: AFqh2kpqeZa97HAZ9XQwojuG4Sg5k7JVbSRTMQN44Vqkydhr9cQbolkV
        T14zQ8EuF9+x57ccrrGB1G8C2uKj6/I=
X-Google-Smtp-Source: AMrXdXsmvcLkS8eKcah6LSQPCwRn0TMe6xq5j+IiD3/fqWcDHyP0sIvQksXViIj9mA3l/O8pMIvvbw==
X-Received: by 2002:a17:902:b704:b0:192:bbe9:4cab with SMTP id d4-20020a170902b70400b00192bbe94cabmr24068292pls.24.1674509533754;
        Mon, 23 Jan 2023 13:32:13 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id bb9-20020a170902bc8900b00190c6518e30sm142629plb.243.2023.01.23.13.32.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:32:13 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/bap: Fix not detaching streams when PAC is removed
Date:   Mon, 23 Jan 2023 13:32:11 -0800
Message-Id: <20230123213212.3187747-1-luiz.dentz@gmail.com>
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

