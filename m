Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7320C636CA
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jul 2021 10:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D55D611AB
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jul 2021 10:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhGRKuw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Jul 2021 06:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231836AbhGRKuw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Jul 2021 06:50:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B4A7C611AD
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Jul 2021 10:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626605274;
        bh=idT6U5GhH2+fPFQ6Ujz1XwjS7jyWy2U6jmstS8cfv+Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XdyDzjXGHwp25QCCStWIyWaNs9BB5bKpTDxxebbMHDqF3j9QG9KhIguAD+6Hkd/5H
         f37QBAOOkQG/E0/IKrJv2yS1LOl7t1YBtO57bzdznwWr64gnb256u1WNqS2jvJTWHl
         dsGxtlXSojG3Hc73wmv8WbkcBqUXhpqpYG0A8uGQ4bUs2fIkLRFCfSXYZWxwgElOdR
         DH4VLzIzB+FAr8TfBmaMSrXOpkQD9vFOJXYHl5kBGFyi8sio5E1QyZEG3KUFg9HSjS
         OgVbRTCjRKZmZ/uCq3hbeaP8KJL873ycqad2O0p3k0AYEZzosMk169EaApTRT4Nydf
         Yv6ivk7EEs+jg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 86931] hid-generic 0005:099A:0500.0001: unknown main item tag
 0x0
Date:   Sun, 18 Jul 2021 10:47:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: someuniquename@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-86931-62941-s5LKjCDiQJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-86931-62941@https.bugzilla.kernel.org/>
References: <bug-86931-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D86931

Roman Evstifeev (someuniquename@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |someuniquename@gmail.com

--- Comment #9 from Roman Evstifeev (someuniquename@gmail.com) ---
The bug is still here in 5.12.13 with asaus m-rbb93 logitech b370 mouse. Af=
ter
some time (unpredictable, can be few hours or few minutes) mouse pointer st=
ops
responding, though mouse appears conneceted in the bluetoothctl.

> bluetoothctl=20
Agent registered
[Bluetooth Travel Mouse]# info
Device 00:07:61:68:D2:9E (public)
        Name: Bluetooth Travel Mouse
        Alias: Bluetooth Travel Mouse
        Class: 0x00002580
        Icon: input-mouse
        Paired: yes
        Trusted: yes
        Blocked: no
        Connected: yes
        WakeAllowed: yes
        LegacyPairing: no
        UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34=
fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34=
fb)
        Modalias: usb:v046DpB002d4809

journalctl and dmesg is silent when the mouse stops responding. Is there any
other way to debug this?

When mouse is first connected, dmesg has the message mentioned as the topic=
 of
this bug:
[185307.429898] hid-generic 0005:046D:B002.002C: input,hidraw1: BLUETOOTH H=
ID
v48.09 Mouse [Bluetooth Travel Mouse] on dc:e9:94:7e:5f:86
[187430.340610] hid-generic 0005:046D:B002.002D: unknown main item tag 0x0
[187430.340668] input: Bluetooth Travel Mouse as
/devices/pci0000:00/0000:00:08.1/0000:05:00.4/usb3/3-3/3-3:1.0/bluetooth/hc=
i0/hci0:1/0005:046D:B002.002D/input/input104

 (In reply to jbMacAZ from comment #5)
> The issue was fixed for the Asus T100 (baytrail) 2-in-1 family.  See this
> commit.
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.gi=
t/
> commit/?id=3Dc4c285da1ee18582ace366f07e56e355c20ebc49 which is in kernel =
4.15.=20

Is there a way to enable this system-wide without patching a kernel, for a
quick test?

I tried to add btusb.enable_autosuspend=3Dn kernel paremeter:

# cat /proc/cmdline=20
BOOT_IMAGE=3D/boot/vmlinuz-5.12.13-1-default
root=3DUUID=3Dece1a448-6944-4f34-a61c-1742fde2ac3c splash=3Dsilent psi=3D1
nvidia-drm.modeset=3D1 btusb.enable_autosuspend=3Dn quiet mitigations=3Dauto

# systool -v -m btusb=20=20=20=20=20=20=20=20=20=20=20=20
Module =3D "btusb"

  Attributes:
    coresize            =3D "69632"
    initsize            =3D "0"
    initstate           =3D "live"
    refcnt              =3D "0"
    srcversion          =3D "8EADE2557C147180496F74C"
    taint               =3D ""
    uevent              =3D <store method only>
    version             =3D "0.8"

  Parameters:
    disable_scofix      =3D "N"
    enable_autosuspend  =3D "N"
    force_scofix        =3D "N"
    reset               =3D "Y"

But this does not resolve the bug

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
