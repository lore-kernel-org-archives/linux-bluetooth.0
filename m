Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14E0C4167E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Apr 2022 21:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379456AbiDDV2f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380493AbiDDUTs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Apr 2022 16:19:48 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797C533EB0
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 13:17:52 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q142so7487510pgq.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Apr 2022 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VkuZxi+FO4+RB8h1ano29K4ElRCpisBCc+2d5OMebQw=;
        b=q4D2DkA6iSL5XyQMSDTaijiFb+rOwh5h7CvMGgxyn0k/xIJeGFqr0g/Sqc/P8bZRxO
         OS+QVN7FSdDg08xtUsMMMB7zQQO4+esvCD8RAlUt7CWpQ6Uz4JvYArMNZuBNKEOZ5cOC
         FlDOjL4AwNyDFmXU3au/MG7lDkgPFzNKVQccGDeUYFTwS6ZEmwgiu1Cq89UFJTepLXx0
         nYG1JfNMgs/Ipe4Cg5IwUnKaQbOVOsNJq4s4Oc4rIqVD1O1lQzYtZGvQLiKS5XLrBZhc
         AfG6PUPPl4mX+6Ox+CAgsdiNPqs0OV2aNyWlydKLXLfmlvjh2IUxgu94nKWcAfesGbOa
         rFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VkuZxi+FO4+RB8h1ano29K4ElRCpisBCc+2d5OMebQw=;
        b=a58LpQsVi1UKqvYZ/ScGjye4QyYXznnx4110Xn7MxZ9BriGDIgTCfL25CJgDYy/dEo
         5KngnF1iPv2nKM8oQs5KaOeTquXmUrQDa9JR7DV8D22IMVoMZVM407ABlbKzAxFNZ30x
         UfaHmHwcMNJMy0RzTSi+7ABDHfojRxG0nrd4lLEAjGijPU74IogndGOpQMgcoNRRpZwt
         b8Td+A5/XRpRThAhDMoCci4aTX4wMFkaVdkcbGpEjxah12R6meG0FrmcVHlc6r1cFGKZ
         KgWBwbE61DRaB3J9+Ae92WMhaGZkQhnLqRf8DNubfSWYjaLK7E8T0azhOK+MUHNXcaJY
         XbGA==
X-Gm-Message-State: AOAM532iizgs3CGl8DkGEUhea7INFMuXxhywTAke+rIRukgomag/AVOd
        7jhvW0gyV6eTNpm3V0Hv7PHBaHfXWrY=
X-Google-Smtp-Source: ABdhPJz+wZGNyRIMZ33x1cCsFCmt0PaHvyiThOe97/5zmjBtgxeQoB6Q0U9IJ0WoXU4XbAIPzyOX2g==
X-Received: by 2002:a63:cf12:0:b0:399:38a7:5063 with SMTP id j18-20020a63cf12000000b0039938a75063mr1299818pgg.311.1649103471712;
        Mon, 04 Apr 2022 13:17:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g70-20020a636b49000000b003823dd39d41sm10997508pgc.64.2022.04.04.13.17.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:17:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] gap: Don't attempt to read the appearance if already set
Date:   Mon,  4 Apr 2022 13:17:50 -0700
Message-Id: <20220404201750.1082470-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Devices are unlikely to change appearance over time which is the reason
why we cache then on the storage so this skips reading it on every
reconnection.
---
 profiles/gap/gas.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index ea3249be9..400818d67 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -142,6 +142,11 @@ static void read_appearance_cb(bool success, uint8_t att_ecode,
 
 static void handle_appearance(struct gas *gas, uint16_t value_handle)
 {
+	uint16_t value;
+
+	if (!device_get_appearance(gas->device, &value))
+		return;
+
 	if (!bt_gatt_client_read_value(gas->client, value_handle,
 						read_appearance_cb, gas, NULL))
 		DBG("Failed to send request to read appearance");
-- 
2.35.1

