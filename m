Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B38C77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 08:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjDTIDA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 04:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjDTIC7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 04:02:59 -0400
X-Greylist: delayed 996 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Apr 2023 01:02:57 PDT
Received: from mail-200160.simplelogin.co (mail-200160.simplelogin.co [176.119.200.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AA4139
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 01:02:57 -0700 (PDT)
Date:   Thu, 20 Apr 2023 07:46:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=8shield.net; s=dkim;
        t=1681976779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BUjwNV/VpEbLHLi9ougHi6A/OfPUTK4fNksYYjjUi0o=;
        b=fvtWNgBV2Rt++chINNGrDeI8sHzYvQvLp7Bu8y7RlF30QS/nT6Tom0J9VjThhwro3zc15h
        mzALauYVpjkuf8r70ifGEI6U3xQitdeVNX2yuWj7HixUnWjPZqVCDPkXWKbSyyzB6o0SE5
        7bnw/S2+5eoHYj8TEdoDkOQ9ONpb+gA=
Subject: Re: btusb driver need to be unloaded and reloaded after boot & lag
 issue
In-Reply-To: <JeOOK1M3oQrgyJmlzKuvQx2O1xwE6THHXiN_zsFAtx0o-1iXxaPIi7whg1y-a8BcT6XHIKxSHXikQrw3WDpS2JRquVXwPB4jHEyuIvhuo2E=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   help.7ocym@8shield.net
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        regressions@lists.linux.dev
Message-ID: <168197677832.7.17052177272272311417.121629099@8shield.net>
References: <168133719213.7.14774994518515251513.119182329@8shield.net>
 <dbbf4556-2719-5827-efbd-da9e87c0de40@molgen.mpg.de>
 <168189401011.9.1190609165422904967.121288919@8shield.net>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 121629102
X-SimpleLogin-Want-Signing: yes
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi,

Sent with Proton Mail secure email.

------- Original Message -------
On Wednesday, April 19th, 2023 at 10:46 AM, jl.malet <jl.malet@protonmail.c=
om> wrote:


> Hi,
>=20
> ------- Original Message -------
> On Thursday, April 13th, 2023 at 7:39 AM, Paul Menzel - pmenzel at molgen=
.mpg.de pmenzel_at_molgen_mpg_de_rislbjit@simplelogin.co wrote:
>=20
>=20
>=20
> > [Cc: +regressions@lists.linux.dev]
> >=20
> > Dear JLM,
> >=20
> > Am 13.04.23 um 00:06 schrieb help.7ocym@8shield.net:
> >=20
> > > sorry to address both list, but this issue seems related, without
> > > knowing where lies the issue > my hardware : https://wiki.gentoo.org/=
wiki/Lenovo_Yoga_900
> > > I use the pre-built gentoo linux kernel,
> > > 6.2.8-gentoo-dist #1 SMP PREEMPT_DYNAMIC Wed Mar 22 17:15:39 -00 2023=
 x86_64 Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz GenuineIntel GNU/Linux
> > >=20
> > > since a few update (sadly I didn't noted the latest kernel version
> > > that didn't had the issue), after a boot, the bluetooth isn't
> > > working, nothing bad in dmesg, I just have to unload btusb module and
> > > modprobe it again to have bluetooth working again...
> > >=20
> > > after a suspend to ram, I have to power off-power on the bluetooth to
> > > have it work again (bluetoothctl power off; bluetoothctl power on)
> > >=20
> > > bluetooth mouse can also be extremely laggy sometimes,but without
> > > error message in dmesg, most of the time `bluetoothctl power` off-on
> > > cycling do solve the issue....
> > >=20
> > > I also included the usb mailing list because it might be related to
> > > some behavior I noticed :
> > >=20
> > > I have usb3.0 micro sd card reader (SanDisk MobileMate UHS-I microSD
> > > Reader/Writer USB 3.0 Reader, Kingston MobileLite Plus (MLPM) microSD
> > > Card Reader USB 3.1 microSDHC/SDXC UHS-II, for example) and some
> > > extra fast micro sd cards (like sandisk extrem 512G), when
> > > transferring data the read rate can be as high as 110Mo/s and write
> > > 70Mo/s sustained, nothing impressive but when such rate is achieved
> > > for a long time (big file transfer) either reading only access,
> > > writing only access or read write, the usb bus become unusable, I
> > > can't even use a usb mouse connected to it by wire... even if cpu
> > > usage is really low (less than 10%) I don't have the issue if I
> > > connect a M2 usb3 flash drive, with comparable transfert speed... so
> > > not related to some bus over usage...
> > >=20
> > > so I suspect that there is an issue with the usb driver, and that
> > > maybe the bluetooth issue can be related to the usb issue, since the
> > > bluetooth controller is on the usb bus on the laptop >
> > > the transfer issue of usb is much more older than the bluetooth
> > > issue, it's approximative, but : > - the btusb boot issue is about 3 =
month old,
> > > - the suspend/resume issue of bluetooth is more than a year old
> > > - the usb transfer issue as more than a year...
> > >=20
> > > I'll gladly provide any useful information, can also do patch tries..=
.
> >=20
> > As you use Gentoo and are able to build your own Linux kernel, the
> > fastest way to get these issues addressed is to bisect them. To shorten
> > the test cycles, I recommend to try, if you can reproduce the issues in
> > QEMU and passing through the problematic devices to the VM [1][2].
> >=20
> > I also recommend to start a separate thread for each issue and, as thes=
e
> > seem to be regressions, also keep the regression folks in the loop [3].
> >=20
> > Kind regards,
> >=20
> > Paul
> >=20
> > (The commands were working for after all, and the device didn=E2=80=
=99t
> > show up due to a (second) Linux kernel regression.)
> > [2]: https://station.eciton.net/qemu-usb-host-device-pass-through.html
> > [3]:
> > https://www.kernel.org/doc/html/latest/admin-guide/reporting-regression=
s.html
>=20
>=20
> thanks for the reply,
> after upgrade to 6.2.11 version,
> - seems that the issue at boot of btusb module is gone... I don't have an=
ymore to unload btusb module after a boot... so that's great news!
> - the bluetooth resumes also after a suspend S3 (suspend to ram)! so grea=
t news again! (I've to check for suspend to disk, but I'm confident about s=
uccess)
>=20
> I still have to do some check with the micro usb readers to see if the bu=
g "bus monopolization" is still present, so far so good!
>=20
>=20
>=20
> Sent with Proton Mail secure email.

so far, so good... the usb congestion seems also to be gone... tried {usb m=
icro flash reader}->{disk}, {disk}->{usb micro flash reader}, {usb micro fl=
ash reader}->{usb micro flash reader}, all CPU 100% due to gentoo upgrade..=
. and the {bluetooth mouse} connected to the {bluetooth usb host} had no la=
g... before (2~3 years) I used the trackpad because it was soooo laggy or n=
ot even moving... so, there is something between  6.2.8 and 6.2.11 that did=
 fixed the issue.

sorry for the inconvenience, seems that just reporting the issue (that was =
annoying me for years) did fixed the issue...
this can be closed, thanks and regards
JLM

