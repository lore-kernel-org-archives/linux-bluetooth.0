Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D9EC33CB1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684C72467A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQozDKe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgAOGfi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:35:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32958 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbgAOGfh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:35:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id z16so8036119pfk.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YFd0JhZ0fswhsnoF6yQcdQAaq0by6LcXYedQoF+YTDc=;
        b=uQozDKe0TMKljkgjQEH9WsJEwogGjqwkgWCT7oKRYdEZ02ntpi9FA3Eo17gyQFLFqx
         BuRk+uOJB5AUQnQG1KmSUf9cVH5R0abCV1Dpb5/lME8KVRvyd3FNn+AxGNvrv4mrui/E
         Ay/QaiCBg0NjCv2eXLfdjO95LWmc8Z+iMbq4p7lhtWs9CL+9114bxQEU2SM4ErR+LJni
         h1NO34Ae4TmdAwyze18xzxYsuEDa48wIijI3wDvy5sWM3ikaIzb0KpXZZllkBuE6nlLj
         ASOmJvW7ml/9K5jg+TlwOpStuuNwXfxs2iP2mXYyDnfDTtynCjqHQDQnDG29UIeMUGoC
         xdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFd0JhZ0fswhsnoF6yQcdQAaq0by6LcXYedQoF+YTDc=;
        b=UDU/UmGYh7mKysCQjYMXHrd6FhAXul/5xCmtbtQFi9Zn6nKUXLQUsQIWqHht9gEccp
         mppG9dTZjlKIjopclAAjWMZrHueKCsnds6VRqqUbYcr6jBnHfL/wcJ5Z++wPv1sypVRI
         j3uJtPoAcoAUAyZI/XmnGBp6EegYysB1UFU4hp9aKHXTZJn7dx5p0TKRYGP5WJ0+iCQL
         ucQrG/CmudZ1OtjxYjQRU3+f00EtjySDen3O7AeojnUX3w4CKwK/cG3065gMgKbHBFYo
         qQ1jFzJ80eGTGzq3FwKrrJKadE8zc2A5eF90TGaOuEvwv2zYomYq1hOUi3WikqKhEH0G
         598A==
X-Gm-Message-State: APjAAAW/CoJUFRrsqTHZN3mMBG4e5697pCZaQ7onPV9eqSjLIjIXEPbo
        fevstkZnyrRlhAPL82A/J34bGZ9ZOvs=
X-Google-Smtp-Source: APXvYqyzzd5ObRFMQ7pjiM25GIMQP5aoLuHkCqE1UrvFJWWDfGyBTu3MtY4Yz2l7ewmUASW26RHoXA==
X-Received: by 2002:a63:1502:: with SMTP id v2mr31179264pgl.376.1579070136693;
        Tue, 14 Jan 2020 22:35:36 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id q21sm19637469pff.105.2020.01.14.22.35.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:35:35 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 8/8] Bluetooth: hci_h4: Add support for ISO packets
Date:   Tue, 14 Jan 2020 22:35:19 -0800
Message-Id: <20200115063523.32127-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115063523.32127-1-luiz.dentz@gmail.com>
References: <20200115063523.32127-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enabled H4 driver to properly handle ISO packets.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_h4.c   | 1 +
 drivers/bluetooth/hci_uart.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 19ba52005009..6dc1fbeb564b 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -103,6 +103,7 @@ static const struct h4_recv_pkt h4_recv_pkts[] = {
 	{ H4_RECV_ACL,   .recv = hci_recv_frame },
 	{ H4_RECV_SCO,   .recv = hci_recv_frame },
 	{ H4_RECV_EVENT, .recv = hci_recv_frame },
+	{ H4_RECV_ISO,   .recv = hci_recv_frame },
 };
 
 /* Recv data */
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 6ab631101019..4e039d7a16f8 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -143,6 +143,13 @@ struct h4_recv_pkt {
 	.lsize = 1, \
 	.maxlen = HCI_MAX_EVENT_SIZE
 
+#define H4_RECV_ISO \
+	.type = HCI_ISODATA_PKT, \
+	.hlen = HCI_ISO_HDR_SIZE, \
+	.loff = 2, \
+	.lsize = 2, \
+	.maxlen = HCI_MAX_FRAME_SIZE \
+
 struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 			    const unsigned char *buffer, int count,
 			    const struct h4_recv_pkt *pkts, int pkts_count);
-- 
2.21.0

