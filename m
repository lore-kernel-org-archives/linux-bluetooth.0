Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1ADC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 21:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0058A6101D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 21:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbhJLVyE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhJLVyB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 17:54:01 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E934C061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 14:51:59 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 133so385577pgb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 14:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allthenticate.net; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EEidnOeF02qPGgC2PjxclUbGbu5ab7r+8hAInS1fBpI=;
        b=kAsK+zJbOKTCK11DQl4k8FGt7+yJOh9dAAm3dyhycNLa2x48P0qdlgrvV31nFFY4/x
         NfTVQu2gvjZViJKXNBjcqcfV+C2cVDMqLiwPfCaNoljXY2ddsvsMhOyoCdBxGXw+kIsL
         QYh8Y4bwxCftykpzuiTnuH/lDE2H5Y8lZBVhvV59A38O01O53DZMXL9tJ6Jqcug5nBmI
         IHheHVGVjI0cu1plsW7tsTgOUkerSN+8V9qXD7MuVvzaUA7QrpQo4mvpxyhegTvneIOO
         IYrbIUOXS3oR5kvJMZYsA8GO52z0jrVqq+ZJxbHP61iUL2/GwPOOWmx2SBt50kN06bM9
         wSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EEidnOeF02qPGgC2PjxclUbGbu5ab7r+8hAInS1fBpI=;
        b=lZ4QcA7i0m/r4EyXnCWaexPTm7SktNA6rM3uxETZVx6bQSbI/Xsnswb8cXmhtFIvMF
         S5aD7tB9C6bxqmTFCne2qUc/vJPMKSWREYXoooHLSPDmQZ9AvVdP9x+K/nxL7DTpMYHN
         dxPZqqZJE0+Z6qcWwQObfooWi0PJ871aQ5Vf+D2JRNsRtlDwtin7v/xGcQwDdwoL22C/
         0w40a4z1vwBCYGAZNGhHG6p7btQSP5/hkXFzDj0bxHVWzxabYyl0XZcw/QWlpHoYnqpB
         hX5UAoyIiCSRTS0w091tLgzflxNocoX0nL8VF6pxh+reUZMAgYyacRUkAVzexAw+lsjB
         mv4Q==
X-Gm-Message-State: AOAM531g0yxbuI3OBZ3dBf40BTzbIM921uOAlSx/BltNlBIMQ26Sof/x
        p1nONuTrCp9wkk51k48XIoSPn4WMQh1bi1Vf
X-Google-Smtp-Source: ABdhPJxoTTRPdfbJUovYd3mzavJM8RWhicE5NOF5g/dbYpalWnnicaeu/lbWwJ4iDkjCjmLPEK74kA==
X-Received: by 2002:a63:cf41:: with SMTP id b1mr25017917pgj.407.1634075518820;
        Tue, 12 Oct 2021 14:51:58 -0700 (PDT)
Received: from BernieDesktop.lan (wsip-72-222-70-2.sb.sd.cox.net. [72.222.70.2])
        by smtp.gmail.com with ESMTPSA id p20sm12504615pfw.124.2021.10.12.14.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 14:51:58 -0700 (PDT)
From:   Bernie Conrad <bernie@allthenticate.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bernie Conrad <bernie@allthenticate.com>
Subject: [BlueZ] gatt: added missing disconn_id's and removed extra check
Date:   Tue, 12 Oct 2021 14:51:51 -0700
Message-Id: <20211012215151.15772-1-bernie@allthenticate.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Bernie Conrad <bernie@allthenticate.com>

Adds missing assignment to disconn_id for pending operations and removes
check that is already handled by checking if the owner_queue of the op
is gone at the start of write_reply_cb. 

---
 src/gatt-database.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 475e7873c..dbe9415a3 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -978,7 +978,7 @@ static struct pending_op *pending_ccc_new(struct bt_att *att,
 	op->attrib = attrib;
 	op->link_type = link_type;
 
-	bt_att_register_disconnect(att,
+	op->disconn_id = bt_att_register_disconnect(att,
 				   pending_disconnect_cb,
 				   op,
 				   NULL);
@@ -2387,9 +2387,7 @@ static void write_reply_cb(DBusMessage *message, void *user_data)
 	}
 
 done:
-	/* Make sure that only reply if the device is connected */
-	if (!bt_att_get_fd(op->att))
-		gatt_db_attribute_write_result(op->attrib, op->id, ecode);
+	gatt_db_attribute_write_result(op->attrib, op->id, ecode);
 }
 
 static struct pending_op *pending_write_new(struct bt_att *att,
@@ -2418,7 +2416,7 @@ static struct pending_op *pending_write_new(struct bt_att *att,
 	op->prep_authorize = prep_authorize;
 	queue_push_tail(owner_queue, op);
 
-	bt_att_register_disconnect(att,
+	op->disconn_id = bt_att_register_disconnect(att,
 			    pending_disconnect_cb,
 			    op, NULL);
 
-- 
2.17.1

