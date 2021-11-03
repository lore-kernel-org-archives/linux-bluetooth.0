Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB3BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 17:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4483E60EDF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 17:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhKCR7S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Nov 2021 13:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhKCR7R (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Nov 2021 13:59:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C617161157
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Nov 2021 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635962200;
        bh=3G4P9Pf7YA5Xevw3LdlApGgszV2bFf0gq/HkZuGFC8o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uRzxvigYypKr1u7ZTtnfoToRiIlBpGn5qUeKaVn4Ayq4Zvl5UF9D87dT2GXThZ0bY
         hQY4Kud361JIwGvtbSl8Ml0R3vpWgKrDjw2VgFZlmjp2szuHrqsOTE69pTm0XVd9hR
         MHR88nRRPuOxeiFcjuhbGu41dAFvSIuYed6nCw4DdwVu+T3KoNdr7WLkwgWXdWTw96
         9lVaWT+iyLgYzwSb+F7x/R4JJJ4EmjEZr4Q2MKDMqiSb7bhYm3mIsgzC96VvSX+DWb
         Q16dxPU5ptPRyjfn57jbQCHg0DCAn/BFoQYZaHMG9DLphEax4LeMEjrtqiou3HtiBB
         IaDeYjhwBkC7w==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Wed, 03 Nov 2021 17:56:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luisoropeza113@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-YEWYCBG9xb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #205 from Luis Oropeza (luisoropeza113@gmail.com) ---


(In reply to guimarcalsilva from comment #204)
> (In reply to Luis Oropeza from comment #203)
> > Hi, I'm facing this issue when my bluetooth dongle does not work in lin=
ux.
> > I'm not much handy when it comes to doing complicated things in linux,
> > messing with the kernel and stuff like that. I can't find information on
> how
> > to use this patch and also what is the actual patch.=20
> >=20
> > My adapter id is the following: 0a12:0001
> >=20
> > When I try to turn on bluetooth with bluetoothctl I recive this output:=
 "no
> > default controller available"
> >=20
> > and the output of hciconfig is the following:
> >=20
> > hci0: Type: Primary  Bus: USB
> >       BD Address: 00:1A:7D:DA:71:12  ACL MTU: 679:8  SCO MTU: 48:16
> >       DOWN=20
> >       RX bytes:367 acl:0 sco:0 events:12 errors:0
> >       TX bytes:37 acl:0 sco:0 commands:12 errors:0
> >=20
> > I can't turn it up :(
> >=20
> > English is not my first language so I'm sorry for any grammatical error=
, if
> > anyone could guide me in how to start and how to apply the patch I'd be=
 on
> > your debt
>=20
> I also can't get it to work even with the patches, but the patch should be
> already available by default starting from linux 5.14.
>=20
> To know your kernel version, just type in a terminal
>=20
> uname -r
>=20
> If your kernel is older than version 5.14, you can try updating your dist=
ro
> or trying another with a more recent kernel like Fedora or Manjaro. You c=
an
> simply boot with USB without installing and test your Bluetooth dongle.

I've been using fedora 34, and there was no use, yesterday I updated to fed=
ora
35 and the issue remains. I try using manjaro in live usb mode but is the s=
ame,
I can't get it to work. My kernel version 5.14.10-300.fc35.x86_64

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
