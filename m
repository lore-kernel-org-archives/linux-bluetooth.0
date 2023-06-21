Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378D8EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 10:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjFUKqb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjFUKqE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 06:46:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1A11A3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 03:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E109C614E9
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 10:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57274C433C0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687344275;
        bh=i66ISwIE4dqumzFeG6jjePjXQ2CViFbDybxShycW64w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jFVv6Yk6M6bjDY5zl22TIUS4JE8Y1yXLEwnJnOUdzeiMrZYMOjIW28bEuHqCdFKwG
         +Y3g75PxMLpq/aw22PZ87vMxQj6gRswXHJxdDK2ZZwT1n9zc/INLazgUdAESDlkkZa
         m6elKjSFb4ef6zY0YubRQOVdjlAFwQvEyaYtUOVd9HJoM05/0r9YFTnXwalnCAVCHY
         dLTGGwEpVCzldxupF28NpwgeTn8ceEAoayb7hKElzTUaDv8tabU0SpHvsgylgTLjyM
         Z/SRc7FHjILsGpXyRZAn8YZ0+45IlM8eyyn1e/Jq3UFDP+oc6w+s2b/QBaK86GhVdM
         qfqG3juZLkS5g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 44168C4332E; Wed, 21 Jun 2023 10:44:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217581] Bluetooth L2CAP use-after-free
Date:   Wed, 21 Jun 2023 10:44:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mohamed-yassine.jebabli@witbe.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217581-62941-7i7rUEgkuF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217581-62941@https.bugzilla.kernel.org/>
References: <bug-217581-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217581

--- Comment #3 from Mohamed Yassine JEBABLI (mohamed-yassine.jebabli@witbe.=
net) ---
btmon trace :=20


@ MGMT Command: Load Long Te.. (0x0013) plen 38  {0x0001} [hci1] 835.836638
        Keys: 1
        LE Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Key type: Unauthenticated legacy key (0x00)
        Central: 0x00
        Encryption size: 16
        Diversifier: 5565
        Randomizer: 08014962c65a5aef
        Key: ea06c5bdb5409c43d3935b7e5b79877a
@ MGMT Event: Command Complete (0x0001) plen 3   {0x0001} [hci1] 835.836651
      Load Long Term Keys (0x0013) plen 0
        Status: Success (0x00)
@ MGMT Command: Load Identit.. (0x0030) plen 25  {0x0001} [hci1] 835.837036
        Keys: 1
        LE Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Key: d74d35e5fd6e95d6804b8391487d76d8
@ MGMT Event: Command Complete (0x0001) plen 3   {0x0001} [hci1] 835.837046
      Load Identity Resolving Keys (0x0030) plen 0
        Status: Success (0x00)
< HCI Command: LE Clear Res.. (0x08|0x0029) plen 0  #1018 [hci1] 835.837519
> HCI Event: Command Complete (0x0e) plen 4         #1019 [hci1] 836.030177
      LE Clear Resolving List (0x08|0x0029) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Add Devi.. (0x08|0x0027) plen 39  #1020 [hci1] 836.031432
        Address type: Public (0x00)
        Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Peer identity resolving key: d74d35e5fd6e95d6804b8391487d76d8
        Local identity resolving key: 00000000000000000000000000000000
> HCI Event: Command Complete (0x0e) plen 4         #1021 [hci1] 836.033137
      LE Add Device To Resolving List (0x08|0x0027) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Addre.. (0x08|0x002d) plen 1  #1022 [hci1] 836.033708
        Address resolution: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4         #1023 [hci1] 836.035051
      LE Set Address Resolution Enable (0x08|0x002d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Adve.. (0x08|0x0008) plen 32  #1024 [hci1] 836.035618
        Length: 15
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        Appearance: Remote Control (0x0180)
        16-bit Service UUIDs (partial): 3 entries
          Human Interface Device (0x1812)
          Battery Service (0x180f)
          Device Information (0x180a)
> HCI Event: Command Complete (0x0e) plen 4         #1025 [hci1] 836.037143
      LE Set Advertising Data (0x08|0x0008) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan.. (0x08|0x0009) plen 32  #1026 [hci1] 836.037778
        Length: 22
        Name (complete): NVIDIA SHIELD Remote
> HCI Event: Command Complete (0x0e) plen 4         #1027 [hci1] 836.039032
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Adve.. (0x08|0x0006) plen 15  #1028 [hci1] 836.039649
        Min advertising interval: 20.000 msec (0x0020)
        Max advertising interval: 20.000 msec (0x0020)
        Type: Connectable undirected - ADV_IND (0x00)
        Own address type: Public (0x02)
        Direct address type: Public (0x00)
        Direct address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from Any, Allow Connect Request f=
rom
Any (0x00)
> HCI Event: Command Complete (0x0e) plen 4         #1029 [hci1] 836.041059
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Adver.. (0x08|0x000a) plen 1  #1030 [hci1] 836.041617
        Advertising: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4         #1031 [hci1] 836.044146
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 31           #1032 [hci1] 836.776845
      LE Enhanced Connection Complete (0x0a)
        Status: Success (0x00)
        Handle: 0 Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Role: Peripheral (0x01)
        Peer address type: Resolved Public (0x02)
        Peer address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Local resolvable private address: 00:00:00:00:00:00 (Non-Resolvable)
        Peer resolvable private address: 53:6E:75:EF:0A:34 (Resolvable)
          Identity type: Public (0x00)
          Identity: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Connection interval: 48.75 msec (0x0027)
        Connection latency: 0 (0x0000)
        Supervision timeout: 10000 msec (0x03e8)
        Central clock accuracy: 0x01
@ MGMT Event: Device Connected (0x000b) plen 13  {0x0001} [hci1] 836.776999
        LE Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Flags: 0x00000000
        Data length: 0
< HCI Command: LE Read Remo.. (0x08|0x0016) plen 2  #1033 [hci1] 836.777167
        Handle: 0 Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
@ RAW Open: btmon (privileged) version 2.22             {0x0004} 836.777817
@ RAW Close: btmon                                      {0x0004} 836.777829
> HCI Event: LE Meta Event (0x3e) plen 4            #1034 [hci1] 836.777798
      LE Channel Selection Algorithm (0x14)
        Handle: 0 Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Algorithm: #1 (0x00)
@ MGMT Command: Pair Device (0x0019) plen 8      {0x0001} [hci1] 836.777975
        LE Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Capability: NoInputNoOutput (0x03)
@ MGMT Event: Command Complete (0x0001) plen 10  {0x0001} [hci1] 836.777985
      Pair Device (0x0019) plen 7
        Status: Already Paired (0x13)
        LE Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
> HCI Event: Command Status (0x0f) plen 4           #1035 [hci1] 836.778817
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Adver.. (0x08|0x000a) plen 1  #1036 [hci1] 836.779076
        Advertising: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4         #1037 [hci1] 836.780813
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 12           #1038 [hci1] 836.885795
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 0 Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Features: 0xff 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Connection Parameter Request Procedure
          Extended Reject Indication
          Peripheral-initiated Features Exchange
          LE Ping
          LE Data Packet Length Extension
          LL Privacy
          Extended Scanner Filter Policies
< ACL Data TX: Handle 0 flags 0x00 dlen 6           #1039 [hci1] 836.886185
      SMP: Security Request (0x0b) len 1
        Authentication requirement: Bonding, No MITM, Legacy, No Keypresses
(0x01)
> HCI Event: Number of Completed P.. (0x13) plen 5  #1040 [hci1] 836.982862
        Num handles: 1
        Handle: 0 Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Count: 1
> HCI Event: LE Meta Event (0x3e) plen 13           #1041 [hci1] 837.031821
      LE Long Term Key Request (0x05)
        Handle: 0 Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Random number: 0xef5a5ac662490108
        Encrypted diversifier: 0x6555
< HCI Command: LE Long Ter.. (0x08|0x001a) plen 18  #1042 [hci1] 837.031865
        Handle: 0 Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Long term key: ea06c5bdb5409c43d3935b7e5b79877a
> HCI Event: Command Complete (0x0e) plen 6         #1043 [hci1] 837.033755
      LE Long Term Key Request Reply (0x08|0x001a) ncmd 1
        Status: Success (0x00)
        Handle: 0 Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
> HCI Event: Encryption Change (0x08) plen 4        #1044 [hci1] 837.177841
        Status: Success (0x00)
        Handle: 0 Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Encryption: Enabled with AES-CCM (0x01)
< HCI Command: Write Authen.. (0x03|0x007c) plen 4  #1045 [hci1] 837.177998
        Handle: 0 Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Timeout: 30000 msec (0x0bb8)
> HCI Event: Command Complete (0x0e) plen 6         #1046 [hci1] 837.179778
      Write Authenticated Payload Timeout (0x03|0x007c) ncmd 1
        Status: Success (0x00)
        Handle: 0 Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
> HCI Event: Disconnect Complete (0x05) plen 4      #1047 [hci1] 837.275758
        Status: Success (0x00)
        Handle: 0 Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Reason: Remote User Terminated Connection (0x13)
@ MGMT Event: Device Disconne.. (0x000c) plen 8  {0x0001} [hci1] 837.275853
        LE Address: 48:B0:2D:02:81:0A (NVIDIA Corporation)
        Reason: Connection terminated by remote host (0x03)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
