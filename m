Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D070C19F2B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Aug 2022 21:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbiHCVzi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 17:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiHCVzd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 17:55:33 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94EE6353
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 14:55:32 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id i71so10745737pge.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Aug 2022 14:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PsUSfkdOdDKpa8omJPWs9MsLgFr8medtUzHBSM7BWGg=;
        b=E86Z+P5YSuk1F8py8B1T+80ZDJrJUUxt19WSwk9r4lcBpPVyF8B4nLEmgHOzouRsrP
         mNICLUNvVIsPYv5bBIbnzhsAjQG3j+Ob3+D7B2TM+MfOHjjntnNISPOOrXMsR2bYfH/o
         DxFJKm7KY0KujjIKOxbstePhHopvNro4Y1/e37M4GVFKTp4sqqgGJgO/4zgLzVb1bvpV
         GOrt2NyS8mOpQ4pkoufM31pGAsqNMsLL+D27bL5pjJxhO1axzz+X/Xv6ZRVW4uNGRm/q
         i59WYOuUYqYQ19SCNdMsM5otGrxMgv0kNcqz/ErgsXK9tIpWOjSJZR4DdIFZ3fLBZU67
         aMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PsUSfkdOdDKpa8omJPWs9MsLgFr8medtUzHBSM7BWGg=;
        b=XB6tQdC5s/O0k7usGVS/e44Ffry1FOYwSmx6vS3X28UBbIWurHVqGMAKO9ZIsDXGml
         b4qhcA0VGCCdTuZV7ZZkNDoVZYXXa8qe/7BgtX+cT8zUU5E92wGQabTJ4kGc8JD1mBmt
         Oiwg48B/gMmiccstQey13vgYFZQqbItxWReSp8aR5loVZ6Enw2Fr4h5JkCsDLcZHgieO
         49n+i8MISGQI7unI7l4rWg/6rW1xJMw3oB0oH4WbxgKxyDF20q5KJEX4heTpuHL3AQ6Z
         TfJ6Qc0Ng/DSHU/VgV/pqk0p8L7llQSBAKH/XC3eAkfbhc0vGrioMYeo/ySi8wJxzWPD
         jigQ==
X-Gm-Message-State: AJIora+gqmRRdfHXmpiepCqoNFl3Mkn5bJhLTho7IuXIzmhk5Qm6w53a
        Zdj4z/eIb8dcJHqZYS2ub4EoEC6+2zSW0Q==
X-Google-Smtp-Source: AGRyM1uOyuowSvtZyb+3yq6EExr4ZjexSzi6UDxg72ny0/Qo4B5ElzcjPJ0OJvfCP9pe3Oc+JCz7Rw==
X-Received: by 2002:a63:1259:0:b0:41b:5589:fa8f with SMTP id 25-20020a631259000000b0041b5589fa8fmr22260178pgs.481.1659563731714;
        Wed, 03 Aug 2022 14:55:31 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l11-20020a170903244b00b0016bedcced2fsm2494052pls.35.2022.08.03.14.55.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:55:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: MGMT: Fixes build warnings with C=1
Date:   Wed,  3 Aug 2022 14:55:27 -0700
Message-Id: <20220803215527.3070932-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220803215527.3070932-1-luiz.dentz@gmail.com>
References: <20220803215527.3070932-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warning when building with make C=1:

net/bluetooth/mgmt.c:3821:29: warning: restricted __le16 degrades to integer
net/bluetooth/mgmt.c:4625:9: warning: cast to restricted __le32

Fixes: 600a87490ff98 ("Bluetooth: Implementation of MGMT_OP_SET_BLOCKED_KEYS.")
Fixes: 4c54bf2b093bb ("Bluetooth: Add get/set device flags mgmt op")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 11eb6e538518..cf393d7c6e87 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3818,7 +3818,7 @@ static int set_blocked_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_blocked_keys_clear(hdev);
 
-	for (i = 0; i < keys->key_count; ++i) {
+	for (i = 0; i < key_count; ++i) {
 		struct blocked_key *b = kzalloc(sizeof(*b), GFP_KERNEL);
 
 		if (!b) {
@@ -4623,8 +4623,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 	u32 current_flags = __le32_to_cpu(cp->current_flags);
 
 	bt_dev_dbg(hdev, "Set device flags %pMR (type 0x%x) = 0x%x",
-		   &cp->addr.bdaddr, cp->addr.type,
-		   __le32_to_cpu(current_flags));
+		   &cp->addr.bdaddr, cp->addr.type, current_flags);
 
 	// We should take hci_dev_lock() early, I think.. conn_flags can change
 	supported_flags = hdev->conn_flags;
-- 
2.37.1

