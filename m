Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DCDC25B4F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 19:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345682AbjHPTFZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 15:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345704AbjHPTFG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 15:05:06 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327DA2708
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 12:05:04 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79095499a16so250641539f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692212702; x=1692817502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xCDlkTBpMjDCjkcTDV51IPmaYmJkFTjasKUUfW5tH+Q=;
        b=MK7DliVDu8kKCz4l422D/n7TJxPHGvGWyvTOijkZ3eLJaaGrcdXAOmI+054kXtztAS
         MuRF4YCZIPHTED/Z2IWivdJlAykb6HzsaChoSjPnZ3KzkZsZL26qChLSjI5lolRw2GTb
         2iOhgIlIIU94BP2eD6/m2ssb9MG2XL6PB2/72WVCiQPi/USjmFdVqa0is+ssoXaab25H
         qnD75+odWpolWT+ZPwGBB4DtLjCNKHXbM/sVrgqVSgFsaY0eod5C5IDZGH89/Ogi9vbg
         L7PssOMPp4m2Kl/9RNnFwdV05qvk/O7eVU/ODRxnfcDGqFfHKA73jERRniTWhCm2vJ78
         kLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692212702; x=1692817502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCDlkTBpMjDCjkcTDV51IPmaYmJkFTjasKUUfW5tH+Q=;
        b=bCfpy5JG5gCKrLZ5A1IgePjgY7byNAKkRl4vypI+VlVDwUBDQZ0njOSU9espAHIKp1
         qpesQTeo2ZJBgPYfPBpVFROMif3cbT+36Ddxv+wuE4hXI/KVZPUpd0Fht9xDSZmLsaWR
         Ii2OJSU6sTUcXSk7Ze2iFJNwM66m9gY7MBSr+bvTblkal+DcgSZPMneM/X9mxN2VC6nE
         kFXHj9Zd/quinlPAhucujpb7MO3neEumtgBPT6l3VA1lNEEIDxz1HUxJna4ygsk2/SuX
         zxupV+SWlyLlKizxIf4Eka58gLgwSUtWwcDslkdf1iMdhjHtKH+78t4Lja0Fvrn2jaKV
         iRwA==
X-Gm-Message-State: AOJu0YwnAK8b8Wm/9gT2JnMOTAERpFl88JL4f5SSN6RNDBpbinHpJRI2
        ve7x8TPJJvOlzDgm9qXWb9wXio+2QLc=
X-Google-Smtp-Source: AGHT+IEj3RGT9GbiHED+a5sE9QeEznvXCDEdRHiJzMg1rTpZ91FMoiBd7FRd1EspGhXtS22b7Zyk1Q==
X-Received: by 2002:a05:6e02:1a47:b0:348:e4a7:7bff with SMTP id u7-20020a056e021a4700b00348e4a77bffmr4242319ilv.21.1692212702599;
        Wed, 16 Aug 2023 12:05:02 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s17-20020a92cc11000000b00345d3f2bb6asm4791856ilp.56.2023.08.16.12.05.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 12:05:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Ignore errors from HCI_OP_REMOTE_NAME_REQ_CANCEL
Date:   Wed, 16 Aug 2023 12:05:00 -0700
Message-ID: <20230816190500.2732009-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This ignores errors from HCI_OP_REMOTE_NAME_REQ_CANCEL since it
shouldn't interfere with the stopping of discovery and in certain
conditions it seems to be failing.

Link: https://github.com/bluez/bluez/issues/575
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d10a0f36b947..f6d1dc1716e3 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5206,7 +5206,10 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
 		if (!e)
 			return 0;
 
-		return hci_remote_name_cancel_sync(hdev, &e->data.bdaddr);
+		/* Ignore cancel errors since it should interfere with stopping
+		 * of the discovery.
+		 */
+		hci_remote_name_cancel_sync(hdev, &e->data.bdaddr);
 	}
 
 	return 0;
-- 
2.41.0

