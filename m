Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157C3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 01:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E734B61053
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 01:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhKCBXP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 21:23:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231157AbhKCBXP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 21:23:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B5E7060FC4
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Nov 2021 01:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635902439;
        bh=bC3UL3oaYJzWc5wctzXxcQ9lxhJIrAdX2F8m8A9kBNw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A9bnS14Tp2fZzlAsKS8peDOtGOU9IVBVFCoQ0/vwWUoOQKY7qVtQkBiNuooA6ObX9
         ZNHcUMGOcfz1lsyrwcgZYrVRIXNzt/bBtOEQSlg/gbIdchGX8EZcX7iSVHECpAM+ir
         euISFU2aHLj+W7w0FDnPX8sUSLgZfjIEDVHtCbluZR2Md6ofv4Mx4Hw34bRf/UA3Ao
         I20Vi+7JJyINZgRbqLbGl6J6OZ78qlB8HzoPMzSM6S9AaDUzVU4a9Mu+BdM9I7LpiV
         CXTk/UEGmic+ny/Ms2RThGIpD2N0jrZ4kP1qQUxXqhTBdc5+Y8hA2tNr9ykmpAfqTl
         Fp2JV86MX7mqQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Wed, 03 Nov 2021 01:20:35 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-3xQMOKkVXL@https.bugzilla.kernel.org/>
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

Luis Oropeza (luisoropeza113@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luisoropeza113@gmail.com

--- Comment #203 from Luis Oropeza (luisoropeza113@gmail.com) ---
Hi, I'm facing this issue when my bluetooth dongle does not work in linux. =
I'm
not much handy when it comes to doing complicated things in linux, messing =
with
the kernel and stuff like that. I can't find information on how to use this
patch and also what is the actual patch.=20

My adapter id is the following: 0a12:0001

When I try to turn on bluetooth with bluetoothctl I recive this output: "no
default controller available"

and the output of hciconfig is the following:

hci0:   Type: Primary  Bus: USB
        BD Address: 00:1A:7D:DA:71:12  ACL MTU: 679:8  SCO MTU: 48:16
        DOWN=20
        RX bytes:367 acl:0 sco:0 events:12 errors:0
        TX bytes:37 acl:0 sco:0 commands:12 errors:0

I can't turn it up :(

English is not my first language so I'm sorry for any grammatical error, if
anyone could guide me in how to start and how to apply the patch I'd be on =
your
debt

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
