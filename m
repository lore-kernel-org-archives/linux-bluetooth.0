Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8B0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 23:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378983AbiEEXJq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 19:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386589AbiEEXJn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 19:09:43 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8700E5EDC5
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 16:06:02 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id b5so3823830ile.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 May 2022 16:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JBpgrjNMgWpTskmRnE/wkrvDdfqnLyxeNkic0pV8L7U=;
        b=LWaSVVe7VuDdxBPER9BT4enBNwV5nzI3xLWVRvi0MBAQXwoQgCE/uAYo+DMuvLkN2c
         F7b7Blr4mx7lisfrdrfmEHimIm9R04jIvnaN7jF1yldl/SJxOBllBZjRqNo8wvJ0Nmn1
         EftRowGsFNgTU2M5Xf9rf1ErRijWRt3NUqqAS8NaVotVqsLvR6Q9jNKehW0hp4SoFyFg
         DCDjm1YiWuOTFzguL8ChdQbf+xH79k6caiB7YPHgoUaWGWI/xVT6BtAMLm9Qf0VjUD5U
         zvqtV2nILoOIqU7zkym0VPTwJd4kGWcViDVEV4YIaM+NTn8/U2JtsLJ8etbAE4ymprzV
         EZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBpgrjNMgWpTskmRnE/wkrvDdfqnLyxeNkic0pV8L7U=;
        b=wbGuFuDRqCIYdnlzdL0sfZoVIU0mDD5LeuovF2cPAN043cfyJv34q2HdWhm84XQJhe
         eGDfRaRrtBDBXlQMJaWoqXgUm6NkMojcmS1J4MiuYpuuC7B1kP0HCl2goqtcvItytcMP
         cNDC5JCpeoqxs/09zyo0O4nbfjFN5y4UsjZh1tiO0JvedUTIdtj2y7yGad6pJqbEtIgf
         qnE/u+oRrNgaxmr/1Gl0VNuXOsH3FJG6Tbho7LY85OPok5UfKKe+pJB7LUSSKnnyG4dl
         KS8G4ZdKjJibZbgNZZODjKLzXEw1hwIt1VvTqyKEmS5WEyQShbamu4VlcID1l9MmlfiE
         LsUw==
X-Gm-Message-State: AOAM530GDzPUae2h1NbZGbKAJ5+MP5HuWM7glKd9TL+r1uIMlGJAUHVi
        UhZDudoC3MCg6vuDkKTZdgOaY+cqpro=
X-Google-Smtp-Source: ABdhPJx+TdASmKkq8q14NXr6M2r3jN3vR4JnLNeJMwrgjvuMRhKriVp5HhVl8tXXk1yKdSFJsnGj7g==
X-Received: by 2002:a05:6e02:1348:b0:2ca:b398:1144 with SMTP id k8-20020a056e02134800b002cab3981144mr183486ilr.163.1651791961766;
        Thu, 05 May 2022 16:06:01 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l10-20020a92d8ca000000b002cde6e352bfsm780757ilo.9.2022.05.05.16.06.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 16:06:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] Bluetooth: btusb: Add support for ISO packets
Date:   Thu,  5 May 2022 16:05:49 -0700
Message-Id: <20220505230550.3450617-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505230550.3450617-1-luiz.dentz@gmail.com>
References: <20220505230550.3450617-1-luiz.dentz@gmail.com>
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
index e25fcd49db70..a1ee0b20bdf6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1762,6 +1762,13 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -2255,6 +2262,13 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 
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
2.35.1

