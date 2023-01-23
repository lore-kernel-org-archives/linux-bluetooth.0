Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E456C38142
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Jan 2023 21:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjAWVcS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Jan 2023 16:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjAWVcR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Jan 2023 16:32:17 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37A73346D
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 13:32:15 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id k18so12784576pll.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 13:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQPugu7B9HrwJq2khs0mn0gnme2ItCl7ethv33RJbRQ=;
        b=fzjwC/p2DHgT8kxUBKkeqZs3NMtCbdJzukHz5IFBZYv4c54YmvgX/xOQpMgsZETjrE
         NDF6UKKxfmGaooN8ARkuAGyLYFJYShkpjvLLAzSccVQHsOctD4KYzEWDkLWxoJ+wB1M6
         2uWZ+h6R1i6/UAlFwTkl8XnTWZtny0AXLcAAVBSvLMeFs12GUIYCNI/LOnkJuc4gzFX1
         OWDjyYnsi/gLZI5POs+hWgRmCdhSla+9+1MrUGGqP2t+JyZOTA6g0V/cklZaeOV3qzRn
         tz8FGeYaxNZyS8TfML3QXhqeEXmsvFfZnc46tTrx80VcRILtTH5OfN5MOHV1i7I0vNWg
         /4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQPugu7B9HrwJq2khs0mn0gnme2ItCl7ethv33RJbRQ=;
        b=NLvjkItsD1kiUU7PnKOW1HpHQh6cIABVjT1mNKtDJhjvtmab/FrF5FHII4AegHdVlH
         wYocxytWQN2NdPa89wEwj9zy+zsIqG4gdH8tJ0roDKTjtSINrBKLib7axsqRttEESmbd
         FgVJpiys37QEC56/GLCGJnGUVwHLYuXbu7vpnBu8KyIn2D1EorCegGjyFhjmjoRQBtZY
         HJImhWyg2YvHgSmYTN88356w4pH5q7ElW2oSpymkbz3eX4NkvMzMAyP3831SY2zPlrJ4
         m9z2Zki6wS2iwPFgV8LEh7ujjcRKTXnZeFBsOPcL2cI/swYA/OGDyBTqKEsOjo+ehoz+
         773A==
X-Gm-Message-State: AFqh2krfLkCrfeAww7FysSnhBvGhSszLspJKvw7+ucYAhdu9ix2ibg8b
        M6X7jAKQ1N0jXWRDX6FRzYQywGO9qZ4=
X-Google-Smtp-Source: AMrXdXsY5gexIIY1t4ajm8ERVzMxB6vlo2kWVM1h7XcwyDUwjpYmENeg41/hAIGaomb/arSg+cCysg==
X-Received: by 2002:a17:903:11c7:b0:194:58c7:ab79 with SMTP id q7-20020a17090311c700b0019458c7ab79mr33923973plh.63.1674509534924;
        Mon, 23 Jan 2023 13:32:14 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id bb9-20020a170902bc8900b00190c6518e30sm142629plb.243.2023.01.23.13.32.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:32:14 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] bap: Fix not setting stream to NULL
Date:   Mon, 23 Jan 2023 13:32:12 -0800
Message-Id: <20230123213212.3187747-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230123213212.3187747-1-luiz.dentz@gmail.com>
References: <20230123213212.3187747-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the stream state is idle the ep->stream shall be set to NULL
otherwise it may be reused causing the following trace:

==32623==ERROR: AddressSanitizer: heap-use-after-free on address ...
 READ of size 8 at 0x60b000103550 thread T0
    #0 0x7bf7b7 in bap_stream_valid src/shared/bap.c:4065
    #1 0x7bf981 in bt_bap_stream_config src/shared/bap.c:4082
    #2 0x51a7c8 in bap_config profiles/audio/bap.c:584
    #3 0x71b907 in queue_foreach src/shared/queue.c:207
    #4 0x51b61f in select_cb profiles/audio/bap.c:626
    #5 0x4691ed in pac_select_cb profiles/audio/media.c:884
    #6 0x4657ea in endpoint_reply profiles/audio/media.c:369

Fixes: https://github.com/bluez/bluez/issues/457#issuecomment-1399232486
---
 profiles/audio/bap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ae944b617bb4..8f24117681d2 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -998,9 +998,10 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_IDLE:
 		/* Release stream if idle */
-		if (ep)
+		if (ep) {
 			bap_io_close(ep);
-		else
+			ep->stream = NULL;
+		} else
 			queue_remove(data->streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
-- 
2.37.3

