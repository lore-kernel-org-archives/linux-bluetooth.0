Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB6DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Nov 2022 21:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiKQVZf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 16:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240816AbiKQVZN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 16:25:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDD6103A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 13:22:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07659B82205
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4B03C4314A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668720170;
        bh=hjByUZgSPqw/wBwaLbpWtj/NCcdqX8zwXAMufynzTHI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pjRO0nI0M8n4UMtKG7Zf3tRqzSxn4Sybf0vQnm19kL3QaZV56+XZJ1a6flTyjiBFv
         Or8Dx1xO4yQJDLAjgyIS7guy1/1g9Qr4M3Dln7sqJn9G5T29E6VrRAn6C34AzkbhxG
         uOtzwPP6hFQdZ/KVZ8tM9fpe867xOqpGOxbucSrBaAcSBxqOi1Eg54AOzT3tOkuN2Z
         7w+C0xvTT3/i3pUpIJ57qmQ6Sm3ACcRJEW/AA0kpCJXkMpYcax2iH9np0fFV4cW81w
         +aDxtEGn2c5hKwprTxe7fKgcyPpbiW0FitNUJgTgcnDSPklIqtQthXFB4NJnF6DSOb
         z7LnGObmzdsNQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9C029C433E9; Thu, 17 Nov 2022 21:22:50 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215197] Memory leaks show up when using Edimax Wi-Fi N150
 Bluetooth/Wireless USB Adapter (RTL8XXXU)
Date:   Thu, 17 Nov 2022 21:22:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: network-wireless
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rtl8821cerfe2@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215197-62941-jtZbl20DGt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215197-62941@https.bugzilla.kernel.org/>
References: <bug-215197-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215197

rtl8821cerfe2@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rtl8821cerfe2@gmail.com

--- Comment #8 from rtl8821cerfe2@gmail.com ---
Hi!

Can you check if this 100% untested patch fixes the leak?

diff --git a/rtl8xxxu_core.c b/rtl8xxxu_core.c
index 39f43c0..b60cc31 100644
--- a/rtl8xxxu_core.c
+++ b/rtl8xxxu_core.c
@@ -5805,10 +5805,11 @@ static void rtl8xxxu_c2hcmd_callback(struct work_st=
ruct
*work)
                default:
                        break;
                }
+
+               dev_kfree_skb(skb);
        }

 out:
-       dev_kfree_skb(skb);
 }

 static void rtl8723bu_handle_c2h(struct rtl8xxxu_priv *priv,

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
