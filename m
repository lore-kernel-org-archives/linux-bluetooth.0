Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8EBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 02:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiKVC4d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 21:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiKVC4b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 21:56:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28339178B2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 18:56:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C68A1B818E7
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 02:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79FB0C433C1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 02:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669085787;
        bh=+rowzngtVDsT7zaL/vM/kxBoIqvQnMsbKEMXASVdGv4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YUD/Ed3AbADU6WudXSc6BeFTmKrSPyKTf0MQzGEyLp+Ewv8nrddZJZkiJz5mWTqw5
         lXiHqQnpO0ya2HUd2OBV8sPp2QsUi7TDCTm5BwsCY3OUcMzHqFu+5C1TuhvxI0H+k7
         lrWVvOvqzISR+2/i9ajA0tfrj1X1J2piS2FTjb11qM9rwPbkZwceOY7c5GJ8NEf9y8
         bJteLvzkQOklxAd7p4vvgQlf6ezKqzi75Xk0WCjQ/rnTVmPRCl7I3EgqPMCkBlI8t0
         gygLrZxC7AmpMg/1mbNsU/Jh3I/M9smnURWcZc6zYftOIwlVFZ4eVke4TqrEC9GbBY
         04YzPv/Rg+Gyg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6BB77C433E4; Tue, 22 Nov 2022 02:56:27 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Tue, 22 Nov 2022 02:56:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lelgenio@disroot.org
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-60824-62941-IHJJESE0Ep@https.bugzilla.kernel.org/>
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

Leonardo Eug=C3=AAnio (lelgenio@disroot.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lelgenio@disroot.org

--- Comment #258 from Leonardo Eug=C3=AAnio (lelgenio@disroot.org) ---
Created attachment 303259
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303259&action=3Dedit
kernel fault with CSR 5.0 dongle

Using patch series 690177, here's the `dmesg` output for the issue mentione=
d by
JustANormalTinkererMihir, where the dongle is plugged and unplugged repeate=
dly
and causes a kernel fault. This problem also occurs randomly during normal
usage after a while even if not connected to anything.

The bug report mentioned by JustANormalTinkererMihir seems to be missing so=
 I'm
leaving this report here.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
