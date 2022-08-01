Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D59C00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 13:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiHANeo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 09:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiHANen (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 09:34:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5283DBF7
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 06:34:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF08F612E4
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 13:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40FD2C433D7
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 13:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659360882;
        bh=HkeirsBn7ivcwUu55gM5vGfjQrnZ53H9nQbk1a1hp1k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eKWtCZKOg4RYEWePLrzqjELTrGeAlFTe3w1kAr3ZffkuoigbzFrNRP4LQM22DdzxR
         GHeiSz+xi7j7PaSRrjx62v8S3Wr6OkAhw0e0tsKIVMhgY6NWXnMVstrP/Vds4pYfZu
         0b1jiSA+VSCxBcmHSRO/Ny5JB9ZbII0RkLuyiw3AGovKj2VQieleiy9P2x3oLllIGz
         JnfRL6w2A6/hDgBBrgh+aozRa+SnoOdEpHkyD92IqXW2dKgrAXyMw5SAxWykBJl0UJ
         vORpY2li615BHEWhA7InDb180J0VkhF7nBr5TTirvRukgmFWnDz6PJOhqBG/AaMY6F
         2G4/+tvxRJ5tQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 24603C433E4; Mon,  1 Aug 2022 13:34:42 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216314] After resume the host stops listening to incoming
 Bluetooth pairing requests
Date:   Mon, 01 Aug 2022 13:34:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kparal@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216314-62941-7k48nTDvfg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216314-62941@https.bugzilla.kernel.org/>
References: <bug-216314-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216314

Kamil Paral (kparal@redhat.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kparal@redhat.com

--- Comment #3 from Kamil Paral (kparal@redhat.com) ---
Downstream Fedora bug with some details and lots of people affected:
https://bugzilla.redhat.com/show_bug.cgi?id=3D2100761

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
