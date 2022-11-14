Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FB8C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Nov 2022 05:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiKNFjv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Nov 2022 00:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbiKNFjr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Nov 2022 00:39:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F122815FF3
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 21:39:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25ACD60DE4
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 05:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 796A5C433C1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 05:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668404384;
        bh=nzZx1xvJdkQB3Uf21ZcFNwA/eTuR5pfRBH5KWY0vf4s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tPQhIJOsKV4ZiDNq3tbEpIbKJePTNPjSHKXzMQIKEi5vk8tIlgA0wcf7GTSlzErZA
         ps1yFe51iJ30qEX1EVEUqZ4lWN4EnJJLrxaM2mAM8CrUM+y3RFxC5exD2tPuPVw24v
         6cakCxz6Bhuyfb6vgF0iQ6WO60tHJipZD+8VcKk6ksbipbZHDHaa1+hh+IeMhg7w2z
         HP2jNE0ZuOM1bHwUZkTd5BANO1V/kirSSIHdUPYcZX5zj6TAE8EXYOLwjaJFt+y2ls
         KxMCEpNWVcdhM75FAGqRfSB/BMLYBzFsCmkSySFlYmaIzrE+U2yTp9ctdJQyCoN2n9
         8bBBAdwh4dSKw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6532DC433E7; Mon, 14 Nov 2022 05:39:44 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216686] BUG: kernel NULL pointer dereference, address:
 0000000000000680
Date:   Mon, 14 Nov 2022 05:39:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: frc.gabriel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216686-62941-UNyTlcM94f@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216686-62941@https.bugzilla.kernel.org/>
References: <bug-216686-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216686

--- Comment #9 from frc.gabriel@gmail.com ---
Created attachment 303169
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303169&action=3Dedit
kernel messages from kern.log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
