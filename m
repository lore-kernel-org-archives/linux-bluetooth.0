Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80844C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 May 2022 13:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiEYNQQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 May 2022 09:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiEYNQO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 May 2022 09:16:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261D3DFC6
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 06:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8E8E61803
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 13:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B4F0C341C8
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653484573;
        bh=MDzJ5V0k0CPVauGDIXt/fQikiceYyc7kIqnSxFzjwzk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HACdblL6xjGKCaamEjIInkdIjENiQXm7wgGQVm+J8WdDreEEQLNRhLX5osHj08OYf
         wUbf47qsjn2YOrDtG1vXQJDwL6NQUW32yESOu517HqJ/dUEUb7TdCm6lsqsMm5Xx6u
         edHNRlgB3+RXosiOXz/ZXi0v5w+yCbmUOdYPGHAlPqygU8+n3qiJaozBkXJNkUR1//
         MfetEvUPR1Sk1e9GyNE26KNjuvggboVB9KzX6zxMkWr816Pu0Bv0Ypud2RGAcnGYxI
         ZAkZeu1BYGOtjUEuH47wZdg2WCpmd2MQ+pc9bb5AKn50BW/20eykxQs/ojyGRCV1hd
         O5ssPKK5XgcVg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1CB6FC05FF5; Wed, 25 May 2022 13:16:13 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Wed, 25 May 2022 13:16:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jmennius@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-5nR1449JAd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

--- Comment #35 from Ievgen Popovych (jmennius@gmail.com) ---
@Paul
I am not exactly sure what you were referring to in your question (regressi=
on
or not) so I'll answer broadly.

The last occurrence of `kernel: Bluetooth: hci0: Failed to read codec
capabilities (-56)` was on 5.16.12. So that one seems to be fixed (did not =
see
it since 5.16.14).

The last occurrence of `command 0xfc05 tx timeout` was on 5.17.8 (i.e. now =
for
me).

Most common commands that suffer from timeouts or errors are 0xfc05, 0x0c01,
0x0c1a, 0x0408.

I will try to collect logs as you've suggested.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
