Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE21C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Feb 2022 15:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiBZPEf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Feb 2022 10:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiBZPEe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Feb 2022 10:04:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A1B1B1DCE
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 07:03:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40FF1B80813
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 15:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E72EFC340F3
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 15:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645887836;
        bh=kmjWDnhCIpJ0aUlyQOTzQXCl9euDr8bUKDcJ2MwqhKk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AtQTY7PQRlMMNZjp2iI/2seG9QabY5b3006h2sWWo8WH4zN4a39G9RYHQrY6pr5l0
         zTizwFnh+JGytj88TGAkUwiBnnQVpWGey7BTlaiIPOPuI4p731LmPQpgOXkL+/0mZP
         0B6KhX42ceTJJ1QL5b9ET9hun7snPouPQmfLuYGuufFrhZz2FboI70fMmG6fAvdPfK
         kCLKP0CuHnOsgXEnsiexhPwiB6euTJJUc+C/TBZXqwBbB2jljeYl34icZELm9pqM9g
         0pnqv0Vr/Y8ejIRhHTHunz41P5+D5U+c3uBc5rbpw1LZCtmJA039l2uU67vb8AHPh/
         2QSl1t1SRrxLg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C97E6CC13AD; Sat, 26 Feb 2022 15:03:56 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Sat, 26 Feb 2022 15:03:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wavexx@thregr.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215576-62941-K8cd5JMx9E@https.bugzilla.kernel.org/>
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

--- Comment #5 from wavexx@thregr.org ---
I tried applying this patch, even though removing the error checking didn't
look right to me. Indeed, after, when trying this, it results in BUG: kernel
NULL pointer dereference, with the stack directly located here:

Feb 26 15:21:16 kernel:  sco_sock_setsockopt+0x110/0x530 [bluetooth]

Changing just codec.id =3D BT_CODEC_MSBC doesn't work either (results in a =
brief
noise on the headset).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
