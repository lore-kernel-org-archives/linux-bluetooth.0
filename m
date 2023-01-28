Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA44C38142
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Jan 2023 06:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjA1GjR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 Jan 2023 01:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjA1GjQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 Jan 2023 01:39:16 -0500
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109494A1F0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 22:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telink-semi.com;
        s=lgqu2209; t=1674887952;
        bh=Sj80bPQmLV7ASK4fKR2qWToQ0Hu/WsXnHdSMBG9M6YY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=ENvcybLxGdOvgE69+VmOdZlJhNOYoVh3Dxx/wd1ePvzkWv9JIckxhqZwRqPfefp2v
         f2i3l2n/GOu4xYLIJCzlZauwar3ln02LG7VMm01TMzJShZ0DhzrluHajlgeQ1Mpp5o
         DIu+A98RfYtdZV5nDQe7gwWUIn0KHCgyKHuoIio4=
X-QQ-mid: bizesmtp89t1674887886t1mo3mle
Received: from fedora.. ( [85.31.249.147])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 28 Jan 2023 14:37:53 +0800 (CST)
X-QQ-SSF: 0140000000200060D000B00A0000000
X-QQ-FEAT: znfcQSa1hKZBIBR//c2YM6++Mn+zQGuddaBEgouTIt8Xz/NHvaa6eDtr8hoew
        aSTNot01ukRe8JvDQuCWiZqoipv/YiSolKJzQIOnGtPc/o6tFjg6ZYg1evztdd65yRlPW/N
        YwlwLIq89wke3pfEKfNe86E0wZadaT9TalXn9w41JC5tRZ9aNJFU0PZMAWI2xajLLPC9mTO
        HQzfzyvzMMQ+PM3pBV8udzWSyw92j/IrX3vrKU7R1GGl2x12jNe+vtoYvl7e9sMAu7HVQJV
        Ilh0wcfPKb10rKqQVtOb38IVb7QFwvx1+1lLVxFJHA0yKKDqp9V1Oqz0lV84KQcg+KNvGob
        gRyJBD+pDWx1mJ5U8yaPFo72q85flxbQl16UA6GFKmBUDNtAcMOub2IDAdLuB2ARz9wUC6U
        bksn1yaw8iE=
X-QQ-GoodBg: 2
From:   Marcin Kraglak <marcin.kraglak@telink-semi.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcin Kraglak <marcin.kraglak@telink-semi.com>
Subject: [PATCH 2/2] AUTHORS: Update Marcin's email
Date:   Sat, 28 Jan 2023 07:37:33 +0100
Message-Id: <20230128063733.18131-2-marcin.kraglak@telink-semi.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128063733.18131-1-marcin.kraglak@telink-semi.com>
References: <20230128063733.18131-1-marcin.kraglak@telink-semi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:telink-semi.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 AUTHORS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/AUTHORS b/AUTHORS
index 291d9b049..5d2d09688 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -84,7 +84,7 @@ Petri Gynther <pgynther@google.com>
 Scott James Remnant <scott@netsplit.com>
 Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
 Grzegorz Kołodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
-Marcin Krąglak <marcin.kraglak@tieto.com>
+Marcin Krąglak <marcin.kraglak@telink-semi.com>
 Łukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
 Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
 Arman Uguray <armansito@chromium.org>
-- 
2.39.1

