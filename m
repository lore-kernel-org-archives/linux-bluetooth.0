Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A8BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Oct 2022 22:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJTW6L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiJTW6I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Oct 2022 18:58:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50E2224A8A
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Oct 2022 15:58:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a6-20020a17090abe0600b0020d7c0c6650so4968637pjs.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Oct 2022 15:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ExdYjNCXcG+fesSjNwNca8v+0SEwW6z7wb0173HsGuU=;
        b=gICNczzEWDaEtjQN6n21gzB8jQAPiFbLOwSbPbPg9kEgiccVo5RusUq+REky58nYqP
         vem0tuwKrgtQQ1NgX23abbEQ0XHMalUEffOGwPcRlvCx9wQ+SW3SKOImT7DrePM0xyiX
         afP4qwuw60M5zy39lJoxC0VRt30xMZGomLc/09vYrlSEZgg6c96Fn1VlYOWboPqFBNOO
         YfLi+tz/4+tzRSeIhwBdxBR4aKsbFDc1JhEq6xpL4+v5JoJ/V6k/DYOpPqYqfWS/O7zH
         tz/2LCKARVqLZE9YpJ4qnp3js5RTbVCozpy3PnwQcxIq2uB3j58D0IMN41Q1mDCQQOVJ
         45SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExdYjNCXcG+fesSjNwNca8v+0SEwW6z7wb0173HsGuU=;
        b=p/7hj6Ih5ymAAPH7zzzbiRjO3P8ntzN77029PAwHxLwTJ0o2whwuXcZfBAOOrw9O8F
         Ki8kvJjuRHuKleLfeFMs+ZqfJ3LSBqFov2jHvdOZl0tIe2zi4i0t/eQJtqg4PRgwk+5p
         HhekZv1R9yU0TN13NclOklg3Op9QRYnrA44fznOwQwQYy9ahLVBm0Lp4aHM5rxZCgFqP
         YL2G93eDZI69CULOzc7E7f7YkvJBhQSV9LE8TxlIQjfJ2oMkYW1wvM3edEvD95XaAgrZ
         f+5lv4mO3YAvLTAZwiKFuAWQf/6JVv1fGZxMD14gV7NLT2X0yoP8hmQi9zljkSPO9Wxo
         ZmVA==
X-Gm-Message-State: ACrzQf2M+OwXrf8vyRufZ11ChyDnWJ25zJ2f4QlVSyge8upgWSvgM0Dm
        NwWsGaxN6X4J9osA1zITaNOjAS3v1CY=
X-Google-Smtp-Source: AMsMyM7OWWcWC4AWjq5sc0vqy+RzmWsUt8nZeJ80BmHQjTyTTiU7lo4qNMht8fkv3aZh3njIMqJpdw==
X-Received: by 2002:a17:90b:4c92:b0:20b:a13:83c7 with SMTP id my18-20020a17090b4c9200b0020b0a1383c7mr54211387pjb.128.1666306686704;
        Thu, 20 Oct 2022 15:58:06 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n30-20020aa7985e000000b00563517deaa8sm13775182pfq.117.2022.10.20.15.58.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:58:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client: Fix advertise.data command
Date:   Thu, 20 Oct 2022 15:58:04 -0700
Message-Id: <20221020225804.291712-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

advertise.data when no parameter is given shall print what is set on
ad.data not the ad.manufacturer which is a different field set by
advertise.manufacturer.
---
 client/advertising.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/advertising.c b/client/advertising.c
index 097b9437f794..fb9b049fde78 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -760,7 +760,7 @@ void ad_advertise_data(DBusConnection *conn, int argc, char *argv[])
 	struct ad_data data;
 
 	if (argc < 2 || !strlen(argv[1])) {
-		if (ad.manufacturer.data.len) {
+		if (ad.data.data.len) {
 			bt_shell_printf("Type: 0x%02x\n", ad.data.type);
 			bt_shell_hexdump(ad.data.data.data, ad.data.data.len);
 		}
-- 
2.37.3

