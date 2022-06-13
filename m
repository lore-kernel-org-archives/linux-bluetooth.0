Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF9ECCA47B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 21:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiFMVno (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352286AbiFMVnf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 17:43:35 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F040E63A3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 14:43:33 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id z186-20020a6233c3000000b00510a6bc2864so2848642pfz.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 14:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+dbqcGyic4c3zYFWxW8WIDheVsDHS+XGvESBEzG7d5k=;
        b=RfOQUrYJ7JQYov7qHkHG0D3CZvnSFd0EoNZxA2h9so3t5ghC6pS+NNf1FUtITajexh
         7gUCIGccN3LwOTdXDbBwTD7+XrbjD2eCTvMc+5aogoJg1NLhjoh/3JkVtiEXluDPD8/L
         62qDQT3rOniALV5GkhgmyKlJ0ekgyrY+4qVRR8hFt1yxoFe8SFc7VrHnqhP4/alrQ73A
         c9U55RUCY452wxUYwC2/CIcZF5HS7c00CsCKbWjA9q8EMErbMw8OpDaDmyFENmglX0pi
         VcnxlZOluUestMBBMo1Fj+JfcG64pqGogk3OFtPZrn7i+1602wbbcfm481/yPdWJKvJk
         6tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+dbqcGyic4c3zYFWxW8WIDheVsDHS+XGvESBEzG7d5k=;
        b=y8FqJrESu6NKoIuCrvEgMeH1E2anNn4DtONCWkekGsvtgrsTvI5+X3OVaoqEH4IJ6X
         VWOvTAy4KsM26xJxCsYQGOnxSYGgEzB3FMz43GrY6QjZ1sxCAQtcnjQo89OxsJgtB+BQ
         BiB8DYF1TLDzBU/S3/G/scVz/UBPAgoJ5jP9You8pTQN3p9Hx+MwFRHnfzmTcyEtyny8
         cP5GL0e3ZmAmGiN8KiiybyGfvas1D90HkjGsMcP3K4fRSqLDq1B6SD7Ciuwb/rru90s1
         Pjq6XszDGDFXKGAZhaxdW4kIrBZLnuhovfd+CEzwJS6gj9jkLpUkFjcQVyJrLikszPKo
         xYtw==
X-Gm-Message-State: AOAM531ZbFOD9iCSY2S+YDqmAa4KWL/hqJwjFjZCOQahsYYljfEz0qZ/
        SX81ubLylrRCNJIJFj/NQkE+ugMgdpx38p8UdOdxbgtVC8RjqEHQrc0+8kFHT1GSDeJl1CQI/mD
        lcZVfhavi65NoJpZTgK/QEoHM6a50Ul+arhz65EwNpBntR3Nfaq54rNuwk8ohBuddVgHcqPTEeF
        5O
X-Google-Smtp-Source: ABdhPJw9jT9qWcmLHduAjFOWxEbRFk+OM7kyD/MBa5/84G/LeQ3nXO0nTD06s+nhmadhnxgd80/26tvZV5NP
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a05:6a00:b51:b0:51c:1219:569d with SMTP id
 p17-20020a056a000b5100b0051c1219569dmr1278341pfo.2.1655156613295; Mon, 13 Jun
 2022 14:43:33 -0700 (PDT)
Date:   Mon, 13 Jun 2022 14:43:27 -0700
In-Reply-To: <20220613214327.15866-1-jiangzp@google.com>
Message-Id: <20220613144322.kernel.v1.1.Ia621daca5b03278ee09314c59659b64c901408cf@changeid>
Mime-Version: 1.0
References: <20220613214327.15866-1-jiangzp@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [kernel PATCH v1 1/1] Bluetooth: mgmt: Fix refresh cached connection info
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        Brian Gix <brian.gix@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set the connection data before calling get_conn_info_sync, so it can be
verified the connection is still connected, before refreshing cached
values.

Fixes: 47db6b42991e6 ("Bluetooth: hci_sync: Convert MGMT_OP_GET_CONN_INFO")
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Set connection data before calling hci_cmd_sync_queue

 net/bluetooth/mgmt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 74937a8346488..cfbea6fa04335 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6828,11 +6828,14 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		cmd = mgmt_pending_new(sk, MGMT_OP_GET_CONN_INFO, hdev, data,
 				       len);
-		if (!cmd)
+		if (!cmd) {
 			err = -ENOMEM;
-		else
+		} else {
+			hci_conn_hold(conn);
+			cmd->user_data = hci_conn_get(conn);
 			err = hci_cmd_sync_queue(hdev, get_conn_info_sync,
 						 cmd, get_conn_info_complete);
+		}
 
 		if (err < 0) {
 			mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
@@ -6844,9 +6847,6 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 			goto unlock;
 		}
 
-		hci_conn_hold(conn);
-		cmd->user_data = hci_conn_get(conn);
-
 		conn->conn_info_timestamp = jiffies;
 	} else {
 		/* Cache is valid, just reply with values cached in hci_conn */
-- 
2.36.1.476.g0c4daa206d-goog

