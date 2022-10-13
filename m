Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B19C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Oct 2022 21:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJMVEG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiJMVEE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Oct 2022 17:04:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD05B1793A2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 14:04:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B369B820C0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 21:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40C4CC433C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 21:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665695041;
        bh=6jsNJqqytuYGkCxVhvSCa3xP9h0Vbeuvk4o2gb39vrM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kv6EPmhWtQTpaUskqiOEoPCVnXCzfLskwf7SGP4ye9LBXmtyIVLJXC8sjsgnZlrqQ
         Ay3lhbYnVJFvcCYCtv/Am/WMGo13iKrL2a4jyWKFgeCbj3fBO8dFf2eotiduk6a6E5
         ZfCugfR9cr3icL5ADwQX1lbYUMY0Yy7k+lIYpH0DRgoTFaUAKMIeEhB7IL4eTRh753
         RUdcRFWtvWEEPO3on8O6ur58TF1WhBCSaBvk6aqpZ8VwCrHRmsVonSnwVazSB2Hs99
         ijnpbS6GZCc/HoPAkxHN0hoEmRmTyqbfFd4FulkguSSey2vTTLDj4X5GFohDtoo5BB
         i6mFzAH6osFbA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2F645C433E4; Thu, 13 Oct 2022 21:04:01 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216580] Jabra Elite 75t (ear buds):Unable to connect and use
 (`hci0: Opcode 0x 401 failed: -16`)
Date:   Thu, 13 Oct 2022 21:04:01 +0000
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
Message-ID: <bug-216580-62941-7qZVrHoZim@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216580-62941@https.bugzilla.kernel.org/>
References: <bug-216580-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216580

--- Comment #4 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
Perhaps something like the following makes more sense since what the command
was meant for is to synchronize the RFKILL of state of the host with the
controller:

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a657e9a3e96a..f8be70f7924e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2597,7 +2597,7 @@ static int btintel_shutdown_combined(struct hci_dev
*hdev)
         * goes off. As a workaround, sends HCI_Intel_SW_RFKILL to put the
         * device in the RFKILL ON state which turns off the BT LED
immediately.
         */
-       if (btintel_test_flag(hdev, INTEL_BROKEN_SHUTDOWN_LED)) {
+       if (hci_dev_test_flag(hdev, HCI_RFKILLED)) {
                skb =3D __hci_cmd_sync(hdev, 0xfc3f, 0, NULL, HCI_INIT_TIME=
OUT);
                if (IS_ERR(skb)) {
                        ret =3D PTR_ERR(skb);

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
