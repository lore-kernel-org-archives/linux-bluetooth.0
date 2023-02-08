Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C22C636CC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Feb 2023 09:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBHJzP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Feb 2023 04:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjBHJyv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Feb 2023 04:54:51 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2A36A7D
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Feb 2023 01:54:50 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k13so18712232plg.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Feb 2023 01:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v6/gY8+V9qh0+Y3B+Oqh5+5unnalDe6MKNr/oC5tHdU=;
        b=OtC1R3x0njzUAJnN3MDfBzxjH1tC0vbxU342TDPg5gfLUzH/thKaQUzwZDczs7ehJM
         x36uSgbL0wp+FiJzNzQQSgqQygL4+tdQi8V+QQQu2dsLDbkuC4AlOSdUgY4zdu5m9OvU
         5oNuUXUFNjbxb+TF8ydWZ76bJ5AsVE6bzL6DeDO8bN42cn1ASyqWl1DZcoEk0D1Vi1gm
         8ObAg0F+CHhTxd9+hNoNcghOyFauH4edxfE4v/qjFDTyIbtcb0dWEeYLa+5kTDVhX6aT
         UO6ruWsr6g8oKeLDn9dZLR+Lb05rg/yZpttQweO2wdJpqk8+f/ydNHvgNXDst5RBkk0I
         OeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6/gY8+V9qh0+Y3B+Oqh5+5unnalDe6MKNr/oC5tHdU=;
        b=XzFM7irV+wOZ7xHPHD1mdGIZYLIR1cdcYpnCdZOeWdHtlc5amE1G2v07Y+/LI2trfB
         cHRchOcaL9SWliCzkhshAIUJzINWm0NN1daFJ1pfq8d1DtAiTCUa1olSMKCZ1bCw0EmS
         YKWcudZqdTystJl9+HVpnpA402Usxnnj5IoQPHHgg8bMn/lBII8NFCWIYBPQUgcMURzH
         I0pIQ/Tl7qsEBLt0RXcvhde2UiIZIz3YF/I1AK7HGH4XXLBqAbJJXaugGBAkrrHY0z05
         id+e1sxHtM2L8B4LUbL6CHf6oH8qTSP/a4n1tymxo+UviG+Thn5nRakBBCVY3PLOGgdu
         w/8w==
X-Gm-Message-State: AO0yUKUA1SwycQvKwGw7IXu1j/KqYHMpq5fD+25mQairpiidMWsDAhse
        L6tlkpiGTrZVLo1U6vbKMeiQuiA5hZtfPlQJyCbbW7ETOekf
X-Google-Smtp-Source: AK7set+DQhsgXTrlkfv0v2Tmm92dxdkXhzZL1YtDiYhQcdMyzV1gz5BTsntM4PSq2Udy68dkfGHGEu3cOm8TBw8G6pc=
X-Received: by 2002:a17:90a:890a:b0:230:c56e:17bc with SMTP id
 u10-20020a17090a890a00b00230c56e17bcmr653167pjn.75.1675850090359; Wed, 08 Feb
 2023 01:54:50 -0800 (PST)
MIME-Version: 1.0
References: <CALDHRCt5KUezfEZCOWK+zYPM1hP32qwZqcoKw09ZjNw=oQoWKg@mail.gmail.com>
 <ecc41929af982862720209eacfa935178a8e0a1b.camel@sipsolutions.net>
In-Reply-To: <ecc41929af982862720209eacfa935178a8e0a1b.camel@sipsolutions.net>
From:   Arda Demir <ddmirarda@gmail.com>
Date:   Wed, 8 Feb 2023 12:54:30 +0300
Message-ID: <CALDHRCuuZdqVorNzF+DFU8kAUU4eiuCHJgtV3Gtbvwr9mVow9Q@mail.gmail.com>
Subject: Re: hci0: Malformed MSFT vendor event: 0x02
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I don't think the device is broken since bluetooth + wi-fi is fully
functional and i also read on arch linux forum people get the same
message on tty with the same hardware. (AX200)

https://bbs.archlinux.org/viewtopic.php?id=276815

On Wed, Feb 8, 2023 at 12:29 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2023-02-08 at 12:21 +0300, Arda Demir wrote:
> > Hello,
> >
> > First of all, my bluetooth adapter is;
> > 04:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
>
> You've reached the Wi-Fi team here though - adding the BT list.
>
> > I see the following message everytime when i boot the pc on tty.
> >
> > "Bluetooth: hci0: Malformed MSFT vendor event: 0x02"
> >
> > But bluetooth works well. If it is not critical it shouldn't print on
> > tty, right?
>
> That's generic from net/bluetooth/hci_event.c, not related to the device
> (apart from the fact that the device might be broken if it's sending
> this?)
>
> johannes
>
