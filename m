Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E798C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 16 Jan 2022 13:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiAPNRA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Jan 2022 08:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbiAPNRA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Jan 2022 08:17:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBEFC061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jan 2022 05:17:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7F0BB80D0D
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jan 2022 13:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49966C36AE7
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jan 2022 13:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642339017;
        bh=R9yX4HiiprJKuO/Id7zF/OeQNXZjuYib3MkxeY9TJeo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lEjOdteoWdnKpCrZRHZVkQm9s2SG4ELlGwmT+iBQeQ1wl5IO3qBLDN1C94Gg/NE4O
         43bNMfJ3T/smPEu+9rxP7NHYA+xHiy9X1+0hUV7GwGiMuygAVoFsbRfSTveQptoPfd
         jxtN3cn83MpjKx0lBmCxc47WIlz6VRNfM1IiI9bv1kaBwz4LDcmjbl5Q1M8nQvbT/+
         UYAEMiwdintbC2HODRGdnDsWmur+EACyCChVjoLgmlCfkCMpM6jJQRu6YhKflln5mQ
         W6txWYl5OYd6kK7X65W/fn0sENGjPqrNj9EnaLavlcnLHDxNserX95jdUsThtJUVmv
         BtVREVm6XGdWw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 219FDCC13A9; Sun, 16 Jan 2022 13:16:57 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215497] NULL pointer deref in klist_next triggered by Bluetooth
 HCI_Disconnection_Complete event
Date:   Sun, 16 Jan 2022 13:16:57 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Networking
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: soenke.huster@eknoes.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: stephen@networkplumber.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215497-62941-VFqt36X9Ab@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215497-62941@https.bugzilla.kernel.org/>
References: <bug-215497-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215497

S=C3=B6nke Huster (soenke.huster@eknoes.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |linux-bluetooth@vger.kernel
                   |                            |.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.=
