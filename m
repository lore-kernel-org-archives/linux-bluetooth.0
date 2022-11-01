Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA6AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 03:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKADPM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 23:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKADPA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 23:15:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189126263
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 20:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C68D0B81B90
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 03:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75F33C433D7
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 03:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667272496;
        bh=IDlrBc0PqJJlrSACmWWlOJyY2Q1tAih6S6TqZ5kypwo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=j+AsVEpKuZz331bcZew9m5gmjaShqbJqbj5py1tCBdfK/iigA1T1ccQJHkvcQi5Nx
         HLQcu6gfR4Ul8W+JALLHTt7kOzErs+Lk8foUYmFW6rYbASMObGEUY8YnK6R9zJhIe2
         HWwdB3bvXUyiLgOKkZu6BOoV3xYW8wSC5iGKkwjNIuCgWfKhWbOf7vse8D/Q9jSTN6
         wJD61ytbTRaKBkDJkQYiyaIqHEQXPT0J1fn72YPsg99u06wGbST8+1fED5zYVeWXZg
         7BsjxguDNaaI7xj/M0JEipg3OFiI75FP3c84Ug4eoeyd6PtyUVXsuI1i5er0BG539r
         L7nreElRj8gdQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 68602C433E7; Tue,  1 Nov 2022 03:14:56 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Tue, 01 Nov 2022 03:14:53 +0000
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
Message-ID: <bug-60824-62941-NtYpnFL3AD@https.bugzilla.kernel.org/>
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

--- Comment #256 from Zijun Hu (quic_zijuhu@quicinc.com) ---
it seems there are indeed CSR devices which say they support
HCI_Read_Default_-Erroneous_Data_Reporting from output of both
HCI_Read_Local_Supported_-Commands
and HCI_Read_Local_Supported_Features. but  they don't support the command
actually.

but is it worth for such getting info commands error to cause BT initializa=
tion=20
failure?

/* HCI Controller init stage 3 command sequence */
static const struct hci_init_stage hci_init3[] =3D {
        /* HCI_OP_SET_EVENT_MASK */
        HCI_INIT(hci_set_event_mask_sync),
        /* HCI_OP_READ_STORED_LINK_KEY */
        HCI_INIT(hci_read_stored_link_key_sync),
        /* HCI_OP_WRITE_DEF_LINK_POLICY */
        HCI_INIT(hci_setup_link_policy_sync),
        /* HCI_OP_READ_PAGE_SCAN_ACTIVITY */
        HCI_INIT(hci_read_page_scan_activity_sync),
        /* HCI_OP_READ_DEF_ERR_DATA_REPORTING */
        HCI_INIT(hci_read_def_err_data_reporting_sync),
        /* HCI_OP_READ_PAGE_SCAN_TYPE */
        HCI_INIT(hci_read_page_scan_type_sync),
        /* HCI_OP_READ_LOCAL_EXT_FEATURES */
        HCI_INIT(hci_read_local_ext_features_all_sync),
        {}
};

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
