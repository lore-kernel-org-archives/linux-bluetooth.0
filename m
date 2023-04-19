Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA9AC6FD18
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 08:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjDSIz2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 04:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjDSIzU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 04:55:20 -0400
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Apr 2023 01:55:05 PDT
Received: from mail-200162.simplelogin.co (mail-200162.simplelogin.co [176.119.200.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C97A4C2C
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 01:55:05 -0700 (PDT)
Date:   Wed, 19 Apr 2023 08:46:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=8shield.net; s=dkim;
        t=1681894012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svMD8qCdCdMeuX7byvejAfnFeoEkqnuCAiytCVsrX9I=;
        b=BN91Nhk3WNk2wdWndHhRGlVATg8Gk5ZPGxw42M5y6/jyMpQNUePNX8WM5K58t1WBZzOTWe
        5JwvONJVdlZTvvE5ClXvoJcR5oqWAijcLEg6Bn0t5YJriwoh0eQkFV4CiL54glBZe5iMzE
        Ep+DYCoNI7BOrbb+34rIJHlnP5fpkU0=
Subject: Re: btusb driver need to be unloaded and reloaded after boot & lag
 issue
In-Reply-To: <dbbf4556-2719-5827-efbd-da9e87c0de40@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------58bb509cbf61eb58031cdc6e0e682bf96f7bc10ce8327a5812e43e037274263f";
 charset=utf-8
Content-Transfer-Encoding: 7bit
From:   help.7ocym@8shield.net
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        regressions@lists.linux.dev
Message-ID: <168189401011.9.1190609165422904967.121288919@8shield.net>
References: <168133719213.7.14774994518515251513.119182329@8shield.net>
 <dbbf4556-2719-5827-efbd-da9e87c0de40@molgen.mpg.de>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 121288931
X-SimpleLogin-Want-Signing: yes
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------58bb509cbf61eb58031cdc6e0e682bf96f7bc10ce8327a5812e43e037274263f
Content-Type: multipart/mixed;boundary=---------------------d434d8696c798ef5f060dccd015a521b

-----------------------d434d8696c798ef5f060dccd015a521b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi,

------- Original Message -------
On Thursday, April 13th, 2023 at 7:39 AM, Paul Menzel - pmenzel at molgen.=
mpg.de <pmenzel_at_molgen_mpg_de_rislbjit@simplelogin.co> wrote:


> [Cc: +regressions@lists.linux.dev]
>
> Dear JLM,
>
>
> Am 13.04.23 um 00:06 schrieb help.7ocym@8shield.net:
>
> > sorry to address both list, but this issue seems related, without
> > knowing where lies the issue > my hardware : https://wiki.gentoo.org/w=
iki/Lenovo_Yoga_900
> > I use the pre-built gentoo linux kernel,
> > 6.2.8-gentoo-dist #1 SMP PREEMPT_DYNAMIC Wed Mar 22 17:15:39 -00 2023 =
x86_64 Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz GenuineIntel GNU/Linux
> >
> > since a few update (sadly I didn't noted the latest kernel version
> > that didn't had the issue), after a boot, the bluetooth isn't
> > working, nothing bad in dmesg, I just have to unload btusb module and
> > modprobe it again to have bluetooth working again...
> >
> > after a suspend to ram, I have to power off-power on the bluetooth to
> > have it work again (bluetoothctl power off; bluetoothctl power on)
> >
> > bluetooth mouse can also be extremely laggy sometimes,but without
> > error message in dmesg, most of the time `bluetoothctl power` off-on
> > cycling do solve the issue....
> >
> > I also included the usb mailing list because it might be related to
> > some behavior I noticed :
> >
> > I have usb3.0 micro sd card reader (SanDisk MobileMate UHS-I microSD
> > Reader/Writer USB 3.0 Reader, Kingston MobileLite Plus (MLPM) microSD
> > Card Reader USB 3.1 microSDHC/SDXC UHS-II, for example) and some
> > extra fast micro sd cards (like sandisk extrem 512G), when
> > transferring data the read rate can be as high as 110Mo/s and write
> > 70Mo/s sustained, nothing impressive but when such rate is achieved
> > for a long time (big file transfer) either reading only access,
> > writing only access or read write, the usb bus become unusable, I
> > can't even use a usb mouse connected to it by wire... even if cpu
> > usage is really low (less than 10%) I don't have the issue if I
> > connect a M2 usb3 flash drive, with comparable transfert speed... so
> > not related to some bus over usage...
> >
> > so I suspect that there is an issue with the usb driver, and that
> > maybe the bluetooth issue can be related to the usb issue, since the
> > bluetooth controller is on the usb bus on the laptop >
> > the transfer issue of usb is much more older than the bluetooth
> > issue, it's approximative, but : > - the btusb boot issue is about 3 m=
onth old,
> > - the suspend/resume issue of bluetooth is more than a year old
> > - the usb transfer issue as more than a year...
> >
> > I'll gladly provide any useful information, can also do patch tries...
>
> As you use Gentoo and are able to build your own Linux kernel, the
> fastest way to get these issues addressed is to bisect them. To shorten
> the test cycles, I recommend to try, if you can reproduce the issues in
> QEMU and passing through the problematic devices to the VM [1][2].
>
> I also recommend to start a separate thread for each issue and, as these
> seem to be regressions, also keep the regression folks in the loop [3].
>
>
> Kind regards,
>
> Paul
>
>
> [1]:
> https://lore.kernel.org/all/5891f0d5-8d51-9da5-7663-718f301490b1@molgen.=
mpg.de/
> (The commands were working for after all, and the device didn=E2=80=99t
> show up due to a (second) Linux kernel regression.)
> [2]: https://station.eciton.net/qemu-usb-host-device-pass-through.html
> [3]:
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-regressions=
.html

thanks for the reply,
after upgrade to 6.2.11 version, =


- seems that the issue at boot of btusb module is gone... I don't have any=
more to unload btusb module after a boot... so that's great news! =


- the bluetooth resumes also after a suspend S3 (suspend to ram)! so great=
 news again! (I've to check for suspend to disk, but I'm confident about s=
uccess)

I still have to do some check with the micro usb readers to see if the bug=
 "bus monopolization" is still present, so far so good!



Sent with Proton Mail secure email.

-----------------------d434d8696c798ef5f060dccd015a521b
Content-Type: application/pgp-keys; filename="publickey - jl.malet@protonmail.com - 0xA25F20CF.asc"; name="publickey - jl.malet@protonmail.com - 0xA25F20CF.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - jl.malet@protonmail.com - 0xA25F20CF.asc"; name="publickey - jl.malet@protonmail.com - 0xA25F20CF.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWkRHNGx4WUpLd1lCQkFI
YVJ3OEJBUWRBc0o4TVNPaVhCR2tKWnlzYm52cExJN3NXR0xHaXNXeDQKbmxlUkRiRlpiRy9OTVdw
c0xtMWhiR1YwUUhCeWIzUnZibTFoYVd3dVkyOXRJRHhxYkM1dFlXeGxkRUJ3CmNtOTBiMjV0WVds
c0xtTnZiVDdDakFRUUZnb0FQZ1dDWkRHNGx3UUxDUWNJQ1pEVy9aZ2x2N3RnQ2dNVgpDQW9FRmdB
Q0FRSVpBUUtiQXdJZUFSWWhCS0pmSU05bm5OS2RzS2RMcnRiOW1DVy91MkFLQUFES3lnRUEKdlpr
VjRWV3l4dXJxUWVOSDM2UmhncjR2QVdUQ1RRQjl6Z1ZrTXFFTHF5VUEvUk9UbFJOMnFVQjAzdE5r
CmRwZXJPV0VQa3JvWG1XRHBYWU0rMldOWk1uWVB6amdFWkRHNGx4SUtLd1lCQkFHWFZRRUZBUUVI
UURJWQpIOHpvdytIeFowSkUyeHJkcy96WlRIa3pZS2lmc0RUUXVRL2o0dEFKQXdFSUI4SjRCQmdX
Q0FBcUJZSmsKTWJpWENaRFcvWmdsdjd0Z0NnS2JEQlloQktKZklNOW5uTktkc0tkTHJ0YjltQ1cv
dTJBS0FBQmFqd0Q4CkM5VmNtRWVTWmpyNFNabWlOSFM2MUtqZlZlaEZJYkJmZnEzTUVCZGFxcHdB
LzJHSTY4a010MzdOSkhTcAo1Q2Fid2UrZ05HZVg5S3RESUxjS2NUbVRjVmNECj04SW9hCi0tLS0t
RU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K
-----------------------d434d8696c798ef5f060dccd015a521b--

--------58bb509cbf61eb58031cdc6e0e682bf96f7bc10ce8327a5812e43e037274263f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmQ/qmIJkNb9mCW/u2AKFiEEol8gz2ec0p2wp0uu1v2YJb+7
YAoAAK/OAP0XIqIp32TYnR4LaBq82EkLkqgQdADqzn2qFgOQuNb+kQEAgfZO
/gl/jcYzocTpyJ/ew05D5D2OXkZoI4EhtqVKIgk=
=ogYk
-----END PGP SIGNATURE-----


--------58bb509cbf61eb58031cdc6e0e682bf96f7bc10ce8327a5812e43e037274263f--


