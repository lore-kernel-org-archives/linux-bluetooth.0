Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE66C001DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 17:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjHHRDg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbjHHRCh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 13:02:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C8D58FBF
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 09:01:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D72E0624BC
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 13:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42F6CC433C8
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 13:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691501440;
        bh=PNfCVWP2Q5xV2FgRMKS2VdwvLzlh4M3mm4QhuY86UmM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jHcKbvCQBh8xuujOM9dQE3IxEWNCgbBO/uvqs92tjsmPVzPqYgEhQyrE84GW9LUsy
         1lC1YDQlGkf+oJg94oaELxMg4aM00zb2LvkpwIXySmIcZ1OTXRwl+LX4lM0yVklh1s
         LsyScGYdz9l+dnrzme54LcO9UmX82LvFFag5e+hZ1MWNe93c2mHwgMEVDaMmUXrch9
         0v8sYmdPTffZ6wQWyFg13qIu30erzsgIItcLiDyTlltO9f/PS4MFpydnlKA7ajKpxQ
         U31icZll0NdvxJQ1kBhjwhHtMFiCzqle3GzNKS9ySIkCV0KRLW+b4281PL0uAZ9Frw
         lzVEwbGumAlEw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2A763C53BC6; Tue,  8 Aug 2023 13:30:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217773] Bluetooth LE scan doesn't show device name
Date:   Tue, 08 Aug 2023 13:30:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bagasdotme@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217773-62941-KfNi8AA17d@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217773-62941@https.bugzilla.kernel.org/>
References: <bug-217773-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217773

Bagas Sanjaya (bagasdotme@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bagasdotme@gmail.com

--- Comment #1 from Bagas Sanjaya (bagasdotme@gmail.com) ---
(In reply to TatriX from comment #0)
> Hi!
> At some point after kernel 5.9 I started having issues with LE device
> scanning.
> Here's how it used to work:
>=20
>     $ bluetoothctl
>     # power on
>     # scan on
>      ...
>     [NEW] Device 68:71:DD:73:97:D5 Playfinity-2
>=20
> It successfully finds my device and it's name.
> On a newer kernel instead I'm getting no name:
>=20
>     [NEW] Device 4D:18:19:A8:63:B5 4D-18-19-A8-63-B5
>=20
> Here's corresponding btmon logs. First from kernel 5.9.12 that can see
> device's name:
>=20
> ```5.9.12
> > HCI Event: LE Meta Event (0x3e) plen 33                  #118 [hci0]
> 5.607028
>       LE Extended Advertising Report (0x0d)
>         Num reports: 1
>         Entry 0
>           Event type: 0x0013
>             Props: 0x0013
>               Connectable
>               Scannable
>               Use legacy advertising PDUs
>             Data status:  [0;32mComplete [0m
>           Legacy PDU Type: ADV_IND (0x0013)
>           Address type: Random (0x01)
>           Address: 68:71:DD:73:97:D5 (Resolvable)
>           Primary PHY: LE 1M
>           Secondary PHY: No packets
>           SID: no ADI field (0xff)
>           TX power: 127 dBm
>           RSSI: -54 dBm (0xca)
>           Periodic advertising interval: 0.00 msec (0x0000)
>           Direct address type: Public (0x00)
>           Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>           Data length: 0x07
>         02 01 06 03 02 f0 ff                             .......
>         Flags: 0x06
>           LE General Discoverable Mode
>           BR/EDR Not Supported
>         16-bit Service UUIDs (partial): 1 entry
>           Unknown (0xfff0)
> > HCI Event: LE Meta Event (0x3e) plen 49                  #119 [hci0]
> 5.608029
>       LE Extended Advertising Report (0x0d)
>         Num reports: 1
>         Entry 0
>           Event type: 0x001b
>             Props: 0x001b
>               Connectable
>               Scannable
>               Scan response
>               Use legacy advertising PDUs
>             Data status:  [0;32mComplete [0m
>           Legacy PDU Type: SCAN_RSP to an ADV_SCAN_IND (0x001b)
>           Address type: Random (0x01)
>           Address: 68:71:DD:73:97:D5 (Resolvable)
>           Primary PHY: LE 1M
>           Secondary PHY: No packets
>           SID: no ADI field (0xff)
>           TX power: 127 dBm
>           RSSI: -54 dBm (0xca)
>           Periodic advertising interval: 0.00 msec (0x0000)
>           Direct address type: Public (0x00)
>           Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>           Data length: 0x17
>         0d 09 50 6c 61 79 66 69 6e 69 74 79 2d 32 02 0a  ..Playfinity-2..
>         00 05 12 50 00 68 00                             ...P.h.
>         Name (complete): Playfinity-2
>         TX power: 0 dBm
>         Peripheral Conn. Interval: 0x0050 - 0x0068
> ```
>=20
> And from 6.4.8:
>=20
> ```6.4.8
> > HCI Event: LE Meta Event (0x3e) plen 33                  #130 [hci0]
> 9.180207
>       LE Extended Advertising Report (0x0d)
>         Num reports: 1
>         Entry 0
>           Event type: 0x0013
>             Props: 0x0013
>               Connectable
>               Scannable
>               Use legacy advertising PDUs
>             Data status: =EF=BF=BD[0;32mComplete=EF=BF=BD[0m
>           Legacy PDU Type: ADV_IND (0x0013)
>           Address type: Random (0x01)
>           Address: 4D:18:19:A8:63:B5 (Resolvable)
>           Primary PHY: LE 1M
>           Secondary PHY: No packets
>           SID: no ADI field (0xff)
>           TX power: 127 dBm
>           RSSI: -53 dBm (0xcb)
>           Periodic advertising interval: 0.00 msec (0x0000)
>           Direct address type: Public (0x00)
>           Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>           Data length: 0x07
>         02 01 06 03 02 f0 ff                             .......
>         Flags: 0x06
>           LE General Discoverable Mode
>           BR/EDR Not Supported
>         16-bit Service UUIDs (partial): 1 entry
>           Unknown (0xfff0)
> ```
>=20
> I've tried compiling 5.9.12 to see if I can bissect, but it fails to comp=
ile
> with gcc12..
>=20
> Is it expected that newer kernels can't get device name? Perhaps some
> additional action is needed fetch it?
>=20=20

Try using gcc 10 when compiling v5.9.12 kernel, then try reproducing this
regression on v5.10, v5.15, and v6.1. Remember to test the mainline release=
s,
not stable tree (like v5.10.y). After that, please consult
Documentation/admin-guide/bug-bisect.rst for how to perform bisection with =
git.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
