Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B802BC6FA99
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Mar 2023 00:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCHAwF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 19:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCHAwD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 19:52:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5CDA9094
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 16:52:02 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so638971pjb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 16:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678236721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4R6L+GTqN8b3HGMFjKfIcEc3M6NiP/F3Cu0JK9UAazE=;
        b=XaylUqxZyDxA28SVDmw24q0HP6BEynbXE0xpAOyfLSPXa5uV6XMoz5FbDM7TVaP1f0
         GQa6qNpJgNEDLLgHyPCgnrTAfrwVlfk9rPn/ZFpTsyiU8JX4vdW3JsMmZGfkQ4A0asqa
         Vo8OOyeSEWtDNmphqyJYaRLwfimGzbYHb6lnUvZIjM3uGouZnbY+cIb7Zrvx8JIKmekN
         9G6Fsr/rIldOysMEO+zjZziv3hfPypBohlx8gerRt0J6r/qdxGrydixpYvRPXiygn9fd
         TQ/+ExOvGa60d9K6Y7zHTKQ2CHlbEhe7cWbuJZqdXdgssMri5nQTpZ0E/Kq0KrtzWMUW
         NcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678236721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4R6L+GTqN8b3HGMFjKfIcEc3M6NiP/F3Cu0JK9UAazE=;
        b=Vbmn8ymyoADyucGvoZb8FHytAW1zw0YzGn7ZBTJIBPD+0RIu2AyHGFpXeTSFkWVxNK
         hU/gM8r8q+bp8kGNf/3D4Uzju0Z+iI2RoLw81NKczpjru3KwiCnNVQevS0gyAUsBTuEi
         kyxG9MKXoLFHoMpL6Grpta1P6nVs4O/7yBYvoyVHO4W9G1ohuck28C+csKySJKHn81LZ
         QywljxMQrHFf39N2VSsxCdEDZYJTXDppadfqPwlYxgd8jlkX69Pq1N0XG2mY7h0nmvZi
         liVKGDFxy+uHtgu9fjtIunY18eQU3nMqEQ3D5bEPHz8HsAOUave5f6dCaU0zvzY2qAUN
         pmCA==
X-Gm-Message-State: AO0yUKUyjiNqJMqgOBBjl5Evfs+NrZwUIInkbl8XLfONG2bST1CjqXtl
        XqAtnZSo//qoPsf7JmJdfWZTiQXRp+0=
X-Google-Smtp-Source: AK7set+nNGHkE5A4fCwnM7MuGvP64tL3NiqSWdDikD1ZJxix0suV2ECN8nMCTP6ZygtUSMw3zwH53Q==
X-Received: by 2002:a05:6a20:7d86:b0:cd:6f68:98d6 with SMTP id v6-20020a056a207d8600b000cd6f6898d6mr20483872pzj.0.1678236721221;
        Tue, 07 Mar 2023 16:52:01 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id j18-20020aa78dd2000000b005d61829db4fsm8379610pfr.168.2023.03.07.16.51.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:52:00 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] device: Fix not always storing device info
Date:   Tue,  7 Mar 2023 16:51:57 -0800
Message-Id: <20230308005158.2661414-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When updating the device address check if the device is marked as
temporary before attempting to call store_device_info otherwise it will
have no effect and instead btd_device_set_temporary must be called.
---
 src/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index df50ce7b4f6c..652c03606b9e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4412,7 +4412,10 @@ void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 	bacpy(&device->bdaddr, bdaddr);
 	device->bdaddr_type = bdaddr_type;
 
-	store_device_info(device);
+	if (device->temporary)
+		btd_device_set_temporary(device, false);
+	else
+		store_device_info(device);
 
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Address");
-- 
2.39.2

