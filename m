Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C18C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 01:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBXBtB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Feb 2023 20:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBXBtA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Feb 2023 20:49:00 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2E926CF8
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 17:48:59 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id e9so10161564plh.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 17:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1J0cSkd41IUpwZQbDB/war02AGMO4LuY7l/V4VgVEpk=;
        b=fUHd/wECwe2BhEenmf0QDMIZl4/ugKXCah8MhXNVeQK1ViNINcj03GYfwXehqQz4ZL
         4FQnMnwou1wgKdOeXZ9TgsGk5Q0l0oWD/XVA0kolg9Dak53n/WUIrUY5JVRE/CDrM68m
         EF4CyTTrhEoOmqcxYunQ+YL7icg5/7UEdXJVGVMgBoDw4yISZM6/M9zmhbDADr648T9n
         Dn58IUFpwmk2A3fkEG2jm5iuMYNTRWkCygFalpPPz9KrIVLuSAaz0/CZkujCEiNz+I7J
         6vRnZANRboHxtfk0LXkGD3EqUIm29lNPHYuDpjwi+s4TSO04ukY153hvlKHqHDhXROg3
         2q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J0cSkd41IUpwZQbDB/war02AGMO4LuY7l/V4VgVEpk=;
        b=hJpYluKh0ECY6wwOecDzeyCf1l3dpzYyHwO1dQj6j6nCRBs4xMT+R9KQ3NDLerkBlr
         LCNHY15PtfjvMck383YwI7kZxu+E/P5+hsmj+AheU5rooDcDbt31cb/TqvO8gKWVzasL
         zUWJoJJkhmzn9B8YHNPLXavX365gnDZ2LJ9aeSaNdBk6qPzMmGW09/cHW2zDlHE5VnR3
         gNMH/MoLqgY/yf01I4cmXuCKfpi2jg0MBUDYYtHA0e9trCZo5A09gCYVCfRUJjB3JNh4
         AT0ApedHDVukIarjO70gfXvfDvz1GYoXIQp+5JuT3E9VzZLdo8e1znK0nT7trFTGlIzx
         6lpg==
X-Gm-Message-State: AO0yUKW6XztKJP2kwWpwdBwp4iD8A0+awjm0UjnZEV6dEmET+h+Nyizi
        7JMzaSYYHg/Ki3YLRpEgTuuMz0q0WBM=
X-Google-Smtp-Source: AK7set+5XEhSqgVANXcHkjFndxR+MD5rsnUIRiNct4T72XdzwkqzXZxo8XMm1v2P4iqeVxPO7dTR7w==
X-Received: by 2002:a05:6a20:6910:b0:cb:ac6c:139d with SMTP id q16-20020a056a20691000b000cbac6c139dmr14622930pzj.9.1677203338227;
        Thu, 23 Feb 2023 17:48:58 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b005a9bf65b591sm4441539pfo.135.2023.02.23.17.48.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 17:48:57 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Don't suspend when there are connections
Date:   Thu, 23 Feb 2023 17:48:55 -0800
Message-Id: <20230224014855.3423985-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
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
index 6273a93defd2..279d9e89c646 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4258,6 +4258,10 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 
 	BT_DBG("intf %p", intf);
 
+	/* Don't suspend if there are connections */
+	if (hci_conn_count(data->hdev))
+		return -EBUSY;
+
 	if (data->suspend_count++)
 		return 0;
 
-- 
2.37.3

