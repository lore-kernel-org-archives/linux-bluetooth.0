Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B3BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 20:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392240AbiDUULa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392218AbiDUULU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 16:11:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745794C795
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 13:08:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FE1E61D04
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 20:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 736CDC385A7
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 20:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650571708;
        bh=Ae1vxhhhycm6EMBWJ3kRmMrT8cEh9fonS89V5u90iZ0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nGiS9SM7Rg1Z2uxs58OYRrwaGeHT5j9edOMANYgC9VBCNupytrsPKDZzXoTSeiK+9
         XhHmMdzkMYFK9X5mGJbjvPL2UOGC4JlWDuxkaY8VZOSDVl6Jwr+qtYMRH7qLrOKPiR
         YoWA14je1rOUvS+C35TAK4zsI7njuFZRJYUEr7QA0wdWxgaJgYpxWlOMTE1mnYuCG3
         DaWznDRjkm9vVny2TBBDNeTmkJMtDAgnTJTI07rYhwGoHeWIHcPEuG2M867Y6JvmWJ
         SzjSs/fqU3tPm9s6/gfibJR/Yw5oE/hHCuvoTrQa8U5zoRVrQkp3ttydZw8aeJBrQO
         YFvnV/IcfHsyQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 60B04C05FD2; Thu, 21 Apr 2022 20:08:28 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215872] ath11k: QCA6390 firmware crashes after some time
Date:   Thu, 21 Apr 2022 20:08:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mail@kai-mast.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215872-62941-uWxmA5uZlv@https.bugzilla.kernel.org/>
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

--- Comment #2 from Kai Mast (mail@kai-mast.de) ---
Created attachment 300788
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300788&action=3Dedit
find /lib/firmware/ath11k/ -type f | xargs md5sum

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
