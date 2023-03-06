Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763F3C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Mar 2023 19:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCFToW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Mar 2023 14:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCFToJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Mar 2023 14:44:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5337EE0
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 11:44:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84A7DB8108B
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 19:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24E54C4339B
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 19:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678131838;
        bh=wYCCzZa12jWrgFKQ/rgXM0DJSO2s0w3q091e/fgT760=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qUfxdF437TK4Sa1eHve9ssdxfjJE+Gi/49UHHkuxWyqHxbObTBEC2k91iHKG6PKLD
         zmltEwj6+l2xo8seYEdejNTRKLM6wEro53ewy9Xp0o6IG+Tzv8fx2D827vm9AEBnVT
         p+maU3i3IH5xPCkldslnD5IR1eBwI8F1IFcnPhdKaEHTMDNcKGvZMkQY1ZX5qcN6pH
         syoei2+E34JsD+pUtlqUl1ygBGaQNfUhf7dm9KyFLkeewEjPlvr9Y/K+DqYcqpb2Td
         uT/O2svKTH55oKkMhwicRxH7aBBRX8dTshJzNtl8iHfbhodFkxOXl6K2dIFmhh93tz
         nL42ESmunTLCg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0B756C43141; Mon,  6 Mar 2023 19:43:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217150] Bluetooth USB Adapter that comes with Xbox One Wireless
 Controller stopped working on 6.3 rc1
Date:   Mon, 06 Mar 2023 19:43:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cmarobnjak@cock.email
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217150-62941-iFU9FwehXP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217150-62941@https.bugzilla.kernel.org/>
References: <bug-217150-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217150

--- Comment #1 from Smokus (cmarobnjak@cock.email) ---
Created attachment 303886
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303886&action=3Dedit
6.3 rc1 output of lsusb -t

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
