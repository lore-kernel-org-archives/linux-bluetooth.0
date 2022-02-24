Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED74C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 15:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiBXPMV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiBXPMU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 10:12:20 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19DFCD307
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 07:11:49 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id c23so3050732ioi.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 07:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XLJXXCWwb6OPq4nqGiaPk5LWn3Ael/oCt7XIoqDJrj8=;
        b=j7Y5BRBl5b3nD6AkJFq6QnJ0NPyNcBh+zkqvuRboKFtGZovSz207Apg9I6uAUoTrIT
         aFb0+4WzsdR/A/GJCFix3qSqaS3zVPXjXKqRHhc94Ed6q2D2WmySPyRjGaQnANFTfAsY
         H43wJXTzdklytjeLJ4Xm8GR7OXFo1kIdC6E7valVdlYluW9wGvPicrocl6Vp/yPXkpkR
         SPTjyft2qiI6tDc5D8RylRp7ezmdq2B+94swk5zK4+DFI1ierKlt0BwjY3YsTLEaBgHk
         s60OgO0S5S02SGgge+luyxOsh8jCB1wzzKJw97gT6CXQ6V2eqaRJrG4EEHfRCJJiPpZp
         d8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XLJXXCWwb6OPq4nqGiaPk5LWn3Ael/oCt7XIoqDJrj8=;
        b=KJdO/FgAHFEC/5bbfSANalBFQ9R4zUK7FokOkGDeDAe3Uf554ikWro4UR/XnxPs5dY
         D0t4RHLZYu6L4cMm6AqGCgKUgWo1faIOJ7vSCmJm0cVcqdEhmGj6Ok0apfCDkscDMD4p
         97jWR+Am6+7tMza3F4U7ClbYnlC9iJCtirEIIiYrWVB0NsfnUQy7dDQr+wYG9yowlehg
         x58B6dYSGz/KwX4ON1CEhj5hBX4b6k+E+8lIsv8pk2OIFIJOwQyjadb2mcvnTxno602i
         pi8anl9Rq8EBp7I9Z81dM1zi9hwG0o6bV3dBm9x7VwnDzqmDyLirFaWA1/N2vwkRY/4d
         0u4A==
X-Gm-Message-State: AOAM532hLgdRnIcKxLXaBQpTM6kd1g/MBiKgH0EbdEckmf8uwx9myqCH
        ToxKZpFVsrRpJTMkf4uu7NTmVzVc+FU=
X-Google-Smtp-Source: ABdhPJz7areVOYGIH01fKrS1Y2gHxR8vYw0bfvoJaO5OrOeS0lMUq3zKdGsjN4LRxvf6X/gmqMOq3A==
X-Received: by 2002:a5d:8903:0:b0:635:9b1:5424 with SMTP id b3-20020a5d8903000000b0063509b15424mr2382119ion.92.1645715508590;
        Thu, 24 Feb 2022 07:11:48 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r2sm1769103ioj.27.2022.02.24.07.11.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:11:48 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_sync: Fix hci_update_accept_list_sync
Date:   Thu, 24 Feb 2022 07:11:47 -0800
Message-Id: <20220224151147.119619-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_update_accept_list_sync is returning the filter based on the error
but that gets overwritten by hci_le_set_addr_resolution_enable_sync
return instead of using the actual result of the likes of
hci_le_add_accept_list_sync which was intended.

Fixes: ad383c2c65a5b ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Use u8 filter_policy instead of int ret as variable to store the result.

 net/bluetooth/hci_sync.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b66a2271c433..d146d4efae43 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1845,6 +1845,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	u8 num_entries = 0;
 	bool pend_conn, pend_report;
 	int err;
+	u8 filter_policy;
 
 	/* Pause advertising if resolving list can be used as controllers are
 	 * cannot accept resolving list modifications while advertising.
@@ -1930,6 +1931,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 		err = -EINVAL;
 
 done:
+	filter_policy = err ? 0x00 : 0x01;
+
 	/* Enable address resolution when LL Privacy is enabled. */
 	err = hci_le_set_addr_resolution_enable_sync(hdev, 0x01);
 	if (err)
@@ -1940,7 +1943,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 		hci_resume_advertising_sync(hdev);
 
 	/* Select filter policy to use accept list */
-	return err ? 0x00 : 0x01;
+	return filter_policy;
 }
 
 /* Returns true if an le connection is in the scanning state */
-- 
2.35.1

