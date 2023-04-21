Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D587C77B75
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Apr 2023 09:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjDUJAO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Apr 2023 05:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjDUJAB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Apr 2023 05:00:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D553C0F
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 02:00:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68A9D64DFB
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 09:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0EA3C433D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 08:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682067599;
        bh=X84MRdiaWv3YsiEEU26soHaVPBDOyK2xCdVSeUbn5gY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fRyd/bHPP26C1EV8a5PdvTAsB5r1TEpSIl8svoKj4VThesQXOrsSgZTBj8L28NUj3
         yDGDe+EiHFGwHSMO6xC3z62GXoQg7b8Q3htJqdzUC+rBC73SYau4IAMRitVlVMZfPk
         rwnP7WvQFtCcvPbyeO33ZTRmkbMKszmz5iemI2LFZJILJQHNfgwM5KLMTvzv7ZuX61
         PvHswJ9U7TNci3iy/8v+1YRMGf5BHKMb2HbLp5MoPWvkuqum0vqfgLBOhv4NZDlhdA
         rIim7F304stFTjRIUkr5k4+ZFYEBlO9oc88Ze17wpYZZCZeKTPy6xKj3ofvwENTTyy
         o+8NNMWT6yyCQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AF5ACC43143; Fri, 21 Apr 2023 08:59:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217256] Bluetooth disappears after suspend
Date:   Fri, 21 Apr 2023 08:59:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217256-62941-SmWDsmXFsk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217256-62941@https.bugzilla.kernel.org/>
References: <bug-217256-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217256

--- Comment #4 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
FWIW, that's up to the bluetooth developers, as it's not a regression. Not =
sure
if they have seen it here. I think they sometimes are active in bugzilla, b=
ut
I'm not sure (participating is optional here, that's why
https://docs.kernel.org/admin-guide/reporting-issues.html discourages the u=
se,
unless developers stated they participate). Using the mailing list would be=
 the
saver bet. But if you do, you want to mentioned it here; and you want to ch=
eck
if that problem still happens in mainline.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
