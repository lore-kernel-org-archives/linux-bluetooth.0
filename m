Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79957C10F1B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Dec 2022 16:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiL0QBT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Dec 2022 11:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiL0QBA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Dec 2022 11:01:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1FEB0B
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Dec 2022 08:00:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF5916119B
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Dec 2022 16:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EF19C433F2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Dec 2022 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672156858;
        bh=b7BetzGSgSHZ9AD/ozVEZW0IgC3x/3A33afol6vuzXw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=khOa4Knn3DpAlpgTBy2Pi3zH2sr/Xd/Y9skw5Iylfi5rwnd/dm1weSCUSPD2DyiQQ
         fONZKPC4CoJgtWCKbUl5TmNxJzPGc4XFpCsgt5GrdC0ibXWAyzhwvi5Y4TWA6tuoCH
         JBmT2of1447PZb4eQA3xNqSvpZ9ujwFhfdMQcDyUHzeZGTpVMfh8am6GxcWjtsEO+R
         fTX5i2VP7CMXoTA8evDtgzeFI7yAfk9sQLjlp2EVVmOPgk+YmKLxOhq7TJ4N1prQH2
         hnxkGs8Qpe5EWsTs+T5I22Z6vXwOjS3AxqfgEjQpAQTXyLF4ScNKqpGUvp4OMr9Qus
         YF0F4Q5MLJaRw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 38410C05FD2; Tue, 27 Dec 2022 16:00:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215872] QCA6390 firmware crashes after some time
Date:   Tue, 27 Dec 2022 16:00:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mark.herbert42@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215872-62941-eJKNPT0ov2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215872-62941@https.bugzilla.kernel.org/>
References: <bug-215872-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215872

Mark Herbert (mark.herbert42@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mark.herbert42@gmail.com

--- Comment #6 from Mark Herbert (mark.herbert42@gmail.com) ---
(In reply to Jakub Kicinski from comment #5)
> I believe this is closed by
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commi=
t/
> ?id=3Dd44e1dbda36fff5d7c2586683c4adc0963aef908 upstream.

It is not. QCA6390 bluetooth is not USB, it is serial device. So all btusb
changes can not help here at all.

It is still crashes from at least 5.17 up to 6.2-rc1, and what is bad it can
not be reactivated by any means except of total power off. Reboot does not =
help
- unless it is reboot to Windows.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
