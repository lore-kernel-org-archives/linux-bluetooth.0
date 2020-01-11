Return-Path: <SRS0=d6qz=3A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D426FC33CA3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 02:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF442072E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 02:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvtWtnpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgAKCW3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jan 2020 21:22:29 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35592 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgAKCW2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jan 2020 21:22:28 -0500
Received: by mail-pj1-f68.google.com with SMTP id s7so1781092pjc.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2020 18:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YFd0JhZ0fswhsnoF6yQcdQAaq0by6LcXYedQoF+YTDc=;
        b=lvtWtnpUIrNq0Yk68iLqGyMXTXYovbxw7Hr/x9UeQGRgkk+vTg0BWYd7WeWl0M+ZD/
         xDW/yHpdQJEFhqYqJg6HZdalbq/4QTDgmDF3ltuGZT6wLAcu+zhkljESQjfVGWcsaV4i
         smde5WMwURBpgH+XT6KIoPHoM0n4DHmnJcqCpvggh+cRzFLJoD9f646JtL9HI0ye6IuO
         7f7pg5voYacjw4BNVCZ+bCw1Y2Q8uIhJhAKz5o00wtA5qbIwXTz8wByzI659RpXgT8E0
         IYtrkNNR1WaX15mAKTWKb6/PkY0woUuC6T+EEraSyIfkebFONX4J+O6fwWqTeexmRXkN
         9bOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFd0JhZ0fswhsnoF6yQcdQAaq0by6LcXYedQoF+YTDc=;
        b=fDE7Q8vLsB+743RptAVoDrh3sMp58ixo03VYbKZA1q/PbjEfD3THkrZCSMvRvKgzlg
         EfRfaFkrrHcSpLHNCGj2Dy749oUSrcyVi1cNk4V7nrlhRhgb4ulrJJDKYG6u9Sg5e/oq
         W1D/AfvB+C4ZPawahA4ixw6Pt8Jjluo9XpLgJp8A3Q8qB5S95yKNgp6lBjCjSRc0lCcg
         Dd0hudCOekjtYR7i/72rTFWWD+VIF4JgydVH2I/1rz1vKLvDGJqFivNwA2YaAqyDefBb
         /jGWja46yUPk1Zrk+ukX4xi88cru8H9+7O/3RpXTicCdEPA7sapvQO8wTAqf5HE+mIvt
         qYDg==
X-Gm-Message-State: APjAAAVf7IcmOJlH1IMGLSAUQ90kliXmCOU10tx153iIkzieXIOtwjBq
        3l++s1xi3d4uRdlSDrwwV71ZFu115Fg=
X-Google-Smtp-Source: APXvYqz+bHAB6rAE7OGdl7Bpie4NSNgWgJOTrWF176Llc5Yd3iA9q1Z2CBfHYZ6O5riGvtnWUoRllQ==
X-Received: by 2002:a17:902:b709:: with SMTP id d9mr2019599pls.235.1578709347477;
        Fri, 10 Jan 2020 18:22:27 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id g22sm4158906pgk.85.2020.01.10.18.22.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 18:22:26 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/10] Bluetooth: hci_h4: Add support for ISO packets
Date:   Fri, 10 Jan 2020 18:22:14 -0800
Message-Id: <20200111022216.30842-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200111022216.30842-1-luiz.dentz@gmail.com>
References: <20200111022216.30842-1-luiz.dentz@gmail.com>
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

