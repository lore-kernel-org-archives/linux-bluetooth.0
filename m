Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FAFC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCWKcl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjCWKcL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:32:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2846E1C33F
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:29:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eh3so84268131edb.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyszvu/uUvUultdr5LryrAA3EmGp70fEi+2Bwj0O3p4=;
        b=GMFSl2KJbNG9p340hRgtA+LG65TJFa0rQWS5qFBAsJEm4m/yuSVBkMHzac3i1d38Fq
         DZ7yxDsy1k8MFGg/+goufuuT8o6AnXdB6Jm1UmcqARKS2n6Kgt7VF5D4KpIpEXziywv/
         HWkPmXagBRyU0qiwxMSjSVBHijjYRBiqZPZ1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyszvu/uUvUultdr5LryrAA3EmGp70fEi+2Bwj0O3p4=;
        b=Be70vImJm2dX72TZig5rBnE0nP9rwgq+nCSgkDbviRvUi61xPVi1XcEjdbUxtLq7z2
         yREiOg2D/lJMbszAhWaLSC/5T435k8rKeEupF1X2Z9uPb2yVFobQ2XiFfN7gq2+NUpAq
         nQfNvKFvHVMlSl1Mbh+YblkLUx4yhfvfTU38huygWaVYLu1H1OfL3S0u7EinPcNATYMh
         4b2cn84flu9wXJgrfXVIqEVbUenk6SXCnPJ5OJ75/V2GCOZi0C2433vizceswauE5wwx
         EEfqD6kj0MHNngEBbWynKiNMxdZO92WLO/2LQVyg3rI824LEQ13bk7jarm+8ikOhIfsn
         E3Uw==
X-Gm-Message-State: AO0yUKXPnMp/1ba23vnQKhwUJ2hFtDcsvS+Cc16N7Q2CHsd9oNVgANiM
        u44HJKN+h++BZqU+syIq/UtxhQ1YNQlWRrFMlgQ=
X-Google-Smtp-Source: AK7set9ADVeRen1CQzJ1OoKorCekoUL4PnA6JMswOxmhoXd3xTKmU9R0eG9UGeGG2ZpQZH5QezJXXw==
X-Received: by 2002:a17:906:d8d8:b0:8b1:fc58:a4ad with SMTP id re24-20020a170906d8d800b008b1fc58a4admr10706710ejb.11.1679567342426;
        Thu, 23 Mar 2023 03:29:02 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906454900b008f89953b761sm8459883ejq.3.2023.03.23.03.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:29:02 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/2] monitor: Fix printing Signed Write Command
Date:   Thu, 23 Mar 2023 11:28:58 +0100
Message-Id: <20230323102858.566934-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323102858.566934-1-simon.mikuda@streamunlimited.com>
References: <20230323102858.566934-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Data field were print twice (1 time incorrectly):
> ACL Data RX: Handle 64 flags 0x02 dlen 19
      ATT: Signed Write Command (0xd2) len 14
        Handle: 0x006f Type: Vendor specific (f7debc9a-7856-3412-7856-341278563412)
          Data: 0800000087f303c224516133
          Data:
          Signature: 0800000087f303c224516133
---
 monitor/att.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index d3b82074f..18a5af05b 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -2934,13 +2934,14 @@ static void print_write(const struct l2cap_frame *frame, uint16_t handle,
 	struct gatt_handler *handler;
 
 	print_handle(frame, handle, false);
-	print_hex_field("  Data", frame->data, frame->size);
 
 	if (len > frame->size) {
 		print_text(COLOR_ERROR, "invalid size");
 		return;
 	}
 
+	print_hex_field("  Data", frame->data, len);
+
 	attr = get_attribute(frame, handle, false);
 	if (!attr)
 		return;
@@ -3105,7 +3106,6 @@ static void att_signed_write_command(const struct l2cap_frame *frame)
 	}
 
 	print_write(frame, handle, frame->size - 12);
-	print_hex_field("  Data", frame->data, frame->size - 12);
 	print_hex_field("  Signature", frame->data + frame->size - 12, 12);
 }
 
-- 
2.34.1

