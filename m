Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA060C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 20:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98FDC610CD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 20:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhESUnR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 16:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhESUnO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 16:43:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAD6C061760
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 13:41:54 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so4179894pjb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4fzT2hxE6fLJiHKxbkfQ4bpeEIKUGkgYL8iRvsYKk7A=;
        b=a8kt5K9xbip7xlIWkmYmah2VTSOSrCljKTYoVO3o7h849DSCEP54tGaV6apVwhXWuI
         Ic1zNqCx6M3hqlWEAsnhseD+1EqXfCXNIXXiupxQw3EofoDiedWju171xLZ6AF5qQ9fg
         WIu8hCBvo0NgAx/TTtyI0klmieh6U2UyonG7UNFY6nKgYOkO5hugVOYRMwCr9HlAbLPA
         MHbozB3Svv7ixkXkwkC2tQ7UFGuiBNWGFADtN5vVeF0vHKvx/smi9C6ksXdrpnpWx+Hc
         hm460TT9COe0OCeZi6Pp4CVWfxJYdzrPjH94SZ/61Gm/F7/O07m+PgUGconPZjEdtk/j
         qDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4fzT2hxE6fLJiHKxbkfQ4bpeEIKUGkgYL8iRvsYKk7A=;
        b=gKexOwv7PPOKDuspVCzg/Iwrzcq25Z+zm30iNTeE+YCLBO+bpUfUULQ+rH3msic0P2
         LyuFdBidbNGrV8AMZtjaKGGQmO0/bo2ON+GaaxQNRts8YVepyBIExCGnIBZ3YrGry019
         V6KalO+4SLfSpv343Vy5XIxCKNf6JApv7n4dv510KAtNU7yhCz7bI4nv5wDkFDB81DKL
         Nk8zM4QP6Axng0hSpVTxq/LN9MJizb27TrA9So4fQXS71MRAg5cu7rNhvcZcm0LU8+rI
         Mw09RI+NaVPiKXx92DeGvCSswtmTYkyBZajuPNzfrFhKEaHdips54Thgv/fSUvTHcysl
         2jNw==
X-Gm-Message-State: AOAM533nZ0/IpG53KEbozAospHYqEurSOg295ICs0hIHMDy/ZFmP8IFA
        JkqamkHWqivvJfhRfG3iD3DIA9XUlow=
X-Google-Smtp-Source: ABdhPJzP6ZWjYED6Nl2FEhySulil6v9WGmgjIlDuIG6pHmYQaR76S+6qd2Hb1EU674rJShHHH24GYg==
X-Received: by 2002:a17:902:720c:b029:ee:f427:91e9 with SMTP id ba12-20020a170902720cb02900eef42791e9mr1599209plb.72.1621456913602;
        Wed, 19 May 2021 13:41:53 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x184sm219726pgb.36.2021.05.19.13.41.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:41:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: L2CAP: Fix invalid access on ECRED Connection response
Date:   Wed, 19 May 2021 13:41:51 -0700
Message-Id: <20210519204151.1087613-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519204151.1087613-1-luiz.dentz@gmail.com>
References: <20210519204151.1087613-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The use of l2cap_chan_del is not safe under a loop using
list_for_each_entry.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f3b70fa348ab..9ebb85df4db4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6066,7 +6066,7 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 	struct l2cap_ecred_conn_rsp *rsp = (void *) data;
 	struct hci_conn *hcon = conn->hcon;
 	u16 mtu, mps, credits, result;
-	struct l2cap_chan *chan;
+	struct l2cap_chan *chan, *tmp;
 	int err = 0, sec_level;
 	int i = 0;
 
@@ -6085,7 +6085,7 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 
 	cmd_len -= sizeof(*rsp);
 
-	list_for_each_entry(chan, &conn->chan_l, list) {
+	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		u16 dcid;
 
 		if (chan->ident != cmd->ident ||
-- 
2.31.1

