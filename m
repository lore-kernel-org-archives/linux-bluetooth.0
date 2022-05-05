Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81751C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 03:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbiEEDmL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 23:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiEEDmK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 23:42:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553F64993B
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 20:38:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q4so354142plr.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 20:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jvhOPk/h+PiSm6cA+QHLGIwHxEOsW3lbCEviC9Q7EDE=;
        b=VGhU+DooelKKV/tv8twR3OgeDJR5ybHgLY0wbGthmbZmCfoSj9sm53fGbL1f74pgKc
         GwOmcPX/CI9Gqd0/4nZfuN5I1ltjg/o3q1xvYJAVEmHa9IQ7UcN44QDGPmHn0ZwwyKE1
         6TGeagrytU85tKRGJZbABMJTUoiTlIuhg4XnAoYZ1W6gvSnRcg2N56tOolnl0kiZmhmB
         ksKzE8IuwbA3dwfsVyPoO0xMIq+I77SSlu9QafUEZXb2xFUVsIlyznAXUneG22+TbJFf
         t8eZwlI8XeSY7N7FSX4HPbwKipjM5vLd0gSvvWiS+hkzii60zkJjCvU8ZE7RDs1OGMNT
         0JcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvhOPk/h+PiSm6cA+QHLGIwHxEOsW3lbCEviC9Q7EDE=;
        b=IpOY3Cl4Sy+qJrHfqD3mI1+JHKUSvPlPOuWLZhA6mahXc7sOrkBdJ5ZDsEC/4WhXFi
         3wqs/ICNkacwxaE3da9esZhy5/ClA0lzaT89yCpa8ziX3nSaBA77RRCC8w+XalgXlINT
         olh+BejD6VxOwHMfjMm8D3QNN55SRVWhFQlf4O/fxIwhIcbYgIT8irzU5O/5x3EdxJwn
         4zGKmpj5Rs+C4cH/n3WDorwOX0+9+8UBcdROx6vDA92tF1NZ+mNUoeGD6422su1dVPWV
         /DonNy7RpmKnlP5/mjzgI4LSnQFuqd65ZkJY3+dOXxBdVkoWI/4fQ/glqeWz+RfgV0Sl
         BUcw==
X-Gm-Message-State: AOAM532fHsSLKNxiLr/I9ILqNsboM4aH8qs3jGN8sIHtiKlSxWV62DWO
        lw8US36RxiuLYE3dhM4k4WHwJ/JBT5w=
X-Google-Smtp-Source: ABdhPJwT68ct4NMEU5UR9E970BplOdb43h5FdhiS/2FwY1aVvD1GFRmfCBHGVmRu+P++6GV9rgaBlA==
X-Received: by 2002:a17:90b:1894:b0:1dc:103a:3ba2 with SMTP id mn20-20020a17090b189400b001dc103a3ba2mr3492524pjb.181.1651721912402;
        Wed, 04 May 2022 20:38:32 -0700 (PDT)
Received: from fedora.. (104.128.94.217.16clouds.com. [104.128.94.217])
        by smtp.gmail.com with ESMTPSA id k22-20020a056a00169600b0050dc7628149sm186918pfc.35.2022.05.04.20.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 20:38:31 -0700 (PDT)
From:   LuoZhongYao <luozhongyao@gmail.com>
X-Google-Original-From: LuoZhongYao <LuoZhongYao@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     LuoZhongYao <LuoZhongYao@gmail.com>
Subject: [PATCH BlueZ 1/1] btmon: discard corrupt data
Date:   Thu,  5 May 2022 11:37:45 +0800
Message-Id: <20220505033745.3242729-2-LuoZhongYao@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505033745.3242729-1-LuoZhongYao@gmail.com>
References: <20220505033745.3242729-1-LuoZhongYao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 monitor/control.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/monitor/control.c b/monitor/control.c
index 009cf15..f256b6a 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -1306,14 +1306,19 @@ static void process_data(struct control_data *data)
 
 		data_len = le16_to_cpu(hdr->data_len);
 
+		if (data_len + 2 > sizeof(data->buf)) {
+			fprintf(stderr, "Received corrupted data from TTY\n");
+			data->offset -= 2;
+			memmove(data->buf, data->buf + 2, data->offset);
+			continue;
+		}
+
 		if (data->offset < 2 + data_len)
 			return;
 
 		if (data->offset < sizeof(*hdr) + hdr->hdr_len) {
 			fprintf(stderr, "Received corrupted data from TTY\n");
-			memmove(data->buf, data->buf + 2 + data_len,
-								data->offset);
-			return;
+			goto _drop;
 		}
 
 		if (!tty_parse_header(hdr->ext_hdr, hdr->hdr_len,
@@ -1330,6 +1335,7 @@ static void process_data(struct control_data *data)
 		packet_monitor(tv, NULL, 0, opcode,
 					hdr->ext_hdr + hdr->hdr_len, pktlen);
 
+_drop:
 		data->offset -= 2 + data_len;
 
 		if (data->offset > 0)
-- 
2.35.1

