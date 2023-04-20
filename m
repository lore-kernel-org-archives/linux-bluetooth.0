Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72948C77B72
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 17:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjDTRfu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 13:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDTRft (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 13:35:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2133590
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 10:35:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1A8C64B0C
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 17:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EF02C433A4
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 17:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682012147;
        bh=qVqXyO6mrz1X1ny0p9giuEjMhUEenrcnTej0psfLm90=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TqzSSkLC1s4dgcr6P10PoRSSE/kCwvPQ4Icn40q6/BIYm82ARF195wiFk0lB4TRtB
         URtRz5xtq5olDSBWAFwd1UgWuxGQhWD+TX3OrLWUy20e0c7YXVyyvfra4p3nmMIY5D
         GTHkH9qjW0pT2WjbnTE3riSOHFqd4V/TJboLRBcbm+CAS4n8FoZ81sHJXOZPuqc0gz
         EyrwIO3e5XUD9hRTUJtGwTvrBP6c3RKh/qAr1CUqJCPSkCbZn7GBX3MjHLzby+23W1
         SbCTVUNSeNCf9+aeqTojDNVwbGPp9+7rXCGs/NtwdesKtAIQJk67N3E24vk2QDzGso
         nHLpyPZZWKOUQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1FC86C43142; Thu, 20 Apr 2023 17:35:47 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 20 Apr 2023 17:35:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vitaliy.ognev@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-SqdUgpH0Xp@https.bugzilla.kernel.org/>
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

--- Comment #270 from Vitaliy Ognev (vitaliy.ognev@gmail.com) ---
Got mine somehow working (scanning, pairing) by applying following patch:

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5a6aa1627791..b27fe44ec41e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3605,7 +3605,7 @@ static const struct hci_init_stage hci_init2[] =3D {
        /* HCI_OP_READ_INQ_RSP_TX_POWER */
        HCI_INIT(hci_read_inq_rsp_tx_power_sync),
        /* HCI_OP_READ_LOCAL_EXT_FEATURES */
-       HCI_INIT(hci_read_local_ext_features_1_sync),
+       // HCI_INIT(hci_read_local_ext_features_1_sync),
        /* HCI_OP_WRITE_AUTH_ENABLE */
        HCI_INIT(hci_write_auth_enable_sync),
        {}


still with lot of errors in dmesg. My dongle having "Hoco." label on it and
looks like following in lsusb:

Bus 001 Device 005: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Don=
gle
(HCI mode)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0a12 Cambridge Silicon Radio, Ltd
  idProduct          0x0001 Bluetooth Dongle (HCI mode)
  bcdDevice           88.91
  iManufacturer           0=20
  iProduct                2 USB2.0-BT
  iSerial                 0=20
  bNumConfigurations      1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
