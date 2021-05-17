Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93942C43460
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 10:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7108861029
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 10:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhEQKBl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 06:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236356AbhEQKBF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 06:01:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9539961359
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621245589;
        bh=Vz6o6ZJwWDw8Ao0AAQARQI+w5Gfs9++PeDMl2aI1PIA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PserX74a16Bhsre8+K6p2JZuqjGPi4aITppsDnpKOVxmKnPtTHbSZMatVhb9ZvbIE
         j0l/jOxq8mkNPf2rLlDVh/Uv8eZEagAiwGLccvdmPafMGz7UTicRrlUnZCCmMqw416
         yefoVp3aXMRW7wofBgkJBogupEgcUfHtEEXpmAml8FrCaAo9X8oPffBZvU816YsEbq
         uFTF5ELrnBnQcKYSVME/1x48gkWw/gGT643cVDzq6z2vQPHCT6o++2cfyaj2DoBLUl
         ZfijyW3Pia68/rUfUBNVOphVczNTFfFcuZxsszYrXoFT8Oa74EeMRXE1AfLauC/SJq
         yTQdd/bC76MUw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 17 May 2021 09:59:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jwrdegoede@fedoraproject.org
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-BT5Xu8Pjvb@https.bugzilla.kernel.org/>
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

--- Comment #178 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
(In reply to mirh from comment #177)
> I could only test this now with the Windows 7 default CSR drivers, but
> indeed this is what happens.=20
>=20
> I tried directly all the row of ports on the P5QPL-AM, and not a single
> hitch. I plugged in my "Techole UH411" USB hub (technically it's USB 3, b=
ut
> I'd hope it doesn't matter much on this motherboard), and boom. Basically
> same behaviour I was getting on the newer PC with connection and
> disconnection cycles all over the place.

Ok, so it misbehaves with the Windows drivers too once a USB-2 hub (with its
TT) gets into play. So other then only using the dongle directly plugged in=
to
really old (by now) motherboars there really is not much which you can do h=
ere
I'm afraid.

I suggest you buy a new dongle. If you search on say aliexpress (*) for csr=
8510
then you will find several dongles which are advertised as "original csr8510
chip" in my experience these indeed contain a real CSR8510 chip and they wo=
rk a
lot better then the clones. So the best advice which I have is just to order
one of those.

This advice goes for everyone in this thread who is still having issues. Tr=
ying
to get these clone to work with Linux is a good thing to do, since this will
also help other users with such clones. But if you just want something which
works then just buying a dongle with a real CSR8510 chip is the way to go
(these things are pretty affordable).



*) Not my favorite source because of the environmental impact of shipping, =
but
...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
