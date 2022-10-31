Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FD9C38A02
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 03:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJaDDk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Oct 2022 23:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJaDDi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Oct 2022 23:03:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5E3657D
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Oct 2022 20:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CE7B60FBE
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 03:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9A9BC433B5
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 03:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667185416;
        bh=Y2M6xEUU/93mqFy/5mQZqm5SlmM/SQoI4YUcBJdxcdY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RF7XdbDuHINbwlGsUQJCuGRnuEy8V00iZqvpcoeDXAND4O489ph/zHF4BTMGKJsrL
         CwNRW33dPab39PK09RA7jnQF5NFmV796w4Lbj+nmPrMBhOUHTA47IzASCOdzTf+9Vn
         yDlkZ/olA47PKYfkpfqDebtoPTHklOoU1vJ/wVbxEwilY/FASKZO/a+vyVQIfdfM0/
         a/ihn/HUWts9WSiP0hNBnFB22ZMGzTwmKJC4tB5rL1ZKcuWNlsF7VrvpRIRZlLDTjb
         EEZycxbBkLBhf3oYtHIN7MTx99eBat0M/gwPdcq1lfmCwGSMv/4NBFs7WrPQfUSY/b
         ODQFg2UYc0OAg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BC516C433E4; Mon, 31 Oct 2022 03:03:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 31 Oct 2022 03:03:33 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-o9G8bRzaFZ@https.bugzilla.kernel.org/>
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

--- Comment #248 from Zijun Hu (quic_zijuhu@quicinc.com) ---
Hi ALL,
let me summarize my points

1)For the original 4.0 controller issue shown below, don't need to fix sinc=
e i
believe the latest bluetooth-next tree doesn't have this issue.

< HCI Command: Set Event Filter (0x03|0x0005) plen 1        #23 [hci0] 4.13=
0423
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4                 #24 [hci0] 4.13=
3374

      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)
< HCI Command: Read Local Version In.. (0x04|0x0001) plen 0  #1 [hci0] 4.07=
3336
> HCI Event: Command Complete (0x0e) plen 12                 #2 [hci0] 4.07=
7324

      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.0 (0x06) - Revision 12576 (0x3120)
        LMP version: Bluetooth 4.0 (0x06) - Subversion 8891 (0x22bb)
        Manufacturer: Cambridge Silicon Radio (10)

2) for the new 5.0 controller error. it is a new 5.0 BT controller. why not=
 to
fix this BT firmware bug?
could you please provide btmon log of these HCI commands?

HCI_Read_Local_Version_-Information
HCI_Read_Local_Supported_-Commands
HCI_Read_Local_Supported_Features
HCI_Read_Default_-Erroneous_Data_Reporting

[ 4195.075805] Bluetooth: hci0: command 0x0c5a tx timeout
[ 4195.075813] Bluetooth: hci0: Opcode 0x c5a failed: -110

> [hci0] 11.276039

      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 5.0 (0x09) - Revision 2064 (0x0810)
        LMP version: Bluetooth 5.0 (0x09) - Subversion 8978 (0x2312)
        Manufacturer: Cambridge Silicon Radio (10)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
