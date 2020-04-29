Return-Path: <SRS0=4cRj=6N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2308C83006
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 19:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D56214AF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 19:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK5B0stW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgD2TAF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2TAE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Apr 2020 15:00:04 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3236FC03C1AE
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 12:00:04 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id j4so2641859otr.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yFy958IcuyeeMse6XElJmLy/3LwuURNiHILY7Vmg+XU=;
        b=AK5B0stWKtLriL2l0+/PCfzxpsI6nQTqnP5I5nIoFNzRWjYCU1S14sfnzcUm5OPkbs
         Q+KzPI86+UoH9NyGET4miiWj1tX6/hQAk0ryfFSP7xflt3FAwl/sf1SHv6bc3+a8lIcJ
         6FflUeZ3Kz9l1GfSQ+t4xzgsKt4NJOFuaHvztfsNb96e+q45PDiXqwJ5QWLV7kPCyDPK
         l46egyFqKfSj4OtlHxlMRDtfgFi7UUUpxLnukwiUQh6DCswtZrBVX+uepjtYTQ7zt8ZQ
         b0HW+3stAmoJPSg8tPtZauE3ZIZ3A2cta/lRRM0dQsDWS/j0f4/AVlafMq70w4W9C5qc
         Nvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yFy958IcuyeeMse6XElJmLy/3LwuURNiHILY7Vmg+XU=;
        b=lq+2e5zM8GPRnNvv0Onldz59XpdNPLEtT6A4R4PQXuJrPh8GatRYtwbQi5vZww8bC0
         u0Vea7aJJNvT0ZdVxRMimXMcXmFUB3n8wgWY64CCFCunxYE8LgKgfdhPY7/bX56GkSK9
         3BOsQz837BEGqTIcf+EWJQo+0RQsxVx3XkwSETND2ZMwuDzGyvmUKc3XpdVIUgedN6mF
         u+6jLAmhcJEgZ2V6hqUBm/Ims32+h+fKzWlm0nY/RtRX1cDeIvW02pte0POpE2oXF+fP
         rV34K6jB8AR9nGyrqc4sav5B2mexouJIMVNLKlJzC2u0mPNt9OBQUxWnu8+7oG32keoU
         G4YQ==
X-Gm-Message-State: AGi0PuYViWwDoKuTd7rdp9plQ35NQW00+UYXjolvXrT6jdqU2vP+mdxN
        Z8AbeZgGu9YzXped49mD9GgZ7+SwCciOoGQWG5EnFlh/
X-Google-Smtp-Source: APiQypJvitqAH8AFYEJnIUeP6ztXwa6TRa4rSasNCZy/kzMoRmKq/p0pdgEK7gt+3nVkANt2LIIqX66MrloqHS7QxeY=
X-Received: by 2002:a9d:7244:: with SMTP id a4mr4122860otk.177.1588186803411;
 Wed, 29 Apr 2020 12:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <AM0PR02MB3841479A0B2378DF0B0109AAC5AC0@AM0PR02MB3841.eurprd02.prod.outlook.com>
In-Reply-To: <AM0PR02MB3841479A0B2378DF0B0109AAC5AC0@AM0PR02MB3841.eurprd02.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 29 Apr 2020 11:59:51 -0700
Message-ID: <CABBYNZ+7_N27=2_t1ZjVtmTvoqAv_PB67A+Or_hp_XrS4tqnNw@mail.gmail.com>
Subject: Re: Characteristic ReadValue / WriteValue never finish
To:     Kai Ruhnau <kai.ruhnau@target-sg.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kai,

On Tue, Apr 28, 2020 at 5:59 AM Kai Ruhnau <kai.ruhnau@target-sg.com> wrote:
>
> Hi,
>
> I'm running Linux 5.4.32 and Bluez 5.54 on my embedded platform and use from my
> application the DBus interface to set up the local GATT database and work with
> remote services.
>
> In one scenario, I have an agent registered and call as peripheral the
> ReadValue method of a central's encrypted characteristic before pairing has
> been done. This results in my agent implementation receiving a
> RequestConfirmation call for pairing. I complete that agent's method call with
> an org.bluez.Error.Rejected error and unregister my agent. The initial
> ReadValue method call, though, is never completed - my application neither
> receives a DBus method return or an error for that method call.
>
> Instead, using btmon, I can see that internally, the read request is
> continuously retried every ~1.2 seconds. Each time, there is an Insufficient
> Authentication error, a Pairing Request, an immediate Authentication Failed,
> and a Pairing Failed response.
>
> I would have expected that after rejecting the first pairing request, the
> ReadValue method call is completed with for example a
> org.bluez.Error.NotAuthorized error, and not an uninterruptible loop.
>
> These are the bluetoothd debug messages while in the loop:
> bluetoothd[2370]: ../bluez-5.54/src/device.c:gatt_debug() Read By Type - start: 0x0001 end: 0x0005
> bluetoothd[2370]: ../bluez-5.54/src/gatt-database.c:gap_device_name_read_cb() GAP Device Name read request
> bluetoothd[2370]: ../bluez-5.54/src/adapter.c:bonding_attempt_complete() hci0 bdaddr 5A:2A:C3:75:E8:BB type 2 status 0x5
> bluetoothd[2370]: ../bluez-5.54/src/device.c:device_bonding_complete() bonding (nil) status 0x05
> bluetoothd[2370]: ../bluez-5.54/src/device.c:device_bonding_failed() status 5
> bluetoothd[2370]: ../bluez-5.54/src/adapter.c:resume_discovery()
> [pause, then repeat]
>
>
> Here's an excerpt from the btmon log starting at the reject and showing the loop
>
> @ MGMT Command: User Confirmation... (0x001d) plen 7  {0x0001} [hci0] 44.045329
>         LE Address: 4E:FE:AC:7A:F8:93 (Resolvable)
> < ACL Data TX: Handle 1025 flags 0x00 dlen 6              #322 [hci0] 44.045373
>       SMP: Pairing Failed (0x05) len 1
>         Reason: Numeric comparison failed (0x0c)
> @ MGMT Event: Authentication Failed (0x0011) plen 8   {0x0002} [hci0] 44.045400
>         LE Address: 4E:FE:AC:7A:F8:93 (Resolvable)
>         Status: Authentication Failed (0x05)
> @ MGMT Event: Authentication Failed (0x0011) plen 8   {0x0001} [hci0] 44.045400
>         LE Address: 4E:FE:AC:7A:F8:93 (Resolvable)
>         Status: Authentication Failed (0x05)
> @ MGMT Event: Command Complete (0x0001) plen 10       {0x0001} [hci0] 44.045426
>       User Confirmation Negative Reply (0x001d) plen 7
>         Status: Success (0x00)
>         LE Address: 4E:FE:AC:7A:F8:93 (Resolvable)
> @ MGMT Command: Remove Advertising (0x003f) plen 1    {0x0001} [hci0] 44.052011
>         Instance: 2
> @ MGMT Event: Advertising Removed (0x0024) plen 1     {0x0002} [hci0] 44.052029
>         Instance: 2
> @ MGMT Event: Command Complete (0x0001) plen 4        {0x0001} [hci0] 44.052041
>       Remove Advertising (0x003f) plen 1
>         Status: Success (0x00)
>         Instance: 2
> > HCI Event: Number of Completed Packets (0x13) plen 5    #323 [hci0] 44.190618
>         Num handles: 1
>         Handle: 1025
>         Count: 1
> > ACL Data RX: Handle 1025 flags 0x02 dlen 11             #324 [hci0] 45.082137
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x0001-0x0005
>         Attribute type: Device Name (0x2a00)
> < ACL Data TX: Handle 1025 flags 0x00 dlen 14             #325 [hci0] 45.084191
>       ATT: Read By Type Response (0x09) len 9
>         Attribute data length: 8
>         Attribute data list: 1 entry
>         Handle: 0x0003
>         Value: 663930307378
> < ACL Data TX: Handle 1025 flags 0x00 dlen 7              #326 [hci0] 45.086693
>       ATT: Read Request (0x0a) len 2
>         Handle: 0x003b
> > ACL Data RX: Handle 1025 flags 0x02 dlen 9              #327 [hci0] 45.141328
>       ATT: Error Response (0x01) len 4
>         Read Request (0x0a)
>         Handle: 0x003b
>         Error: Insufficient Authentication (0x05)
> > HCI Event: Number of Completed Packets (0x13) plen 5    #328 [hci0] 45.141350
>         Num handles: 1
>         Handle: 1025
>         Count: 2
> < ACL Data TX: Handle 1025 flags 0x00 dlen 6              #329 [hci0] 45.142787
>       SMP: Security Request (0x0b) len 1
>         Authentication requirement: Bonding, MITM, SC, No Keypresses, CT2 (0x2d)
> > ACL Data RX: Handle 1025 flags 0x02 dlen 11             #330 [hci0] 45.201290
>       SMP: Pairing Request (0x01) len 6
>         IO capability: KeyboardDisplay (0x04)
>         OOB data: Authentication data not present (0x00)
>         Authentication requirement: Bonding, MITM, SC, No Keypresses, CT2 (0x2d)
>         Max encryption key size: 16
>         Initiator key distribution: EncKey IdKey LinkKey (0x0b)
>         Responder key distribution: EncKey IdKey LinkKey (0x0b)
> @ MGMT Event: Authentication Failed (0x0011) plen 8   {0x0002} [hci0] 45.201455
>         LE Address: 4E:FE:AC:7A:F8:93 (Resolvable)
>         Status: Authentication Failed (0x05)
> @ MGMT Event: Authentication Failed (0x0011) plen 8   {0x0001} [hci0] 45.201455
>         LE Address: 4E:FE:AC:7A:F8:93 (Resolvable)
>         Status: Authentication Failed (0x05)
> < ACL Data TX: Handle 1025 flags 0x00 dlen 6              #331 [hci0] 45.201551
>       SMP: Pairing Failed (0x05) len 1
>         Reason: Pairing not supported (0x05)
> > HCI Event: Number of Completed Packets (0x13) plen 5    #332 [hci0] 45.261239
>         Num handles: 1
>         Handle: 1025
>         Count: 2
>  [pause, then goto 45.082137]

Interresting, I think originally the kernel would disconnect if the
pairing fails but perhaps that is no longer the case so we keep
retrying, will have a look what can be done regarding this.

-- 
Luiz Augusto von Dentz
