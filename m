Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C309FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 13:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87416613F8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 13:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhEFNlu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 May 2021 09:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233853AbhEFNls (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 May 2021 09:41:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 93DAD61426
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 May 2021 13:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620308450;
        bh=lf/2PnGwQsJY8yRyWUM3dSPX06MYM8DU6OC+l3rJRIo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Fce8KBWxLYBNvjEe4Tqn5BsVHd0asEPj98lyhiYqESe6FbYfADm+saFOr+TLEOACT
         Jwlq/7f2VXECx7dQB0NfUkstazAWopT7KLD7ZXvlGxf+CoSmbVzFa1coQluVQJgZC8
         eQ+tVWGDZAWwYmATedL2M6dB77HyASd3AY/JOxS+xQm3lyKpaOrY3hKSSV04NxFZ7T
         yYqSxi9/ER5f53M1EDV67yNlCDdUayAp0pktKMVR87UsptiPrFBmi5aKncvmAsUdQl
         5guurmtvGGD6hleEM/oRi9ee9hHaF7aVZ26o5Ukv0abWRr7IpS0LlSA81SEe0dYvJD
         N8om8aEYIdzAA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 06 May 2021 13:40:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: diegosiao@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-VLzJCod1HJ@https.bugzilla.kernel.org/>
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

--- Comment #176 from Diego Morais (diegosiao@gmail.com) ---
(In reply to Steeve McCauley from comment #175)
> (In reply to Diego Morais from comment #174)
> > I have a CSR Dongle with the exact same problem on Debian 10. I am a new
> > linux user, so my question is how to apply the patch suggested this com=
ment
> > (In reply to Gustavo Padovan from comment #6)
> > > Created attachment 107379 [details]
> > > mark Delete Stored Keys as non-critical failure
> > >=20
> > > Please apply this patch and check if it works. Also capture logs and =
send
> > > them here.
> > >=20
> > > This is a modified version of a patch Johan Hedberg did some time ago.
> >=20
> >=20
> >=20
> > Thanks
>=20
> Probably best to ask for debian advice in a debian forum.  I'm not a debi=
an
> user but I'd try updating the kernel, found this on google,
>=20
> https://www.osradar.com/how-to-install-linux-kernel-5-10-debian-10/

Thanks for your response.

Installed the kernel mentioned with no success.

uname -r
5.10.0-0.bpo.4-amd64

I would like to try applying the patch mentioned in my last post, is it
complicated?

Thanks again!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
