Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF858C77B73
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 May 2023 09:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjEAJD2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 May 2023 05:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEAJD1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 May 2023 05:03:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E320510D8
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 May 2023 02:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13A6A61BAA
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 May 2023 09:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 738BCC43446
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 May 2023 09:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682931744;
        bh=CpMih+Y6al+M6UaN6xQf6e/00vdwXmyVY7x8fv8VJI0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FAXbiTrzqPdrO1GbyQZFkIWXq4c1e4Yxnq3DlwBD4EKY/YfSwH6n+dRmJHJDocnRK
         SL2Tc+PeISWS8iv/sEX1CDxzyUaUqdgF1zF7s+R1DVIGfhFC0NQ2lA1UCbQVrZ3Z0U
         JoodTyRchw1k08GG06Kizluf2zXY5eSySYkmp1n8GUWf4Az/18ULt4azSe0NCl9iF6
         QjQj5ePtjhV54capIwejkNIY/JfNccHyMQJMaaasoDtSTKyYpSpf4ggwi5MbHvrgdS
         fGGMB5dFEmcgWB6Q8RmXHkjtVU9ms8Y2ymIzeVrhlrC8PPoIcWNHB7YgtTGNclvssj
         7vPh0PNBvc8TA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 63B30C43141; Mon,  1 May 2023 09:02:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Mon, 01 May 2023 09:02:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pieroavola@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-wT6cNpLbiK@https.bugzilla.kernel.org/>
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

--- Comment #51 from Piero Avola (pieroavola@gmail.com) ---
(In reply to Dan from comment #50)
> There is a workaround found by hmmsjan.
>=20
> su -c "modprobe -r btusb;sleep 2;modprobe btusb"

Unfortunately that workaround does not work 100% of the time. Usually
re-running it after 10-15 does the job, but also that does not always work =
for
me.

In either case that doesn't solve the problem. Bluetooth should work after
every boot without intervention.

I'll see if I get around testing the patch from comment #48.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
