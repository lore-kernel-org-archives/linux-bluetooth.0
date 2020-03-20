Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D413AC4332B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FED120724
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3VTDZJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgCTUka (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:40:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44831 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCTUka (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 16:40:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id b72so3877478pfb.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 13:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VVQ7vhvCR/dzXjhnVWZBKnsMGVGyca6I+XsQHNIPA+E=;
        b=m3VTDZJ6PK19hrjGMIBs7ROldDRFJlouDJppD1SF38tEmFyEa4cTpFsMyPLqleu3qa
         8ultG6Mfb4yyAOdODPWtzgqA1cPEOitMvNqgPPYq84SEzMB3DJP8uBL1qmNXW63E8d1n
         P0Md09fUAOmI4f+c9EWLXCGyG+iJXXi0PAi/b1V6MQ2UO/kAyenjNVlHCzL2eqhCR0YM
         8tYduzyZt3pFvTsLb8TmvI5Rcwk1f4qMVakifgwIWHSYfNuCJYYFMoeyj9efxQdO2upf
         uLfT+N3d2IRYYjQ878y9GeO7BWWOECnYYAThG4DLRSrTq/ru1S+AZHYAau6wONHhhZo/
         qKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VVQ7vhvCR/dzXjhnVWZBKnsMGVGyca6I+XsQHNIPA+E=;
        b=ix30S2msBJJNXQ1JzLJ7PZg9Y6uNNcttixH+Rjlm4om+dFBxRoUXVvOjJ70tIUoDrc
         b0B/XrldHLu4r+nhjv3HtuYdOkXgNq2B382Issklzjy7DW+VsvUy541/0lYYiphFRN8f
         LuDYF8QF9RDUwKsVn8gWR9zQmUFq/TR321WfkyJD36DHlEkiyiXPdyed+uNmy/+nRxey
         rKE60kl3phY8zTKc+e4lqbTmy4TYbWTLOhh5DYHWvf5QwlVVRCypw6hivZCSN0RS6yY6
         pm+gxjWT0bwKmksIbpwaAyZq+VWMJ1lrW4wcK3FcRf7qnUhR9IB3vYjM1cdq+8bS9b29
         h3eQ==
X-Gm-Message-State: ANhLgQ20MlrWwXiVO3fq3TyawLVO0zvSJO4MsAX7Tm+pauFka4c97sfi
        z30ZGY4ndp18W2wiwNJhVjd1H8Sh
X-Google-Smtp-Source: ADFU+vv5gvTBAix8T5aybqJqrxgZStr9JtX7Pi6saf6CrQqBiwY/ubamOkQ9ytDxvD0aQfmk2dTkFw==
X-Received: by 2002:a63:fd0f:: with SMTP id d15mr10208547pgh.26.1584736828454;
        Fri, 20 Mar 2020 13:40:28 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e187sm6048744pfe.143.2020.03.20.13.40.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:40:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/3] Bluetooth: L2CAP: Add get_peer_pid callback
Date:   Fri, 20 Mar 2020 13:40:24 -0700
Message-Id: <20200320204026.11680-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320204026.11680-1-luiz.dentz@gmail.com>
References: <20200320204026.11680-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a callback to read the socket pid.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h | 1 +
 net/bluetooth/l2cap_sock.c    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 537aaead259f..2d7d28474d34 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -660,6 +660,7 @@ struct l2cap_ops {
 	void			(*suspend) (struct l2cap_chan *chan);
 	void			(*set_shutdown) (struct l2cap_chan *chan);
 	long			(*get_sndtimeo) (struct l2cap_chan *chan);
+	struct pid		*(*get_peer_pid) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long hdr_len,
 					       unsigned long len, int nb);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 40fb10b591bd..117ba20ea194 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1504,6 +1504,13 @@ static long l2cap_sock_get_sndtimeo_cb(struct l2cap_chan *chan)
 	return sk->sk_sndtimeo;
 }
 
+static struct pid *l2cap_sock_get_peer_pid_cb(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+
+	return sk->sk_peer_pid;
+}
+
 static void l2cap_sock_suspend_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
@@ -1525,6 +1532,7 @@ static const struct l2cap_ops l2cap_chan_ops = {
 	.suspend		= l2cap_sock_suspend_cb,
 	.set_shutdown		= l2cap_sock_set_shutdown_cb,
 	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
+	.get_peer_pid		= l2cap_sock_get_peer_pid_cb,
 	.alloc_skb		= l2cap_sock_alloc_skb_cb,
 };
 
-- 
2.21.1

