Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB2BC00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 21:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiHAVGP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiHAVGO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 17:06:14 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFAE1408C
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 14:06:13 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c139so11744342pfc.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Aug 2022 14:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/pyMGEWDoc/FXBebC8GjWdLFxpcW4asNo31zbe5YOvc=;
        b=FLljusUu77Z2iIGBWH6+236kcOqw6LhbIY44duN1VjuSAwCIdJB5nbFudPFnmrXINz
         NltzTAUnpycq9Un6J4DXj2bCAudDWCTI+B6BwyUIrO7skYNrUlTeDF4ZaQ6NI1FX09n1
         lYFRnNcmMxu+pWQGqerXvzMdbfuxK9cDKK2D4KQxFBX9+0bOdBhWczUiYtaJpFctRlKh
         gmlZnG3Z/yiGO/ZYCTcDiwfZeZ2zR4yP4oZ1YtBUwqmPpCBl4GNvBSGSTNFDipqJf5xs
         6Tlsond2bwr3VYBnWxyYZqJ1mQlctdDFwn7ulMIksJuHoaBWgqowNdYvTGkmUzCY0tZG
         SCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/pyMGEWDoc/FXBebC8GjWdLFxpcW4asNo31zbe5YOvc=;
        b=Qfw1WferIUAKpQ1h/E0yRx6Gaq66feuIzlI2f46lSPi2ksMDDzmhlXIOySrIZa8tXf
         PJkor/YNsy/9ZIl5+8OcniHM+ngugfks2lZ8/f5/J+fxmLifTIyrpI/+iWqBQy0fBAIr
         gn6gbx1zibhyDvacwTcz8+ApMen4P9GpQZJ3Tpd/EP2CdwEqwbCMgJp7Qqj2VgWoaZJ/
         0MpJ41VK1OYj11Pojbr28N+NdtgacQgOfsW0HePhjW3DXQBFblG4ngQb3c4HKoYM33Z5
         Z2tuQ/An4NJXyjkJfIjTWV4BlLkqjTGNe5/VErE0HSo5mVyuIBHfiRluOWN98xhWAoS5
         SCww==
X-Gm-Message-State: ACgBeo2MBPwbawLJz1y+B9ePR2ArXYvNvG8xKGPA5tynQDKKM/kUGKSN
        oztYnBX94yS5x6PDlQJQciB1kRmpNxyY5g==
X-Google-Smtp-Source: AA6agR6P862VQbc/xky7bo68fH9qe/JZ9KfgWwjJZAchGZuw04DjnRl2/gBBLKaf6o87JZszhCUakQ==
X-Received: by 2002:aa7:8e91:0:b0:52d:8ebf:29a4 with SMTP id a17-20020aa78e91000000b0052d8ebf29a4mr5127718pfr.1.1659387972633;
        Mon, 01 Aug 2022 14:06:12 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p1-20020aa79e81000000b0052d96d86836sm2179475pfq.50.2022.08.01.14.06.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:06:11 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm regression
Date:   Mon,  1 Aug 2022 14:06:09 -0700
Message-Id: <20220801210609.2183766-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The patch d0be8347c623: "Bluetooth: L2CAP: Fix use-after-free caused
by l2cap_chan_put" from Jul 21, 2022, leads to the following Smatch
static checker warning:

        net/bluetooth/l2cap_core.c:1977 l2cap_global_chan_by_psm()
        error: we previously assumed 'c' could be null (see line 1996)

Fixes: d0be8347c623: "Bluetooth: L2CAP: Fix use-after-free caused by l2cap_chan_put"
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 52668662ae8d..f18d0c72713f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1969,11 +1969,11 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 						   bdaddr_t *dst,
 						   u8 link_type)
 {
-	struct l2cap_chan *c, *c1 = NULL;
+	struct l2cap_chan *c, *tmp, *c1 = NULL;
 
 	read_lock(&chan_list_lock);
 
-	list_for_each_entry(c, &chan_list, global_l) {
+	list_for_each_entry_safe(c, tmp, &chan_list, global_l) {
 		if (state && c->state != state)
 			continue;
 
@@ -1992,11 +1992,10 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 			dst_match = !bacmp(&c->dst, dst);
 			if (src_match && dst_match) {
 				c = l2cap_chan_hold_unless_zero(c);
-				if (!c)
-					continue;
-
-				read_unlock(&chan_list_lock);
-				return c;
+				if (c) {
+					read_unlock(&chan_list_lock);
+					return c;
+				}
 			}
 
 			/* Closest match */
-- 
2.37.1

