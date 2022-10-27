Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07070C67871
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Oct 2022 10:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiJ0KAo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Oct 2022 06:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbiJ0KAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Oct 2022 06:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA58E109F
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Oct 2022 02:59:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27DE462280
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Oct 2022 09:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89676C43470
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Oct 2022 09:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666864769;
        bh=x/5BCzSQR7JKvzR505LvOZOJDyqllkE4LsL2Cb8EAbc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GSmfbxPhuAScsaAWUQJkKCjF6a1PNJ0luP7gfzImoA/u0zXA5QZDwexGbUh+6k1rt
         rKGVDHSJVJPIfzt0cwm9Z2MVDRZeQobvZJzFwA4Z2EIqFEo8UB9n25BYXhPm88uSpV
         dRBytO95vCPtiUpwzKx7RhyHob30fdY57zYsb0VnMWGFL5MsNcCs/Y4LYVNpgL/EL2
         boSns4rWgtWAECj/1gAKjPcsjmtlory0jVCmcu/qXhDXgMoZKolfQnY74akaZ0XImp
         IBa5n6SelnlzUAV3zhe7sayI7IR/VTKWN6DaAOYFaoJKkPsMktdiPSp615wcWItdfX
         lD4wtqqU+yaPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 7B94AC05F8A; Thu, 27 Oct 2022 09:59:29 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 27 Oct 2022 09:59:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quic_zijuhu@quicinc.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-8OBcrsX9kx@https.bugzilla.kernel.org/>
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

Zijun Hu (quic_zijuhu@quicinc.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |quic_zijuhu@quicinc.com

--- Comment #239 from Zijun Hu (quic_zijuhu@quicinc.com) ---
i maybe find the root cause for this issue.

the device seems a fake device actually but it is not detected as fake devi=
ce.


below error show it seems a fake device and HCI_QUIRK_BROKEN_FILTER_CLEAR_A=
LL
should be set

< HCI Command: Set Event Filter (0x03|0x0005) plen 1        #23 [hci0] 4.13=
0423
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4                 #24 [hci0] 4.13=
3374
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)

but current fake device detect logic miss this new device.
< HCI Command: Read Local Version In.. (0x04|0x0001) plen 0  #1 [hci0] 4.07=
3336
> HCI Event: Command Complete (0x0e) plen 12                 #2 [hci0] 4.07=
7324
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.0 (0x06) - Revision 12576 (0x3120)
        LMP version: Bluetooth 4.0 (0x06) - Subversion 8891 (0x22bb)
        Manufacturer: Cambridge Silicon Radio (10)


i will fix it as below:

+++ b/drivers/bluetooth/btusb.c
@@ -2155,7 +2155,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
                is_fake =3D true;

        else if (le16_to_cpu(rp->lmp_subver) <=3D 0x22bb &&
-                le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_4_0)
+                le16_to_cpu(rp->hci_ver) >=3D BLUETOOTH_VER_4_0)
                is_fake =3D true;

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
