Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7A1C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Oct 2022 15:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJMPgi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJMPgf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Oct 2022 11:36:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F3DBE2C8
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 08:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6A5A61840
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 15:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32670C433C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 15:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665675393;
        bh=zTMF7+VKzt4jgpXDFAkTfUlT79/ttDwUI2vfZ7m4qQo=;
        h=From:To:Subject:Date:From;
        b=O3sPoGpjdmd8qXLARXd8dZwEWcBWFZSaIy21aiSUR5yWZy23LBBe4M2lbjPJTJFr4
         Gx8gJx6Nshv5IQnHpXDTFVXWKlG2tYRZT+p06lfeXehJJtMVgVNKiL3XCI2m6Aw1qu
         57VfGYGyCeMySc/sS56W4OcYQFX6Fh1vi1qhTG+6Adio8NFLyNggV/SBD+nrpDWkSU
         ptSQAiismjTiXNJYUlZMuT9pFeJhLDiPq907l47YjCwgQTlOpbQBJs2Dn5cvLmEN+o
         kABHlvIGrw9qEBpTu3dyFphjPDli0qqMEZ6k60SGfy03fCQdOuHk9RAF94B3tHGSEE
         CaJTHNGHcRCVw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 19217C433E7; Thu, 13 Oct 2022 15:36:33 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216580] New: Jabra Elite 75t (ear buds):Unable to connect and
 use (`hci0: Opcode 0x 401 failed: -16`)
Date:   Thu, 13 Oct 2022 15:36:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216580-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216580

            Bug ID: 216580
           Summary: Jabra Elite 75t (ear buds):Unable to connect and use
                    (`hci0: Opcode 0x 401 failed: -16`)
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.0-rc7
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: pmenzel+bugzilla.kernel.org@molgen.mpg.de
        Regression: No

This is a Dell Latitude E7250 with Debian sid/unstable with Linux 6.0-rc7 a=
nd
*bluez* 5.65-1.

    Bus 001 Device 003: ID 8087:0a2a Intel Corp. Bluetooth wireless interfa=
ce

The Jabra ear buds show up several times in the gnome-control-center=E2=80=
=99s
Bluetooth section (Every three(?) seconds one more popped up until three or
four were shown.)

Pairing and connecting worked, but then it was disconnected, and the proper=
ties
said, the device type is unknown, that means it wasn=E2=80=99t detected as =
audio
output. Linux logged the line below, no idea, if it is related:

    Bluetooth: hci0: Opcode 0x 401 failed: -16

```
[10968.635501] calling  bnep_init+0x0/0xc2 [bnep] @ 8069
[10968.635510] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[10968.635512] Bluetooth: BNEP filters: protocol multicast
[10968.635517] Bluetooth: BNEP socket layer initialized
[10968.635518] initcall bnep_init+0x0/0xc2 [bnep] returned 0 after 8 usecs
[10968.639206] Bluetooth: MGMT ver 1.22
[10968.656529] calling  af_alg_init+0x0/0x1000 [af_alg] @ 8072
[10968.656536] NET: Registered PF_ALG protocol family
[10968.656537] initcall af_alg_init+0x0/0x1000 [af_alg] returned 0 after 1
usecs
[10968.670311] calling  algif_skcipher_init+0x0/0x1000 [algif_skcipher] @ 8=
075
[10968.670319] initcall algif_skcipher_init+0x0/0x1000 [algif_skcipher]
returned 0 after 0 usecs
[10968.694495] calling  algif_hash_init+0x0/0x1000 [algif_hash] @ 8080
[10968.694502] initcall algif_hash_init+0x0/0x1000 [algif_hash] returned 0
after 0 usecs
[10968.703175] calling  crypto_cmac_module_init+0x0/0x1000 [cmac] @ 8084
[10968.703181] initcall crypto_cmac_module_init+0x0/0x1000 [cmac] returned 0
after 1 usecs
[10969.100553] calling  rfcomm_init+0x0/0xdd [rfcomm] @ 8087
[10969.100629] Bluetooth: RFCOMM TTY layer initialized
[10969.100634] Bluetooth: RFCOMM socket layer initialized
[10969.100643] Bluetooth: RFCOMM ver 1.11
[10969.100646] initcall rfcomm_init+0x0/0xdd [rfcomm] returned 0 after 81 u=
secs
[10998.096380] calling  prng_mod_init+0x0/0x1000 [ansi_cprng] @ 8139
[10998.096539] initcall prng_mod_init+0x0/0x1000 [ansi_cprng] returned 0 af=
ter
149 usecs
[10998.102550] calling  drbg_init+0x0/0xef2 [drbg] @ 8139
[10998.103349] initcall drbg_init+0x0/0xef2 [drbg] returned 0 after 791 use=
cs
[10998.115790] calling  sha512_generic_mod_init+0x0/0x1000 [sha512_generic]=
 @
8168
[10998.115976] initcall sha512_generic_mod_init+0x0/0x1000 [sha512_generic]
returned 0 after 175 usecs
[10998.117796] calling  sha512_ssse3_mod_init+0x0/0x1000 [sha512_ssse3] @ 8=
168
[10998.118010] initcall sha512_ssse3_mod_init+0x0/0x1000 [sha512_ssse3]
returned 0 after 205 usecs
[10998.124309] calling  jent_mod_init+0x0/0x1000 [jitterentropy_rng] @ 8179
[10998.133261] initcall jent_mod_init+0x0/0x1000 [jitterentropy_rng] return=
ed 0
after 8942 usecs
[11016.243648] Bluetooth: hci0: Opcode 0x 401 failed: -16
```

bluetoothd messages in the journal:

```
Okt 13 14:08:19.628200 ersatz systemd[1]: Starting Bluetooth service...
Okt 13 14:08:19.717447 ersatz bluetoothd[8067]: Bluetooth daemon 5.65
Okt 13 14:08:19.731566 ersatz systemd[1]: Started Bluetooth service.
Okt 13 14:08:19.740475 ersatz bluetoothd[8067]: Starting SDP server
Okt 13 14:08:19.778720 ersatz bluetoothd[8067]: Bluetooth management interf=
ace
1.22 initialized
Okt 13 14:08:19.846270 ersatz bluetoothd[8067]:
profiles/sap/server.c:sap_server_register() Sap driver initialization faile=
d.
Okt 13 14:08:19.846286 ersatz bluetoothd[8067]: sap-server: Operation not
permitted (1)
Okt 13 14:08:20.245498 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/ldac
Okt 13 14:08:20.245524 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSink/aptx_hd
Okt 13 14:08:20.245533 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/aptx_hd
Okt 13 14:08:20.245540 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSink/aptx
Okt 13 14:08:20.245546 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/aptx
Okt 13 14:08:20.245554 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSink/sbc
Okt 13 14:08:20.245562 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/sbc
Okt 13 14:08:20.245568 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSink/sbc_xq
Okt 13 14:08:20.245574 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/sbc_xq
Okt 13 14:08:20.245580 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/aptx_ll_1
Okt 13 14:08:20.245587 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/aptx_ll_0
Okt 13 14:08:20.245593 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/aptx_ll_duplex_1
Okt 13 14:08:20.245603 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/aptx_ll_duplex_0
Okt 13 14:08:20.245616 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/faststream
Okt 13 14:08:20.245628 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/faststream_duplex
Okt 13 14:08:20.245639 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSink/opus_05
Okt 13 14:08:20.245651 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/opus_05
Okt 13 14:08:20.245661 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/opus_05_51
Okt 13 14:08:20.245668 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/opus_05_71
Okt 13 14:08:20.245674 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSink/opus_05_duplex
Okt 13 14:08:20.245680 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/opus_05_duplex
Okt 13 14:08:20.245687 ersatz bluetoothd[8067]: Endpoint registered:
sender=3D:1.56 path=3D/MediaEndpoint/A2DPSource/opus_05_pro
Okt 13 14:08:22.515725 ersatz bluetoothd[8067]: Failed to set mode: Failed
(0x03)
Okt 13 14:08:26.044861 ersatz bluetoothd[8067]: Failed to set mode: Failed
(0x03)
Okt 13 14:08:57.914640 ersatz bluetoothd[8067]: Device is already marked as
connected
Okt 13 14:08:59.218535 ersatz bluetoothd[8067]: Device is already marked as
connected
Okt 13 14:10:02.335876 ersatz bluetoothd[8067]: src/profile.c:ext_connect()
Hands-Free Voice gateway failed connect to 50:C2:ED:6B:24:98: Connection
refused (111)
Okt 13 14:10:02.471755 ersatz bluetoothd[8067]:
profiles/audio/avdtp.c:avdtp_connect_cb() connect to 50:C2:ED:6B:24:98:
Connection refused (111)
Okt 13 14:10:05.127901 ersatz bluetoothd[8067]:
profiles/audio/avdtp.c:avdtp_connect_cb() connect to 50:C2:ED:6B:24:98:
Connection refused (111)
Okt 13 14:10:11.327826 ersatz bluetoothd[8067]: src/profile.c:ext_connect()
Hands-Free Voice gateway failed connect to 50:C2:ED:6B:24:98: Connection
refused (111)
Okt 13 14:10:11.463810 ersatz bluetoothd[8067]:
profiles/audio/avdtp.c:avdtp_connect_cb() connect to 50:C2:ED:6B:24:98:
Connection refused (111)
Okt 13 14:10:14.107766 ersatz bluetoothd[8067]:
profiles/audio/avdtp.c:avdtp_connect_cb() connect to 50:C2:ED:6B:24:98:
Connection refused (111)
Okt 13 14:17:56.098494 ersatz bluetoothd[8067]: Device is already marked as
connected
Okt 13 14:17:56.475325 ersatz bluetoothd[8067]: Failed to set mode: Busy (0=
x0a)
Okt 13 14:17:56.936575 ersatz bluetoothd[8067]: Device is already marked as
connected
Okt 13 14:18:18.286239 ersatz bluetoothd[8067]: src/profile.c:record_cb()
Unable to get Hands-Free Voice gateway SDP record: Host is down
Okt 13 14:31:41.074910 ersatz bluetoothd[8067]: Wrong size of start discove=
ry
return parameters
Okt 13 14:31:46.754174 ersatz bluetoothd[8067]: Terminating
Okt 13 14:31:46.754333 ersatz systemd[1]: Stopping Bluetooth service...
```

After removing `btusb` module, and starting `btmon` and inserting `btusb` a=
lso,
and after a restart, the Jabra device did not show up anymore.

(Connecting the laptop to the Nokia N9 still worked.)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
