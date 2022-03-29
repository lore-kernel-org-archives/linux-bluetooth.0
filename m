Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12856C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 20:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiC2USd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiC2USd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 16:18:33 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD76D12221A
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 13:16:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id s8so16860309pfk.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XQT701YRSJ402y6Tka71w5G5iKmRXtCUkDwtxSadIvE=;
        b=QOAdtRT0jSdf5qZLGdaB7woKK7v41V4fEeZBCMVlW58BEdetWw6e+PwaFyZ6TzMaTD
         qEqrxsgsIUKj+WORK3vtLBK/GVvO7iiqkXOn3lM34EpIaAJM77NsgksLE25yUR6SZwqA
         MxVlo60bCeizSLIIRCja2iZMputuqEY1g0axz9OoF2vd3oG0hqAeG3RWLeTOAwhymZhN
         bPBA+GEMdj1qQatqfTdbddzlKB1UEutWRt3Dyrxg5bI1+wo16BJDK2dh2sVxr4/qXpHq
         5vMeRwj16uXWqiizRBj6Q5EFpJWMZkhU7iA2feJDh+wsqO4nT8ZfZ2atoxDrB3+ifiJg
         oI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQT701YRSJ402y6Tka71w5G5iKmRXtCUkDwtxSadIvE=;
        b=b9daRWzSN1JKYkYoFutaPTj/WJ/83Bu7nCjlBnqXHPWYHqlWJwZ1hO6Gwf7BODAfM+
         1tF8d+GDtkuSOOjQCFUwKllVNI/XpMswbsm3gdxa1seKU0YNnlItZ3E3jbfRYgxxkYUa
         4G+dU9smpm6fQ3sQS5/HfYip4KXfSnZUN5VhItMYa2TvUOQhMs7O4QpTBBmiuKisJGzy
         3qCFlg9X5i5GXr56ih2ec3aHpnBC0h/xvJGdYrFIkMdF2u9NpdK7PtoEXtFVdLfn5Kof
         lXh7LMVY7uCFWBdjH0X87bjLbkP9JMYgMZ7Rwshu6zI+yvWfXoJzQXgk3uyPMBf3UTe5
         DX2Q==
X-Gm-Message-State: AOAM533+oQIkKjTlWmAvS9DQSDgxqoB3PH7eE7JU4NdcAKFbWw3dfUO4
        78PwhDipgXUAe2r/tA+kONCqh8HZi/I=
X-Google-Smtp-Source: ABdhPJwye80wEf7uGzkuQBQioVTPeWmLE7XnYxEFTvsWnbCg0Qnb9haMudm1eTrNCV6XD8nHwimYkg==
X-Received: by 2002:a05:6a00:10d0:b0:4f7:5af4:47b6 with SMTP id d16-20020a056a0010d000b004f75af447b6mr29503606pfu.6.1648585009013;
        Tue, 29 Mar 2022 13:16:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm20816270pfh.83.2022.03.29.13.16.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:16:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: btusb: Set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for QCA
Date:   Tue, 29 Mar 2022 13:16:46 -0700
Message-Id: <20220329201646.2296314-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329201646.2296314-1-luiz.dentz@gmail.com>
References: <20220329201646.2296314-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sets HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for QCA controllers
since SCO appear to not work when using HCI_OP_ENHANCED_SETUP_SYNC_CONN.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215576
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 50df417207af..2470c3d4ef0f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3335,6 +3335,9 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 			msleep(QCA_BT_RESET_WAIT_MS);
 	}
 
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=215576 */
+	set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev->quirks);
+
 	return 0;
 }
 
-- 
2.35.1

