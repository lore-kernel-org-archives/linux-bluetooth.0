Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34536C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 22:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347171AbiFQWRa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 18:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346786AbiFQWRW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 18:17:22 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75F35D1A2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:17:21 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso2399877pjn.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iQYywyf7iBnsNVgDmdxLZWmYH4PU0zg4vQRXr7w8BhQ=;
        b=h3ZGDfsiTOaQyAsK5heMJ2CSDSSAYhnSwRF74jT3+pwC1fRAT+dVkQVPlLGJL/49ZC
         Vg99ceA9iu9Rg+tJxjKl2nb/b1gg1WSluVI2cbU1LCYSuqI51b0wbpncRUj7z9NksgWQ
         BR17w0+RYYDeUAwn10R2ksdtGymoCSfttVzDniMaL+mbd9u86HLc5OLRnHlg9np5uwWP
         2iSuY3Kz26i5Xz8KP160QBLu11nyuU1JABV8ijhZ4kF/AoODmehw+xmQPw8+H3daDELq
         LDk/VcgwsFZHQIxSIC7HgrDbzy6TgSkj179qmOJ+fiA51oRkVu3MQ+p1xOcpcSNwk7GV
         8aiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQYywyf7iBnsNVgDmdxLZWmYH4PU0zg4vQRXr7w8BhQ=;
        b=Q+NngAO5Tdm1yZzzynyTm8zoh9Ep3WCNXBDKguo6LKvaap+VUGFSI88VXA4izym938
         GpVHL/8zsyN+zU8N+YFaAMTMiWHbGexYSq2H2HAhumuVgI8gyQzxOaS6y3X5L+YQysSY
         RcLYyxcL7Kmzx9G+/9jPZWO4xU0Afsnb/8tygTM7Mvn3LBo1KIo/Utq7lSFrX65U7BBO
         aid54dj/uL8vmzXlQIwt2M09YcVYdwQmkmVofVCDKvK69pvAt9PUw0SFZDZejF68aWWY
         DkjnT80CGFfxlCiLVaI1hlMKOFQSBJUwi1da2dDtA8ZACearqqtZN2RVHEGxuUc1pmTo
         oefQ==
X-Gm-Message-State: AJIora/orXplVpOp1OJrmZVpQk8oQ+qm5DeIOYrXgDAavXMjOzuYYqVY
        CI2Suo2b7OhEmNPGlz/k4/bCVzZwZHs=
X-Google-Smtp-Source: AGRyM1tnXGNRFiUZ5nmUsx5Vjz9GXru9UU/G1053Dt5DnaaZeEAox+Hl01nPQxZ+hgSt7xmzZnzqug==
X-Received: by 2002:a17:903:130d:b0:164:17f5:9de5 with SMTP id iy13-20020a170903130d00b0016417f59de5mr12296412plb.132.1655504240711;
        Fri, 17 Jun 2022 15:17:20 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id jc21-20020a17090325d500b0016184e7b013sm4117261plb.36.2022.06.17.15.17.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 15:17:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/7] Bluetooth: btusb: Add support for ISO packets
Date:   Fri, 17 Jun 2022 15:17:11 -0700
Message-Id: <20220617221712.1394014-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220617221712.1394014-1-luiz.dentz@gmail.com>
References: <20220617221712.1394014-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enabled btusb driver to properly transmit ISO packets.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fb1a67189412..28fbc5837f79 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1765,6 +1765,13 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 		hdev->stat.sco_tx++;
 		return submit_tx_urb(hdev, urb);
+
+	case HCI_ISODATA_PKT:
+		urb = alloc_bulk_urb(hdev, skb);
+		if (IS_ERR(urb))
+			return PTR_ERR(urb);
+
+		return submit_or_queue_tx_urb(hdev, urb);
 	}
 
 	return -EILSEQ;
@@ -2258,6 +2265,13 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 
 		hdev->stat.sco_tx++;
 		return submit_tx_urb(hdev, urb);
+
+	case HCI_ISODATA_PKT:
+		urb = alloc_bulk_urb(hdev, skb);
+		if (IS_ERR(urb))
+			return PTR_ERR(urb);
+
+		return submit_or_queue_tx_urb(hdev, urb);
 	}
 
 	return -EILSEQ;
-- 
2.35.3

