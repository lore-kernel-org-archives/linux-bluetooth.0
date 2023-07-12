Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D084C001DD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 06:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjGLGcb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 02:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjGLGbk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 02:31:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B98211F
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 23:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 995DA616E6
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 06:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06D52C433CA
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 06:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689143398;
        bh=s8XQ4z6LPJRXPzEh4EQoDPbonH4TMU0Svuc2qvlrzlc=;
        h=From:To:Subject:Date:From;
        b=K34+7N3sgY57bkCguH+zlt9IoNSDNBsAKCrQi9pifWzCsCMLwhEsln4gXaVLETVpe
         FQbpUGEHYFjxOw0WcONSu8QMqcDZSkVK3AhWWYqiIcrvkG0r4iMRNBnjtIW/l1o5td
         z7XPMA8qAtdeds0/4idBGk6rLyruoVmcjTSotRSmv40G1BdYyki5air+lZRlheOJ0W
         hpX8jNDs9Vw2Tq3pe7ox3uuo7GgpNeh6rlVPycrEJJQwwzkmTri+O9kt3yS2sOxvlg
         ydg6KiEmRmXF931ISEKReSXJA30W1cs1VnAUcSpDWqsAp7ZeuN6gA+loZE49Tz2voi
         7CLzHNNs+e//Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E2F0CC4332E; Wed, 12 Jul 2023 06:29:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217663] New: Bluetooth GPS modules profile unavailable
Date:   Wed, 12 Jul 2023 06:29:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dicetrash@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217663-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217663

            Bug ID: 217663
           Summary: Bluetooth GPS modules profile unavailable
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: dicetrash@gmail.com
        Regression: No

bluetoothctl: 5.66
Linux version 5.10.110-3+=20

As a pilot I have a bluetooth skypro gps module, this module works with and=
roid
and ipads.
Specifically I have an XGPS160, when I attempt to connect with bluetoothctl=
 I
get the error

[CHG] Device 00:19:01:40:62:32 ServicesResolved: yes
Failed to connect: org.bluez.Error.NotAvailable
br-connection-profile-unavailable
[CHG] Device 00:19:01:40:62:32 ServicesResolved: no

I attempted to debug the device and received its services list with Qt
Bluetooth, it identifies its service as {00001101-0000-1000-8000-00805f9b34=
fb}

I am under the impression it is a sort of serial device that gpsd would be =
able
to read from.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
