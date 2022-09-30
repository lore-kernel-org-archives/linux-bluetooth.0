Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32FFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 10:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiI3KAl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 06:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiI3KA0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 06:00:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE68CB46B
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 03:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6322AB82795
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 10:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 265CEC433C1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 10:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664532012;
        bh=bfh/8cn/t2gZM0R5rf28ML4sPqA74cv+G8q6HR0rWJc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A7MA86hrkBnfxTpCMYGOnsTZ4b4xlpVbvLbtRNSxTF6e3u124S5UxEmSlmvUk11HQ
         FlvqbOP0OfFlzsg35VTqGrG097rg+opnYQs0BqtJRYCbC8Bt0ZPkqRk0xLBD6X+rIn
         OFTRLwMyW8OXSXlt/qzZV2YZ6A9Tw++bG/AQJtPxCX9qa7uIP8caZ3NfkRz26VZzjU
         Ja/MEl7o/qYbxXXvSzc+CDaOCKVTGBKe6ETPYytv24LjHcux/hXXK6f663sDx5yw3W
         MBWxgRt6zLZ1Tu5owF3idENaWVoDNQy4PbEgosWeFkGeYVp4ZhAsXP6qLLq2TZ5S+z
         eDA2RxPcbJW5g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 135BEC433E6; Fri, 30 Sep 2022 10:00:12 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216532] openSUSE Tumbleweed, AX210, bluetooth, connection fails
Date:   Fri, 30 Sep 2022 10:00:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: epistemepromeneur@free.fr
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216532-62941-2UN8hkU8pM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216532-62941@https.bugzilla.kernel.org/>
References: <bug-216532-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216532

--- Comment #6 from epistemepromeneur@free.fr ---
bluetoothctl info 90:06:28:B6:B1:B6
Device 90:06:28:B6:B1:B6 (public)
Name: Samsung Galaxy S7 Argent
Alias: Samsung Galaxy S7 Argent
Class: 0x005a020c
Icon: phone
Paired: yes
Bonded: yes
Trusted: yes
Blocked: no
Connected: no
LegacyPairing: no
UUID: OBEX Object Push (00001105-0000-1000-8000-00805f9b34fb)
UUID: OBEX File Transfer (00001106-0000-1000-8000-00805f9b34fb)
UUID: Audio Source (0000110a-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control (0000110e-0000-1000-8000-00805f9b34fb)
UUID: Headset AG (00001112-0000-1000-8000-00805f9b34fb)
UUID: PANU (00001115-0000-1000-8000-00805f9b34fb)
UUID: NAP (00001116-0000-1000-8000-00805f9b34fb)
UUID: Handsfree Audio Gateway (0000111f-0000-1000-8000-00805f9b34fb)
UUID: SIM Access (0000112d-0000-1000-8000-00805f9b34fb)
UUID: Phonebook Access Server (0000112f-0000-1000-8000-00805f9b34fb)
UUID: Message Access Server (00001132-0000-1000-8000-00805f9b34fb)
UUID: PnP Information (00001200-0000-1000-8000-00805f9b34fb)
UUID: Generic Access Profile (00001800-0000-1000-8000-00805f9b34fb)
UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
UUID: Vendor specific (a23d00bc-217c-123b-9c00-fc44577136ee)
Modalias: bluetooth:v0075p0100d0201
Affected by Policy: no

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
