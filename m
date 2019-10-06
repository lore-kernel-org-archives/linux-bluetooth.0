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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C25CC4360C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AE5214D9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hAJsRPyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfJFP3P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 11:29:15 -0400
Received: from mout.gmx.net ([212.227.17.21]:41535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfJFP3O (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 11:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570375737;
        bh=Uiusfd++iO6W8WtYRF60ANQDODpBG+UQSmFz88xtJgk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hAJsRPygpz5yPJxWUAzlPKY8+matr0x7fsIjsmkXPg8wz97u2ol9vKp/9MWEHshpn
         sDrUJYE6N/SGya6tlaROjUmUWdR1MXEAS4E19A/ZZncuxhfE43UNDh7dtM4KJon0kp
         yHMMfFr85KdXCjXbocomutVGquJIgQc8JCGvK8vw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.116]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mg6Zq-1hc2cB10Aw-00hfKa; Sun, 06 Oct 2019 17:28:57 +0200
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
Subject: [PATCH V4 02/10] ARM: dts: bcm283x: Remove simple-bus from fixed clocks
Date:   Sun,  6 Oct 2019 17:28:20 +0200
Message-Id: <1570375708-26965-3-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:i+h4gvRfF9vHSRzrDVG9tj8BWytU3V7SOKB7jSlFNNT5OZnTdf7
 zwcxT0kJKG6dK1uSFnDU+1PJ7uYF+10rUxWvssuotj32NMbuslu5fe0Y/XEZSbXXeubmRqz
 rmlCHfNnBnZR7Js398llpq1oPS5KKwKSmp7TAy4TptEdM8nyGHD4svOi7jP/z55k0c5Vxj3
 4i9oDDVNso6y/PExitqsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qHIs3v19TaA=:uuLAVFU7rYjRbXHJzsYs5S
 liQTvF/wRD4kP3xO78s+ggITe7VaGMFOoaLDZjmU2kGptd7RVy/GovKC41JevdOJirYfLE7L3
 xgRds8qqK3gVSpV21/kaREDJuPIECuqavMgtm6sr7PXYb4c/BwytDVhMOz4x3aX9/44zO8dZ0
 VKEZtIUydQbFvCq+ZhzQN2r4tf34cnY1Yv0AZdy/Hf5yuxFro73Dot7WZB0LGyORENx9a4TB3
 v6EXdmA1YECKdwNS4Sz0SpVEhnCHhE/gBGCKspR5OFSoDB09tyI+VVbkO4ZGFgdrZDRs2WsaN
 ncs9Hpl4HFfHrRHk0mSMosfJ8VAIMeOST3i22d7n5qUad9wiNoxsd4p1W4lIeQsZHed40D2fi
 uh2b2wUsjc+u0LucruIH1eoHow/qSe49f+GlJE5vj9FsIxDte3MNYK4gWatbdHf5xMUl98+Eh
 DP/YiQp2LbhGBYvLnNoy/+/GIcwZneocE++tTAXb6MzwPVpIpW8jTxTa45cKKkwoEM/s7xhY+
 fqond8zdtib0lhkGzj6cAi8ynWNZCcIVZWgMfNA9h3uqsbPR/Td6SPJTrDbNwLAI4ixMZ8OQm
 F6OPKX50h16JBBayhb+wxCykybN42G9M4Z2pLDJprl77XNsEKC2g2qUUNDjkBbpVKrWnfbTkb
 BpWzDret0jbgiOMA4jUyEu/lcnhIMxf35enTCUTpcqmxDEC8G3EOmjgj/QHjwtGFsdhCDErqp
 ULlcgzhpeG3pHdDaiudy0Ez/P3s3bYeTEiuqb1LVbyxXmGG7d2s42UQId6q2rSY6Rj8uKWYBi
 +QiYY91Yo0/MNBDIUxVg9IEUGsDg8PHle27hfl5xiNfzt04azjO67f4T79+TlPJ5aS0FM+14k
 rqozmsu+1H/ymPrtK/yATVPB24z2I2ypR1B/o7eJDHDSe1znh+djpQYI0j4ulqfr8SMTM4zsR
 SbFVAh7C0K3bk2l1Nn7Fz18QFQrDkR85uA4uaFC4/Oe740VpfMDFpxMrTBfIrLySQaU9AlDYd
 cFXYsfZGaPtEqmZ4TehGwhvAz4nWMT5Ffu3vuQkWOk3ratwMGyT9iLgrlc0hYiah+/x7mDNRw
 ITSaaKFSX4EGnfBef7Fmb5Ws5//z3S8DLu4gXI5Yerqda57U4QETgfGznFu2BVi6CMuYxlGSB
 vVaHdVQ6O5APEM6iNMcYPWvX8G3P6gazxmVVQjuo74MrpNYVK/I+1HIANz4dFudE5hu27qYcj
 Rgnyj1ZLMJkQX2jEdR7BwLt84F0vQWu6KiGjp1g==
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The fixed clocks doesn't form some kind of bus. So let's remove it.
This fixes the follow DT schema warnings:

clocks: clock@3:reg:0: [3] is too short
clocks: clock@4:reg:0: [4] is too short
clocks: $nodename:0: 'clocks' does not match '^(bus|soc|axi|ahb|apb)(@[0-9=
a-f]+)?$'
clocks: #size-cells:0:0: 0 is not one of [1, 2]
clocks: 'ranges' is a required property
clock@3: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
clock@4: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 arch/arm/boot/dts/bcm283x.dtsi | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dt=
si
index 2d191fc..f16899d 100644
=2D-- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -650,22 +650,16 @@
 	};

 	clocks {
-		compatible =3D "simple-bus";
-		#address-cells =3D <1>;
-		#size-cells =3D <0>;
-
 		/* The oscillator is the root of the clock tree. */
-		clk_osc: clock@3 {
+		clk_osc: clk-osc {
 			compatible =3D "fixed-clock";
-			reg =3D <3>;
 			#clock-cells =3D <0>;
 			clock-output-names =3D "osc";
 			clock-frequency =3D <19200000>;
 		};

-		clk_usb: clock@4 {
+		clk_usb: clk-usb {
 			compatible =3D "fixed-clock";
-			reg =3D <4>;
 			#clock-cells =3D <0>;
 			clock-output-names =3D "otg";
 			clock-frequency =3D <480000000>;
=2D-
2.7.4

