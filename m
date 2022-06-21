Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4F8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 19:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352984AbiFUTKg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 15:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiFUTKf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 15:10:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0CD2A942
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:10:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p3-20020a17090a428300b001ec865eb4a2so9438427pjg.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M91d+Ao3w5IAZXIjlfYZP08YquFQRILfjWGYi4V/OIo=;
        b=p1y4hYOTAGzBGnwtq5LdnpeqToWsmktHHijFz7TR9A55r5arPI1vPi9q4goxnq76Fl
         Hg59NfTwn3cvMaX7VhRYtJfawodfEMpSO8S/ak3XUTjzCxkeAaMIt++sA4YJa2RMRAMA
         VVIhbsM3uAjj6oPP1XSpBlXSca5f0LRKG4QrYYp8PEGi2aERu4Pv7AMUQPSpw7S5j2/t
         +ao8bVRY1ngdyi7Aa8oMmqcNCcWrQ0w42YJ6cgHwqRbVXY1yxZcGkqD7Hp9zoh//XV99
         dKumbBkcedNiyAHIV/zCkbHmBLGKRjfrkVFcOVv0T6ChClppl+owfZJp2INCGKDOYssK
         DgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M91d+Ao3w5IAZXIjlfYZP08YquFQRILfjWGYi4V/OIo=;
        b=ox/uifgQl/LDeYuURp4BQK714qCcOb8txxqq3yZZdCPQhM3gbX46eBIBv+GQv0pWDm
         liu09khXBIXN3RFDIJs5DjGwEjv9a7QQZpAWPr7OXlvdspOuzIkOQOxOwHwU0rEazqEs
         jFID7R+zfd1Lv32jQ1uIOFwNbefR8QQd80HthdVcWkfYP1BG1TL1PROWK2g7gIqiuk0S
         8b53VMRRXeShehixd/I0JsepwPhvDTtq90tSJF99JOuByO2YxnOlavBdDa+a96YvAqlw
         SBXcu0HbMBeI8Sh9Moxh6rFyYUMQaZK4Zhv3GgwMUVZHs6nBK4eDgxsjH6D5j+WAZKp/
         XIMg==
X-Gm-Message-State: AJIora8RpSsVhbvglUXvhZt9UOuTpD4m5yP1AW+uVGwgXlDL63Our9dv
        wGPAQsBODrPvVaQ7feWyRaux/mPY/wD41w==
X-Google-Smtp-Source: AGRyM1v9VcZCTq6xa3L9bvbbYrjhHGYg7to8eAsTa47nEa95U3NXkFVbwn6em9D6xWpkEjvPNYVLpA==
X-Received: by 2002:a17:90a:778a:b0:1ea:264c:e9af with SMTP id v10-20020a17090a778a00b001ea264ce9afmr34216718pjk.246.1655838633750;
        Tue, 21 Jun 2022 12:10:33 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y188-20020a62cec5000000b00525286c7847sm4183546pfg.216.2022.06.21.12.10.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 12:10:33 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RESEND 2/2] Bluetooth: Use bt_status to convert from errno
Date:   Tue, 21 Jun 2022 12:10:31 -0700
Message-Id: <20220621191031.2160381-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220621191031.2160381-1-luiz.dentz@gmail.com>
References: <20220621191031.2160381-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a command cannot be sent or there is a internal error an errno maybe
set instead of a command status.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7829433d54c1..1ce89c469293 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -950,7 +950,7 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 	if (conn != hci_lookup_le_connect(hdev))
 		goto done;
 
-	hci_conn_failed(conn, err);
+	hci_conn_failed(conn, bt_status(err));
 
 done:
 	hci_dev_unlock(hdev);
-- 
2.35.3

