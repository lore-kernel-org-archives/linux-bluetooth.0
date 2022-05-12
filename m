Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE466C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 22:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353938AbiELWau (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 18:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345057AbiELWat (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 18:30:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA54140F9
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 15:30:46 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d25so6049343pfo.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0tS5GuZAPhDArSYGea5NYia/bze9O9vmhRUhWdUMB3E=;
        b=IJ/TQYi+EeZ+y5UJR34QksJvqPBkj6wJeY1Dn87rED9bnzcoZu+maNhpuGj8bh5Ksr
         ycprRLglpAHYnwuEX9C3T6IhLyieYCuFJqe7TEvLC63SNWNNuCnP3MCeLWAAgQWwdQSf
         PjYuh8EeHxf0gHMmEavTyy+ERoFMiPFvUZB2/3i5+NMenS+r4yBRPBQBTpQGpruf2q3j
         J6pGG0iZYwbJsPyyvRrKecww3brUtIFsPhU29XYaBMpyay3wxgIgkKTpOrKJ2O5pMhxk
         yxe06gfN1g14MhjxwinvDaIihp2dX3YgqzYyNaJ4cY4YOGqCkL7H8V+cEXu4XpA0y7j5
         kJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0tS5GuZAPhDArSYGea5NYia/bze9O9vmhRUhWdUMB3E=;
        b=f3M86iUkuJmrxLL6ikqHkbS1ZscAIU5vzjOXFBZNniOC4mncpI12OnRW4pScTD6ftJ
         4w0EWnYaJi3ViSIyvrd84993bXm413bYXJ+6lxObVQsv2YyZ8TPx+ev2w3qFRFOMMupT
         /NyRcT3S94U8iBSHAI63d3XJDU4zJ8veehiD22MOg14szelTLlyU6qggxx3oBaYuJT98
         UtWyZ0kSH79v6nuo72k0VygdWCWBqB3oN2nH2hhVudwKDlarea4lt4sqo9IF7tSW3act
         j5fK7MaCAU36EJOOfBB99SHewgFMxfK4mfdiQVrDCIwWyF5bvp8ioc2AAw1dIpsfVQfV
         /+Bg==
X-Gm-Message-State: AOAM531Y5Ugv5++PdXjRC3JII85+XdY25tSxtyjdqs7w6gRz8xlZBmvv
        tuR4fxmU0FGivnKV7ELjnQ/JfvTAQSc=
X-Google-Smtp-Source: ABdhPJxoLouSH2Oai3CGL2+85l2KWtZg/ozBOstX9osRZAWWc2wdyCELQBOHFd0XqCY6ym3c0LR9oQ==
X-Received: by 2002:a65:6946:0:b0:39d:a0c3:71f with SMTP id w6-20020a656946000000b0039da0c3071fmr1399731pgq.160.1652394645998;
        Thu, 12 May 2022 15:30:45 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902e54b00b0015e8d4eb21asm409848plf.100.2022.05.12.15.30.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 15:30:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: MGMT: Add conditions for setting HCI_CONN_FLAG_REMOTE_WAKEUP
Date:   Thu, 12 May 2022 15:30:42 -0700
Message-Id: <20220512223043.1020767-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

HCI_CONN_FLAG_REMOTE_WAKEUP can only be set if device can be programmed
in the allowlist which in case of device using RPA requires LL Privacy
support to be enabled.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215768
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d2d390534e54..74937a834648 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4529,6 +4529,23 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 						le_addr_type(cp->addr.type));
 		if (params) {
+			DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
+
+			bitmap_from_u64(flags, current_flags);
+
+			/* Devices using RPAs can only be programmed in the
+			 * acceptlist LL Privacy has been enable otherwise they
+			 * cannot mark HCI_CONN_FLAG_REMOTE_WAKEUP.
+			 */
+			if (test_bit(HCI_CONN_FLAG_REMOTE_WAKEUP, flags) &&
+			    !use_ll_privacy(hdev) &&
+			    hci_find_irk_by_addr(hdev, &params->addr,
+						 params->addr_type)) {
+				bt_dev_warn(hdev,
+					    "Cannot set wakeable for RPA");
+				goto unlock;
+			}
+
 			bitmap_from_u64(params->flags, current_flags);
 			status = MGMT_STATUS_SUCCESS;
 
@@ -4545,6 +4562,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		}
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 
 done:
-- 
2.35.1

