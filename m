Return-Path: <SRS0=aznX=T7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14254C04AB6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 May 2019 14:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC80126AA1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 May 2019 14:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu9ooz2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfEaOas (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 May 2019 10:30:48 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:46284 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfEaOas (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 May 2019 10:30:48 -0400
Received: by mail-pg1-f175.google.com with SMTP id v9so4135258pgr.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2019 07:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=haEx6zSIRMkTpzylOYcRsF9YOqvbgQyv21uXJLPRjvo=;
        b=Mu9ooz2ER/MOKrBJNNxFIuqBxZe4IS3ZDDJPtOa2VPJ92MD2Nf8ldUs6I3M+GR+ML8
         NftC0ZtYvCcUXcPBTIUDMooVG+za+5F8yWlV2R/N1Qm886zXAQexhipTmBinWNGxqf3t
         AJyXygjlhKI9+7qIhDS2lbugZ4iiXZfIdJInBiXSHdLSHTyZoNoQ6MaVuUEW9IiTvaPQ
         Sf1u5RniCJmZgi6fV8oGhBoSWTxq8+FLqBTH/am6LiDlP03LmzJS2WNgvt3g8P56J3ew
         CzQ3DBFQ1yj6IcxKmjMrqj+vY7Zs4TEeUWJbWg0dygUVhdjKloki7YwxzgoDxuHf310S
         0cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=haEx6zSIRMkTpzylOYcRsF9YOqvbgQyv21uXJLPRjvo=;
        b=Eahi4ZBwsZvZFnhv/ASLPG3MGAEWXUmmORekd6PDpckqC9tlA6Mhbc/Z+qdhcaScmc
         HL5BC0eeVsRQ++tDOFX/qip7y8zuSfhiV4EqCKGwGCbzkl3R1sLJg7mZAelWiropjMsY
         rCvhCpSl1bS1qxTDLBLj/QoR5NnvlwfzCYkBGoguamBpjzHAa7fdivex7ayfGZBIs6vs
         YWUi/S+cwxbt2OR+A7BKZEkmC2yLyRCinn7fUAjRKgOETJQc/uNLMhZWlHeD09LRIMyK
         Dm26i4x8JSyNt6dxbCXp/H/1jd5R7pgPRRm8/YKO9Ks4B32dxjQe+oXVGnd1ul5uJZqV
         pjLw==
X-Gm-Message-State: APjAAAVJAcmEsJii2ouzhT1bXYgCevkOUWoAXCOZjEZhdHewg/KUWSrH
        FRI/HBlMjZFRJXJcvEDxB7dYj0IPggt0CYfN8LI=
X-Google-Smtp-Source: APXvYqx1VYg80VMZ81fCu9BRbcw5j4NxQ9wrB0jCiu/F4Jkz72N6AIZKg0lIdXkQb8DHbS7M1VUQNjKZne0bpvf7XY8=
X-Received: by 2002:a63:4d5d:: with SMTP id n29mr9862932pgl.235.1559313047206;
 Fri, 31 May 2019 07:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190531122557.GA3176@griso>
In-Reply-To: <20190531122557.GA3176@griso>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Fri, 31 May 2019 16:30:38 +0200
Message-ID: <CAO1O6sdSBPXR-h1sfzCF6zsAv-a5Bexd2s8X7wDQwrghrvuCEA@mail.gmail.com>
Subject: Re: Different respones to BLE scan from a Peripheral device?
To:     John Whitmore <arigead@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John,

Den fre 31 maj 2019 kl 14:27 skrev John Whitmore <arigead@gmail.com>:
>
> Hello all,
>
> I'm running on two identical embedded Linux Gateway devices, both on
> Ubuntu 16.04 and Bluez 5.37. That's certainly an older version, but
> it's part and parcel of that version of Ubuntu. I'm having an issue
> where the two identical gateway devices are getting different
> responses from a BLE scan, and can't figure out what would be the
> cause. In both cases it's the same peripheral device, a TI CC2650
> device. On one gateway I get a truncated response with just the MAC
> address and in the other I get the MAC address plus the description
> string "CC2650.."
>
> [bluepy.btle:37] Got: 'rsp=$scan\x1eaddr=b546C0E530068\x1etype=h1\x1erssi=h43\x1eflag=h0\x1ed=b020105030280AA06FF0D0003000011094343323635302053656E736F72546167051208002003020A00\n'
>
> [bluepy.btle:37] Got: 'rsp=$scan\x1eaddr=b546C0E530068\x1etype=h1\x1erssi=h28\x1eflag=h0\x1ed=b020105030280AA06FF0D00030000\n'
>
> I'm probably going to have to get a Bluetooth sniffer device to trace
> this issue, but if anybody had any idea what this would be the case,
> I'd love to hear.
>
> Perhaps even though the Gateways are running the same Hardware and
> Software there might be a Hardware difference in the chipset used or
> something. It's all I can think of. Hopefully get something to help
> diagnose this issue.
>
> In those two messages there is a difference in RSS, is that signal
> strength and could that be the issue? Have to open things up.
>
> Thanks in advance for any help, and apologies I'm at the wrong end of
> a learning curve.
>
> John

You could try running btmon in a terminal to show the HCI traffic.
There you should see the raw advertising packets in form of LE
Advertising Report packets. You should see both ADV_IND packets as
well as SCAN_RSP packets. Maybe the software doesn't always combine
them and that's why you get different results. And yes RSSI is signal
strength.

/Emi
