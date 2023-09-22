Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF30CD4854
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Sep 2023 19:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjIVTXu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjIVTXt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Sep 2023 15:23:49 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65622AC
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Sep 2023 12:23:43 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34fd889f69aso8516665ab.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Sep 2023 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695410622; x=1696015422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21P4t/bCjC0CF3b0Rdmk1oY+T75CEBIb/YD8L5fymtQ=;
        b=jVN8WCnlgKszxp6qsWNgyS1loaCcDzjY+Wznxo/bL84HaKH+/MdNyDc0qKlPTV6YgC
         p0aWoIag8NSF57bUuDewL6prryWvOaZBa8rs74HhiAA7wRCIzzFnXRFe12g23sRcPAFL
         6C2THlDBWqRRTvOSUq4ShhvceLBNOWTJ2aDqvyvC+d/l2VeVkXoXZukchM4F/8JyFMEc
         UcwHwkTkcz9yd31nQBb/k1UVzhvGPelvVEsh4V0y+6YgL3rwcdW583tBbzdrZe6EdqO3
         gLTdIb/T2voyv98P/X3dcCsrMCmRBzXDSSsbjfuKm5ZolIk5e/NFkD6PECnitwmAS7rj
         4XvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695410622; x=1696015422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21P4t/bCjC0CF3b0Rdmk1oY+T75CEBIb/YD8L5fymtQ=;
        b=Ovt2tuXw1OKCEm7fHsF3INDk9atCFHKzw3HmSWD0whe1oI76llKwqTbsTvCp6ltIPG
         WYAHdiffh/f9c7Ta+KSRQSUHrkD7MkwhWOuqaPsXzva0SJIqXMWdxtMnZ5geP2Ebt6Go
         8iHHxUEzrHAicwcx41hRevdarF99dGwvDcNn0nRUZQv8spo6dzRtsvf3W0JhLOX6tiOU
         nssQD1J1oJulmdy/XSr5ghuufv8WGxUTZEVFU/+w+aliJI/4lyZVFarvBdHBuq2usnxv
         qKf+wP7DYBS19IMoOMspFCQ0ICt4GEPgIbgx6w+FRxyIlte5nJH35BY6D7H4uYYYE15W
         iDeQ==
X-Gm-Message-State: AOJu0YwfQz/mlxAKXQgp27TOod2x58jAS591YYV+PbfQaVOjUhf+ko4q
        j6jPSzwRSEMiYc0M35SsPWXgqTHAW1U=
X-Google-Smtp-Source: AGHT+IGpG/a+ZJxdqFlbGQDgQ6QudiBL1Q1tCH3jzucBb0qO3WHtzP5GmcyFhTIXzXpkYQyeoiUH8g==
X-Received: by 2002:a92:c5cb:0:b0:34f:b9e8:a431 with SMTP id s11-20020a92c5cb000000b0034fb9e8a431mr490096ilt.22.1695410622020;
        Fri, 22 Sep 2023 12:23:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s5-20020a02cc85000000b0042b6a760c31sm1211519jap.28.2023.09.22.12.23.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:23:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/6] client: Make transport.show to print QoS property
Date:   Fri, 22 Sep 2023 12:23:32 -0700
Message-ID: <20230922192335.1060601-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922192335.1060601-1-luiz.dentz@gmail.com>
References: <20230922192335.1060601-1-luiz.dentz@gmail.com>
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

