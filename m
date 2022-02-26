Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF4BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Feb 2022 15:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiBZPbp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Feb 2022 10:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiBZPbo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Feb 2022 10:31:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34573288635
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 07:31:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEF7FB80814
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 15:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57C46C340F4
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 15:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645889466;
        bh=0eDVAv7i0aB7rpA0v9VfM0k3q31x0KdoHd7LxxscUlU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oXk8OJtxHLKWtm5/I/MVMT3xK9S3rAM08Z+MULKUU4Tjg83VgSqzgCTMC9QPFRuW3
         AIAlYpFGtMEEqBSlglRvclsUp6BPTwdXxJ7n7WuyJTZrezx+wZbTnumukDKXn1/iuv
         cZ2GETDOS/1dXx+apcUNTWWF8YJ6VXP9rnN5/XQR2dOywusXyVoh4EKNxfDFaAC9zX
         gOfGkazTZ5LsQsNCc83bCalRXTk97SBpbattq5sY3wpfdT+ahP9yd9nhPe4EQR9Kq0
         p5EKYrIMQR3TJlyAo9ZXiP0NT9xB0vY8Gp1BYjmKx4lA/8LyPexv6aMsb7hvO9HSpu
         L8HzbQRHn3Fbw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 436CCC05FD2; Sat, 26 Feb 2022 15:31:06 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Sat, 26 Feb 2022 15:31:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wavexx@thregr.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215576-62941-ZOvNVWO6XR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

--- Comment #6 from wavexx@thregr.org ---
Commit b2af264ad3af437238c9500aa830ebcafb180e05 doesn't revert cleanly
anymore. Looking at the code however, it's obvious that just setting
BT_CODEC_MSBC can't work, since hci_enhanced_setup_sync_conn itself
only handles TRANSPARENT (which looks like it's already mSBC underneath)
and CVSD.

However I tried to brutally disable enhanced synchronous connection
support, which is what the commit adds, by doing:

> diff -rud linux-5.16.11.Orig/include/net/bluetooth/hci_core.h
> linux-5.16.11/include/net/bluetooth/hci_core.h
> --- linux-5.16.11.Orig/include/net/bluetooth/hci_core.h 2022-02-23
> 12:06:08.000000000 +0100
> +++ linux-5.16.11/include/net/bluetooth/hci_core.h      2022-02-26
> 16:00:44.896727458 +0100
> @@ -1465,7 +1465,8 @@
>  #define use_ll_privacy(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
>=20
>  /* Use enhanced synchronous connection if command is supported */
> -#define enhanced_sco_capable(dev) ((dev)->commands[29] & 0x08)
> +#define enhanced_sco_capable(dev) (false)
>=20
>  /* Use ext scanning if set ext scan param and ext scan enable is support=
ed
>  */
>  #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \

and this "unbreaks" mSBC even on a current kernel.

I'm not familiar with BT at all, but again doesn't seem to be a
controller-specific issue at all.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
