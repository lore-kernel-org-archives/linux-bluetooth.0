Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D3AECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 13:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiJaNVk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJaNVi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 09:21:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CAB658D
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 06:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBB97B8112E
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 13:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78C75C433D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667222495;
        bh=Iumn4rCmwpvN0y2c7SO/ylGntX4etShyaM9vehRUp1o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FVFyDUMk36/p3GYuI22KNFaUblbBWCtEQVutGibyo+4tbMl7Og32CkIRSJ7TGOIPB
         f0Y/D+WAZfWzCvp5xuKolNyi+oRK18qD1c8kfmA/LV+vnCyWwgAr8qeS77JdkYuo8v
         vP/5UDNXxG66Rfcjp2tXBLa8j3HHo6N3hQHvXmu8HP1XaRQCGQcuTi0dT/U4fj+2JR
         kljd130GV5zeepqojRwKnSacRUtZFS2vlNoxMCtpX0248aEnurlroV3wzN9uhfN+Hn
         38QT9NqhdVNx69ll/nK2ZILYsBPTxajdocrLfmM9P01O99FI7W57EzT27sEjtdK+dV
         fauKinY6TmeiQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 56DC9C433E7; Mon, 31 Oct 2022 13:21:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 31 Oct 2022 13:21:22 +0000
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
Message-ID: <bug-60824-62941-GpcXVRTPiw@https.bugzilla.kernel.org/>
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

--- Comment #254 from Zijun Hu (quic_zijuhu@quicinc.com) ---
Hi justanormaltinkerermihir,

you maybe catch bton log of that command by below steps:
1) open one terminal and run  btmon
2) open another terminal and run hcitool -i hci0 cmd 03 5a
3) catch dmesg log for this hci command.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
