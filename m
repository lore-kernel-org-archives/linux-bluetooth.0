Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F867C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 20:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiI2Ucq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 16:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiI2Uco (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 16:32:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E38612968F
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 13:32:44 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so2423498pjk.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 13:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=FeeOZAtAjZUmYD55G5V8TWYnHZX+4Y4ahas6G0qZxSI=;
        b=jlLfVacVCDrYd1X4HjtG3kSMpr+CxJ1FA9PzrXYXLJFi5Sj2bjERdr/MCH3bLsfyAD
         DORdtMEVpEdDVDeP77Pz6CuFq6o4e5h8GLmoKKE6DHu+f6ofvkiQ04di5bNU43KFmT2D
         mXItV56kJ1i+mpPg1PdHUtdqec645DaBJmoX+r0rwlxZJRgV2pAqrjU+eRUY5slZrK2d
         aEBCN6R+XufJm9WJ689HhtMRD/1x04d0x/IRPEp366xXJMc97S5D5yDzd7AmoMaunilk
         kmBFP/YGZNE75KoMO9SqfwwDYAdIcc1QyxQvvEZsvTqexuP/Sm0yrpkbfeCtyHKoMslJ
         +ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=FeeOZAtAjZUmYD55G5V8TWYnHZX+4Y4ahas6G0qZxSI=;
        b=4ltU15bgQPm+OtTJilugI+md5nzwl1R57ePvgopOSgtjFLAjZHWVQfEpsni6dz7uHX
         ZWmfzac/U8m09B8Wj2HUIeS3ZO6kbmX2vNnB8Jnrz6dD/QkMvqXxqW8b729zIhhnJHAM
         tbXSaa7uDIqZ4ngWWxrRg2FUoDTzmJbIlAIRCI02me+eN79E9X3RH/unBUJkLeEDgTDA
         lF4LGcZJ7XC/Ijqt3siYEKZTf4lDLlCXoYl3oQnZ3EbOcgTw/c++KkC5JIVca0m8ic94
         joQHgGGWRIPQScwXs9QG7XKHWyhcr5TLkPxTehzGrUW6fM5vRR8DGKQ1hq2W9P4NBZdT
         ZSCw==
X-Gm-Message-State: ACrzQf2m4S3/JXVBHryTdjfGuekqrzt+f8D9eD0Q9c9REZS7GLltBaxu
        hBP8fRyCy/z9s5bbKcIpalH5/6ZQE7o=
X-Google-Smtp-Source: AMsMyM73w9tbPw2CPTSdbTGifFgGler0ykpwRhfclYwyrlaW0tcdLLsDYtDLG8a8a0j58wqh2INfTA==
X-Received: by 2002:a17:903:22d0:b0:177:e5b2:c598 with SMTP id y16-20020a17090322d000b00177e5b2c598mr5230030plg.56.1664483562995;
        Thu, 29 Sep 2022 13:32:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t131-20020a635f89000000b004393c5a8006sm298451pgb.75.2022.09.29.13.32.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:32:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix user-after-free
Date:   Thu, 29 Sep 2022 13:32:41 -0700
Message-Id: <20220929203241.4140795-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses l2cap_chan_hold_unless_zero() after calling
__l2cap_get_chan_blah() to prevent the following trace:

Bluetooth: l2cap_core.c:static void l2cap_chan_destroy(struct kref
*kref)
Bluetooth: chan 0000000023c4974d
Bluetooth: parent 00000000ae861c08
==================================================================
BUG: KASAN: use-after-free in __mutex_waiter_is_first
kernel/locking/mutex.c:191 [inline]
BUG: KASAN: use-after-free in __mutex_lock_common
kernel/locking/mutex.c:671 [inline]
BUG: KASAN: use-after-free in __mutex_lock+0x278/0x400
kernel/locking/mutex.c:729
Read of size 8 at addr ffff888006a49b08 by task kworker/u3:2/389

Link: https://lore.kernel.org/lkml/20220622082716.478486-1-lee.jones@linaro.org
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 net/bluetooth/l2cap_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 770891f68703..1f34b82ca0ec 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4309,6 +4309,12 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		}
 	}
 
+	chan = l2cap_chan_hold_unless_zero(chan);
+	if (!chan) {
+		err = -EBADSLT;
+		goto unlock;
+	}
+
 	err = 0;
 
 	l2cap_chan_lock(chan);
@@ -4338,6 +4344,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 	}
 
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 unlock:
 	mutex_unlock(&conn->chan_lock);
-- 
2.37.3

