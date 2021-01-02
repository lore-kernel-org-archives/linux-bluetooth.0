Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5168BC433E6
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jan 2021 21:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D932207A1
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jan 2021 21:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbhABVnB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Jan 2021 16:43:01 -0500
Received: from mout.gmx.net ([212.227.15.15]:49157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbhABVnA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Jan 2021 16:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609623687;
        bh=qNleJz2MDSBKwJ535sioeu+q8NtazABN1rs29sN2K6A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=a30Eiyol41cYZR7Xfhwmb44/BULuhaZG1oz3Jpnj1Wk0kuqdTq8UBdXFwTqyRNQiw
         KZi6aaHHoq4sCTqbn/Z6q2IEZ0kDOLQpvuRXS0PqbD4hl6nksr4Y0POPhZz+8679Lj
         JMhmueyUhONivbKSmrL0Bj5rKQ9y7GUGsM6r8sMI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MockUp.fritz.box ([77.10.124.214]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26vL-1kyHcs2H3R-002UOk; Sat, 02
 Jan 2021 22:41:27 +0100
From:   John-Eric Kamps <johnny86@gmx.de>
To:     johnny86@gmx.de
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_h5: Add support for binding RTL8723DS with device tree
Date:   Sat,  2 Jan 2021 22:41:15 +0100
Message-Id: <20210102214116.1098030-1-johnny86@gmx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Otp79H9k2G7AFm+Yvo0CkrX3Lmpr4FZ3yvjFBAgdc6DyOanWqQa
 dWNMXScXe5JPdP8ym7nQuQtFNaX3xMrg1kP1rRFvYJwA+6QgWIc6vIgYNgsaxuN523cWGIY
 BBiarRbSxgCC5AAoQuDoqkBFyH5HMGsu4WeIvR1OFCBfncr0FLqO1ZJEk9TDUW9aVGJA/Ns
 KO4f3hdk2ttYdBduvHDaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yuIwH5pAvYI=:X224beW9GoqL9nDUq53R+3
 LWAZthQZMih7KJ4l4oFDNjl1ZPn5SXz4w4oVMui6CbcfBd9WRC9cfOiJGjkcdqZ9whutOwCkd
 rA687vkqBk8K9SKA8rQ3Jr7K/w6qiel/qbGsKvwCmN6OuqeCx0IHbRLme7L6oMwjYix6TBCt8
 c//rNn//Rc91FVGkM5TAOayU3DFfgATNfxWSEA79j8Cx6yEMD3onqHKLzz2menaomKT0py1Av
 3iutj+riAnSZ5g1Tueo2BsrAzax8u65dSBKvjY0ZaZV2ubQV0gGnZhOfy/WpHLQJtVjJ1j6Z9
 zJIz38Gqn9baV8ESGdRE5Hu08Snx4RZinPgHzqT3Xyy0w5Lw5bJhkusT5TcUh6rHy6+i5V396
 sh5glSg/UJpmxhKXMR6aGbL0+yLH115BFnreTnAwIpjqnLvhtWyeuD3xP5L5/fkrT7cY1vnfs
 TiwKxe0SN1JNQs+9LfCrFasQDcFh1Hp/Hb6GgjhUKe6RpE04wvEvDMyjv60l+5ZSR1cn4gtQr
 6lSK/IEKeNeqI1H1vForsVMihMKQSQeky7ky72/8GkUfOrNQzevPx6S9/9n46zwj4iote/VjZ
 eKeLq5MyWmOO97ELQuoIq1Vgmq6ZZW9gjiQ01XgNl1kYe6RbdPJ7iK7wJ4xI2913LSn1lha5h
 bVwAz9yCf1chLdhBnJL0lGBnKtC/y47Rl6L8z1GhSoZubLDeYS9OElk++G3wOKF1zxxJmz2IG
 j/pkFbpiMYe3ofXoc35HimY1bq8tRYEiBal1HHYt+QebqPwUAyfPkwB0etCUUh3As2wxDTI7q
 NTvnvgI3C0KS+qfWjnt7TT647H8Ax8zxy6Y21giwQtiBcbnKK7m+m4LFfoNTs5Sh3feKKKjuw
 CBqVENsDzAVIHOhdPeMw==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

RTL8723DS could be handled by btrtl-driver, so add ability to bind it
using device tree.

Signed-off-by: John-Eric Kamps <johnny86@gmx.de>
=2D--
 drivers/bluetooth/hci_h5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 7be16a7f653b..fb9817f97d45 100644
=2D-- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -1022,6 +1022,8 @@ static const struct of_device_id rtl_bluetooth_of_ma=
tch[] =3D {
 	  .data =3D (const void *)&rtl_vnd },
 	{ .compatible =3D "realtek,rtl8723bs-bt",
 	  .data =3D (const void *)&rtl_vnd },
+	{ .compatible =3D "realtek,rtl8723ds-bt",
+	  .data =3D (const void *)&rtl_vnd },
 #endif
 	{ },
 };
=2D-
2.25.1

