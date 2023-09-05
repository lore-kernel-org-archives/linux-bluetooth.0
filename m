Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5DFCA0FE2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 16:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjIEQWg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354526AbjIEMUw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 08:20:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6CA1A8
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 05:20:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 97310CE10AC
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 12:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1A44C433C8
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 12:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693916444;
        bh=3mEjorwAVXYo4EEaEn1AdebE49zW/CvgRE78GYuzTXY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lle8XPJ8BXaoS+GqOGkdRUea4oTv2IpOLM7FFGAA4xb6xIdL63PlJbrB9inyt0Bu4
         GiUE5dKj7wBcrduVrwWKAPvmH8R09dynkoqtNTcJfcn0bMh3IodiQOVV2H6BMdqqaD
         EICU3W25lNKChCjCJUzqNXudiZ9ofGzYxErTjczJvwFwfSXlLrWc95WFpMjkuBYm0g
         O9B+kFXHt7XhmKNsmskkW7qHXN85vGMcCSxaKanGROtJm/ihiXS6Ce+zZQEDBgz/mJ
         msgXZAc4uC4xCACNzVaG8zvVe+ZS8E0jJwMLexmvMMds9ASwaD9z52RdmPo4vBoGGQ
         M4ifIqN1qdGiQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DBF30C53BCD; Tue,  5 Sep 2023 12:20:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217870] ATS2851 chipset for Baseus BA07 Bluetooth does not
 connect, no bluetooth device connects, adapter does not turn on
Date:   Tue, 05 Sep 2023 12:20:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: bagasdotme@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217870-62941-5KnWoOvnU1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217870-62941@https.bugzilla.kernel.org/>
References: <bug-217870-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217870

Bagas Sanjaya (bagasdotme@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bagasdotme@gmail.com

--- Comment #1 from Bagas Sanjaya (bagasdotme@gmail.com) ---
(In reply to mg-tatangelo@hotmail.com.br from comment #0)
> doesn't connect/bugs on linux, mainly on KDE, on KDE it doesn't even show
> that it's connected, on gnome it shows that the adapter is connected, but=
 it
> looks like it's plugged in and not plugged in at the same time, like, it
> really, IT IS CONNECTED, but it appears that it is off, no device appears=
 to
> pair and when it appears (rare occasions), it keeps loading infinitely wh=
en
> I click to make the connection, an interesting fact that happened and I w=
ill
> leave it here as a help: when I I use a virtual machine with Linux, THE
> SOUND CATCHES, the adapter picks up, I can hear what comes out of the
> virtual machine, with the same headphones that I try to connect to the
> bluetooth adapter and it does not go when Linux is my main OS, the only T=
he
> thing that doesn't work is the phone, through the virtual machine, but the
> sound comes out! so probably the chipset works, but it must be misconfigu=
red
> or have little/no support for the chipset and that's it, I hope you can h=
elp
> me, hugs!

Sorry but can you attach full dmesg output?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
