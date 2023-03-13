Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E845C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 18:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCMSdn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 14:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCMSdN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 14:33:13 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B33B85A75
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 11:31:42 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id m22so5397073ioy.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 11:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678732284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QzxqcEPuj3SIPLppzfgx8mTGqsqol+jn+EaIUCVBl1k=;
        b=CT8J/V0dnlksJo7hlo0rbUvk2afQnPJ+IKT87ILdvDl+rOTxjUSznav0TyAicsp9l2
         wXKZ/LRZiCOIEgbcDcpmCx0GvuVycX+WNVZoHX4iCQaVCVypQahJznkH8FCmKUbH0+yz
         tAAoXKU2lfBmsQQcpf+9Sn458KQxI5OgYwbZRtR0jwkAuSATnz55h4vaYIaaELfT/+6K
         EXnie/3zuWucQ7TJjmzmWbsBNJrIEjtz/5b00l9ldE5gvE85V1RGydgNovHsYmirXyN9
         HJuzjH59Yz24lNwmbwMbZqobTfJ8eGClyzDsD2fI/ZudEQ9Vu/DbdCofRdXNh2FB8O/M
         yIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678732284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QzxqcEPuj3SIPLppzfgx8mTGqsqol+jn+EaIUCVBl1k=;
        b=hHMjXgpl2vr0/MBMV9w0AC1uWnFWNKe/zQ97Gmy0WQQW3ByjDp+GQbOQ+0r9wdV+Q6
         nsKCbZ1Sdl6OqaORoj9YikmThkhRMl6XuZAWT+HkFjWtzd1VzYqxnNfrCvq89jZ7NyWi
         bkOpjDRvSVF8RmMQ3Ct8/A07l05b6JuBLhwrnTBc3hDrbi/51zXTiqLkowSVIZjbTpKN
         TUPda0H522HpxCDsDE+AQ30oNSUuTQMLkxgyuOGnFc14xUBQL6GDSpq4jfpMpbDuUyFE
         4VOCiNZwwiOcJtiElQ9zeLztVLSZG1hBVOEGVVwVpK3iQ1GIyPViOrkhZyAm+eSm93PK
         PpMg==
X-Gm-Message-State: AO0yUKVkGVG7d3W4CSnc+xrKPuWkq55ePW+4MzIUWyws+ao97GjxB29R
        KzbUtc1+pCKbw+/352jCarJVqYD9PWw=
X-Google-Smtp-Source: AK7set+43Uf9qZ0hIlo6Q0zcyVfLR11MtBbnz0w3RvwjysQeZ7NYGgLP5xUOgYoSfqdDSLMRujWqjQ==
X-Received: by 2002:a6b:a07:0:b0:74c:94b7:3e8c with SMTP id z7-20020a6b0a07000000b0074c94b73e8cmr21432044ioi.8.1678732283823;
        Mon, 13 Mar 2023 11:31:23 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id a15-20020a6b6d0f000000b0073fd8ca79c6sm147150iod.9.2023.03.13.11.31.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 11:31:23 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix crash attempting to read Sets property
Date:   Mon, 13 Mar 2023 11:31:21 -0700
Message-Id: <20230313183121.162037-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The following set can be observed when a sirk is exists but it is
encrypted leading to info->set to not be set:

Invalid read of size 8
   at 0x1ACDF0: append_set (device.c:1662)
   by 0x1FFEFFF7DF: ???
   by 0x1D4461: queue_foreach (queue.c:207)
   by 0x1AC8DE: dev_property_get_set (device.c:1700)
   by 0x1CF3E2: append_property (object.c:498)
   by 0x1CFA91: append_properties (object.c:527)
   by 0x1CFAFD: append_interface (object.c:542)
   by 0x48D7CEF: g_slist_foreach (gslist.c:887)
   by 0x1CF5A7: append_interfaces (object.c:1104)
   by 0x1CF5A7: append_object (object.c:1119)
   by 0x48D7CEF: g_slist_foreach (gslist.c:887)
   by 0x1CF5D0: append_object (object.c:1122)
   by 0x48D7CEF: g_slist_foreach (gslist.c:887)
 Address 0x8 is not stack'd, malloc'd or (recently) free'd
---
 src/device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 77b38e97a7ea..f31f2a097e07 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1659,10 +1659,15 @@ static gboolean dev_property_wake_allowed_exist(
 static void append_set(void *data, void *user_data)
 {
 	struct sirk_info *info = data;
-	const char *path = btd_set_get_path(info->set);
+	const char *path;
 	DBusMessageIter *iter = user_data;
 	DBusMessageIter entry, dict;
 
+	if (!info->set)
+		return;
+
+	path = btd_set_get_path(info->set);
+
 	dbus_message_iter_open_container(iter, DBUS_TYPE_DICT_ENTRY, NULL,
 								&entry);
 
-- 
2.39.2

