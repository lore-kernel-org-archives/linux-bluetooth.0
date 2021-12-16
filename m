Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329C0C43217
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Dec 2021 12:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbhLPMuI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Dec 2021 07:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbhLPMuH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Dec 2021 07:50:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DA7C061401
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Dec 2021 04:50:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h5-20020a255f45000000b005ffd939127bso48889861ybm.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Dec 2021 04:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S1nY8qFye4VS7aI2Ex7vC+CRaOMsD5vumGdm2AeuvSo=;
        b=eaQA7mpwTk0w1lXjaNNBuByro3X9DWSPaEGaCBrG2HEoWuHYnCO5SmYbRZ8Kxy0fQE
         pkmO6NEQoTw1x9Z90TmxH9X6b+IlZf7qfOhS39tNwU5Rr2php84TMasxONNrr7GMQzss
         VqNfTMoX5e3ZusQuLQU5VQ54SUFbLp0wPrWQW4FOCKEN866ij5pIEz260r6XGcin+wGI
         eaQqy0bjo4uTKh1k4DvFa7FFtRUU0GU6y6qRzhu1wrSkCEU5GtCBYk6583AVq6IjC3Gl
         q6E6Vc2n6AFCnH7KQkMVEGD0K5f4+kXf0lmaJxtnZersQrT7BLqL2VjsOFaI9o4NL64n
         pDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S1nY8qFye4VS7aI2Ex7vC+CRaOMsD5vumGdm2AeuvSo=;
        b=pZQE9fzzELihgT/g/5cVF6WZhGyK3P7FE8uiS969K4U+TvzWW37b3H83Li2plUbv2v
         t/Yox0KaQ7NGbrzPV6hcX01NRN+dZgc3T4jNNUopJih2LuNcGVXeFLACvdgbQPfwVzW3
         aW98Z4hMA9Ywokl2nPp41TN8Sd1njk/eNh6zGJzfXNp8n743N+WUFp8dUlPJO5OOc4OA
         0VwrZRrau/IuAQc1wGfga4kwWXuRuCvPPm7I1WZ3D2Qur7Xdo7aRA4K3hRHJ4xpOm84O
         GkpQI1MqzjJ6YeUH+0vtl9zVWuyPQDZOX9ocVOYMa80/gsczYHHUXUaAe7W7i1olEVdr
         2PsA==
X-Gm-Message-State: AOAM530TAQc0IIeBQVvMXuA4RYlHeBgoJevRgIdORn/auSiKYzzEWbRZ
        A3Nfd8B/BLi5xoDKme+zzkvOztkMmRIGoQ==
X-Google-Smtp-Source: ABdhPJzXci8bvwLqg5dOpNylp6qY3iTOWvjUI2Myi0SZDl+iOaJlDImmnRQk1rWVBvDLJuGK5qJ5tyqiNUkQlw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:bfe1:d4f7:bb68:8aa6])
 (user=mmandlik job=sendgmr) by 2002:a05:6902:154c:: with SMTP id
 r12mr13928990ybu.374.1639659005967; Thu, 16 Dec 2021 04:50:05 -0800 (PST)
Date:   Thu, 16 Dec 2021 04:49:56 -0800
In-Reply-To: <20211216044839.v9.1.Ic0a40b84dee3825302890aaea690e73165c71820@changeid>
Message-Id: <20211216044839.v9.3.If37d23d1dd8b765d8a6c8eca71ac1c29df591565@changeid>
Mime-Version: 1.0
References: <20211216044839.v9.1.Ic0a40b84dee3825302890aaea690e73165c71820@changeid>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v9 3/3] bluetooth: mgmt: Fix sizeof in mgmt_device_found()
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

(no changes since v8)

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

