Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4608C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 17:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhLHRUC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 12:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbhLHRUB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 12:20:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AA3C061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 09:16:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C59EB821C8
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 17:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19E98C341C7
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 17:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638983787;
        bh=iF5cGwZXJBKiiAGMQ9kJ7loE5P9AVHtL8q4cPgYehpw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A2UuKobicM5+fv5QIV0b/kYi+P374SMZES/nMJMVVxaFNHDGjicYjSM4jYH2zpbNP
         EGfKk1xW6NMQIg9jErFH0FaEI4r8RM4hsMouBIrBZG9l2AjTPo9V/2JNDvHPiXAlvA
         ELDA4O1JUrMGnQx3hOY2efLrxcNDtJP3WETsP9QdfXtaJmIIHTNpkV8wmoH2j3WasM
         Nb5Vnm/tIBsxWG8DFzWORrZ+YLfmfHCalewN76L02UZvWsTAOfaMFTSERvfnm8RpXv
         tAhvVSJ8EofqC531Bv2IdABFnVUfCuRDTPDE1EkiPbWb+iQ9HjX2JIfXmTBWKzudW+
         1M03lcphi72+g==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 0078560F48; Wed,  8 Dec 2021 17:16:26 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215187] btintel: AX201: missing firmware ibt-19-16-0.sfi
Date:   Wed, 08 Dec 2021 17:16:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nozzy123nozzy@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215187-62941-rNQUYn5L1C@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215187-62941@https.bugzilla.kernel.org/>
References: <bug-215187-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215187

--- Comment #3 from Takahide Nojima (nozzy123nozzy@gmail.com) ---
Hi Kiran,

  I removed the whole /lib/firmware directory and put 22.80 to  /lib/firmwa=
re.
I  booted again with 5.16-rc3.

 As a result, the kernel loaded "iwlwifi-Quiz-a0-hr-b0-63.ucode", but the
kernel tried to load a different version of Bluetooth firmware than before.=
 The
kernel became to load "intel/ibt-19-16-0.sfi". Before this test, whenever t=
he
kernel loaded "iwlwifi-Quiz-a0-hr-b0-63.ucode", it try loading
intel/ibt-19-0-4.sfi. I will dmesg of this time test as below.
-----here--------------
ernel: iwlwifi 0000:00:14.3: firmware: failed to load
iwlwifi-QuZ-a0-hr-b0-67.ucode (-2)
kernel: iwlwifi 0000:00:14.3: Direct firmware load for
iwlwifi-QuZ-a0-hr-b0-67.ucode failed with error -2
kernel: iwlwifi 0000:00:14.3: firmware: failed to load
iwlwifi-QuZ-a0-hr-b0-66.ucode (-2)
kernel: iwlwifi 0000:00:14.3: Direct firmware load for
iwlwifi-QuZ-a0-hr-b0-66.ucode failed with error -2
kernel: iwlwifi 0000:00:14.3: firmware: failed to load
iwlwifi-QuZ-a0-hr-b0-65.ucode (-2)
kernel: iwlwifi 0000:00:14.3: Direct firmware load for
iwlwifi-QuZ-a0-hr-b0-65.ucode failed with error -2
kernel: iwlwifi 0000:00:14.3: firmware: failed to load
iwlwifi-QuZ-a0-hr-b0-64.ucode (-2)
kernel: iwlwifi 0000:00:14.3: Direct firmware load for
iwlwifi-QuZ-a0-hr-b0-64.ucode failed with error -2
kernel: iwlwifi 0000:00:14.3: firmware: direct-loading firmware
iwlwifi-QuZ-a0-hr-b0-63.ucode
kernel: iwlwifi 0000:00:14.3: api flags index 2 larger than supported by dr=
iver
kernel: iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.37
kernel: iwlwifi 0000:00:14.3: loaded firmware version 63.c04f3485.0
QuZ-a0-hr-b0-63.ucode op_mode iwlmvm
kernel: iwlwifi 0000:00:14.3: firmware: failed to load iwl-debug-yoyo.bin (=
-2)
kernel: Bluetooth: Core ver 2.22
kernel: NET: Registered PF_BLUETOOTH protocol family
kernel: Bluetooth: HCI device and connection manager initialized
kernel: Bluetooth: HCI socket layer initialized
kernel: Bluetooth: L2CAP socket layer initialized
kernel: Bluetooth: SCO socket layer initialized
kernel: iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz, REV=
=3D0x354
kernel: bluetooth hci0: firmware: failed to load intel/ibt-19-16-0.sfi (-2)
-------------here--------------------

As written above, the kernel still failed to load intel/ibt-19-16-0.sfi bec=
ause
the 22.80 firmware tree doesn't have it.

=E3=80=80I guess basically  the 5.16-rc3 with "iwlwifi-Quiz-a0-hr-b0-63.uco=
de" supposes
to load "intel/ibt-19-16-4.sfi"? The 22.80 firmware includes it. In other
words, does the "ver->fw_revision" in "btintel.c" supposes to be 4 after the
kernel with "iwlwifi-Quiz-a0-hr-b0-63.ucode" sends 0xfc05 to AX201?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
