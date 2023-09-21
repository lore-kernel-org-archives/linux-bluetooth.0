Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0798E7D0B6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Sep 2023 23:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjIUXrx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Sep 2023 19:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjIUXrw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Sep 2023 19:47:52 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F89F7
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Sep 2023 16:47:46 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bf298ef1f5so975418a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Sep 2023 16:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695340065; x=1695944865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ya3nPyfjusocvVhqck2xI39alx8UBJWfktx7B8iYr8c=;
        b=Ih3yF2xVdNegimAoIaCaP22HpZl9MWPhiUSonEXOSDVW6AuqrmZXZ40ZZOfhJ5e38c
         uajl6Y/LMOb+NkLcmUsh2xzrBwhmzYc1G3Ez7i19rtP/PNa5iLlbD9qWlBr1EbIbl7lK
         x8eRgi4yq+oo7nc439r+z3SHrSRhx/SdyPv0PUcLLOvX+B5RXGst9mbiTHtO27WBgRxw
         4vnGdXs51FHjDtXirpmFW0cq5KIjzdrSGjoIRM/aBqNFWjUwlb7BjxJ937F03Rlp8A9F
         t1qq2I+AbB/YS3XflQ121DEfcrGYxgA+DMiYknuFaA81KFmLrbReknO90yr3lpZ+u3+R
         yH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695340065; x=1695944865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ya3nPyfjusocvVhqck2xI39alx8UBJWfktx7B8iYr8c=;
        b=lXeuYB8MTOV1Np/Jop0xxoDAsqRTGZG538KH2hd4dZHZZViPyuuR/jFkbM0j3Zy/XV
         mH8p6BD0qAR8XNIqPnJAAs2U4e3HgpsJIg4auMlAHYXatJXX0ViYap8xAX/WQc7sAe1T
         PZ/Q4JJtg50AmMebG87+psMrIoCmRzf85lxa4vJ5Wu/4T5TW1Y4Y3HvNY1KkEbUSSve3
         0Cn3XQ3xJBeUtBo2ir+EMw0Lq+9BFKnef2N/A5OCofvGadVbPN6HZsYuYD2gk/Kfdw+6
         n+jiPTNS5lMULuwbxWC11L257/MhsRtxS8x8IHrM3kUxfq8uNM4HP7OAmACJZxjRQjE7
         qokw==
X-Gm-Message-State: AOJu0YwFPhhPzKMKXeDjgtSKl9ivHlvKO6kFW9H/+wnhgV1WGEwMd2bw
        5Xhg/tTucB5MANOFgn0RnY+CJqPMxkk=
X-Google-Smtp-Source: AGHT+IGc/LLGFpdjuGaUIbLIRBMCOW9aTZFnVsR1rHkGPzpzYGGFg531k0uTaF4PFFT/7G3WsXCNVg==
X-Received: by 2002:a9d:6d8e:0:b0:6b9:9de6:2cc with SMTP id x14-20020a9d6d8e000000b006b99de602ccmr6126864otp.25.1695340064942;
        Thu, 21 Sep 2023 16:47:44 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id d18-20020aa78692000000b00690fb385ea9sm1959824pfo.47.2023.09.21.16.47.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 16:47:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] client: Make transport.show to print QoS property
Date:   Thu, 21 Sep 2023 16:47:36 -0700
Message-ID: <20230921234738.929423-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921234738.929423-1-luiz.dentz@gmail.com>
References: <20230921234738.929423-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes transport.show to print QoS property since it is now a single
property:

transport.show <transport>
Transport /org/bluez/hci0/dev_00_AA_01_01_00_03/pac_sink0/fd1
	UUID: 00002bcb-0000-1000-8000-00805f9b34fb
	Codec: 0x06 (6)
	Configuration:
  02 01 03 02 02 01 03 04 28 00                    ........(.
	Device: /org/bluez/hci0/dev_00_AA_01_01_00_03
	State: idle
	Endpoint: /org/bluez/hci0/dev_00_AA_01_01_00_03/pac_sink0
	QoS Key: CIG
	QoS Value: 0x00 (0)
	QoS Key: CIS
	QoS Value: 0x00 (0)
	QoS Key: Framing
	QoS Value: 0x00 (0)
	QoS Key: PresentationDelay
	QoS Value: 0x00009c40 (40000)
	QoS Key: Interval
	QoS Value: 0x00002710 (10000)
	QoS Key: Latency
	QoS Value: 0x000a (10)
	QoS Key: SDU
	QoS Value: 0x0028 (40)
	QoS Key: PHY
	QoS Value: 0x02 (2)
	QoS Key: Retransmissions
	QoS Value: 0x02 (2)
	Location: 0x00000003 (3)
	Links: /org/bluez/hci0/dev_00_AA_01_01_00_03/pac_source0/fd0
---
 client/player.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/client/player.c b/client/player.c
index ac8493d3cb0b..77fdf9691733 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3916,11 +3916,7 @@ static void cmd_show_transport(int argc, char *argv[])
 	print_property(proxy, "Volume");
 	print_property(proxy, "Endpoint");
 
-	print_property(proxy, "Interval");
-	print_property(proxy, "Framing");
-	print_property(proxy, "SDU");
-	print_property(proxy, "Retransmissions");
-	print_property(proxy, "Latency");
+	print_property(proxy, "QoS");
 	print_property(proxy, "Location");
 	print_property(proxy, "Metadata");
 	print_property(proxy, "Links");
-- 
2.41.0

