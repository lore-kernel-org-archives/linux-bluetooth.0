Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3340BC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 23:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJRXqO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 19:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJRXqN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 19:46:13 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35721CD5C6
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 16:46:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so15430539pjl.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 16:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdeBnWLi1p2OWSh/6GSZ28/2GrjhlAjLt5fiAujUhM4=;
        b=PQkZiM6Z9OH+tadRYYz1ml804enRYF0N56cnlaCCvfBo/5dbr5+nM8FF2xpq1fi44v
         gwp/unfQG8xtPi/LX3/vCaK0y0KpU9Hq/a25bI+HZZQF+n+8AJGM1nuAnKpDQP28c0MM
         sG7nqFQEArHEoQqYah/12rdL7N5GlmmevcMZ6LKgv2z/kw2qifH6LVgzxAuMM2obIeur
         l9hK106C5prPycVSJGrUii/M3YsOMsCJSgu0PQ/mPVtq/OCiy9Hd+K4wt/HiMSd9Pmx1
         oyz5TrxdPCLFggxFddd9H+htgY77VIziwK3N6uEBZXyJias9/756JaT5238g/NGkAl9z
         eAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdeBnWLi1p2OWSh/6GSZ28/2GrjhlAjLt5fiAujUhM4=;
        b=0lXwwWKU4gPBAiNbpzTB+REwb3eh+7XxjrYQx1ic9GZrWCoVcr7Yo16oqW9o7kJpBR
         KClGzc1l/lvL+9cAe9ubruHPIVhrvjHUILOlr40TQwL6iPSvQHY8LxN9izGWvq1dxl2G
         O+5JW0xOijOkqJBZshP93RavOpBGJmyZ6ucQeGh3cSWflWZHtwgTVmUYTdCRhwcZe/Tw
         pzjr2AkhhRlfnPrHvbOPGEjY1nqxv4Cfjs1rfpr9kP0W+5msvv1sGV+fk8O3y9sOJ/nC
         NFMuUUQxfWVw9j0WVOb1ZDcbqsjvnLrKQ0hEuEN3ZGWaqyWpGPw9mpHce/nlw4pUeDtz
         uimg==
X-Gm-Message-State: ACrzQf0OzAiA8U6egvudRMnJdO3IJpkmCMFl92Vs4k55n+VE73+C8rLK
        BHsG1O7KGUPGygBoA67CjUgYDrvQ39g=
X-Google-Smtp-Source: AMsMyM7/8emveGIiy5db/rV83qrYLcPHcJN4B5SEIVedaQg4xCeI8z4kQi7fVfnctD6idIpmd8GV+Q==
X-Received: by 2002:a17:90a:e7c8:b0:20d:6c60:c38 with SMTP id kb8-20020a17090ae7c800b0020d6c600c38mr6374404pjb.26.1666136771152;
        Tue, 18 Oct 2022 16:46:11 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ik3-20020a170902ab0300b00170d34cf7f3sm9137783plb.257.2022.10.18.16.46.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 16:46:09 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] monitor/att: Revert treating Notification/Indication as a request
Date:   Tue, 18 Oct 2022 16:46:00 -0700
Message-Id: <20221018234600.3990980-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221018234600.3990980-1-luiz.dentz@gmail.com>
References: <20221018234600.3990980-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Notification/Indication shall be treated as response (rsp=true) so the
correct database is used:

> ACL Data RX: Handle 3585 flags 0x02 dlen 14
      ATT: Handle Value Notification (0x1b) len 9
        Handle: 0x002a Type: Report (0x2a4d)
          Data: 0000feffff0000
---
 monitor/att.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/att.c b/monitor/att.c
index 7a4125567498..fbd75db03b83 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -2785,7 +2785,7 @@ static void print_notify(const struct l2cap_frame *frame, uint16_t handle,
 	struct gatt_handler *handler;
 	struct l2cap_frame clone;
 
-	print_handle(frame, handle, false);
+	print_handle(frame, handle, true);
 	print_hex_field("  Data", frame->data, len);
 
 	if (len > frame->size) {
-- 
2.37.3

