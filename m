Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450F1C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Oct 2022 13:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJKNWr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Oct 2022 09:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJKNWL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Oct 2022 09:22:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C8360FE
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 06:21:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9253611AB
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 13:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 605A3C43143
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 13:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665494486;
        bh=YeOuAiUlvVcEmxjNsXZnKbWZFKNmAhUH9SAOSygYsqA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GsgeRYI23lmmu3sBIWJIFyizWEbaRmUE1g7fmimaNzmPXqhvoYtc/Tq8EOV3niTIQ
         5gDjHIlPiGTMS2JPpDUHc0CaQMC+UYAGsIyo5g4GDlbYQj+pWx1uHaPUyjGehzn7ZI
         UOShpW8aWGeJs8CDssthYhJuViq6Sq1E0WHGLzOMqRHPWEjzDAx/Q58jsQu7lCYrih
         zuwMdfEv5xFwYBl8+2eTl6zMmyas/KbwfEAwJvHUA/xasQiIVewDRbgVbHxTqwHJET
         LfonNqkbAEEc03YBQUojQ+P0DwUqmf54sJcx7eRmboVukLHukG8x6f+86+85QqHijy
         mxLS5hD5iix9Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4C147C433E6; Tue, 11 Oct 2022 13:21:26 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Tue, 11 Oct 2022 13:21:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ostroffjh@users.sourceforge.net
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-wd3BsfJI8Q@https.bugzilla.kernel.org/>
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

--- Comment #234 from Jack (ostroffjh@users.sourceforge.net) ---
I'll try to do that, and I can try bisection.  The good (?) news is that I =
have
repeated the failure in a reboot, but without those long traces in dmesg, so
that bit might just be a red herring.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
