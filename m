Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ABAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Dec 2022 01:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiLIBDT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLIBDR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Dec 2022 20:03:17 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0D775BC4
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 17:03:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so3362829pjd.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Dec 2022 17:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPxlPB77OzQNUBW1EgOuo55XCJcGR0T2VxU+nuwk8GY=;
        b=dluj3XPJ+KZScL0LGl/nZhmAgImQu718K3UJ2FLKbHKygChyw/LeSu796II9/bQJ1v
         u1Gbaux0bbgTTixFjhb+B4lQ/gVyBtOvwMPNUIWvVOVoqZdQGKuHL49RV22aXyymL855
         qj8ZitpFI3JtJPVHUr3cQV1beFRL8ZE+Li7uSSrwRkT7FDDAEm8FtsTf25dSR2+rwyXD
         EmCtQKkscqlirHe76P8brHefdjy/qN3DSRw9kcAz6+yMOvZuZmv9wlCwKbK5RE7Iq0IP
         0lT0AzxHODz1GAtkaA9QDR3t2Endp2aff1zwL/llh/O9kWd1X5zOqrsVOZdcnXNHn8OG
         7VzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPxlPB77OzQNUBW1EgOuo55XCJcGR0T2VxU+nuwk8GY=;
        b=Cjtaq+DheY/QUztYEMZNiYJidcLQ601K2ZkK0fwzai2S7UrzixjRJEpNL/k48lI2fN
         aF45Ysfc8Y8EKGMCaZOeYUuTjnfxtBNPWLpAzQIsFFvN+S8Am3e+0nN7I7+ibmLQCYnH
         o9IEsXQCecsLkLtGKo3wX1pYSD5PESAvak1VKqHamYo3ky2zEs3kvkEvlngxyZhZJua3
         MWeC3jHQfKsSs2nBfk374AoHN8KGbTAO6EtZ3piHJixIORTDwlqLM8LRWUNyLbYNlvcL
         QdPEk6q8qiVkjkCULPrS4X/VhABbE2R3AL9vJfI/w9PQjR7ey0P8ub4m/3A1W3HfglRA
         jCMw==
X-Gm-Message-State: ANoB5pnjQ1UiEBvNeoagDCmOJal/IGAn6Wizw1fDvqrTcl9cJRK4hH7Z
        +QO9uOHeopfZIwfSQNvdpVG2wP4hdzlV5g==
X-Google-Smtp-Source: AA0mqf5MSySrVtNNuBL688xlmspqLbJlXfvPt8gOJ7++gysGFZbrMk8sTELqEPICGJwaGh1Pe5TYTg==
X-Received: by 2002:a05:6a20:b042:b0:a9:ec2a:1013 with SMTP id dx2-20020a056a20b04200b000a9ec2a1013mr4175162pzb.56.1670547795872;
        Thu, 08 Dec 2022 17:03:15 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z21-20020aa79495000000b005746c3b2445sm100253pfk.151.2022.12.08.17.03.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:03:15 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] shared/att: Fix not requeueing in the same channel
Date:   Thu,  8 Dec 2022 17:03:10 -0800
Message-Id: <20221209010314.707606-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If request needs to be resend due to change in the security use the
chan->queue otherwise it may end up using a different channel.
---
 src/shared/att.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index f7bef08bc169..b90af93ccbf8 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -799,8 +799,8 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
 
 	chan->pending_req = NULL;
 
-	/* Push operation back to request queue */
-	return queue_push_head(att->req_queue, op);
+	/* Push operation back to channel queue */
+	return queue_push_head(chan->queue, op);
 }
 
 static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint8_t *pdu,
-- 
2.37.3

