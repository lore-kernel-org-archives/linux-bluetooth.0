Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B44C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 17:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C16608FB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 17:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhKAR22 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 13:28:28 -0400
Received: from tropek.jajcus.net ([31.179.132.94]:40984 "EHLO
        tropek.jajcus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhKAR22 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 13:28:28 -0400
Received: from [10.253.0.4] (tropek.jajcus.net [31.179.132.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by tropek.jajcus.net (Postfix) with ESMTPSA id 94DA684FD6
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 18:25:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jajcus.net; s=mail;
        t=1635787553; bh=01OSzVwgitXHshNb5XEuKXXNm3MBvStc7hGvb5ak0q4=;
        h=To:From:Subject:Date:From;
        b=0/Tgfwjvu5wbsEQa0adDNw4jHU8uoF4AR88TKnCx+kt6aSg1KrgcztQTu8COMMXsf
         jOAZX6I1PnGNDs9dMpfxMjcoFTPvC/eQYtX8/SSFKDD1vX26L7ZYFE4zpWEpyVkfOS
         R3PM0RcWOEPtw2+gaNrCkNjvoTaVAqwR5N7a+7lrwcc3a/MNn8EuRURR8BPBloHBS3
         I4csRFoY7cZgOa897AzyRI6c87X115QHSnaVhAutbLl/OXHgB5KfFISm79Mx88hK3p
         4qNCutNS3TBfFpTt9ItiX64iQ8DIWx8Nx0yY94hZNOMjl12xqdlj0I3bKzvGvmVaw0
         YDHDf2ArzlfQw==
To:     linux-bluetooth@vger.kernel.org
From:   Jacek Konieczny <jajcus@jajcus.net>
Subject: Is there a way to force legacy LE pairing for a device
Message-ID: <585f70ee-e8f0-dfbc-6d61-f5082a1c18aa@jajcus.net>
Date:   Mon, 1 Nov 2021 18:25:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I have a problem connecting to a BT device from a Linux desktop –
pairing fails, while an Android phone pairs properly.

The obvious difference in the btsnoop logs is in the pairing request.

Android:
< ACL Data TX: Handle 65 flags 0x00 dlen 11


#995 150.491086
      SMP: Pairing Request (0x01) len 6
        IO capability: KeyboardDisplay (0x04)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, MITM, Legacy, No Keypresses
(0x05)
        Max encryption key size: 16
        Initiator key distribution: EncKey IdKey Sign (0x07)
        Responder key distribution: EncKey IdKey Sign (0x07)
[...]
> ACL Data RX: Handle 65 flags 0x02 dlen 11


#1006 150.571137
      SMP: Pairing Response (0x02) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, Legacy, No
Keypresses (0x01)
        Max encryption key size: 16
        Initiator key distribution: EncKey (0x01)
        Responder key distribution: EncKey (0x01)


And on Linux:
< ACL Data TX: Handle 16 flags 0x00 dlen 11               #53 [hci0]
132.273100
      SMP: Pairing Request (0x01) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, SC, No Keypresses,
CT2 (0x29)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign LinkKey (0x0d)
        Responder key distribution: EncKey IdKey Sign LinkKey (0x0f)
[...]
> ACL Data RX: Handle 16 flags 0x02 dlen 6                #57 [hci0]
132.362160
      SMP: Pairing Failed (0x05) len 1
        Reason: Invalid parameters (0x0a)



So it looks like 'Bonding, MITM, Legacy, No Keypresses' used by Android
works and 'Bonding, No MITM, SC, No Keypresses, CT2' used by the desktop
Linux (bluez 5.62, kernel '5.6.2-050602-lowlatency' from Ubuntu) does
not (note: I am still quite ignorant about Bluetooth stuff).

So my question is: is there any way to force using legacy pairing? Even
if that requires bluez or kernel patching (though, I would rather avoid
that).


Greets,
Jacek
