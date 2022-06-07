Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE4DC43334
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jun 2022 13:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbiFGNrb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jun 2022 09:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241609AbiFGNr2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jun 2022 09:47:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717381E3C5
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jun 2022 06:47:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p10so24253900wrg.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jun 2022 06:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yHEkZ4f8EPJnKRi58/HD9Y5sbQwKZUo9tMe5hK1B3uM=;
        b=ZttsjQv7dTxM63O5dpFy+spl2V91d5GksN6LFZwJuX9es1h8Uh0FVbttGTeJgnG8yb
         YtFzpHjwqCymygxIscwrSWSfW5DLQnE3gcjcVO6BjJanguQcwTIdR/SUrR0y5wHdm8yo
         /me+Y0e6AmnyJxFOf8YCvttFgOiQQarJ67oXzHT8d0I+m3vCPdV1dmhq8ahLDCw8Y/N7
         rlWxQfe1eT04lBiUXnGgmWnWQQunbVA9tszlviIM5q7qo1wlPAAuYJIg+daCq6JHwmMD
         pU8VRSrJ98cdUXy39Fx8k5m0H/K3eDdIl7PSQqz8PVMt214ECT9CVLEV6t+QypBBp8FV
         DnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yHEkZ4f8EPJnKRi58/HD9Y5sbQwKZUo9tMe5hK1B3uM=;
        b=JcGUQmCDez56XISKpFivdw0JptPc8hhDiqyscWIgCA0AQ2sh/Xfxd07E9UCT7d6C+5
         1oWxahfG9+mHheO3PWksJaqZ2/2w+L18zxs/3b0D2AnAB3LZk9uyAI7s6lJ/6FFKU53c
         yjLLGCsNLD2OwlEQd4lYoZBYVJhTXIOT9iPPKxVHlCWQHzSO+wsWJIt8bY0xy1ij5Luo
         v8s8+4MqdxcegqWXuw2odbR+2IYTN5DAzhTG8eeKc4RIgDrQqfKNjYK75BQGFHwHPy+R
         1YZPo5AGA7+4j6QzS4ypa2cxIrQNd3rqMEa2ywagCdMkiKVJhSpFgkdVgjzOuh/clgqv
         ZZjA==
X-Gm-Message-State: AOAM530iQlsKM97mso0+iSk7L5E+l1y/K3h1CiyUnIwsvtfhWNEOjec5
        mQl9wMUFokqfTIozJfx0Fw6+7g==
X-Google-Smtp-Source: ABdhPJzzQfep8a5zTJFgnsRLIjY9+/W6fqSitNbXiSv+k+J3uaniR58mvoMKm18jhKL42gVSkwAO0w==
X-Received: by 2002:a5d:5c07:0:b0:218:544d:4347 with SMTP id cc7-20020a5d5c07000000b00218544d4347mr2153991wrb.107.1654609644928;
        Tue, 07 Jun 2022 06:47:24 -0700 (PDT)
Received: from joneslee-l.cable.virginm.net (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id d6-20020adff846000000b0020c5253d8d2sm18280401wrq.30.2022.06.07.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 06:47:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, stable@kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 1/1] Bluetooth: Use chan_list_lock to protect the whole put/destroy invokation
Date:   Tue,  7 Jun 2022 14:47:09 +0100
Message-Id: <20220607134709.373344-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change prevents a use-after-free caused by one of the worker
threads starting up (see below) *after* the final channel reference
has been put() during sock_close() but *before* the references to the
channel have been destroyed.

  refcount_t: increment on 0; use-after-free.
  BUG: KASAN: use-after-free in refcount_dec_and_test+0x20/0xd0
  Read of size 4 at addr ffffffc114f5bf18 by task kworker/u17:14/705

  CPU: 4 PID: 705 Comm: kworker/u17:14 Tainted: G S      W       4.14.234-00003-g1fb6d0bd49a4-dirty #28
  Hardware name: Qualcomm Technologies, Inc. SM8150 V2 PM8150 Google Inc. MSM sm8150 Flame DVT (DT)
  Workqueue: hci0 hci_rx_work
  Call trace:
   dump_backtrace+0x0/0x378
   show_stack+0x20/0x2c
   dump_stack+0x124/0x148
   print_address_description+0x80/0x2e8
   __kasan_report+0x168/0x188
   kasan_report+0x10/0x18
   __asan_load4+0x84/0x8c
   refcount_dec_and_test+0x20/0xd0
   l2cap_chan_put+0x48/0x12c
   l2cap_recv_frame+0x4770/0x6550
   l2cap_recv_acldata+0x44c/0x7a4
   hci_acldata_packet+0x100/0x188
   hci_rx_work+0x178/0x23c
   process_one_work+0x35c/0x95c
   worker_thread+0x4cc/0x960
   kthread+0x1a8/0x1c4
   ret_from_fork+0x10/0x18

Cc: stable@kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 net/bluetooth/l2cap_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ae78490ecd3d4..82279c5919fd8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -483,9 +483,7 @@ static void l2cap_chan_destroy(struct kref *kref)
 
 	BT_DBG("chan %p", chan);
 
-	write_lock(&chan_list_lock);
 	list_del(&chan->global_l);
-	write_unlock(&chan_list_lock);
 
 	kfree(chan);
 }
@@ -501,7 +499,9 @@ void l2cap_chan_put(struct l2cap_chan *c)
 {
 	BT_DBG("chan %p orig refcnt %u", c, kref_read(&c->kref));
 
+	write_lock(&chan_list_lock);
 	kref_put(&c->kref, l2cap_chan_destroy);
+	write_unlock(&chan_list_lock);
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_put);
 
-- 
2.36.1.255.ge46751e96f-goog

