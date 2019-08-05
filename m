Return-Path: <SRS0=EM7j=WB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFFEC0650F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Aug 2019 14:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B45B206C1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Aug 2019 14:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9PKhvn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfHEO5G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:57:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41491 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfHEO5G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Aug 2019 10:57:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so2285253qtj.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Aug 2019 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=D3PKpDY0peenCvLWy3GZ+KYFXFN9jPcrqA1Cgd6rbb4=;
        b=n9PKhvn5N7G4MbE/rwEeXNGYRhKNjS7L5LoLjBZZuV8I3yDvVF+2ZlyBg2LnXOD5wL
         rx+6fc+n7cUT/1kXJ+YkHG+oHnsZPMUgz+w6fFavsisntsqKMG5Wm9U1VLcqih28BJBD
         lKQPyUfQQAFwhlgaG19tAKx7g7Asr8JE5mxY6ni8sf3imCGcCeR+fZYOSS7qzkUMpICN
         48wdXQrpW3ULW5iY+hODNzRF1vi/57t9W234PudqwtqVf62JRND24RNMGFnqBgPe/7EY
         eTofuBFBeaAJH/V2XIdqA5hhYwTqtWOjVsatIGRnoGbFobofdG5xYsujF+2c3/TjmstG
         gSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=D3PKpDY0peenCvLWy3GZ+KYFXFN9jPcrqA1Cgd6rbb4=;
        b=hqCvK5rSdqT/3g8if6PIstGmXLfupPBN147TTt6IjBfa47ej0f+LGptLAue53an5pe
         bFl4C58CQYGs4Lf/+I+DtnZPT6m/V9/jCRcujldbGfRsR28cAIdUBLcxqRTv3fNtx2Et
         gurfWEoMpTr2rSr6gziq1Q1EzUKtzgUL9BNmp31h/WTbDDbHoDgGJB+EVQTVSPwYTa6p
         8SmwnQuOe+KOggLY4/UCHIJwUyqAYaTHB20nbfCUNAPWevqL+GQVhCotrSYwPc1FFTJB
         hCGV3L1106vjf+eDirwBG5hmJgWUSxBpbPKSUTU+qV45ewjtZKy9w2fAsCe2wvZo5sft
         nfmw==
X-Gm-Message-State: APjAAAU/H4ktmp0FVwKw3G8y1fu5iQcm3L7Y1mw5yn1qKSWduTYnKQ4v
        1W/yD1lchYDnXJXDSLjbnT8bPldZjzADyLNvRMfBbyqvPGY=
X-Google-Smtp-Source: APXvYqwnLn65hAXVmV+GS0/zH7b/YHVLY1YivqsN4qzjZIXePjy0neeijQIy88g0ygadQjbCYiyEj6mMLgxTBlslxWo=
X-Received: by 2002:a0c:f5cc:: with SMTP id q12mr58165755qvm.79.1565017025412;
 Mon, 05 Aug 2019 07:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <CANKzOHAsWzZR3aXWnh9-bYJoO=d124KD+C5gPmot5fMfEH_G9Q@mail.gmail.com>
In-Reply-To: <CANKzOHAsWzZR3aXWnh9-bYJoO=d124KD+C5gPmot5fMfEH_G9Q@mail.gmail.com>
From:   Axelle <aafortinet@gmail.com>
Date:   Mon, 5 Aug 2019 16:56:54 +0200
Message-ID: <CANKzOHCJKAnrCBV8Pmbm1XiOSZ-+U8o=ps247FUHHwS7=oL=UQ@mail.gmail.com>
Subject: Re: Pairing request ends in timeout
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I managed to pair, by a mix of factory reset + ensuring that other
devices previously paired were unpaired.

Now, I can pair. However I continue to experience disconnections. Typically,

- I connect, I pair
- I send a Write Request
- I receive a Write Response which looks
- Immediately after I also receive a Disconnect Complete with reason
"Remote User Terminated Connection". This is not meant to happen.

Can I do something about this?

This behaviour is exactly the same on two different hosts: Linux Mint,
and a Rpi 3. Using Bluez 5.50.

< ACL Data TX: Hand.. flags 0x00 dlen 15  #47 [hci0] 2019-08-05 16:37:27.290456
      ATT: Write Request (0x12) len 10
        Handle: 0x0014
          Data: xxxxxxxxxxxxxxxx
> HCI Event: Number of C.. (0x13) plen 5  #48 [hci0] 2019-08-05 16:37:27.295258
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handl.. flags 0x02 dlen 5  #49 [hci0] 2019-08-05 16:37:27.324637
      ATT: Write Response (0x13) len 0
> HCI Event: Disconnect... (0x05) plen 4  #50 [hci0] 2019-08-05 16:37:27.341258
        Status: Success (0x00)
        Handle: 70

        Reason: Remote User Terminated Connection (0x13)

Thanks

-- Axelle

On Thu, Aug 1, 2019 at 4:10 PM Axelle <aafortinet@gmail.com> wrote:
>
> Hello list,
>
> I (again) face problems pairing with a BLE device.
>
> Using bluetoothctl (v5.50), I connected to the device (connect).  Then
> I try to pair but it fails (org.bluez.Error.AuthenticationCanceled).
> The hcidump show a connection timeout.
>
> NB:
> - I have a registered agent (although I do not think it is useful in my case)
> - I am using Linux Mint 19.1. The same error occurs on a Raspberry Pi
> 3 with Raspbian.
> - I have some bluez distrib packages v5.48 installed. Can this be an issue?
> - I got this to work a while ago with the help of someone of bluez on
> IRC, doing power off/power on, but this is not working this time...
>
> Thanks
>
> -- Axelle
>
> What bluetoothctl says:
>
> [D2A74C76F3E0]# pair D2:A7:4C:76:F3:E0
> Attempting to pair with D2:A7:4C:76:F3:E0
> [CHG] Device D2:A7:4C:76:F3:E0 ServicesResolved: no
> [CHG] Device D2:A7:4C:76:F3:E0 Connected: no
> Failed to pair: org.bluez.Error.AuthenticationCanceled
>
> The corresponding hcidump shows that the connection times out:
>
> < ACL data: handle 71 flags 0x00 dlen 11
>     SMP: Pairing Request (0x01)
>       capability 0x04 oob 0x00 auth req 0x2d
>       max key size 0x10 init key dist 0x0d resp key dist 0x0f
>       Capability: KeyboardDisplay (OOB data not present)
>       Authentication: Bonding (MITM Protection)
>       Initiator Key Distribution:  LTK  CSRK
>       Responder Key Distribution:  LTK IRK CSRK
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 71 packets 1
> > HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 71 reason 0x08
>     Reason: Connection Timeout
