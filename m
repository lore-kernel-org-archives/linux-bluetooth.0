Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBFEC001DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 17:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjHHRNM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjHHRMf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 13:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39021BAF8
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 09:05:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DA5660D3C
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 10:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0B4FC433C8
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 10:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691489357;
        bh=GRM+rQg/xFFqw0SHFmc80xOzKY9i7GKRnWocnqhNL3Q=;
        h=From:To:Subject:Date:From;
        b=J6jixQ6bXplkGVqpmZggQ7ERuhbXFaQVGhuX/mBkqulBHqkD92OAHjCpVfFAe/pEP
         dFTyxuHeqKpOM72NBWyZDU24Mu+i3V6+RDBC6/SwyJq2KjyTHff23inygAzHVAPgcB
         cSeRjpTrmVHiCGQiqyblTojqqmxO2Qz6ewxTko34G+g4GlxyaoDYMAhXiicc2v2eLe
         qyTV5fpslKDD0nQb7cYPpNOMvGR7WD57sFzM1F8sfcTFwQ1mNYdrTqyhgeLTbb17oO
         ddiyLkuwYBOGNxKslXj6YizHkxCeijQxqHN0BGShSotOr+qKywAb0TbdaWKFKA0LJ/
         Qp+iSKKRiyMPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D457BC4332E; Tue,  8 Aug 2023 10:09:16 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217773] New: Bluetooth LE scan doesn't show device name
Date:   Tue, 08 Aug 2023 10:09:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tatrics@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217773-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217773

            Bug ID: 217773
           Summary: Bluetooth LE scan doesn't show device name
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: tatrics@gmail.com
        Regression: No

Hi!
At some point after kernel 5.9 I started having issues with LE device scann=
ing.
Here's how it used to work:

    $ bluetoothctl
    # power on
    # scan on
     ...
    [NEW] Device 68:71:DD:73:97:D5 Playfinity-2

It successfully finds my device and it's name.
On a newer kernel instead I'm getting no name:

    [NEW] Device 4D:18:19:A8:63:B5 4D-18-19-A8-63-B5

Here's corresponding btmon logs. First from kernel 5.9.12 that can see devi=
ce's
name:

```5.9.12
> HCI Event: LE Meta Event (0x3e) plen 33                  #118 [hci0] 5.60=
7028
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0013
            Props: 0x0013
              Connectable
              Scannable
              Use legacy advertising PDUs
            Data status:  [0;32mComplete [0m
          Legacy PDU Type: ADV_IND (0x0013)
          Address type: Random (0x01)
          Address: 68:71:DD:73:97:D5 (Resolvable)
          Primary PHY: LE 1M
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -54 dBm (0xca)
          Periodic advertising interval: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x07
        02 01 06 03 02 f0 ff                             .......
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (partial): 1 entry
          Unknown (0xfff0)
> HCI Event: LE Meta Event (0x3e) plen 49                  #119 [hci0] 5.60=
8029
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x001b
            Props: 0x001b
              Connectable
              Scannable
              Scan response
              Use legacy advertising PDUs
            Data status:  [0;32mComplete [0m
          Legacy PDU Type: SCAN_RSP to an ADV_SCAN_IND (0x001b)
          Address type: Random (0x01)
          Address: 68:71:DD:73:97:D5 (Resolvable)
          Primary PHY: LE 1M
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -54 dBm (0xca)
          Periodic advertising interval: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x17
        0d 09 50 6c 61 79 66 69 6e 69 74 79 2d 32 02 0a  ..Playfinity-2..
        00 05 12 50 00 68 00                             ...P.h.
        Name (complete): Playfinity-2
        TX power: 0 dBm
        Peripheral Conn. Interval: 0x0050 - 0x0068
```

And from 6.4.8:

```6.4.8
> HCI Event: LE Meta Event (0x3e) plen 33                  #130 [hci0] 9.18=
0207
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0013
            Props: 0x0013
              Connectable
              Scannable
              Use legacy advertising PDUs
            Data status: =EF=BF=BD[0;32mComplete=EF=BF=BD[0m
          Legacy PDU Type: ADV_IND (0x0013)
          Address type: Random (0x01)
          Address: 4D:18:19:A8:63:B5 (Resolvable)
          Primary PHY: LE 1M
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -53 dBm (0xcb)
          Periodic advertising interval: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x07
        02 01 06 03 02 f0 ff                             .......
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (partial): 1 entry
          Unknown (0xfff0)
```

I've tried compiling 5.9.12 to see if I can bissect, but it fails to compile
with gcc12..

Is it expected that newer kernels can't get device name? Perhaps some
additional action is needed fetch it?

Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
