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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DA0C47409
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 01:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DBB222C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 01:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYgjS2Hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgAOB71 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:59:27 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40519 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgAOB70 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 20:59:26 -0500
Received: by mail-pj1-f67.google.com with SMTP id bg7so6833114pjb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 17:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HGHqSmS/H24jXyYIiH8Dw8BZO8Ld4AD9qcBK9/ryLFo=;
        b=IYgjS2Hi0AyxBy2gchk1q/wAvdaxzA2tyHQBE35nRyiqP7GeUv5obCRcdZFfLQ4BCp
         6rwdteQOWLWUlWL3e9Gp3LKrmaNdylN1xPTexvO14L9g+bHZIHY3c29JQgBk0LCn9A6C
         wa846AwuYqfEkUx6des48FLkVKD6HDt/trffZW4vqLahsy91E3U0vs1DsCnqOoIXuQOl
         h+Esg7aInTusCH3t3FkewjAnavjnNjW/auaJnern0WjWIN5eZv/YZgYvCoPv6HrxNcJC
         AvXWbsMshZPv7WbXdtbLv5rnwSaI0KLUTEmnMrm2RQh3yjSh73mpyaCca0UVsjsj4/PJ
         sJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HGHqSmS/H24jXyYIiH8Dw8BZO8Ld4AD9qcBK9/ryLFo=;
        b=BaezFOo2XQWaFW2U+7YtHRa4fQrpxQrws/PgRzJ18H9v93nv+yY2erpbRlhpCZ7V2Y
         5HKxPoJ6Nnc+3ANBfHL/rPadfLi9BEDCwjlqnIlDsGsAVMr1T1GxljZ1OSqq57HZ7ehG
         23+73V93ZVPfYZL4Neyr/YIvQxWBhdPgB6JqNSx4zQ8RnaS8Sxsml7aR6A3k5/LKmDqF
         6W9u+uuXc/gAaxws/Det7XJCG0fYQ/8K6n7AJrkqAElAGKGqC5fJByJ4EIwmISgRo4Y3
         cR3W21oLJyxMFYM6ouAKIqgqIjzAkvkuIPNGVK20UBRsmjqD5/9fZQUvuRfI9BMBty7G
         5lLQ==
X-Gm-Message-State: APjAAAWdT4WDWiOU8zkzLZCezgccSfTgkErNQRNEh8XPFeTQ1dIdNx7+
        mbtaLF5DcwNU4tOrBF4eZF3iWNhRV/E=
X-Google-Smtp-Source: APXvYqzYeooH36V0kjNM5ypz1KqvF0gX+to/mwZvY9LTj75KaQhMUi1wgsvoDnLLn9wnErulvf4iBQ==
X-Received: by 2002:a17:902:7883:: with SMTP id q3mr14839854pll.113.1579053565556;
        Tue, 14 Jan 2020 17:59:25 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id q10sm20263573pfn.5.2020.01.14.17.59.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 17:59:24 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/8] Bluetooth: hci_vhci: Add support for ISO packets
Date:   Tue, 14 Jan 2020 17:59:15 -0800
Message-Id: <20200115015918.1187-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115015918.1187-1-luiz.dentz@gmail.com>
References: <20200115015918.1187-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make virtual controllers to pass ISO packets around.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 65e41c1d760f..8ab26dec5f6e 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -178,6 +178,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 	case HCI_EVENT_PKT:
 	case HCI_ACLDATA_PKT:
 	case HCI_SCODATA_PKT:
+	case HCI_ISODATA_PKT:
 		if (!data->hdev) {
 			kfree_skb(skb);
 			return -ENODEV;
-- 
2.21.0

