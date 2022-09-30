Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0EDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 10:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiI3J77 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 05:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiI3J7x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 05:59:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6651459BD
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 02:59:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D580A62286
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 09:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44791C433D7
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 09:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664531985;
        bh=sRGmxLf96RGxqCen+WDvX54eNobOklWTfBKQVHeg4iw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KZV9tKSOvfigfhu5qBI7nTXH6fRFTJ72UchXEdS8sexakc0IKh4omOUfjO8i5xE/V
         Woh4qCGXPql1wNxcfK4ZemIhaTPfLAWWtecl1gLIEZluDq7no3Z/qhETrwMKRkJcWo
         bQ25wp23b5G0xSH4ofMH5HJyw2krLYCePlB/MjZTWnE6xmLypk3X9nu60Tuh2Syytz
         YzyPbxh97PXWkSDnJM7jFxdG49CvYv4i5ncO8Dhx7KoixTKB+gEafW2Q0g9J60GoVA
         wnIiMW7EOIZ93YStACmfMxiwnsGTptt0hKWSMrvzY//d505wotMmwkH2FQ9FXevjDW
         4h7MTVBw37yyA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2FBDFC433E6; Fri, 30 Sep 2022 09:59:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216532] openSUSE Tumbleweed, AX210, bluetooth, connection fails
Date:   Fri, 30 Sep 2022 09:59:45 +0000
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
Message-ID: <bug-216532-62941-qgKUUjaLEH@https.bugzilla.kernel.org/>
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

--- Comment #5 from epistemepromeneur@free.fr ---
bluetoothctl show
Controller F0:B6:1E:FE:FB:F4 (public)
Name: grincheux
Alias: grincheux
Class: 0x007c0104
Powered: yes
Discoverable: no
DiscoverableTimeout: 0x000000b4
Pairable: yes
UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control (0000110e-0000-1000-8000-00805f9b34fb)
UUID: OBEX Object Push (00001105-0000-1000-8000-00805f9b34fb)
UUID: Message Access Server (00001132-0000-1000-8000-00805f9b34fb)
UUID: PnP Information (00001200-0000-1000-8000-00805f9b34fb)
UUID: IrMC Sync (00001104-0000-1000-8000-00805f9b34fb)
UUID: Vendor specific (00005005-0000-1000-8000-0002ee000001)
UUID: Headset (00001108-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
UUID: Phonebook Access Server (0000112f-0000-1000-8000-00805f9b34fb)
UUID: Device Information (0000180a-0000-1000-8000-00805f9b34fb)
UUID: Audio Sink (0000110b-0000-1000-8000-00805f9b34fb)
UUID: Generic Access Profile (00001800-0000-1000-8000-00805f9b34fb)
UUID: Handsfree Audio Gateway (0000111f-0000-1000-8000-00805f9b34fb)
UUID: Audio Source (0000110a-0000-1000-8000-00805f9b34fb)
UUID: OBEX File Transfer (00001106-0000-1000-8000-00805f9b34fb)
Modalias: usb:v1D6Bp0246d0541
Discovering: no
Roles: central
Roles: peripheral
Advertising Features:
ActiveInstances: 0x00 (0)
SupportedInstances: 0x0c (12)
SupportedIncludes: tx-power
SupportedIncludes: appearance
SupportedIncludes: local-name
SupportedSecondaryChannels: 1M
SupportedSecondaryChannels: 2M
SupportedSecondaryChannels: Coded

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
