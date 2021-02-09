Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9390DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 03:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5518964E9D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 03:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBIDLk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Feb 2021 22:11:40 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:60722 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhBIDKP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Feb 2021 22:10:15 -0500
Received: from marcel-macbook.holtmann.net (p4ff9f72d.dip0.t-ipconnect.de [79.249.247.45])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7BA7ECED12;
        Tue,  9 Feb 2021 04:16:41 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2 1/1] Bluetooth: Fix Just-Works re-pairing
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210208220531.3471-2-matias.karhumaa@gmail.com>
Date:   Tue, 9 Feb 2021 04:09:12 +0100
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ari Timonen <ari.timonen@synopsys.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <6C8EE9C0-1F0C-4536-88F2-168A6C31B2E1@holtmann.org>
References: <20210208220531.3471-1-matias.karhumaa@gmail.com>
 <20210208220531.3471-2-matias.karhumaa@gmail.com>
To:     Matias Karhumaa <matias.karhumaa@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Matias,

> Fix Just-Works pairing responder role in case where LTK already exists.
> 
> Currently when another device that was previously paired with Linux
> device and lost the LTK for some reason, tries to pair again using
> NoInputNoOutout IO capability, pairing fails due to DHKey check failure.
> 
> Btmon snippet from failing pairing attempt, Linux side already has the
> LTK:
> 
> < ACL Data TX: Handle 3585 flags 0x00 dlen 6               #12 [hci0] 38.872591
>      SMP: Security Request (0x0b) len 1
>        Authentication requirement: Bonding, MITM, SC, No Keypresses, CT2 (0x2d)
> = bluetoothd: No cache for DE:C7:3E:59:CE:8B                          38.873677
>> HCI Event: Number of Completed Packets (0x13) plen 5     #13 [hci0] 38.972258
>        Num handles: 1
>        Handle: 3585
>        Count: 1
>> HCI Event: Number of Completed Packets (0x13) plen 5     #14 [hci0] 39.072201
>        Num handles: 1
>        Handle: 3585
>        Count: 1
>> ACL Data RX: Handle 3585 flags 0x02 dlen 11              #16 [hci0] 39.171956
>      SMP: Pairing Request (0x01) len 6
>        IO capability: NoInputNoOutput (0x03)
>        OOB data: Authentication data not present (0x00)
>        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
>        Max encryption key size: 16
>        Initiator key distribution: IdKey Sign LinkKey (0x0e)
>        Responder key distribution: IdKey Sign LinkKey (0x0e)
> < ACL Data TX: Handle 3585 flags 0x00 dlen 11              #17 [hci0] 39.172070
>      SMP: Pairing Response (0x02) len 6
>        IO capability: KeyboardDisplay (0x04)
>        OOB data: Authentication data not present (0x00)
>        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
>        Max encryption key size: 16
>        Initiator key distribution: IdKey Sign LinkKey (0x0e)
>        Responder key distribution: Sign LinkKey (0x0c)
>> ACL Data RX: Handle 3585 flags 0x02 dlen 27              #18 [hci0] 39.371260
>> ACL Data RX: Handle 3585 flags 0x01 dlen 27              #19 [hci0] 39.371550
>> HCI Event: Number of Completed Packets (0x13) plen 5     #20 [hci0] 39.371891
>        Num handles: 1
>        Handle: 3585
>        Count: 1
>> ACL Data RX: Handle 3585 flags 0x01 dlen 15              #21 [hci0] 39.372120
>      SMP: Pairing Public Key (0x0c) len 64
>        X: ca5cb38db1955168537666917f6769235c16684dd5015b29d1f02040178a5e36
>        Y: 59e440e4fe49cffb4a1d5abfd0392c088412b19a21c8799ed940e88bb1b7a844
> < ACL Data TX: Handle 3585 flags 0x00 dlen 27              #22 [hci0] 39.382192
> < ACL Data TX: Handle 3585 flags 0x01 dlen 27              #23 [hci0] 39.382197
> < ACL Data TX: Handle 3585 flags 0x01 dlen 15              #24 [hci0] 39.382199
>      SMP: Pairing Public Key (0x0c) len 64
>        X: c19a87e4b8a77a38b5737aad34022cfb339ac421596e66405d0f7e4439598520
>        Y: b1293924e8476082639900ea5241c9138842550b2757427b03d43be67a448409
> < ACL Data TX: Handle 3585 flags 0x00 dlen 21              #25 [hci0] 39.382200
>      SMP: Pairing Confirm (0x03) len 16
>        Confim value: 34cb38b22d23b3a9e80f4bbc90f8efe0
>> HCI Event: Number of Completed Packets (0x13) plen 5     #30 [hci0] 39.471989
>        Num handles: 1
>        Handle: 3585
>        Count: 1
>> HCI Event: Number of Completed Packets (0x13) plen 5     #31 [hci0] 39.472933
>        Num handles: 1
>        Handle: 3585
>        Count: 1
>> HCI Event: Number of Completed Packets (0x13) plen 5     #32 [hci0] 39.473930
>        Num handles: 1
>        Handle: 3585
>        Count: 1
>> ACL Data RX: Handle 3585 flags 0x02 dlen 21              #33 [hci0] 39.571354
>      SMP: Pairing Random (0x04) len 16
>        Random value: cccccccccccccccccccccccccccccccc
> @ MGMT Event: User Confirmation R.. (0x000f) plen 12  {0x0002} [hci0] 39.571462
>        LE Address: DE:C7:3E:59:CE:8B (Static)
>        Confirm hint: 0x01
>        Value: 0x00000000
> @ MGMT Event: User Confirmation R.. (0x000f) plen 12  {0x0001} [hci0] 39.571462
>        LE Address: DE:C7:3E:59:CE:8B (Static)
>        Confirm hint: 0x01
>        Value: 0x00000000
> < ACL Data TX: Handle 3585 flags 0x00 dlen 21              #34 [hci0] 39.571482
>      SMP: Pairing Random (0x04) len 16
>        Random value: c57bf6866a97bfa184657f89c3c644e5
>> HCI Event: Number of Completed Packets (0x13) plen 5     #35 [hci0] 39.571752
>        Num handles: 1
>        Handle: 3585
>        Count: 1
>> ACL Data RX: Handle 3585 flags 0x02 dlen 21              #37 [hci0] 39.721325
>      SMP: Pairing DHKey Check (0x0d) len 16
>        E: 7a264e8fa19c835ff0db5db07bec23f6
> @ MGMT Event: Authentication Failed (0x0011) plen 8   {0x0002} [hci0] 39.721440
>        LE Address: DE:C7:3E:59:CE:8B (Static)
>        Status: Authentication Failed (0x05)
> @ MGMT Event: Authentication Failed (0x0011) plen 8   {0x0001} [hci0] 39.721440
>        LE Address: DE:C7:3E:59:CE:8B (Static)
>        Status: Authentication Failed (0x05)
> < ACL Data TX: Handle 3585 flags 0x00 dlen 6               #38 [hci0] 39.721463
>      SMP: Pairing Failed (0x05) len 1
>        Reason: DHKey check failed (0x0b)
> 
> DHKey check fails because one of the inputs of DHKey calculation
> function smp_f6() is mackey and it is not calculated at all in this
> scenario.
> 
> Commit introducing this bug was meant just for fixing uninitialized
> use of passkey variable and the bug looks like accidental side effect.
> The commit adds "goto confirm" statement that skips mackey calculation
> in smp_cmd_pairing_random() function.
> 
> With this fix mackey is calculated in a similar way also in the case
> that Linux responder already has the LTK. Mackey is calculated right
> before requesting confirmation for Just-Works pairing from userspace
> which in turn fixes the DHKey calculation.
> 
> Fixes: eed467b517e8 ("Bluetooth: fix passkey uninitialized when used")
> Reported-by: Ari Timonen <ari.timonen@synopsys.com>
> Signed-off-by: Matias Karhumaa <matias.karhumaa@gmail.com>
> ---
> net/bluetooth/smp.c | 42 +++++++++++++-----------------------------
> 1 file changed, 13 insertions(+), 29 deletions(-)

thanks for the extra explanation. Now I just would prefer that we get a Tested-by and Reviewed-by tags added from at least one other person.

Regards

Marcel

