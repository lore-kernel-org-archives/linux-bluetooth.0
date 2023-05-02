Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC3DC77B75
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 22:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjEBWMU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 18:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjEBWMT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 18:12:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073302D4E
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 15:12:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ab0c697c84so10373375ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 15:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683065521; x=1685657521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v7lDS/DUVufJhsyLLgo2/B8BZ79r25vTsYHDbB/n2g8=;
        b=hO0RzYvYy4WhhnNbEeBavLJu7OD72u+msKLbwjmY83nUpOiKIJnY5YZoM42IZhR+2V
         caLtwpk18IvKlIO14Oh+OxaMwnmXhM2DLelAXltrvzYJe8WVSiXKzlC7KFUqoo4sO4Dp
         wV0KR4YIMLQxzop3VPsZVEHNI1sBZu/dVXLqZRoy5rhLjTIJ5FlG2M8YEhUu3b+ZjKzr
         A2SQtXN7Je6fFyIHq6HKf52X9P6ki02fCDM4wgEcfKfncDbaXzbECFJ7VbrekZwQhjzy
         e/LHpHhYNI9qETL7xtDJRCPjTg5c5di4TbY/cv74DicsXgKQrztttomoBDbFVbHNb/TB
         2DaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683065521; x=1685657521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7lDS/DUVufJhsyLLgo2/B8BZ79r25vTsYHDbB/n2g8=;
        b=MXH/Y2xxoURa3eV5Z8qoe81gMQGoKZkRtvqF2+nr/9MnnnHcRw/MdZoyr3xZhynjxV
         o3aAf8StJhlibFRlkYJ8oTrp8ZCvqMsprwM31j0jtWRrmSwFgTaqJoNXhHWcwWabaXCS
         ohRPZR4ufGWP11GZuW14h+dJfpa0MRTMpFbBtn2E4iyvM5DCEkSEOGNYw+ixVmpW08aI
         ZkNRRN2McPHH6Uisd62ixE7AcbpmS4NfXsQphw5lA63G1SP2H0hCXxyHZrpEJTSWcFNI
         DqvrHCY/Uk6K5x4SIik+DkdUF8MsaK2DIOOR0O34VIv98451N9LixwHCqjREqj5GyWtD
         qDQw==
X-Gm-Message-State: AC+VfDznM1lCLHZrTeJYCokqvzQj+IgwUO8oip0KYQ6nywRLxfKYjo6c
        VMZJsMH1Hj66bGFnHFlAyOinTkh8uUw=
X-Google-Smtp-Source: ACHHUZ5/STWbEWxMNShn/YttRBHSgXlSteEJsspPH7YzQOmIu+OFBUhxppdIu93rjoGVLJT4JS5CjA==
X-Received: by 2002:a17:902:d50c:b0:1a9:98ae:5970 with SMTP id b12-20020a170902d50c00b001a998ae5970mr30734plg.23.1683065521366;
        Tue, 02 May 2023 15:12:01 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902bd9200b001ab0672fc1fsm2258122pls.105.2023.05.02.15.12.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 15:12:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: btusb: Don't suspend when there are connections
Date:   Tue,  2 May 2023 15:11:59 -0700
Message-Id: <20230502221159.1674607-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks if there are connections before suspending since that may
disrupt the connections making it stop receiving any data if remote
wakeup is not enabled.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2a8e2bb038f5..dcf1c4f5042b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4523,6 +4523,10 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 
 	BT_DBG("intf %p", intf);
 
+	/* Don't suspend if there are connections */
+	if (hci_conn_count(data->hdev))
+		return -EBUSY;
+
 	if (data->suspend_count++)
 		return 0;
 
-- 
2.40.0

