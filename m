Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8141E82CC0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjI0VkR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjI0VkO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:40:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F24121
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:13 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690bd8f89baso9645658b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695850812; x=1696455612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOmbSCSuxl/iBoDJgSbUBLhFhdtVyCAjbkktwlieTt8=;
        b=Nahq3CdJHwlN506RoFSZSSVSpXHJASi+BpxBkRAsmdHJULunr0vAi8GL74OJTMz9YN
         Xlkjyvm7/cBjPZihKzF+5kvfJMOgah2s3E8msU0LxZPGHoFn4HtiXUdiGIJOxlGSU3j+
         RH61G5gJIxi7OH1qxvUhhiJAVXcyvVw6rCGahSrWQeqOFzWCKFPcxyS7a0+I/8b5p6XD
         RSmGW1JZ/oVb5sBwY4HgRe9/pZcb8gcOiVdnZtppHwLnvGXBYj1wxgb3yCp1YbrLzMcs
         V3CG3CanoNlR29ja7UraP79fS0w7vmmYsCliA7iLIFuAWcwQ43LNQQKxT4S4AgKq/1Bn
         Y4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695850812; x=1696455612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOmbSCSuxl/iBoDJgSbUBLhFhdtVyCAjbkktwlieTt8=;
        b=fvAEtBZDfyPArkohKgrxLwA+l2Jm4PmJbULMEv0zpDC0DdwX8mMnl2VvodDHUjX//f
         TWZtOW/mU5iAHZG7BUKu0qKBNvWzqnelAPZRBotsHwpDqsnM5nnv9ivWfVHRkR0TlOiB
         AstNp+jFiTPj5tYrG6y3/JtFr9Vxds2U8w84qaHl5PkBAzEYjJSpq3hUBIWGT6A6yX77
         fVdgMCX+7c7113lQ+aL7GHOAvnOJCPSzrkhmiRdyPeDU2w6ZF6INFEqkmWHgM0iDD/EW
         3CElNfHupqYM9u2TM5NHuXfLLrxSYMgedrHjqHZ4jiL2BgR7fWiXRO120/kTlzcQ617G
         hrjg==
X-Gm-Message-State: AOJu0YzbbbNZlrOBD0wdZE4erTMqkxIwuldMZB2EA57BuMu2+CL4pIpD
        x0eVewzdRRGaKdBUUKVClRu7W+vPl7pRHZ2K
X-Google-Smtp-Source: AGHT+IGLGT1SmlNfKcvKrMbN0Jcy87BXuzMjBksp9QnhR3aglI8EsCVoWrToEIikDrS4L57lACab9Q==
X-Received: by 2002:a05:6a00:1a06:b0:692:b6e8:ce88 with SMTP id g6-20020a056a001a0600b00692b6e8ce88mr3229396pfv.17.1695850811828;
        Wed, 27 Sep 2023 14:40:11 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00672ea40b8a9sm12546004pfe.170.2023.09.27.14.40.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:40:10 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 03/12] client: Make transport.show to print QoS configuration
Date:   Wed, 27 Sep 2023 14:39:54 -0700
Message-ID: <20230927214003.1873224-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927214003.1873224-1-luiz.dentz@gmail.com>
References: <20230927214003.1873224-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes transport.show to print QoS configuration since it is now a
single property:

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
index fdc27c281ed8..d72ad6a5da01 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3799,11 +3799,7 @@ static void cmd_show_transport(int argc, char *argv[])
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

