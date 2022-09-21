Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E52C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 12:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiIUM5z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 08:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIUM5x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 08:57:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6965C6CF58
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 05:57:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E16EB82F83
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 12:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFCECC4347C
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 12:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663765066;
        bh=70lnFvnxB2IzIVvZ7AMDx59+dbRhVh/eYqOOdtKr5cg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ic2GaLMTqDintaxDj8EebcdX97w28+uPj6JP9Wp5K7DCkP3Fj/t7I5Jyuwy9SrCJt
         vGFQZ52BdWsnaVixDgiHMtmpd49uG1EJm29dhhKYnhB0yg+g5gSKJSrex1cNpYjTTj
         /ZdwI4MQDvwTgXGLv3PIM2IsmAHCb+Ygyc+zHLulPhOQ9oeb9wNE1OYpRGI5W0isLa
         wHFD9d32pWQq+SdUp3vTHOmMZIlIIO/EGh/GHGhdFDrOuS2+YccyvVer4TfMkU54bC
         cKgdafAenXTd76Ii5ucBjST7B6ipYiTgFjbiPNrr0mPufVkc7KSJHNFHQL+TeOYCK9
         7NNWGx3Iu13gA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id ADB3EC433E7; Wed, 21 Sep 2022 12:57:46 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203753] Bluetooth: hci0: advertising data len corrected
Date:   Wed, 21 Sep 2022 12:57:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: xymox18@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203753-62941-VcOfKRWr6l@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203753-62941@https.bugzilla.kernel.org/>
References: <bug-203753-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D203753

Diego Rodriguez (xymox18@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |xymox18@gmail.com

--- Comment #11 from Diego Rodriguez (xymox18@gmail.com) ---
(In reply to Pablo AB from comment #10)
> Ubuntu 20.04.3 LTS, kernel 5.4.0-91-generic, bluez 5.53-0ubuntu3.4
>=20
> It happens to me *only* with Sony WH-1000XM4 (LE_WH-1000XM4). Tested with
> journalctl -xef -p warning on one terminal and bt-device -l on other. All
> the other BT devices doesn't produce this.

Hello i have the same problem in my Ubuntu-Budgie 20.04.5 LTS with kernel
5.4.0-126-generic.

I just bought a dongle SABRENT Cle Bluetooth 4.0 USB pour PC [Classe 2 v4.0=
 =C3=A0
Basse consommation] (BT-UB40)
(https://www.amazon.fr/Sabrent-Adaptateur-Bluetooth-V4-0-Classe-technologie=
/dp/B06XHY5VXF),
in the description they say "Plug and Play" in Linux, the dongle was
immediately recognized and i see all the devices around me ... but when i t=
ry
to connect to my Soundcore Motion+, in the devices list i see the device is
connected and immediately disconnected, when i execute the journalctl -xef =
-p
warning i have these 2 lines:

> bluetoothd[1038]: a2dp-sink profile connect failed for 7C:96:D2:AD:4E:AC:=
 Protocol not available
> bluetoothd[1038]: a2dp-source profile connect failed for 7C:96:D2:AD:4E:A=
C: Protocol not available

So after a little search in google i find and try this:

+ sudo apt-get install pulseaudio-module-bluetooth
+ sudo killall pulseaudio
+ pulseaudio --start=20=20=20=20
+ sudo systemctl restart bluetooth

Is much better if you restart your PC, because after "pulseaudio --start" my
audio stopped :p
When i got back into my Ubuntu (restart) everything work great.

I hope that can help you.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
