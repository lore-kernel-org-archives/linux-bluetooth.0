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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC56C4360C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6032084B
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lGdSiXeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfJFP3T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 11:29:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:37957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfJFP3S (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 11:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570375738;
        bh=/ScWQbBAyXuNKzjoeYet94tK8hr90mgTZg1PlOrDDcw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lGdSiXeXnx05AcjF9FMoJ56Mi3xkP3i5CnjRD3vI6pAb475U2vcx9Vk8EiLGC6frp
         ebL2WcBtRC7OEq1VxhSoe43S94NtDZRpd8oElYHcm5lxxnGQ9GTVjftEV+mRqhj3uy
         /LNnnjc2C9GFPNjvEy1Xcmxvwqd/q7LU23E0l9/o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.116]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MkYXm-1hpG1X3Mxa-00m7K4; Sun, 06 Oct 2019 17:28:57 +0200
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
Subject: [PATCH V4 03/10] ARM: dts: bcm283x: Remove brcm,bcm2835-pl011 compatible
Date:   Sun,  6 Oct 2019 17:28:21 +0200
Message-Id: <1570375708-26965-4-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:/zzvIW/HC4W+22ZxJXt2jd0PXF2oBqFI9Z/YdHJ6fAgP3DEamAL
 etDsm+3ZLBzk/bWktyG2CCSToz96TPhTYNfvL7qUMJbn4M78+Zf9R7CmfAmAnInf+iYyKf6
 QDfXOxG+Zjbs0R2MNRs5IDQG3mmJ7O1DmMZI7id5X3LvppRGenJHUhwj3zRfKnZiqn4HlZ1
 uoy0GZ0g5N2jTM0raklnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5cwYUFPMH/k=:9xAVsgzFqpsvBMT3K9weAj
 3IpEWhFCTij5KtUp+zjBmo6OCZjOwHupUOJ6f9b5vDXV6FvFod2CRsWi/i1vzhxfFazA+B/g9
 zFz/zeOUGLQ5/4FDGHUuwwNUOEh+pxqSyKmHrRXdSn1Ic3rV7yOiFUAaf9ubnYg1CWgp9jnVL
 zUv9TmqSWpQfJgDuPc7mOT6QIG77Lvdpuox4m/DAdqQUw/NPSgYJ6eOfZ+ywXeL0ia9PoMOOB
 xcOvf6hrSVPX7G/n56zsKSpsLGW8SD/Lkht+1zrKSwL1tUTd3FqUXfT21PNdzI6dxvf2Dxsel
 Tcf86iyJtLOnbOFUZRkmXsvXEzPddRA321PAK9c4mwd7C71XyphfyuYUNMFn1t0MNoo9XbpiA
 jDSxa0vwqDBhwncaGhJFcBpTs5oPlJmFuz3IGsRQI77c25NmJLTRdN9/6cc63hWE/ZxnK9XEq
 6e3SS2K04XZgDUMnYVPG2El3n8SDMNMroEbiHsBNvxx9p7qYQX26+vLXBRXWBP8W7ouXLphnY
 IwmcDIAdtv4b6Mt0S3qJBKclG6AhZM5u6nEG4sYpipWtr9bqCPCCBv4eGScUZZw22J783ZpXC
 6J7lyRZpLLUGs41nvH1LsdLtceFQhu1LB6oETSa7DwWG7Yy/2ZaGjOnJAPWwG+Ogv0tnhCEmt
 qnDnY1n4hmE53A4EX7EfFEvqwVrygjm/kq1DwUbZSv0zixA/TxU57uZzx9lCihoaFMm2wJ1zV
 igTeuPUt5As3ENrrEaWm0IYC33FRYupOZ5zBAKz8MM4Y8VArWzed/ifKUrmyH6Phemx5mjTeb
 9PR0D4XawNKYsrwVppy4m9X1jV+pOIIFkQlrX+BmxZCk4geekWoxxZpPfNhB5IiueezKrfUX8
 krFleZqIxmZcCIECJSvLr91aJOvmmH2MoYsb2W7FWLIRNx0Lu3IXuDxEtuYQI98xKRPtPs5qp
 /HC85BG7fpVp8tkkqLGpeZtp4BMlREr6MagO0CtW/5LMSh5qFOf2f6aoEhaHXafcTWy4Y+bf7
 Mtn9nbP0zBc5Kzl2ydOyBHfVy4SJlClHCMjjL6cQ6H3/vR1DYwiIam1Ujc1g1CzfpUg5fH5VV
 j3ZEpn8mKtixipncktXPy0Bv8Hf2UFVOLwA4bBDp/BvYPH+Hz+xhhh3Fb4BpYcWz0f1j7AZXN
 73prhErVUputtf6fnJlEmxdkYnsOvONemXkTq33E2i7l2hgCyA/1EaTKJI+oe3fahKeZgjbGK
 Gv/ymbi9JQQXyteBeSBoqLNgEV0Rt913NfSgy7A==
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The downstream compatible brcm,bcm2835-pl011 hasn't been upstreamed yet.
So remove it.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 arch/arm/boot/dts/bcm283x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dt=
si
index f16899d..ae8296f 100644
=2D-- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -396,7 +396,7 @@
 		};

 		uart0: serial@7e201000 {
-			compatible =3D "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
+			compatible =3D "arm,pl011", "arm,primecell";
 			reg =3D <0x7e201000 0x200>;
 			interrupts =3D <2 25>;
 			clocks =3D <&clocks BCM2835_CLOCK_UART>,
=2D-
2.7.4

