Return-Path: <SRS0=Kt1c=UU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10F5C43613
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jun 2019 17:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EBA2070B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jun 2019 17:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTkk+1Sp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfFURMZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:12:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36261 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFURMZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jun 2019 13:12:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so7014544oti.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2019 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ia3Es3ZIQOSw8LnbSlXPT9BBqbcriY6xDKpdfJwUeM=;
        b=gTkk+1SpIdAT0RI3M9a7Gp5RpJi7JVBf8ktC4cnDLeqUoiaaF1lJEvhbj0lKWlzyg1
         o5j0iAp3okw4YAe1+QrxhsYiRBVdxFmq1OHeraK46zFfi2pY0QTKaNcZyJiYV1ZqBJ7w
         gWz1ag3M5aV7UE9awz+3zJePFFd8T+pv3FIyN3EgrS9As0SdqIJBuoUJlUIHzjZKDUuY
         pJuQUofA8bG6AUKxQMq8l3nG5X6ayh/TjmROSC/JDmGNekUA3NqQyWUFEIJUO2vFrmTc
         Oa4Q7Ejlcf22WVAezYijLehFHMIz56lmeAaKUrkK/oGKIiiCf9lQqF8yKPaY2AM5YMnc
         yeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ia3Es3ZIQOSw8LnbSlXPT9BBqbcriY6xDKpdfJwUeM=;
        b=smL8FrmxJCh6otsR+ifbpSAldDjXsmCoWv7OgZGhtzA7KLKyQdaIx39CDzcbFM85KU
         4C/cnh31MdIgEYXOaJGBtDCZnNY/v8oLzy8sawvZ7crxBC+T9bYkJ01NjDRj7lUenfOa
         P1cfxscCHtTFzuWGlamZx/n+XVbXejkyN3iMTC+SCsUWRVv4UieIkCbFQ0tNtHEZsQE2
         TgDo43gcUChEnGifNrbdkiXZMgxeIDq2MuNnPrHnYY+JRwAEPA9HZ05BTor1oXwyb0+v
         iSLbZLX5/T3PC0qnB3pE5GSmodiXKCf7Ak4jLwf2LYLOYSHjtSd8QwGB1wXBPdDW+TiU
         nKPg==
X-Gm-Message-State: APjAAAX6U1T2C1l51NMhaoM/JGjVqB9NUrTV3P8oyhStvo281IC02FbQ
        PLwEcdGAvxKgyu78yz2Lj3DGfo/MNoekGmlhHLCAUc13+CY=
X-Google-Smtp-Source: APXvYqyAXonT3GIIezS75ViQTb9R0/TC0R42y163owY46geAh8RkIiqBoactmmisw2e3T9MF1LlBuu2u3wOrA5eERKk=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr6000844otf.146.1561137146216;
 Fri, 21 Jun 2019 10:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <ac86be65a0d4e042a6d2a5b51ff7e56fcbaf38a8.camel@victronenergy.com>
In-Reply-To: <ac86be65a0d4e042a6d2a5b51ff7e56fcbaf38a8.camel@victronenergy.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Jun 2019 20:12:16 +0300
Message-ID: <CABBYNZKXF_2MHA0vSb=zwYoriyFWoA+k4b4_9Y=su2Jme=1duA@mail.gmail.com>
Subject: Re: Double flags field in LE advertising data
To:     Thiemo van Engelen <tvanengelen@victronenergy.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Thiemo,

On Thu, Jun 20, 2019 at 12:53 PM Thiemo van Engelen
<tvanengelen@victronenergy.com> wrote:
>
> Hi,
>
> We have an embedded device with Bluez 5.50, kernel 4.19 and a bluetooth
> controller where we disable br/edr.
> When we start an LE advertisement and set the Discoverable property (of
> the advertisment, not the adapter) to True, the advertised packet
> contains 2 flag fields, containing different values. See the following
> btmon log of the device:
>
> < HCI Command: LE Set Advertising Data (0x08|0x0008) plen
> 32
>
>              #211 [hci0] 1656.561908
>         Length: 24
>         Flags: 0x04
>           BR/EDR Not Supported
>         128-bit Service UUIDs (complete): 1 entry
>           Vendor specific (cd54c001-880b-425b-b167-81ed6a15e913)
>         Flags: 0x06
>           LE General Discoverable Mode
>           BR/EDR Not Supported
>
> This is not allowed according to the "Supplement to Bluetooth Core
> Specification" and the fact that both fields are different seems to
> confuse other devices.
>
> The flags are added twice because bluetoothd appends a flags field in
> the parse_discoverable / set_flags functions (since commit eca59ac27),
> but the kernel also adds a flags field in the function
> create_instance_adv_data when BREDR is disabled.

Interesting I guess that is a problem only when BR/EDR is disabled
since I tested this and the kernel would be adding any flags, anyway
the kernel should check if the flags have been set and don't attempt
to set it again.

> Perhaps the way to solve this is by not adding the flags field to the
> advertisement data, but changing client->flags in accordance with the
> Discoverable property and passing that to the kernel using the
> mgmt_cp_add_advertising struct (which is already done). The kernel is
> then solely responsible for flags. I however have no idea if the flags
> passed this way are also used used for BREDR advertising or not.
>
> Kind Regards,
>
> Thiemo van Engelen
>


-- 
Luiz Augusto von Dentz
