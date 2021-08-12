Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC38AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 14:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 701FA610A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 14:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbhHLO2X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Aug 2021 10:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233293AbhHLO2X (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Aug 2021 10:28:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0DD436113B
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Aug 2021 14:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628778478;
        bh=r3MIe8Ao6UA21CvlDllc2RgMxgsSCXo/IzdZgFBlAwA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LmRXRnayoi2uNjvfT7ynvh77i91Y96u37J0Jh7zG+7i9cTLYVC1DkbmtgOU/oZTqr
         /HJxAW1Yz+oD78ozY3mf+4qYLvE2S/eVN/Y3cA7ij++nDUhMgDxhDswUHMav/YX35c
         nOskqXrSsI/gF2Nxrory9py/Iu5C+XtOAmzEJ/K//KPIYaV9SHkXMXacl1KcXY6jkB
         ebFxG8lzHmv7YjlsCvKPD9oUaZng3BHdduN4h9MB1GtM+isLiFIJDje3POA61qR8r9
         dwLo999mhXrMzw6XHmGs481uSQk8tUhRj4PnZpj6xHmIox/zkzAbJJLMOMOjE2WBCc
         h/IgsspS+ZO+w==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 12 Aug 2021 14:27:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jayfu@web.de
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-yzcZnUD3C8@https.bugzilla.kernel.org/>
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

Jay (jayfu@web.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jayfu@web.de

--- Comment #190 from Jay (jayfu@web.de) ---
With both patches I can finally use my China Bluetooth Dongle CSR V5.0! Wor=
ks
perfectly with my Sony bluetooth headset. Thanks a lot!
On Arch Linux 5.13.9-arch1-1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
