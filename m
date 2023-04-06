Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D804C7618D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Apr 2023 08:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbjDFIzc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjDFIza (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Apr 2023 04:55:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18946E89;
        Thu,  6 Apr 2023 01:55:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso2485293wmo.0;
        Thu, 06 Apr 2023 01:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680771325; x=1683363325;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UqB8C0YqtoCa+EUxHHyv/O6zFBSvw0sxqdv4bPbxOig=;
        b=G1yXOIBuEuAVOqNviT5S8hhE4jK0rc4wJ3bPYeGNzmjIaRhX4T12pynavTz20lJy5V
         54FRk6htMr1FgFLJnAXTYLHUPm7Gl9lA6Xm5ixnH0kt9PRGfkugwHkPeRYgfe9VmUetP
         UNgP+LeodwQyjNHf9r72ZM5il8NsTWrWRgMLKDTSyWEuJLtFQrPVQrPWEUa4AEr3Pvih
         VNQFAgNEANTp6JAgonIxpt7Id7kRF6TuD8UYzvmier5/2+5sPXKh7Vc7VzO6gtSFRYKk
         9k3j5a6UH1LlYQuiBDybI7EtQzveNqQAXnPncqz7nXoFS/GOJ3NzE/nK4Z51EWR2u8ZL
         I6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680771325; x=1683363325;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqB8C0YqtoCa+EUxHHyv/O6zFBSvw0sxqdv4bPbxOig=;
        b=FO0Ennt9G1MhSIU2r7NVpb/3ES7ezrd5HajC4ldj6hm5+SgoYOyt9Qsg9KfimJYpyQ
         kJi3PuGztN57PqVbQHFYxBSRKv3qUe61EFFa65BW9BUW7BZ8lBGTMMp2SOwVFUJDE+jt
         EFRrFPMDN70YuWZiCHksheL8yUIjADfTiUaRS7wjsZwCXMHjt2Bf4bSYWFYqX7Fk/oac
         C6EBd1FOobl45eOnLB6JmkcDsxuYRZXwRHe2bnXu079KruCeMonrx1XYBSpnTDQz4v8i
         Yz3nIxDns/rOuaizuZ2bQJfqr0u8Zaaeo5s9FAgIU+zmfmpudfAKciIHk0DYpFDU2bO+
         OWUw==
X-Gm-Message-State: AAQBX9cRqJSLDgnoxgpMhnPqkhVgffYP1Vs28tWjLD1SbjwLyZlXjyWQ
        BfM2JEXUjm9v4NtO1qnMOLw=
X-Google-Smtp-Source: AKy350Zbz2BUKlhacOhqgyI56Ve9un3X/wIjWsFI2VV09enV/V69+SK8lQU3AbN8HB0kBWTk73yXKA==
X-Received: by 2002:a7b:c34a:0:b0:3ef:f26b:a187 with SMTP id l10-20020a7bc34a000000b003eff26ba187mr6630534wmj.0.1680771324947;
        Thu, 06 Apr 2023 01:55:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b003ee6aa4e6a9sm4797532wmp.5.2023.04.06.01.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:55:24 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:55:17 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: vhci: Fix info leak in force_devcd_write()
Message-ID: <634ab328-3ef2-43b7-8f81-8a48c7661427@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There are a number of bugs here:

1) If "count" is less than sizeof(dump_data.data) then it copies
   uninitialized data.
2) If simple_write_to_buffer() returns -EFAULT then we run into a
   problem "ret < count" comparison.  "count" is an unsigned long so the
   comparison is type promoted to unsigned long and the negative returns
   become high positive values.  That also results in copying
   uninitialized data.
3) If "*ppos" is non-zero then the first part of the dump_data
   buffer is uninitialized.  Using copy_from_user() instead of
   simple_write_to_buffer() is more appropriate here.

Fixes: d5d5df6da0aa ("Bluetooth: Add vhci devcoredump support")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
From static analysis.  Untested.

 drivers/bluetooth/hci_vhci.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 691fe93b1976..40e2b9fa11a2 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -323,17 +323,21 @@ static ssize_t force_devcd_write(struct file *file, const char __user *user_buf,
 	struct hci_dev *hdev = data->hdev;
 	struct sk_buff *skb = NULL;
 	struct devcoredump_test_data dump_data;
+	size_t data_size;
 	int ret;
 
-	ret = simple_write_to_buffer(&dump_data, sizeof(dump_data), ppos,
-				     user_buf, count);
-	if (ret < count)
-		return ret;
+	if (count < offsetof(struct devcoredump_test_data, data) ||
+	    count > sizeof(dump_data))
+		return -EINVAL;
+
+	if (copy_from_user(&dump_data, user_buf, count))
+		return -EFAULT;
 
-	skb = alloc_skb(sizeof(dump_data.data), GFP_ATOMIC);
+	data_size = count - offsetof(struct devcoredump_test_data, data);
+	skb = alloc_skb(data_size, GFP_ATOMIC);
 	if (!skb)
 		return -ENOMEM;
-	skb_put_data(skb, &dump_data.data, sizeof(dump_data.data));
+	skb_put_data(skb, &dump_data.data, data_size);
 
 	hci_devcd_register(hdev, vhci_coredump, vhci_coredump_hdr, NULL);
 
-- 
2.39.1

