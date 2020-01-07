Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C1CC33C99
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2B0206DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvTJYhJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbgAGHlJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:41:09 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44263 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbgAGHlJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 02:41:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id x7so28089069pgl.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2020 23:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=583/WEUGQh38LNSV8BmtQVONpnFPOaiN7kX5OAt3Mkw=;
        b=MvTJYhJP40DUk0d323SgWO8VXGrRBySntaacbwU/HYlk6qiQC+juuDMeUcGEBnvK+8
         wzrW4k95Bgme8lTsYWkTm0k0wL35zXKhdlaMDq34zpdKqRLg/KJJFKrWszWsnKahMYSy
         lboiRdN5QVEBQAs6DH6eH36XTgdOUS5ojeHa7fDLRgEqA4aoLtLNnIlx2eHBDoG+4f82
         f/pMDiX53/RE+ciVKZ5Wg0dqio6A3ZCKx+jT0EjA9sIEFTbQxyHfYMxaU/X+hCwtxpxg
         PtEqAyfY0pqfm0jcreNpT44mTunFSzq0LML93SMtNRdqla3clMs+ynaUA4auQXiG27kM
         f9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=583/WEUGQh38LNSV8BmtQVONpnFPOaiN7kX5OAt3Mkw=;
        b=JT+P+L1dqs1/0+JEJRdy2jlurjhlLlA44Ijed7dZoxYOE8crzKkjWqRnnEFwaOXob2
         1EYWJ2SmeBZbNBTWKPDXDz0vVI33/yXnM2MFCVFp+vkRxrbTtN2SRRU7tjZdyw+anzNN
         koRI0z7csC07m1qx8XLNHxwkuHPxnaH95/1rsddi2Y1u2zsVRhepuNP9zbjGaZsI59sN
         b7BACDoeUf7qRZbzEj8DGP8Xsdi58LGmUBrOr32xqlDEAWSGUd2hVhuiuAkf4qtcQTpJ
         3QaNAId+W/mHxHBC56oCp4rYw758mEj87ilABMs5ZwePND12kOk9dNuymT5zlnqolmAF
         m8Qw==
X-Gm-Message-State: APjAAAUkXrV0WtpvW935W10A2gDUQV0lvmSxPsgZO60PRRvtS1K7CdQ7
        hkG/Z/cjlkuU9sST7SZYdmaT6Rr/NNo=
X-Google-Smtp-Source: APXvYqwvKMhYn63ju5da0Rg+rUmIVBUwN5kMmadcoArYkhpScD5KO/2pH1jR4Rkppq1MqF7KtKKMwA==
X-Received: by 2002:a63:4e06:: with SMTP id c6mr61809945pgb.187.1578382868501;
        Mon, 06 Jan 2020 23:41:08 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id k21sm67725388pfa.63.2020.01.06.23.41.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 23:41:07 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/10] Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet
Date:   Mon,  6 Jan 2020 23:40:56 -0800
Message-Id: <20200107074056.25453-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200107074056.25453-1-luiz.dentz@gmail.com>
References: <20200107074056.25453-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix up the packet type if ISO packets are sent over the bulk endpoint.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ded0ba83bcce..c1e030fc272f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -663,11 +663,18 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 		hci_skb_expect(skb) -= len;
 
 		if (skb->len == HCI_ACL_HDR_SIZE) {
+			__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
 			__le16 dlen = hci_acl_hdr(skb)->dlen;
+			__u8 type;
 
 			/* Complete ACL header */
 			hci_skb_expect(skb) = __le16_to_cpu(dlen);
 
+			type = hci_conn_lookup_type(data->hdev,
+						    hci_handle(handle));
+			if (type == ISO_LINK)
+				hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
+
 			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
 				kfree_skb(skb);
 				skb = NULL;
-- 
2.21.0

