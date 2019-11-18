Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4794BC43215
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 19:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA6122318
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 19:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YkiIf2B3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfKRTVn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:21:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34844 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfKRTVm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 14:21:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id k32so4376850pgl.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2019 11:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Vv2B0bFyN86x+8y9RduLalL/HEcvQ97xAs8bNkoqkM=;
        b=YkiIf2B3OQussUzFcXNFRTUsy45i9XgaSTRKEeUr6P68fOeMC7WfkpxokUULDn8o2Y
         81WOgLDOTfUaFb6KqpTEMkvOWWLjm7RxsR9FyMH0oORnxLI0mbe0ud+HZYRMVNMlrq0a
         3Stutl0NThC6s6axuW2y0b08o+LRLu/Jqkoic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Vv2B0bFyN86x+8y9RduLalL/HEcvQ97xAs8bNkoqkM=;
        b=Bu5p58md+Q2CkFF2jJz1n4232Vl/gcGJKAEvL8zERM8oGqMH7dt7sqbgzZu39ctcBk
         9Bdb6DcMmjfaiUnL11vqWV7UQdS4auTurZUEH8NXq3VbOSHbQv+22KXgShubwjU9/b4x
         6EIgDAFFTPE3KuS6QxTcIXHTmDHQfqh8jcxGg4xzBELo3cXkFdIEbKvQe6of7coUPkHI
         nYsGFsaFnv7og6IbfjKI9sYPaD4YOkBS4SV5Bec2sgf3URaruxBphuJ4gNkbxmIyhNIA
         MjCkR/KTSFrah34eWgYxXRw1ZLC7mrjJ/jF05Fjl315ANzxZUPrQp7Tb/nd/HVooYpng
         Qy3A==
X-Gm-Message-State: APjAAAXaClrpk61BsaK0eCpUmDUkg1bc6D3YU6NlYfCc5JTbfP9r0Qha
        qaBa+XOqHp+2qebqzoSZcCslqQ==
X-Google-Smtp-Source: APXvYqyftvKH1fK0ACjlvyP+upMLpK/ORTLYCjxK+/XeKb32FV0IOsarIrAKdQQe9sSFMBw9Hv91cA==
X-Received: by 2002:aa7:9533:: with SMTP id c19mr919367pfp.77.1574104901053;
        Mon, 18 Nov 2019 11:21:41 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id p123sm22772633pfg.30.2019.11.18.11.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 11:21:39 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v6 3/4] dt-bindings: net: broadcom-bluetooth: Add pcm config
Date:   Mon, 18 Nov 2019 11:21:22 -0800
Message-Id: <20191118110335.v6.3.I18b06235e381accea1c73aa2f9db358645d9f201@changeid>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191118192123.82430-1-abhishekpandit@chromium.org>
References: <20191118192123.82430-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add documentation for pcm parameters.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 .../bindings/net/broadcom-bluetooth.txt       | 16 ++++++++++
 include/dt-bindings/bluetooth/brcm.h          | 32 +++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 include/dt-bindings/bluetooth/brcm.h

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index c749dc297624..8561e4684378 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -29,10 +29,20 @@ Optional properties:
    - "lpo": external low power 32.768 kHz clock
  - vbat-supply: phandle to regulator supply for VBAT
  - vddio-supply: phandle to regulator supply for VDDIO
+ - brcm,bt-sco-routing: PCM, Transport, Codec, I2S
+ - brcm,bt-pcm-interface-rate: 128KBps, 256KBps, 512KBps, 1024KBps, 2048KBps
+ - brcm,bt-pcm-frame-type: short, long
+ - brcm,bt-pcm-sync-mode: slave, master
+ - brcm,bt-pcm-clock-mode: slave, master
 
+See include/dt-bindings/bluetooth/brcm.h for SCO/PCM parameters. The default
+value for all these values are 0 (except for brcm,bt-sco-routing which requires
+a value) if you choose to leave it out.
 
 Example:
 
+#include <dt-bindings/bluetooth/brcm.h>
+
 &uart2 {
        pinctrl-names = "default";
        pinctrl-0 = <&uart2_pins>;
@@ -40,5 +50,11 @@ Example:
        bluetooth {
                compatible = "brcm,bcm43438-bt";
                max-speed = <921600>;
+
+               brcm,bt-sco-routing        = <BRCM_SCO_ROUTING_TRANSPORT>;
+               brcm,bt-pcm-interface-rate = <BRCM_PCM_IF_RATE_512KBPS>;
+               brcm,bt-pcm-frame-type     = <BRCM_PCM_FRAME_TYPE_SHORT>;
+               brcm,bt-pcm-sync-mode      = <BRCM_PCM_SYNC_MODE_MASTER>;
+               brcm,bt-pcm-clock-mode     = <BRCM_PCM_CLOCK_MODE_MASTER>;
        };
 };
diff --git a/include/dt-bindings/bluetooth/brcm.h b/include/dt-bindings/bluetooth/brcm.h
new file mode 100644
index 000000000000..8b86f90d7dd2
--- /dev/null
+++ b/include/dt-bindings/bluetooth/brcm.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * This header provides constants for Broadcom bluetooth dt-bindings.
+ */
+#ifndef _DT_BINDINGS_BLUETOOTH_BRCM_H
+#define _DT_BINDINGS_BLUETOOTH_BRCM_H
+
+#define BRCM_BT_SCO_ROUTING_PCM			0
+#define BRCM_BT_SCO_ROUTING_TRANSPORT		1
+#define BRCM_BT_SCO_ROUTING_CODEC		2
+#define BRCM_BT_SCO_ROUTING_I2S			3
+
+/* Default is 128KBPs */
+#define BRCM_BT_PCM_INTERFACE_RATE_128KBPS	0
+#define BRCM_BT_PCM_INTERFACE_RATE_256KBPS	1
+#define BRCM_BT_PCM_INTERFACE_RATE_512KBPS	2
+#define BRCM_BT_PCM_INTERFACE_RATE_1024KBPS	3
+#define BRCM_BT_PCM_INTERFACE_RATE_2048KBPS	4
+
+/* Default should be short */
+#define BRCM_BT_PCM_FRAME_TYPE_SHORT		0
+#define BRCM_BT_PCM_FRAME_TYPE_LONG		1
+
+/* Default should be master */
+#define BRCM_BT_PCM_SYNC_MODE_SLAVE		0
+#define BRCM_BT_PCM_SYNC_MODE_MASTER		1
+
+/* Default should be master */
+#define BRCM_BT_PCM_CLOCK_MODE_SLAVE		0
+#define BRCM_BT_PCM_CLOCK_MODE_MASTER		1
+
+#endif /* _DT_BINDINGS_BLUETOOTH_BRCM_H */
-- 
2.24.0.432.g9d3f5f5b63-goog

