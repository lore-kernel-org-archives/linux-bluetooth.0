Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4B6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Feb 2022 01:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiBDBgX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 20:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbiBDBgW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 20:36:22 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AECC061714
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 17:36:22 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id v74so3792801pfc.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Feb 2022 17:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zyyw+q7z34FUZ7s3/pc1NezcL/Wq0U8jfEcKdYRkbK4=;
        b=E8EyBBBPhYTYyCxJ4a4MJ6NRSYJHkRvmKUh1+QxA5TSJMVW9uuZbrtHb1lAj5oP8gK
         Eu4bvdQi7RTmndpiNC220GlGLgR48G3QY5UYAILi1nU9C8Ee2MpOW7NMZx0wEU870w2J
         iTFdWRGoX2srqEjVPDQ2bdytUbaNwhJ25TgKapwx9KZ3vyjJthnojywPy0oVuyDZGKXm
         hrL1DwORR9xHMZHrAkZ69cLT+KQ/F0Hp5fBLFCseRBq02k2VO6mp6RpORpL65ovKbDvn
         lmAK9+3yM7byUqQjhKmoVPRT6o2UklKK1u0b6ytF7N3hjaXrk/7JiN3Mjya99XH+Wmlg
         xjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zyyw+q7z34FUZ7s3/pc1NezcL/Wq0U8jfEcKdYRkbK4=;
        b=xqHG8tl4OsrUes81kQZaoH6LwmcJEpNyxXHFv3Esy00sWrVXHEXuF8QNLbHOlzIkBA
         3x2v7XXEMbVTXYjuwL7CGqDB9zv1KvHTN3gmiUTVp1Af9IA/A59btOGvfHihLolUrsgS
         I8wF9dy4QRwEJZa7xLRohufWbs3QQTBSabTXGBnMd9JrT/01AvCu9X2l7P6FaPeLQQUb
         mFhCGCAL8WBqCvsD/2qDUnaOEP9JpcZhnHCSW/Bly/38eUIciZ/Ry5hjR796Vc4GVvyj
         gN3cZOZkicLQ4GrtKjG/qUdbShz54zDdqkMKBqn56Y/Wmev3br+QiLzyKb2fpzDljutO
         BzEQ==
X-Gm-Message-State: AOAM531avnbpZuRco+1vFc0Q8COmnFg3YJP+wWFi0yt8yWve/+pVrDUp
        yK8+joti0I+uFzbD4luOeQsXeIFFis7fnA==
X-Google-Smtp-Source: ABdhPJwrETITTbca/heuWvSZ/NXNE9fkL8HUzvmTHodYIP3WHOIKT/8Nply6yyoRzzEuAbJ10KtgIA==
X-Received: by 2002:a63:1655:: with SMTP id 21mr637943pgw.156.1643938582011;
        Thu, 03 Feb 2022 17:36:22 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c5sm277632pfc.12.2022.02.03.17.36.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 17:36:21 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gdbus: Emit InterfacesAdded of parents objects first
Date:   Thu,  3 Feb 2022 17:36:20 -0800
Message-Id: <20220204013620.2465024-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes InterfacesAdded respect the object hierarchy in case its
parent has pending interfaces to be added.

Fixes: https://github.com/bluez/bluez/issues/284
---
 gdbus/object.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 50a8b4ff1..7232c2986 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -551,6 +551,12 @@ static void emit_interfaces_added(struct generic_data *data)
 	if (root == NULL || data == root)
 		return;
 
+	/* Emit InterfacesAdded on the parent first so it appears first on the
+	 * bus as chield objects may point to it.
+	 */
+	if (data->parent && data->parent->added)
+		emit_interfaces_added(data->parent);
+
 	signal = dbus_message_new_signal(root->path,
 					DBUS_INTERFACE_OBJECT_MANAGER,
 					"InterfacesAdded");
-- 
2.34.1

