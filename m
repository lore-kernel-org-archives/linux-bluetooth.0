Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46833C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 20:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbiBRUz4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:55:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbiBRUz4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 15:55:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C37C184631
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 12:55:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D3C961D47
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 20:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02114C36AE5
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 20:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645217738;
        bh=LaNPChOg+miV91fqHQK5+TXpKw900xz1BmgY424e2eU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UCO21hK7LhAcjgscgpAA0jBVE7/10SJn3Ipxtefd/C+rKsT1o9mqAt1EHUGSJbXZg
         LZO2vMiwnRzogWpLAcfzVTGRMK1BTjvRa7Upy+ytu6z18P8tkFCbWDk5F8kILW20Qi
         O3a3ijD0oBAo/BOblWShB6VICxrDB57B/LE1HtI/uojrGZYwqyPwyq4YwxYZ6RnW5c
         QgN+w3DWfW5gp1WF3+603Ue0dfOKpRGsTKcY8N3GrkCaOABVtG3KVk5M3TIOV0jgdK
         gwo8HN0zJ3SEsd45JFVLTdOrnRKxsTvy+E8MIP0DIqvcetc/6/5Jhve5OAr/KgmJLc
         N0yFalmUQeRrA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E49ACCC13B1; Fri, 18 Feb 2022 20:55:37 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Fri, 18 Feb 2022 20:55:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215576-62941-2nprEl3omz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

--- Comment #4 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
Hi Kiran,

On Fri, Feb 18, 2022 at 6:35 AM <bugzilla-daemon@kernel.org> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D215576
>
> The Linux kernel's regression tracker (Thorsten Leemhuis)
> (regressions@leemhuis.info) changed:
>
>            What    |Removed                     |Added
> -------------------------------------------------------------------------=
---
>                  CC|                            |marcel@holtmann.org,
>                    |                            |regressions@leemhuis.info
>
> --- Comment #3 from The Linux kernel's regression tracker (Thorsten Leemh=
uis)
> (regressions@leemhuis.info) ---
> hey bluetooth maintainers, what the status here? This regression was repo=
rted
> more than ten days ago, it was bisected, and a second person roughly conf=
irms
> it, nevertheless there wasn't a single reply yet. Is somebody looking into
> this?
>
> --
> You may reply to this email to add a comment.
>
> You are receiving this mail because:
> You are the assignee for the bug.

Looks like a regression introduced by:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3Db2af264ad3af437238c9500aa830ebcafb180e05

It seems BT_VOICE sets BT_CODEC_TRANSPARENT when perhaps should be
setting BT_CODEC_MSBC:

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8eabf41b2993..b35c772efc7e 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -879,15 +879,9 @@ static int sco_sock_setsockopt(struct socket
*sock, int level, int optname,
                }

                sco_pi(sk)->setting =3D voice.setting;
-               hdev =3D hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
-                                    BDADDR_BREDR);
-               if (!hdev) {
-                       err =3D -EBADFD;
-                       break;
-               }
-               if (enhanced_sco_capable(hdev) &&
-                   voice.setting =3D=3D BT_VOICE_TRANSPARENT)
-                       sco_pi(sk)->codec.id =3D BT_CODEC_TRANSPARENT;
+               if (voice.setting =3D=3D BT_VOICE_TRANSPARENT)
+                       sco_pi(sk)->codec.id =3D BT_CODEC_MSBC;
+
                hci_dev_put(hdev);
                break;

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
