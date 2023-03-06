Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFF0C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Mar 2023 22:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjCFWcn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Mar 2023 17:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCFWck (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Mar 2023 17:32:40 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E506F636
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 14:32:39 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id b20so6889610pfo.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Mar 2023 14:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678141958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb8xtFrMji0ZrxEhtXoqfUaad86MGatiZYZtMFjD6Rk=;
        b=bY4tGiBmYQetGMrq6PEnb2eMmBH4LizLMvE2BfxIf7wtdJDN0c1BepA2RHf7eRRjbP
         FCthFJEvd0tlFghZw6yxrXjtPSJrzuTqEFZPpFx1KU6aTigqOi4bfOrWDdHzI2rslspN
         2ssap4wbfLogF4IjU5OdK4WXMQJXfJBoiGh+bYC/0vbcJyXZNI8lf6Lxp9a2XpWQqS3h
         VM3EltigNgma4UGTEsYMfSGP51b1tKk7ax+bzhfo/6X53Hq0qi44HgWeh1gPh3f09lm3
         THMfi5+E66mis8HQSS5YlBpp//c+VCIuFLORbBce0CDNSQA3qjowM4ZfMkiF4Jsm/MzO
         z2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678141958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qb8xtFrMji0ZrxEhtXoqfUaad86MGatiZYZtMFjD6Rk=;
        b=fN1vqWoarxLz+iSYR0zyFhXSmp5E1WzLlHd6ehWkB5dAJrFF63hscxmrNNbEikM8KP
         8mNr5Grp5Q8UO4WWNH40YG6PEbXtVsZ7vWN4X2C759rim+QRr422z2b1j/Q0oGK5zNOe
         pnVFdb7bo17Us8Tlg49gGrWQq7gVQp6kvO92bq306bTsu5Ge+Bjt3Ze4DAbc9FvF8kG4
         e2Gz24U9VJ08OB9Zu3GeLlvOtfAkD/ywyFG+ZxV23AeXXdwgsZf8AhTrpoaaP0UkisTH
         p6LG/Bmwgt2FwONCaDFwgijCuXqufQ/+pc0qBHkDOtzgL/k/sFOH9PWnvNSpNUuqUdwC
         DfGw==
X-Gm-Message-State: AO0yUKXkGSaNejI6K4TqO+QD0YoSv+v3Bud9FNS+EbGQ1kYHH0gnh6Si
        jxH7D0zHFbzulgxgZc8CBDdTq7uJoe0=
X-Google-Smtp-Source: AK7set+WInOkeplnCaCfUp37H/dqoUte22sdA7xQ4Mhg7PcPyXFi6rbo2wS476TGG0S/zanwzuVpFg==
X-Received: by 2002:a62:5401:0:b0:5e2:da34:4aaf with SMTP id i1-20020a625401000000b005e2da344aafmr9599452pfb.4.1678141957772;
        Mon, 06 Mar 2023 14:32:37 -0800 (PST)
Received: from zbook.. (97-113-12-200.tukw.qwest.net. [97.113.12.200])
        by smtp.gmail.com with ESMTPSA id j7-20020aa78007000000b005e0699464e3sm6704009pfi.206.2023.03.06.14.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 14:32:36 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, Brian Gix <brian.gix@gmail.com>
Subject: [PATCH] Bluetooth: Remove "Power-on" check from Mesh feature
Date:   Mon,  6 Mar 2023 14:32:21 -0800
Message-Id: <20230306223221.536377-1-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Bluetooth mesh experimental feature enable was requiring the
controller to be powered off in order for the Enable to work. Mesh is
supposed to be enablable regardless of the controller state, and created
an unintended requirement that the mesh daemon be started before the
classic bluetoothd daemon.

Fixes: Unintended Bluetooth startup order dependancy
Signed-off-by: Brian Gix <brian.gix@gmail.com>
---
 net/bluetooth/mgmt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0dd30a3beb77..7576db8eb83e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4627,12 +4627,6 @@ static int set_mgmt_mesh_func(struct sock *sk, struct hci_dev *hdev,
 				       MGMT_OP_SET_EXP_FEATURE,
 				       MGMT_STATUS_INVALID_INDEX);
 
-	/* Changes can only be made when controller is powered down */
-	if (hdev_is_powered(hdev))
-		return mgmt_cmd_status(sk, hdev->id,
-				       MGMT_OP_SET_EXP_FEATURE,
-				       MGMT_STATUS_REJECTED);
-
 	/* Parameters are limited to a single octet */
 	if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
 		return mgmt_cmd_status(sk, hdev->id,
-- 
2.39.2

