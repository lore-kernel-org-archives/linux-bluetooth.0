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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDF2C47409
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FE3222C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CV0kxtSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgAOVCb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:02:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41079 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgAOVCb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 16:02:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id f14so39903plr.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 13:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HGHqSmS/H24jXyYIiH8Dw8BZO8Ld4AD9qcBK9/ryLFo=;
        b=CV0kxtSGy3Eb8Wz4UjNhb5U+i6t2BisjkITHlE8uMVco4ANVbh2iBuNBuuegwk5vl7
         /SAeakSbBW1lkrGuA7bLOdWI4XcbWm19CquT2RinW8TjS0fSgY5txagdT1QS5yU6f1Hh
         vuNXEQd/Die7jIDerUS//lm43OwdfGwbEUQGELF9O342t3P5AN8LQP70dBbA3YjDPUTs
         VFdS6UuyRhTe+VE9u+Zk7YXw2SHe9OQQyUfps5e1lcsWqXNfioO2TcKycvQJ5cBAE+by
         oJW5rlC0zgjAKfTuIE6ujuugmue069aAtyFLVd//MBW5ColI9SlJXyIw1VmIqDoWND7J
         zOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HGHqSmS/H24jXyYIiH8Dw8BZO8Ld4AD9qcBK9/ryLFo=;
        b=iXaTCMXix9iuFv/p9gkBXTUWdaHXITWYlNfb/BbZSJ4a5SVKnY2Msqrucd0Jv4e9LS
         7YhqcSjaIpAqAB1GP8/9jd+8zNkq/8KU5ZVWBJizSLZQtfSMToifH5rLtown38Zpp6qa
         Uedgu+Gb8x5+GfjxlytktazxJsa9P63X1LuUH0boyRLqWPgELVMlnk8bjp/xUspiq43v
         IzdfohFR5PlOj+XKx3qfd6Djop5UKqtOCPhBZafHaibNTTzC2PPcq92G1OAsgW9EJBel
         NhJovhDuRdyzT2IBQ+NHXcBh2Ktcz35PNxCbVDq9pbwzSneiWPn95xxbb0UjcdydaN+j
         Y1kw==
X-Gm-Message-State: APjAAAV3TA1qQWb8jxC4Ax/qh+F3Bn8NjmtE6o+myphaLIrADA9wdWt0
        3vd++16w8NhHOTR85Uad8XoG0sxkM3A=
X-Google-Smtp-Source: APXvYqx3dQFjcEGXjHUjI6Aqh+P5nNm4NaB9HcxKKpL9mcwAmqp0kJchEIWhFJz8G4xFLSg0qygHGw==
X-Received: by 2002:a17:90b:11d7:: with SMTP id gv23mr2240411pjb.94.1579122150103;
        Wed, 15 Jan 2020 13:02:30 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.41])
        by smtp.gmail.com with ESMTPSA id s24sm23290976pfd.161.2020.01.15.13.02.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 13:02:29 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 06/11] Bluetooth: hci_vhci: Add support for ISO packets
Date:   Wed, 15 Jan 2020 13:02:16 -0800
Message-Id: <20200115210221.13096-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115210221.13096-1-luiz.dentz@gmail.com>
References: <20200115210221.13096-1-luiz.dentz@gmail.com>
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

