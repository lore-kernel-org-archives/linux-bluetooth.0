Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C82C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Dec 2021 04:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhLPEkB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Dec 2021 23:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhLPEj5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Dec 2021 23:39:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B5C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Dec 2021 20:39:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l75-20020a25254e000000b005f763be2fecso47604162ybl.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Dec 2021 20:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5H0K2WTV+Z6r7XuBB5S5tPek7ul4X2Bnd52bQV+Ie5M=;
        b=qN534aUfveXpuF3fOwhP5Dc9XI/Hb+V3ushIhxHA/KUS+KJ4PpEW6cTdRcFaJBT6Ia
         5ZOqR9+t4khokO+pGK3QRDfmibZiY225LiI55ZCy6Mw+0pC6SvCGXo5QpRZpth4LTEP1
         0S8W/KNiU+/SlDd5j49r6CShDVqjACFROw8kPeeRkZzN9+oemsPQKsjIHtMPph3DU80S
         jZ12ucY7WiboErfPCJ1QJymjgjQyafT1tNBoqMWCtILv6DtdJrV5buZclScQcDpIy9/f
         du/OeErJp2oL4oeE/Nutaw3EBKJrqVmqAfICDS+FFqBU+brdNZE2lcEkSo+xmdrBgRNM
         7sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5H0K2WTV+Z6r7XuBB5S5tPek7ul4X2Bnd52bQV+Ie5M=;
        b=NoXgYgjH7bGlPv5Te6nbr0Sj7FuA+0z/a4qi7dHIq3XoGwLh+sin+XP3sQGU2gwu3h
         g/3dmhVsjyJbhQQAVrvhHo45VMws5oLec6LDbr9+5MQ+IkqbDw03dK/4T1Fuc73U4ORl
         7Wf5zTuTKb4cEKNIpZyZ8VEGib2tNTeDg2LJ2iAYQrzgNGZPkfUyzp0EzcP6bWnDXHz6
         y0wZx8qeD1rsn/nLjOoGi92gNe0ZVwKBFAHjME3WDmjVwnm39N+gTpR0aJfblkrh5rbO
         gSZI5hzBgBfwBMuR72RrRjJNCJUgujnTY4F7pJDBasxl1YkN7vnG7RHws0Z6t3ep68MB
         tt+w==
X-Gm-Message-State: AOAM530Sc+3kIi6+VJwTS9ZNeCBjKXK8y0H15pinJq5pUjUZcFJnRdMJ
        5Q35qqC2aXHs2/r0N9/D3cg9pG6fe4X3gw==
X-Google-Smtp-Source: ABdhPJy9FPnt7x7ywLCf1iQt44qoWyZlktAuvpKD0QP9sK/zYRjgn3+/yf8bL9lgZ/1HWCI12QIBpKbAseU87Q==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:bfe1:d4f7:bb68:8aa6])
 (user=mmandlik job=sendgmr) by 2002:a05:6902:102d:: with SMTP id
 x13mr11001115ybt.114.1639629596800; Wed, 15 Dec 2021 20:39:56 -0800 (PST)
Date:   Wed, 15 Dec 2021 20:39:47 -0800
In-Reply-To: <20211215203919.v8.1.Ic0a40b84dee3825302890aaea690e73165c71820@changeid>
Message-Id: <20211215203919.v8.3.If37d23d1dd8b765d8a6c8eca71ac1c29df591565@changeid>
Mime-Version: 1.0
References: <20211215203919.v8.1.Ic0a40b84dee3825302890aaea690e73165c71820@changeid>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v8 3/3] bluetooth: mgmt: Fix sizeof in mgmt_device_found()
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use correct sizeof() parameter while allocating skb.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

Changes in v8:
- New patch in the series.

 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c65247b5896c..5fd29bd399f1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9709,7 +9709,7 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	/* Allocate skb. The 5 extra bytes are for the potential CoD field */
 	skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND,
-			     sizeof(ev) + eir_len + scan_rsp_len + 5);
+			     sizeof(*ev) + eir_len + scan_rsp_len + 5);
 	if (!skb)
 		return;
 
-- 
2.34.1.173.g76aa8bc2d0-goog

