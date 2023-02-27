Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB27C64ED6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Feb 2023 23:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjB0Xw7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Feb 2023 18:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB0Xw6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Feb 2023 18:52:58 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27DE9742
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 15:52:57 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y2so7956955pjg.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 15:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8DWfgeQMu1kzbEvzoUgB2j/uxIuSMvgn0F9Y5wPW0yU=;
        b=hc70cLPYmQMtriUtQWhP6g9zJ7uf6gpGh/k0W6rYS556O+uZRjPDG6PHgqyiqyQeyL
         PV2Ewzm3+g1GDx2FLhs5WNpddWI/F+ZIjBi6kMRau+ZaZsv5SJkyZaNQdffPEocc5Efh
         YkaIig35LYaSjJIwvXCaAjKquxASg3yAfQhZereRP0T1PEyq6y7nC4OCcPeEJT04W651
         q4KiEwCy3EVDQdtitwhjsg+Ks2Gbupojx/o4S5DOsDp808kwsIx/ME0hk5Pyuw54SeWY
         +xTKiKW3CEeeTf8hv+U1wUPHyA51zpLQxB6SU9aYNNVSMZECUd26xLkSvluVF6Qx4ht/
         59vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DWfgeQMu1kzbEvzoUgB2j/uxIuSMvgn0F9Y5wPW0yU=;
        b=icNXCqq5rwATjTLIR9v/3CnOnyhd9zh4C/eYjLvCjN9YZmn86IWQ7OGYjIUQhaiv/9
         TbMFPEfpPhvw8i893BQk4Nfgo5t9BMG2LqvQP7wZuLRu0NWewSPPsHqx7My5OAIWNUqW
         lcz4JV1a4BdwVrSfySf4gm3M2bWlU7LXQV1IV8pkGyNn1z6X5mZ0RdhO0aiwe8xskXSq
         Z7WSSYuIQ3iMESPYVYoZGW3gY2iRJo4CzbQtgWZXJiTNf8Uvu6hLEQbH09E5bh2Az8p/
         1vu/2cktb7s3oF1/xG3dBAvl6+nbM1tjKGx1TKxLfLX4kSJqxQ+18gANlVWtITkbuPTw
         Jg4g==
X-Gm-Message-State: AO0yUKVuIFa6t//Bu4LbpJ+wDLlNkQZiFik3xA07uwT38LwYQo1+ZLAU
        Wje2wg0dL3PCtLAIM8zUPkyLkqcM1DM=
X-Google-Smtp-Source: AK7set/0M7JQYl9MiZVXotHBVQmHsy/4fn6ZJsP4A5vsXhMuDNCspr2ixXfnXtEauS9mgigV2YYZuw==
X-Received: by 2002:a17:902:d504:b0:19c:e842:a9e0 with SMTP id b4-20020a170902d50400b0019ce842a9e0mr743514plg.16.1677541976783;
        Mon, 27 Feb 2023 15:52:56 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902868200b0019a5aa7eab0sm5118029plo.54.2023.02.27.15.52.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 15:52:56 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix smatch warning
Date:   Mon, 27 Feb 2023 15:52:55 -0800
Message-Id: <20230227235255.266852-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following new warning:

net/bluetooth/hci_sync.c:2403 hci_pause_addr_resolution() warn: missing
error code? 'err'

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202302251952.xryXOegd-lkp@intel.com/
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7e152e912e8c..561a519a11bd 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2400,7 +2400,7 @@ static int hci_pause_addr_resolution(struct hci_dev *hdev)
 
 	/* Return if address resolution is disabled and RPA is not used. */
 	if (!err && scan_use_rpa(hdev))
-		return err;
+		return 0;
 
 	hci_resume_advertising_sync(hdev);
 	return err;
-- 
2.39.2

