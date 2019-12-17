Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E63C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 16:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E0221835
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 16:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ygsoftware.com.au header.i=@ygsoftware.com.au header.b="KLyYiT0k";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="aMSNvWDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfLQQTD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:19:03 -0500
Received: from a27-14.smtp-out.us-west-2.amazonses.com ([54.240.27.14]:41682
        "EHLO a27-14.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728950AbfLQQTC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 11:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vl7dyoqhfh6isglrlfucb4hjwred72dq; d=ygsoftware.com.au;
        t=1576599541;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
        bh=ZYbR2MkTuYaz2t03IA5YT5meWaY2y6WxrPcvEP0Z3oc=;
        b=KLyYiT0kM9wXuUqGQRcn72NDJNcv7KK+s452UZ5Bbtr51QRAKIykpogIr5aRIKrs
        1Q563XY2gVKQiBtUvzcQhkpjIFJ8VqaPrQ/1WXhYHW2exrkvkpbrH0Qg9jGX8Q5vitV
        eBL9avsk0YBsm6eGzI7gJhpMRMA6NUWIx66RPfNY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1576599541;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
        bh=ZYbR2MkTuYaz2t03IA5YT5meWaY2y6WxrPcvEP0Z3oc=;
        b=aMSNvWDYozcnahxXX+yAP9JJwCIzFLeDQ57R6+EgEkW693zQq9whx200lHhw9/Xn
        alALvplBLSEM55jlHMkrDSO2bPDVo4qIGEOzZD/hH4gCKWGptAql1RQWvUQ27lZCZHi
        n+V1tb8N9MUwJl90wCiG+sjXrr7MEcEGyuesV9mo=
Subject: RE: mesh-cfgclient fails with 'Segmentation fault'
From:   =?UTF-8?Q?Yury_Galustov?= <yury@ygsoftware.com.au>
To:     =?UTF-8?Q?Micha=C5=82_Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
Cc:     =?UTF-8?Q?linux-bluetooth=40vger=2Ekernel=2Eorg?= 
        <linux-bluetooth@vger.kernel.org>
Date:   Tue, 17 Dec 2019 16:19:01 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191217153402.teo4tv44fxgbvmkd@mlowasrzechonek2133>
References: <mail.950b9bbe-7735-4634-bbe9-de9ff9bc7bd4@storage.wm.amazon.com> 
 <mail.950b9bbe-7735-4634-bbe9-de9ff9bc7bd4@storage.wm.amazon.com> 
 <0101016f14697e81-b2b4716b-65b2-47c1-949b-36193e42ecf7-000000@us-west-2.amazonses.com> 
 <20191217153402.teo4tv44fxgbvmkd@mlowasrzechonek2133> 
 <mail.818c9bc4-2f51-4df1-a8f3-a37c0d84cc99@storage.wm.amazon.com> 
 <mail.818c9bc4-2f51-4df1-a8f3-a37c0d84cc99@storage.wm.amazon.com>
X-Priority: 3 (Normal)
X-Mailer: Amazon WorkMail
Thread-Index: AdW07CI9akHkPeGZRIeoVtfEhG5axsGRml+3wZGK5+A=
Thread-Topic: mesh-cfgclient fails with 'Segmentation fault'
Message-ID: <0101016f14a7d6f7-c2c20ba5-322b-4803-b010-472848fc33b4-000000@us-west-2.amazonses.com>
X-SES-Outgoing: 2019.12.17-54.240.27.14
Feedback-ID: 1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Micha=C5=82,=0D=0AThanks for the quick response.=0D=0A=0D=0A> On 12/17=
, Yury Galustov wrote:=0D=0A> > pi@raspberrypi:~/bluez-master $ ./tools/m=
esh-cfgclient=0D=0A> > Warning: config file "/home/pi/.config/meshcfg/con=
fig_db.json" not found=0D=0A> >=20=0D=0A> > [mesh-cfgclient]# create=0D=0A=
> > Segmentation fault=0D=0A> >=20=0D=0A> > Happy to debug the code if so=
mebody would explain how )=0D=0A>=0D=0A> You might try running it under a=
 debugger:=0D=0A>  $ gdb ./tools/mesh-cfgclient -ex run=0D=0A> and captur=
e the backtrace via "bt" command.=0D=0A>=0D=0A> Although honestly, I'd re=
commend playing with D-Bus API directly, e.g.=0D=0A> in Python.=0D=0A>=0D=
=0A> The command line is a bit alpha.=0D=0A>=0D=0A> --=20=0D=0A> Micha=C5=
=82 Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>=0D=0A> Silvair h=
ttp://silvair.com=0D=0A> Jasnog=C3=B3rska 44, 31-358 Krakow, POLAND=0D=0A=
=0D=0A=0D=0AWarning: config file "/home/pi/.config/meshcfg/config_db.json=
" not found=0D=0A[mesh-cfgclient]# create=0D=0A=0D=0AProgram received sig=
nal SIGSEGV, Segmentation fault.=0D=0Al_dbus_proxy_method_call (proxy=3D0=
x0, method=3Dmethod@entry=3D0x342c0 "CreateNetwork", setup=3Dsetup@entry=3D=
0x14fa0 <create_net_setup>,=0D=0A    reply=3Dreply@entry=3D0x14e04 <creat=
e_net_reply>, user_data=3D0x0, destroy=3D0x0) at ell/dbus-client.c:304=0D=
=0A304             req =3D l_new(struct method_call_request, 1);=0D=0A(gd=
b) bt=0D=0A#0  l_dbus_proxy_method_call (proxy=3D0x0, method=3Dmethod@ent=
ry=3D0x342c0 "CreateNetwork", setup=3Dsetup@entry=3D0x14fa0 <create_net_s=
etup>,=0D=0A    reply=3Dreply@entry=3D0x14e04 <create_net_reply>, user_da=
ta=3D0x0, destroy=3D0x0) at ell/dbus-client.c:304=0D=0A#1  0x00015b00 in =
cmd_create_network (argc=3D<optimized out>, argv=3D<optimized out>) at to=
ols/mesh-cfgclient.c:711=0D=0A#2  0x0001e398 in cmd_exec (argv=3D0x69308,=
 argc=3D1, entry=3D0x33210 <main_menu+8>) at src/shared/shell.c:441=0D=0A=
#3  menu_exec (entry=3D0x33210 <main_menu+8>, argc=3Dargc@entry=3D1, argv=
=3Dargv@entry=3D0x69308) at src/shared/shell.c:468=0D=0A#4  0x0001e730 in=
 shell_exec (argc=3D1, argv=3D0x69308) at src/shared/shell.c:511=0D=0A#5 =
 0x0001f684 in rl_handler (input=3D0x69068 "create") at src/shared/shell.=
c:713=0D=0A#6  0xb6f7cdc0 in rl_callback_read_char () from /lib/arm-linux=
-gnueabihf/libreadline.so.7=0D=0A#7  0x0001e608 in input_read (io=3D<opti=
mized out>, user_data=3D<optimized out>) at src/shared/shell.c:1256=0D=0A=
#8  0x00022f9c in io_callback (fd=3D<optimized out>, events=3D1, user_dat=
a=3D0x69280) at ell/io.c:126=0D=0A#9  0x00023e28 in l_main_iterate (timeo=
ut=3D<optimized out>) at ell/main.c:470=0D=0A#10 0x00023ef0 in l_main_run=
 () at ell/main.c:520=0D=0A#11 l_main_run () at ell/main.c:502=0D=0A#12 0=
x00024150 in l_main_run_with_signal (callback=3D<optimized out>, user_dat=
a=3Duser_data@entry=3D0x0) at ell/main.c:642=0D=0A#13 0x000202d0 in mainl=
oop_run_with_signal (func=3D<optimized out>, user_data=3Duser_data@entry=3D=
0x0) at src/shared/mainloop-ell.c:87=0D=0A#14 0x0001f90c in bt_shell_run =
() at src/shared/shell.c:1174=0D=0A#15 0x00012980 in main (argc=3D<optimi=
zed out>, argv=3D<optimized out>) at tools/mesh-cfgclient.c:1982=0D=0A=0D=
=0A
