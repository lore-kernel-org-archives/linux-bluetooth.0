Return-Path: <SRS0=Qmzf=DH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43224C4727E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Sep 2020 14:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF96F20754
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Sep 2020 14:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGn/rFmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgI3OS1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Sep 2020 10:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3OS0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Sep 2020 10:18:26 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC469C061755;
        Wed, 30 Sep 2020 07:18:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t13so1114044plb.10;
        Wed, 30 Sep 2020 07:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TwJdx0lIfhHir6Nqx17GvuwpEA6xq9365oCpCop+vGs=;
        b=VGn/rFmLYPyMEMwlJDY0UTwwEY0T48qfEF3k+SblEi1HXQFUc4gB314tq8+0SCK+ty
         +0qmpjsXwfWbRflf2ym2DBnbqiIaJnJdj1fqwwQ8Obl9Hn+PpXhvl2ccyZDFSN0KxVrl
         0wYcNfXqPQS7NB7QPRT7LnEGHXxRUOVS/l7BLECFMP4PIF7uhstzuYY1IpaGE0iczKhx
         Y0H5RhMs04NrIMJaG1HYIGK7JiUk4AAIBUvvjN7j4xaRBSX5T78mFLKCT7Ss4GPwJy6a
         /OYW5BFqpPECa8BfLJEFm/m+yMknHQcZZP72LylqFoHHhQ4o6Sm2v1v/0SWMUiAbTLVP
         0zeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TwJdx0lIfhHir6Nqx17GvuwpEA6xq9365oCpCop+vGs=;
        b=dHihiQvHWTlrpfltj0y1zt72/9sm6KnShz8SAJZe1pVqIRW+yBK/qzGHUrvl9Jt8ts
         cGQPsmbhSK0oy76Gr48DMtmyitt7DSBs+jS4M7vNHeUc0t7/1CgQsjAqzPPYDCv82GP5
         S39OFFN0qIk4JH6egNABMKnPW4P6+XNxi5ER0XlBagdemB1PfmoEyFn1QBjz5V0H/Eft
         A7o87kllGD1yJdQKiQD1HrO1vbGGmbHG4xfyFq/HqDVbNkuFFsJOVGIuVWlbIe9Ynfi2
         snknMQ5Jhm1tsiwD3tSmAZ95Webd+9+Jbw6w6y2sAmkq1zFzWwxioOuL+3Iy2IRdeHxm
         csIg==
X-Gm-Message-State: AOAM533VCYK/DMLC/Onz1v8An6W0MjIIW54wmIP/iVbzutEow0ohxWEg
        3cQb7O9j5D3Qrd7cdFYNDyg=
X-Google-Smtp-Source: ABdhPJyU3iDeeonfLrCyZS8ZegFFDuTux5IsDvMQ8QoTTjVYYmJpmE38dykd4LCzMzGk2yDNKMIRRA==
X-Received: by 2002:a17:90a:d18b:: with SMTP id fu11mr2678375pjb.203.1601475505953;
        Wed, 30 Sep 2020 07:18:25 -0700 (PDT)
Received: from localhost.localdomain ([45.118.167.204])
        by smtp.googlemail.com with ESMTPSA id 34sm2460770pgp.5.2020.09.30.07.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 07:18:24 -0700 (PDT)
From:   Anmol Karn <anmol.karan123@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, anmol.karan123@gmail.com,
        syzbot+0bef568258653cff272f@syzkaller.appspotmail.com
Subject: [PATCH] net: bluetooth: Fix null pointer dereference in hci_event_packet()
Date:   Wed, 30 Sep 2020 19:48:13 +0530
Message-Id: <20200930141813.410209-1-anmol.karan123@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929173231.396261-1-anmol.karan123@gmail.com>
References: <20200929173231.396261-1-anmol.karan123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

AMP_MGR is getting derefernced in hci_phy_link_complete_evt(), when called from hci_event_packet() and there is a possibility, that hcon->amp_mgr may not be found when accessing after initialization of hcon.

- net/bluetooth/hci_event.c:4945
The bug seems to get triggered in this line:

bredr_hcon = hcon->amp_mgr->l2cap_conn->hcon;

Fix it by adding a NULL check for the hcon->amp_mgr before checking the ev-status.

Fixes: d5e911928bd8 ("Bluetooth: AMP: Process Physical Link Complete evt")
Reported-and-tested-by: syzbot+0bef568258653cff272f@syzkaller.appspotmail.com 
Link: https://syzkaller.appspot.com/bug?extid=0bef568258653cff272f 
Signed-off-by: Anmol Karn <anmol.karan123@gmail.com>
---
Change in v3:
  - changed return o; to return; (Reported-by: kernel test robot <lkp@intel.com>
)

 net/bluetooth/hci_event.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4b7fc430793c..bbe0ca42cad2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4936,6 +4936,11 @@ static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 		return;
 	}
 
+	if (!hcon->amp_mgr) {
+		hci_dev_unlock(hdev);
+		return;
+	}
+
 	if (ev->status) {
 		hci_conn_del(hcon);
 		hci_dev_unlock(hdev);
-- 
2.28.0

