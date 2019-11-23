Return-Path: <SRS0=47vR=ZP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423A5C432C0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Nov 2019 20:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB9C20672
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Nov 2019 20:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Qw9jCj6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKWUtv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:49:51 -0500
Received: from mout.gmx.net ([212.227.17.22]:51389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfKWUtv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 23 Nov 2019 15:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574542189;
        bh=6N8o7SpMjm31bF+dOeFe/HYRlj81sRaYmricct/MB1Q=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=Qw9jCj6QEj/8KKq5cAKTyOn44cVuwvtZyNFEz2MwZye3+dF3pJfuVf+a35S7Pt9Bg
         K5PIt+8DnZ4a2WPSlHMFExF99RN1oR/TPhIOIOqkucUFO/PmuHH78NazBycG/FgCz4
         lAktW5rZ3L0ZohB5xP/uNFV1d3urIHUGvoMBeuXg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [92.206.82.1] ([92.206.82.1]) by web-mail.gmx.net
 (3c-app-gmx-bap41.server.lan [172.19.172.111]) (via HTTP); Sat, 23 Nov 2019
 21:49:49 +0100
MIME-Version: 1.0
Message-ID: <trinity-48fd37f8-df0e-4c83-b6a8-19e742af2090-1574542189568@3c-app-gmx-bap41>
From:   "Mathias Essenpreis" <EssE@gmx.net>
To:     linux-bluetooth@vger.kernel.org
Subject: bluez 5.50 on raspberry howto to trigger bluez to advertise
 hands-free service profile?
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 23 Nov 2019 21:49:49 +0100
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-Provags-ID: V03:K1:GBGEZ29v9lVPjjNdNxfpprUG93vV6de8m4oDRi6Nr/clSHReU8KN8wmFxzuZ9oglXBQG9
 91140fMN6ycstj2+30P/Szckp12trxvl6ZqL9xburMX+H6R8i4WvgIrsYtSbMFK7OfbYIKNWW3+u
 OZ1iccusD1ZkMykikIwO7pdCbU8wmAxEztUEZn6XImx0K8blaLqtgBpRI7AMXVSUYEXGduoSNrmw
 BqGJ8LoF+iJ3FT2Mfwk2lrkHgn7i05Jvkfm4rxUQR4hb9O/e09lFYX7v3WXwfe00Y2E95XYy1zOZ
 PQ=
X-UI-Out-Filterresults: notjunk:1;V03:K0:adXeglXk1+8=:aHUwQ0lOGGDIYMSJ09vsP1
 h1jjWjAk+84/nCIZQ16CgCb7n/K96RcRaq93OmhuuayUKLg8gnqobM+tlC6oEV2dfeNGWL58L
 jUzLPmvKCipkx+NrgseE1pc3sb57kdB4qR3iiel/30DA5vSG+5vBXUhE1Fdz6bczzDF8iolC9
 mDyflGarQou5YAuogtgIL8Y9BjFmK6CX05TB82ZdgEOxzmdqpR+nfSntodUU/t0Unsner2PRg
 oJw1ClRbA/r72RRXqmqc8HFgaytazEXxZFVj2z+WQug/5c+BlGQjl+gFfPySXUqkn7Kz+L4O9
 KmCmensSJGvkxlq+V/Fwzm7BTKFiKnZh7cVEe6DVUOYwm9pj8ufyKgZVd9oQ9wwlxLdjjzOya
 YWdIaODjKQhTXiCra8doZL8h4hRA5dhj7XVC9fFkh2WyuNOhVR6pKIzXmvmwLMdFaFhrLdhjQ
 7XIYV8NssEw7K99NnlvFaiKkmHVbdbooUVmpTpwt8RyH0yaSZkwuqhMFwO0xWpXPaHK9Lkuk6
 nBHUw15fvPe09QltllDWGQth4LDwHw5BUOaQE2tYjs/nL25iW7tapiUKtW9p7oMtsdFT5Vjor
 0NavYV+BhHKHlhug3gfOINyMcWAiEbJ+3ZExI0vPBOmGAx+oo1Zdo06SWlknAvhTbpJ56EhYK
 k+J3vDG5Xi7O5k+HDwxlDdmfvWIDngVx8ucUnupVpqlAkkw==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi experts,

My goal is to pair my car Bluetooth to my raspberry each time the devices =
connect=2E Therefore I want to enable e=2Eg=2Ehandsfree profile on the rasp=
berry=2E I played around with the example=E2=80=93advertisement script=2E W=
hile running the script it seems Bluez is advertising the profile but after=
 ending the script the profiles are gone=2E=20

So I tried with the sdptool and I enabled it via running bluetoothd in com=
patibility mode=2E However when issuing the show command in bluetoothctl I =
don=E2=80=99t see the added profiles=2E I only see it when issuing "sdptool=
 browse local"=2E



So overall my question is about the right and recommended way to advertise=
 a certain set of profiles in my bluez version 5=2E50? =20

Also I wonder whether I should still use sdptool in latest versions of blu=
ez=2E Or perhaps I should switch to BLE and Gatt? My car would support it=
=2E=20


Thx Esse
