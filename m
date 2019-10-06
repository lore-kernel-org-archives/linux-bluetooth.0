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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EEAECE58E
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9D920862
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ANd9bRY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfJFP3V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 11:29:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:60213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfJFP3S (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 11:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570375736;
        bh=NwItNtT+7dpX+iWyiTITnRT5WiPEzLaDE1MGjMA7YOg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ANd9bRY6nlA9CkLmoofMgDgyztlan1n14KCoNKhBQot3NXn5C9T3Xs/aldhrhy+sB
         ph736MrANE20n5UErAk8E+Z8I3yoaAyzNqcSelOgc47CDB1aW30RjkHGjwS5tfSdxz
         IMQKgRdroVp2nhp7IGW6QfAGDjktUhmvPTDZf2sk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.116]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mf078-1haw9S2rBi-00gYs0; Sun, 06 Oct 2019 17:28:56 +0200
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
Subject: [PATCH V4 01/10] bluetooth: hci_bcm: Fix RTS handling during startup
Date:   Sun,  6 Oct 2019 17:28:19 +0200
Message-Id: <1570375708-26965-2-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:ydi0+r/v2uhwbqNRG+VV3qbpvXLV3l7XeekgER9sm7enzV2hdrO
 5wzwGRlimd5NHMQ2ZXaeah2owHvMuNOS6gMPEL/m1Tofsha3vJ8PJewY+m2NyFbohzK1Pxx
 hV4aLd3Swv7fRMxG4GDfPoPwd9ltidUv3CgoXsm8B+MmIxGK+CZfZk8Szb2wdPGAoQjjaQ7
 POsnLxUr7C7oDMoUGhddw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sWyR1XuQ+bU=:uSjFzauqsT7GRwxIA2dY/o
 6NteiLKcsUR0I7nVwpTn+guJ29HUKzrYwoeZcgMThT/xN7ZxRQVAzQBIMLhNjermHUNcPrhhz
 s+jd1HVhUdsF/Ln3VSBwtgQIM9mjuaQIyEqBR+bV/Dmuz0hdsCijtac+v466mXOpXry0Tb9HH
 AjF/V+/cWobpu/l6O6m0zGtzRydzxS9I1YlhSUCBLH2lm9xjAcD9jYwiVFEPp8v+5lW5e4OI0
 ba6of7pZ29qPT+Ped3cjWC6aYQ+lPILCbQwyFBp9c+B61Bxen1p3lrcpw5ayGqbYzBcCzNorB
 9ELOhpPnRgiDDeUn9/fztrOm1CSHZfdDyhuapNa/fGESucTv/8hZfMyf4gnkAxbo6CMv15Z7M
 YfEzsVECKTmnVwgiUQgoYCovQIvEeSC05IvIOscrWHfWtdvKWUqX8lNqzYl1+w/otpIv51KP8
 HQqgqG2+dAOIgiQOdji4m03FVF1ScHg9LFHCw40XUw157LtxeR8mEiWvTSwQPqSAEdeZ1vbvL
 NoD38zmBEuaXeg2+9k27ezgs1cefecJDzOB1yQhT3qiXZZkc1Gykq6zLiacFfe25CFqhq++i7
 +3UW4cfsMpdMMeBRN/ksoQhBYRtGKP5uBtN4hKbvx32Xbt31pmYtA/D+9UVvi4fUKIIQ366AE
 ViGxOQxXfB5miB+cleAbdjlFxGxKpP6t78xoZAyfGlmY+X9FXybZlIcCy1GXK8ikCIJuTcZk7
 V0IE06nEeyzjj2eSM+R6dAI39o98HXrWBX94+PZ3Mzpz3p5TOlHIQNKvMbsuOjuhzSN+cHQL8
 NCKRQWuqkxrxfXTadp+e2wapz/xpaqEroOf1HH4sRztLkDcUF7tNw3AFmw5b+RiZX4rb98P4K
 d6gSsuVfSylf4KufnJE7CnRdU6bLx2qtf2WM61PTwELtyPZ2hkZu7roWSdI7zwGpTRnZh9/Gw
 RsqreQ1QGpIrep1aYOPJLfvWx7lLhPenr9RIinGnYW3NCK9/sEPr++bdm3uigL4xRkgi4avQV
 LUintut4IeEhJICH0cAfs3A/j660AJM1b3VkR2TiXK393yjIPBZtwEaievE3igfgPt/XZT01h
 39EkQfaRJDM0MzOwm2XMx8QbgEd+EQgImNCcj6xXvzce7yO0rgQ9h1gQgJkowT2F2sUQxO3nG
 8DrfRjE+3RxHByyCmU+83AGUMxEcfhQA5vT6FCSZae4lRljDCscj1PE+08sEPemYVqoS4XohV
 xmvd2jLIm1cGIN+PnqFGdEX7/eJyVwbLtrS+8Nw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The RPi 4 uses the hardware handshake lines for CYW43455, but the chip
doesn't react to HCI requests during DT probe. The reason is the inproper
handling of the RTS line during startup. According to the startup
signaling sequence in the CYW43455 datasheet, the hosts RTS line must
be driven after BT_REG_ON and BT_HOST_WAKE.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/bluetooth/hci_bcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 7646636..0f73f6a 100644
=2D-- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -445,9 +445,11 @@ static int bcm_open(struct hci_uart *hu)

 out:
 	if (bcm->dev) {
+		hci_uart_set_flow_control(hu, true);
 		hu->init_speed =3D bcm->dev->init_speed;
 		hu->oper_speed =3D bcm->dev->oper_speed;
 		err =3D bcm_gpio_set_power(bcm->dev, true);
+		hci_uart_set_flow_control(hu, false);
 		if (err)
 			goto err_unset_hu;
 	}
=2D-
2.7.4

