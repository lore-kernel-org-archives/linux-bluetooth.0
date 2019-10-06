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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF1CECE58B
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BE3218AC
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dqiIxaTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfJFP3S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 11:29:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:44645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbfJFP3S (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 11:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570375739;
        bh=64/G+U7l4YOPgIxQpEDvRKVpp256aIf2sojAAfNasOc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dqiIxaTIzqDRObfmAZ3/di2XK9+3OEU2JonFN9ey/Laoq9Fxq/w+Srur/TtdXnQ7X
         y10p0KEzOJXYkCSMQB5O9Lc+natucVioJjmup7AAEsqEbJOaMZkriL5RbqeZNXbVz5
         2Rv+6Ws8hwLt0GMlm4cd8vA3SfGoqgJHNie0IctQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.116]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M5fIQ-1i9zqz26w6-007E7Q; Sun, 06 Oct 2019 17:28:59 +0200
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
Subject: [PATCH V4 06/10] dt-bindings: arm: bcm2835: Add Raspberry Pi 4 to DT schema
Date:   Sun,  6 Oct 2019 17:28:24 +0200
Message-Id: <1570375708-26965-7-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:4tpMAFC283UicsXToFZeNTvuWl+GxKSv5sw8It1QDxTanTbHnJk
 COfkxhnv4HIrsDOQmGmeQNt97Qo0MHKklc3acFM90R6aqWcRsGQ++2msOWgh3EfA541+2hj
 FjV3dRDOXeoKadgMsQg2FAmpxtKgx887qCpb8QJkDq4AcQT1xI7ltJpAVx9CbWXqOXdbux3
 zR3QJXFd3PnlKSJuNPlQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tJ+R1OyxgUg=:7zg9roUbN/AXkyc1NHRX6j
 6mRU1cV9Nr9/RpjcIkOlaO1xfVwxSf+Y4g4CAACLDTwvko4kWOKiHllg6ru6skg/HPYtlJuUv
 oCDCOPVIYcEi4UGVx+KfdXSjLvI3u0eZGjaQnK4BncuHJrA7L8N6p/R7PlEVT+3X6QLZzHZpM
 oteHlhQAT+RVJRI3hSEPVJPNMGbgQQUdk2wCp0jG1XYSswoS/0JjziGiERRVWti4UgrsyUzhl
 qWQhb1b2fJmkx3Rku6OMnSsImHuRztqUI326DZRKB+obslXgKQ4dY0JxGSS0WnZtYJ6w8JbXD
 9JdN2c5n52fWBDn14pKj/W+sD+/03D/NWXcR9GsNU+XEzmFx9pFZKxTV/4a65vTEgRg8Xi7ZY
 ea7TWlPwYXX6R0JbGsm9tKzfBBN2fYK66ThixOoRjpd0yZGtM+w1oWF8JXdi9Gdwasm91br8a
 Y6n7lIdVF8wK/c0z/NxuNV7JssNE/pc9cb3c987tZluEY33slN1lFdisWTxfGHE529IWdvZ3y
 pt/QvRgMGYSuvPdjoIWKFzADbbfWEuQQQXFuOUi5Gol2Bc7PDAtP812kpXMqa4LO8extUAqAJ
 bf2eeQKvEzvit0UHOFTP9IInB1xlmBd1mbME+m8wUBNHFy++NKaK2gtkt8tUQAl/HkYw89X4l
 sP4g+UwGfLMlv2heGbVR6uKqeieLrV3b+jN2eQeLfbbum6C0q6eF5eKoMwXRHqFBzFJgkErBo
 ATQfwftGGZ6U4m1/KcUf3v8rRzNn+X5KLuXGVnC7iNtladPQpkxCJSD9bto+u6P4iO1g5Qrjz
 KEJLraZX7ns0QDn79am7dA7O4jHxU4hefcgw0a8B0TT9vMKqOclLwKkYlA5yJsmKrZBvmovJs
 Ri+u7YUbIw4QJrZBt2tsltoDJSlbhGZrJBW07N3npTRs2U31ghu1mgGEKDD0Wondc/+9dpuYa
 cHeN58YgKLomhzymojOQAMDoUw6npCs6dGlsobae7xJW+Rqo45AUwWhMJ05swNl+DBmvr7H21
 h9s1bsu9/i4WT4bwoub0vg16tcjGGvOqxlnp5KHd8YzFYNg0viLdJ1ptCB/q45/o2vpzdsV8h
 LIKcgm5RjRN/xqlERB5XX+Ze8JaQGP1pYviPoe5PQYcM/a8xdsWta0zyjvXKLjkoahuioUUm+
 oUyOYZ6H/VNu9ZltXWsMt280DQLMiJGliyz4gmFb7gOLNfEcs0xGPvVN+uOhl+jZLaC/usN9l
 gzzDp40ViDlZYVO/tBWsFUmno7ycCLw/MQHwhHQ==
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add new Raspberry Pi 4 to DT schema.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Rob Herring <robh@kernel.org>
=2D--
 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml b/Docu=
mentation/devicetree/bindings/arm/bcm/bcm2835.yaml
index 67bf9e2..dd52e29 100644
=2D-- a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
@@ -15,6 +15,12 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      - description: BCM2711 based Boards
+        items:
+          - enum:
+              - raspberrypi,4-model-b
+          - const: brcm,bcm2711
+
       - description: BCM2835 based Boards
         items:
           - enum:
=2D-
2.7.4

