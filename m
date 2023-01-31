Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8CCC636CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 23:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjAaXCC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 18:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAaXCB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 18:02:01 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B77CC671
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 15:02:00 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso193371pjj.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 15:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matician-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jluehKlxUGXq2+vghVWnC4Xvup58MfvgTPLtNeMpSHM=;
        b=1yew5PdhDVPlDigntwUhgb9kySg7cAFSLW1V+B0EMVtJAcdfgcnLMPtedIO7SQ3mOB
         TGj74Mmnqu3uBUhLF2wXKPMpbVWWSroRYohP08qK9/rJkFTDuNaDrSc2Xpai2EksU7cz
         N4CXm5n8oat7qhcdq4X71EV6Zp7Urf9RIknwPfqq9fmcgHWrpQu2LKjB54TrarLk6MLF
         /zEGNZN6bG0OMjYM7UlhtaQVYKeNVX35rrJkAGgByfkTfgCLyE90sYdsBfHPe/btSzjc
         COStr7ktdD4laT8n92WCne+qOz8QfzeMQlIKRnvP6cVFFpS8OVKMlIBw+rvSrBqq/PBE
         xDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jluehKlxUGXq2+vghVWnC4Xvup58MfvgTPLtNeMpSHM=;
        b=rPDJhubKb3cVlXLaAcehRYwMgiGFwxEZITz8sRFwPqAxqG64Wu2HtapMCxV7vPcJSQ
         XFi6T3bhzno6jwvp8pIZv1VHZpTBxPQS2BOobVs6F7ocV4Hfzg4anCTCZSfe+UbGOZ3F
         YjAm+NHcYuSa5SN/Mjrdy2GzhL65Amz25rBaY3UND8Ot0ODxjQPdC7RflMq0+yTCZXnn
         NX893D8pmnTw2fEI7R4hFbeOkllU94iivnfXZFaxKauIBB1fnmQcDO7DUk7sCIPwty3n
         WRZnILwfJjHctmXBbyB2Shor0649He9WtzpJNdxbfdR2SLOryLlpKX/DTZJ4NEkbwK/2
         qs+w==
X-Gm-Message-State: AO0yUKVOQN4wkfD+5WlzCa1BkXotTJ6vEhfP9UUyCcX2IsL+TSx4ds26
        /Gy2dyq5ibCfGtC4oT7Z2IVS0C8oKRl7WfRJeAw=
X-Google-Smtp-Source: AK7set8waaM1o+akQkVVSrA1DxrqfGIFtDNW1h/vn+KCFdTIHRxk3w+JVp5x/VnTMvp3EUZWur4Uaw==
X-Received: by 2002:a17:903:1cc:b0:196:63d0:a674 with SMTP id e12-20020a17090301cc00b0019663d0a674mr871418plh.9.1675206119656;
        Tue, 31 Jan 2023 15:01:59 -0800 (PST)
Received: from coffindebian.corp.matician.com ([209.214.194.154])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902d90400b0017f756563bcsm10296025plz.47.2023.01.31.15.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 15:01:59 -0800 (PST)
From:   Alexander Coffin <alex.coffin@matician.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Alexander Coffin <alex.coffin@matician.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: fix use-after-delete
Date:   Tue, 31 Jan 2023 15:01:05 -0800
Message-Id: <20230131230105.139035-1-alex.coffin@matician.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

the use-after-delete occurs when the bluetooth connection closes while
messages are still being sent.

Signed-off-by: Alexander Coffin <alex.coffin@matician.com>
---
 net/bluetooth/l2cap_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a3e0dc6a6e73..6cf5ed9a1a7b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2350,6 +2350,10 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 					 struct msghdr *msg, int len,
 					 int count, struct sk_buff *skb)
 {
+	/* `conn` may be NULL, or dangling as this is called from some contexts
+	 * where `chan->ops->alloc_skb` was just called, and the connection
+	 * status was not checked afterward.
+	 */
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff **frag;
 	int sent = 0;
@@ -2365,6 +2369,13 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 	while (len) {
 		struct sk_buff *tmp;
 
+		/* Channel lock is released before requesting new skb and then
+		 * reacquired thus we need to recheck channel state.
+		 * chan->state == BT_CONNECTED implies that conn is still valid.
+		 */
+		if (chan->state != BT_CONNECTED)
+			return -ENOTCONN;
+
 		count = min_t(unsigned int, conn->mtu, len);
 
 		tmp = chan->ops->alloc_skb(chan, 0, count,
-- 
2.30.2

