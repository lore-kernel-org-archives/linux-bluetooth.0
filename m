Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C6FCCA47B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jun 2022 09:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiFHJYk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jun 2022 05:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbiFHJYB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jun 2022 05:24:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4AF274D75
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jun 2022 01:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9AF9616FF
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jun 2022 08:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3826AC385A2
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jun 2022 08:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654677923;
        bh=iUO258RXI9gPrWF+Shz4CnQYN7bsealxftifqg0eAb4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=U0nYcjbeCNvk7R3A7BziZWNKSYsICBXhSpxXV2UoM7aX4fNVJ0rsxyVmoXTZx9xWy
         nWrV17Jqqj+9/x8wOjS/UzelxEVGHO1boZKsEclmljMLs8CIW+sTSq1hQw52+YF+Nr
         EbZQYlic/p5oTYwW6FU1Np+qdY82NqolWWOKuBNChpn8YesMVl2TLWMRhQ3fdrhlLB
         nWg3/CWLNPIcwgHwz8yH9shVXhfsrdl8O4Waf+UaRusZ80tjWbmf44Ceu76Fbz6jyO
         9p9EO7RVTHxgGGqxb6viGRgHIbulJpNKS/9vnqNt0nOko9UWweRK23CA3WcgQlo8+P
         m68ZDKyqmGatQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1EBE3CBF854; Wed,  8 Jun 2022 08:45:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Wed, 08 Jun 2022 08:45:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hyperair@ubuntu.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209745-62941-NhFslXbwwo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209745-62941@https.bugzilla.kernel.org/>
References: <bug-209745-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209745

--- Comment #21 from Chow Loong Jin (hyperair@ubuntu.com) ---
I was facing this issue with my Logitech MX Master 3 as well, but applying =
this
patch[1] seems to make it work, quoted here for posterity:

-------------------8<---------------------
diff --git a/include/net/bluetooth/hci_core.h
b/include/net/bluetooth/hci_core.h
index 9873e1c8cd16..7ed862135110 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1363,7 +1363,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
                         ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))

 /* Use LL Privacy based address resolution if supported */
-#define use_ll_privacy(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
+#define use_ll_privacy(dev) (0)

 /* Use ext scanning if set ext scan param and ext scan enable is supported=
 */
 #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
------------------->8---------------------

I'm not entirely sure if the issue is in Logitech's implementation of Bluet=
ooth
 LL Privacy, or the kernel's, but it doesn't seem to work very well togethe=
r.

The other workaround of removing the IdentityResolvingKey as documented in =
the
ArchLinux wiki[2] seems to also work, but not quite as well as the mouse
frequently disconnects and reconnects randomly, especially when scrolling f=
or a
long time.

[1] https://bbs.archlinux.org/viewtopic.php?pid=3D1932543#p1932543
[2]
https://wiki.archlinux.org/title/bluetooth#Problems_with_all_BLE_devices_on=
_kernel_5.9+

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
