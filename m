Return-Path: <SRS0=Uexg=X7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ECEC10F14
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32E620835
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="V5Apv0Zn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfJFP3Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 11:29:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:59103 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJFP3P (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 11:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570375739;
        bh=+Ntvzuy36h2lYmk3C1RzynnKi0efDfFW+hXy3gSJNSU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=V5Apv0ZnVeB+Z0U62pHHjUH0/QBc8NjkVjwqXAA3oP7rk/6xcZSFgNqrj1vedMT4x
         tjuGaUuVxED1ELO8a3X5eg3rX5Q/TtmLPrCqTKAYNEDrV6hfbFTdJHW4D5ZPo7Ees1
         U+M0SEr6uN+Bj/JlGEGvKh8pKbPUKvzs0g6d67+0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.116]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MqJqN-1hmFsf41aN-00nSlR; Sun, 06 Oct 2019 17:28:59 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V4 05/10] dt-bindings: arm: Convert BCM2835 board/soc bindings to json-schema
Date:   Sun,  6 Oct 2019 17:28:23 +0200
Message-Id: <1570375708-26965-6-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:YtuTyqhExdNFIyIWtVu7QQoaNm/leC/Kp3ybCICd0REnOs2Fdq4
 Sth3OQYqsSySzS0lhEiuIDbiCS2hm4Avy2AqfyTeIB4GZdS5AaHD9LLfwnyKbMfwUjjkQ5n
 OsTShr9FlhbLyzRPMAYvCX/ZqT8n7HJeC6nd3wcugImFENoko90NBzTN1hEE12o4uBfS3vV
 jaYO+FG4aWx3ye7AM/vKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YzL94UnfrVs=:9XH3OE9kOQvnndYTT1NWxV
 9PVv6VqPNc7cbAvi/qXtKMIUQ5G6X9+L5aNY51myG6b20osLy66zaN0z5j67qZZgfhYZGSp+A
 rDaVBzqSsYSn5coGfEuWq11GJqXnsGneDAlUaKBQj4k5UxAV8/jGYStExPAXdr3M225lIBU45
 VPCJnSvOLPhyD5+a9YLuJBLoUGSxDG4VgmlFkwHIRtcQ1sJEfBRzGWBYsCCDc08+IWV/0D9u1
 fRxQDWS8/WQ09wU14N/6i807estmgnTrpGOL0Z2fNU1HC37xE9vinQtrMCCWCGwjdKPJCwscm
 +lBeGezAO7TZkMHZj+67abB6vpB+Z8Ra/j0f2KyqpxSRJoLhA0+sOEJQhELOPZL8Js3ujgMkn
 JXSbJuAhGrKQODzW3WoaUsLXnORbWGJQzazuQd6o7JTtySnnd9uhR1Wkq/SBuKQ1wXOL34VvM
 ReP5tcv4Zdtah2QrNI4yjpHNNTQGkMOVBwXovf7igrxQ6M9w38LabdLUW/B+9dfxisXKdiOFM
 fJg2P3jMMlo7SHo9fXeIGA6PW3VLuJYPbIg/gQIam0He3GJx6taNCXwOcv0djcIx8/szl4XSv
 BUa39+umcw2W0MerzCtIv8l1G0pVBQIUn/JbIb0rkxklcddcBYxzQTjRaE8jymwL8xUroyMHm
 mNlURIN1rZm3m4wfRt8OubSiKlDEByprr/gjuA/nJAxiljpu1VOLERF1TNRo1FLkAXrgOD1SF
 4e7urSErBJOwvdeD9C3ytSmmUeN6gaKxmkR9+Xj7IkVdsjnah3zLgPX2MuPkIB3N6fTdp/CP3
 0qIpxMDxiAe3ZFgIYIdaj7kd3CeskAdhF6YgMBM1EajCB8kVroUhNwA6fPEgY40VgU+mApRgQ
 q7kdFyBhMyvuoJA96QEKa7TJVbP4TrreE9xmBi77dozgZfSOP+be46s1xu+xDzjcKEsbUhDwX
 TfXqLOtHjsCN6CudGSpEHWTZCvFqA/+2iXKF55VeXWaG7fF2xmD5HBxK/eHmsT/82X4FL3GQD
 CnMOFxz3p4PlkVqK7ExdtETfr9RIpzEPcJC65uZEdMIIv75W1dVZvLcLF3hoSVXaubwzjnw/y
 Iep1hHQAONCfKCj9UZmFWVai4yTRHI0IDJh/ae3I+4ibRVquT9yA/Qnl0mxbV6QbemKbiP0hy
 4q2iNQV2+bd6MGMI35ZqCHOR1R6PTFgAl4ve41nCRR/nQVpTQWjXiK3siTuenL42Nthfc436h
 Su8Dqg3Hhaoshus3GmV9gOpmf6iYtXytcfADqFg==
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Convert the BCM2835/6/7 SoC bindings to DT schema format using json-schema=
.
All the other Broadcom boards are maintained by Florian Fainelli.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Rob Herring <robh@kernel.org>
=2D--
 .../devicetree/bindings/arm/bcm/bcm2835.yaml       | 48 ++++++++++++++++
 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   | 67 -----------------=
-----
 2 files changed, 48 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835=
.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml b/Docu=
mentation/devicetree/bindings/arm/bcm/bcm2835.yaml
new file mode 100644
index 0000000..67bf9e2
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/bcm2835.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2711/BCM2835 Platforms Device Tree Bindings
+
+maintainers:
+  - Eric Anholt <eric@anholt.net>
+  - Stefan Wahren <wahrenst@gmx.net>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: BCM2835 based Boards
+        items:
+          - enum:
+              - raspberrypi,model-a
+              - raspberrypi,model-a-plus
+              - raspberrypi,model-b
+              - raspberrypi,model-b-i2c0  # Raspberry Pi Model B (no P5)
+              - raspberrypi,model-b-rev2
+              - raspberrypi,model-b-plus
+              - raspberrypi,compute-module
+              - raspberrypi,model-zero
+              - raspberrypi,model-zero-w
+          - const: brcm,bcm2835
+
+      - description: BCM2836 based Boards
+        items:
+          - enum:
+              - raspberrypi,2-model-b
+          - const: brcm,bcm2836
+
+      - description: BCM2837 based Boards
+        items:
+          - enum:
+              - raspberrypi,3-model-a-plus
+              - raspberrypi,3-model-b
+              - raspberrypi,3-model-b-plus
+              - raspberrypi,3-compute-module
+              - raspberrypi,3-compute-module-lite
+          - const: brcm,bcm2837
+
+...
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt b/=
Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
deleted file mode 100644
index 245328f..0000000
=2D-- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-Broadcom BCM2835 device tree bindings
=2D-------------------------------------------
-
-Raspberry Pi Model A
-Required root node properties:
-compatible =3D "raspberrypi,model-a", "brcm,bcm2835";
-
-Raspberry Pi Model A+
-Required root node properties:
-compatible =3D "raspberrypi,model-a-plus", "brcm,bcm2835";
-
-Raspberry Pi Model B
-Required root node properties:
-compatible =3D "raspberrypi,model-b", "brcm,bcm2835";
-
-Raspberry Pi Model B (no P5)
-early model B with I2C0 rather than I2C1 routed to the expansion header
-Required root node properties:
-compatible =3D "raspberrypi,model-b-i2c0", "brcm,bcm2835";
-
-Raspberry Pi Model B rev2
-Required root node properties:
-compatible =3D "raspberrypi,model-b-rev2", "brcm,bcm2835";
-
-Raspberry Pi Model B+
-Required root node properties:
-compatible =3D "raspberrypi,model-b-plus", "brcm,bcm2835";
-
-Raspberry Pi 2 Model B
-Required root node properties:
-compatible =3D "raspberrypi,2-model-b", "brcm,bcm2836";
-
-Raspberry Pi 3 Model A+
-Required root node properties:
-compatible =3D "raspberrypi,3-model-a-plus", "brcm,bcm2837";
-
-Raspberry Pi 3 Model B
-Required root node properties:
-compatible =3D "raspberrypi,3-model-b", "brcm,bcm2837";
-
-Raspberry Pi 3 Model B+
-Required root node properties:
-compatible =3D "raspberrypi,3-model-b-plus", "brcm,bcm2837";
-
-Raspberry Pi Compute Module
-Required root node properties:
-compatible =3D "raspberrypi,compute-module", "brcm,bcm2835";
-
-Raspberry Pi Compute Module 3
-Required root node properties:
-compatible =3D "raspberrypi,3-compute-module", "brcm,bcm2837";
-
-Raspberry Pi Compute Module 3 Lite
-Required root node properties:
-compatible =3D "raspberrypi,3-compute-module-lite", "brcm,bcm2837";
-
-Raspberry Pi Zero
-Required root node properties:
-compatible =3D "raspberrypi,model-zero", "brcm,bcm2835";
-
-Raspberry Pi Zero W
-Required root node properties:
-compatible =3D "raspberrypi,model-zero-w", "brcm,bcm2835";
-
-Generic BCM2835 board
-Required root node properties:
-compatible =3D "brcm,bcm2835";
=2D-
2.7.4

