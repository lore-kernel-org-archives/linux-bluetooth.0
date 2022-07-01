Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5481C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Jul 2022 23:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiGAXhM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 19:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiGAXhL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 19:37:11 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3DC70AC1
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 16:37:09 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id 9so2316568ill.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Jul 2022 16:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A5LrmgTgvCmMiw2D30mRJ2rF8pm0EvvvJb9ByHe153M=;
        b=e27CZC9CqLANx76ih7YS6rAI0H5Ni2a3UMfByqinThXvTRt0lfwlFEPW9j/OxYE5tz
         VcpsLsqavgl5uezXIUYx4Evssogc5HiQ1O/AkWREW8rSHWODup9Zr7W/b356tnKLA1lS
         aMULU3hPkrsOGwepaz8ToAQVsJ9A8hceODrrBOmOWZ9Bte3+cY6bsiLRBC6ccHcuY6fd
         fIq4fSLHY8cmguRDw25p/khV2tu10yqOrG4RZ/38/avkbBGoBsSQ4PD2Nc8x3X+nCtGf
         8+PKxYpbGUwm5mFYWJPYwahSemaBnCxPPillRDGe612DTh2A4ErkmZpurqnbzCqQPEKm
         MlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5LrmgTgvCmMiw2D30mRJ2rF8pm0EvvvJb9ByHe153M=;
        b=krbCkFAfQeBjQK4b9OztKKYV+1MS1crvvFtGotDwUX6hC5QC7vAnQoKHZW+BnHmxcK
         fBpV2rCbqy0YtaVGWAfcDYpAvyXALTmkjPA68VuIFfdWqSzCRlkMGgJkpxE9pHPKJOqH
         OxOCSIkkIB3RIuFaSktIGKcvUhZz23VY4+bGrgsBCpEB4a2b7XSuMqmr9ko5UH1Tb3ot
         hNlSLjuQAhXgCDbthWcn1VdVDx0kvo92PhukAo0sYOI3KwCFxFzJNJt33+vS3XAf8Bs9
         0cqAhGVp3dLhPC/mlc+esrRw1uPdHxx5rLOcaczQKEKGnaqsSnotLpZxR9wOwnFUVwP4
         DETw==
X-Gm-Message-State: AJIora8Xng4chFSgsvhWSNqblB1W8NAzXbECvtyAHxNu5mWoAPcRfvYA
        3e6iEGAM/eWNOr0ZhOBxFx5bKZI+jnA=
X-Google-Smtp-Source: AGRyM1sKFPF/xyouxO6PPdEjWDIJZn0ue9b57fn0oU6EkbrKrkkjy2f+claGU5tSmZRGJ3UOsWlweg==
X-Received: by 2002:a05:6e02:144d:b0:2da:b8f7:402a with SMTP id p13-20020a056e02144d00b002dab8f7402amr9484078ilo.178.1656718627968;
        Fri, 01 Jul 2022 16:37:07 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p70-20020a022949000000b00339d2cd8da1sm10312154jap.152.2022.07.01.16.37.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 16:37:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 7/7] Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet
Date:   Fri,  1 Jul 2022 16:36:58 -0700
Message-Id: <20220701233658.966972-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220701233658.966972-1-luiz.dentz@gmail.com>
References: <20220701233658.966972-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix up the packet type if ISO packets are sent over the bulk endpoint.

Note: This is a stopgap since the Bluetooth specification currently
doesn't define any endpoint to transport ISO packets.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 28fbc5837f79..812a046f1b5e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -896,11 +896,21 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 		hci_skb_expect(skb) -= len;
 
 		if (skb->len == HCI_ACL_HDR_SIZE) {
+			__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
 			__le16 dlen = hci_acl_hdr(skb)->dlen;
+			__u8 type;
 
 			/* Complete ACL header */
 			hci_skb_expect(skb) = __le16_to_cpu(dlen);
 
+			/* Detect if ISO packet has been sent over bulk */
+			if (hci_conn_num(data->hdev, ISO_LINK)) {
+				type = hci_conn_lookup_type(data->hdev,
+							    hci_handle(handle));
+				if (type == ISO_LINK)
+					hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
+			}
+
 			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
 				kfree_skb(skb);
 				skb = NULL;
-- 
2.35.3

