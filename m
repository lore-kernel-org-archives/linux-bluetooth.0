Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACE6C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 23:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353427AbiDAXk2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 19:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353438AbiDAXkW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 19:40:22 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97185FF9
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 16:38:30 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id j15so3002796ila.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Apr 2022 16:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tRi9mkD2hB3smWylSIZlbf8NOW3OIQwRaYtRTDbSDKo=;
        b=JX6OijcR8WIImGFVrJ4ROAoFpl0K80Bhx+Ilvd6AHfcC2GH9CDE59pp/5gSTif7ocd
         RgruJ4CJelx9p5SrebBiW+u86LPBsFOW5dnyJTELeXVu40FpEoF8PCxMVKkgefVOZPLB
         5j9+maTEQKcX3uK31Lla1EYbshio1RRI5uoUnMBFVy52lTSDeTX0fyKmYZWBZ4twU3hq
         UcSf6/xeG/nTtII0UcXkaBS9nuRJk2T3scdmnthGriU1rJKF/N9vny/H4fjS/zmy3/yA
         iuI4edMJaLYeyw14CLhh4rZNkOCItxgHgc/4M1J9zSUq2TpTvjBvMVRYqqQd33yUdrtu
         zyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tRi9mkD2hB3smWylSIZlbf8NOW3OIQwRaYtRTDbSDKo=;
        b=3eP1BjAmcoqBqFYrsAXZsy2QOYiLZ5vOZMrI0a0d4S/47q/Kjd0HSJZbVWbyMP+53M
         ks3hGdV5jyv9FvYgNz//kiTlrRzOKBMU+9zIjxyTPoRHacDA1OZSd/ctDdKfOoct4laE
         vAqhL31dM6XeRgi3fzOFB9i32LvJvdXFIguQKep8lg6T34Rpk5yg3fvQ/DLf4xE6qwT8
         +3m2cV5qMsP+q3HWRG7x+jU6N++2o6z/A7bbNMW5byO8hhcnxQPLOEGWSFQ6ph/b8aq/
         MSCE3S5xlJJxP6OAqnjjs3JsjtOiBRkz6HHRKCneeTMzmQ7X7tNtGVBsfXdKkHOvlo9K
         JiXg==
X-Gm-Message-State: AOAM5333bdCe/Oc5SF8VD7od8++VPciUO3Ke+0Bkft5UTQOQQEO8P3u7
        OXIJZvg5TJ4oXGnotaX/ZHH9h9tJxp4=
X-Google-Smtp-Source: ABdhPJwvWvVpMosNtpDd0BAJNqg1aTe/WegJcfCVC75ddGPvpMKa5o7Jw/NR7UOscrFTYoExoCR7Bg==
X-Received: by 2002:a05:6e02:178a:b0:2ca:123a:c6eb with SMTP id y10-20020a056e02178a00b002ca123ac6ebmr952473ilu.187.1648856309872;
        Fri, 01 Apr 2022 16:38:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b19-20020a5d8553000000b00649f02b1b0csm2217062ios.39.2022.04.01.16.38.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 16:38:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/4] Bluetooth: btusb: Set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for QCA
Date:   Fri,  1 Apr 2022 16:38:25 -0700
Message-Id: <20220401233826.122544-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401233826.122544-1-luiz.dentz@gmail.com>
References: <20220401233826.122544-1-luiz.dentz@gmail.com>
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
 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 50df417207af..06a854a2507e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3335,6 +3335,11 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 			msleep(QCA_BT_RESET_WAIT_MS);
 	}
 
+	/* Mark HCI_OP_ENHANCED_SETUP_SYNC_CONN as broken as it doesn't seem to
+	 * work with the likes of HSP/HFP mSBC.
+	 */
+	set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev->quirks);
+
 	return 0;
 }
 
-- 
2.35.1

