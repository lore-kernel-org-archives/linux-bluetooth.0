Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A22C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Jan 2022 18:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiAASzh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Jan 2022 13:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiAASzh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Jan 2022 13:55:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4F2C061574
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jan 2022 10:55:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED812B8092C
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jan 2022 18:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3CB0C36AF1
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jan 2022 18:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641063333;
        bh=btCA4K68J9PZiwvdp7sewS05bSqYqC8sUzJdHDMVX2E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=o26UNzJqURFLM5bpWGF+OmDkIPPXqpv+v9BirQlrzPPNYAeNu6uhGpeD5lY+ZoORX
         tcVzCtZHVOIGNxoLHXFBR1MLrg+UAttFoDgWAsxK8SN4UVcPzkNu5O+u0nxUOauyBR
         33c1Q+WlkYaXdAFfzszxwS7goyyzRRRJwQpY3jVDjdvuKlCA/Ej6G/GvGjcFIs07oZ
         tEPFBk+ApgU96mNHcl5ugspOGbwWrUnAQNMPMWeeCcGabJZzIYLbUPhyxldnRPTSii
         vZJ+95aHY8szCN8XD+Eid3pfq0MAmQHjXXWsmvhLkaBBY7eG6TXawOh74nrCXbOlFd
         kecs4I1NErTtA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A4DE8C05FCA; Sat,  1 Jan 2022 18:55:33 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 01 Jan 2022 18:55:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-0ETiucIvMe@https.bugzilla.kernel.org/>
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

--- Comment #211 from Swyter (swyterzone@gmail.com) ---
pverda: Please try running this patch to see if your [HCI Revision: 0x3120,=
 LMP
Subversion: 0x22bb] dongle likes it, maybe the problem is due to the notori=
ous
HCI_FLT_CLEAR_ALL bug, like most of the remaining ones:
https://raw.githubusercontent.com/void-linux/void-packages/be587c070716d820=
eceee2377f966874ae51eb67/srcpkgs/linux5.15/patches/btusb-quirk-HCI_FLT_CLEA=
R_ALL.patch

I checked and I actually own what seems like the same BT 4.0 "V5.0" (note t=
he
lack of space) marked dongle. Same internal IDs for everything, and it works
fine with that patch. So give it a go.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
