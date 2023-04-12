Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC07C77B6C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Apr 2023 22:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjDLWO0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Apr 2023 18:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDLWOZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Apr 2023 18:14:25 -0400
X-Greylist: delayed 466 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Apr 2023 15:14:24 PDT
Received: from mail-200167.simplelogin.co (mail-200167.simplelogin.co [176.119.200.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CCC65B6
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Apr 2023 15:14:24 -0700 (PDT)
Date:   Wed, 12 Apr 2023 22:06:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=8shield.net; s=dkim;
        t=1681337197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3QIKZYyDwVYZ16tbgagaCvjpy0LQkwhUHoy8ARF4pbc=;
        b=EsrQasQSwkKeC8ow5PTAUfZSfibG7I2VzJ7QKCDDEOQUBRi5EGzq8eDq2JYYpPr4SE+2Tm
        JxFCfwPT/xWT63rCKcwLgybeHwGqmc7WxivpUR0/ZBvya/AMACYw8PaEjoeqssSpk/sgR9
        hH9O8sVP+jFVtsIQVCoQjjnrkBvEqRM=
Subject: btusb driver need to be unloaded and reloaded after boot & lag issue
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   help.7ocym@8shield.net
To:     linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org
Message-ID: <168133719213.7.14774994518515251513.119182329@8shield.net>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 119182345
X-SimpleLogin-Want-Signing: yes
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
sorry to address both list, but this issue seems related, without knowing w=
here lies the issue
my hardware : https://wiki.gentoo.org/wiki/Lenovo_Yoga_900
I use the pre-built gentoo linux kernel,=20
6.2.8-gentoo-dist #1 SMP PREEMPT_DYNAMIC Wed Mar 22 17:15:39 -00 2023 x86_6=
4 Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz GenuineIntel GNU/Linux

since a few update (sadly I didn't noted the latest kernel version that did=
n't had the issue), after a boot, the bluetooth isn't working, nothing bad =
in dmesg, I just have to unload btusb module and modprobe it again to have =
bluetooth working again...

after a suspend to ram, I have to power off-power on the bluetooth to have =
it work again (bluetoothctl power off; bluetoothctl power on)

bluetooth mouse can also be extremely laggy sometimes,but without error mes=
sage in dmesg, most of the time `bluetoothctl power` off-on cycling do solv=
e the issue....

I also included the usb mailing list because it might be related to some be=
havior I noticed :

I have usb3.0 micro sd card reader (SanDisk MobileMate UHS-I microSD Reader=
/Writer USB 3.0 Reader, Kingston MobileLite Plus (MLPM) microSD Card Reader=
 USB 3.1 microSDHC/SDXC UHS-II, for example) and some extra fast micro sd c=
ards (like sandisk extrem 512G), when transfering data the read rate can be=
 as high as 110Mo/s and write 70Mo/s sustained, nothing impressive but when=
 such rate is achieved for a long time (big file transfer) either reading o=
nly access, writing only access or read write, the usb bus become unusable,=
 I can't even use a usb mouse connected to it by wire... even if cpu usage =
is really low (less than 10%)=20
I don't have the issue if I connect a M2 usb3 flash drive, with comparable =
transfert speed... so not related to some bus over usage... =20

so I suspect that there is an issue with the usb driver, and that maybe the=
 bluetooth issue can be related to the usb issue, since the bluetooth contr=
oller is on the usb bus on the laptop

the transfer issue of usb is much more older than the bluetooth issue, it's=
 approximative, but :
 - the btusb boot issue is about 3 month old,=20
 - the suspend/resume issue of bluetooth is more than a year old
 - the usb transfer issue as more than a year...

I'll gladly provide any useful information, can also do patch tries...=20

thanks and regards
JLM


Sent with Proton Mail secure email.

