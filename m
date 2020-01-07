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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAB9C33CA1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242B5207FF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA1PR9Ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgAGHlE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:41:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34370 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbgAGHlE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 02:41:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id x17so22872446pln.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2020 23:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HGHqSmS/H24jXyYIiH8Dw8BZO8Ld4AD9qcBK9/ryLFo=;
        b=ZA1PR9EeI9jA14WdIbPz5idA7DNfXwtIT8wxm4hFaxY0yZVHR2jyrN2NVPqx5EG2A1
         dvJx4ZFP5BTw2gdSbiUEZr0iGuAUmM+IFLuF75oMm2QB1nVLJyE816vIhamQxvsadaN7
         FtPi+RWttSMpzK1QfM4sDOovYqbAoNNBnQCxIccDIfs3R2CZ5WSaKFtH1DpOmwS0Yo1p
         LVk3VNS4apEe9hAB5LTMrfnP3NLdFs6HmKSPuUIBiAqMoVRzxlyCFYAxZIFkas18TN5g
         62tQlTN8GBgHN+SJXazgutEoNEEAIUK3f6fLinSl8bsqLbhzHjSj0cM3C+l5QRiudOSO
         GKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HGHqSmS/H24jXyYIiH8Dw8BZO8Ld4AD9qcBK9/ryLFo=;
        b=C/qjim9sljw02Ilb1mRV8YNSgd4VSV3nT5NtXcB3rXtFpRKQkie51Jt1Nrd5GSv9yp
         QpvafOwO6oCRw0/wMI21j1kxuABLVYhh17PyDe5WYAklNcnravQe2ORbfX53LWjiNfWA
         F3VmWz53dQerc24a+3/kXGi0bys5he+IQgByDdvubNKIeASdZ19QGCClbrF65I1E98B2
         lI/3oIwHyXgXMww8gfnNYkRPku4kL2n8VdqmSqVm39jcFUvAMFCemJIdnfCm8OPGIL0y
         0Puo2LlKjZySWg3nkLQNctSPuGGcqmsUGHNjQkpOjCN/0eUtTWjqZfgNsyXcgr2tdqpO
         +fyQ==
X-Gm-Message-State: APjAAAUz7Mfdk1vwIiFRW+JsdzZuxTIbnT50a6y5Zv4FsTGAGbb/H0OD
        xooJa8QyinUoFr6e1sJWFY4jthKTIlg=
X-Google-Smtp-Source: APXvYqxV9VEQCHyTylU6cal7GjeigPYuU4hZUOK3LzPfZd0Ljiti5CuGxzU3j5oBZopnLIYP8V07KQ==
X-Received: by 2002:a17:90a:25c2:: with SMTP id k60mr45414874pje.127.1578382863404;
        Mon, 06 Jan 2020 23:41:03 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id k21sm67725388pfa.63.2020.01.06.23.41.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 23:41:02 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/10] Bluetooth: hci_vhci: Add support for ISO packets
Date:   Mon,  6 Jan 2020 23:40:51 -0800
Message-Id: <20200107074056.25453-6-luiz.dentz@gmail.com>
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

