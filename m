Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A6BC05027
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Feb 2023 23:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBHXn7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Feb 2023 18:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjBHXny (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Feb 2023 18:43:54 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD4C1CF44
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Feb 2023 15:43:36 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id b13so207454ljf.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Feb 2023 15:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q8/oYAtjPyZPb8EmkQT3hcEtcqwqMnXaRjCgh07d5xc=;
        b=dLM0MVZaIstWdVCkVYOlRR9i/rzgvkqJI2ylbA2TCYz7nvHHHOvPmnc8r6bdzp3cmU
         i+hQa1A9qw3E7YLwEX2yibmPgujkJvDLygkkbnRgmzwDHa5GfVrcDZRriEeorbSJ964g
         Ou4a4jeTU7WPmskulAJDHH2pUbs2Jlr+y3+RAicxZ0dOGgbCvvgjTq6JpBBd9VtQeAz/
         Z4sZzoV+Yc2ukhqUuGNVvWenH8/EvFJlm3I9okjN3OszkgHkMhU7mrqH2N7HMxkZTvVG
         x4ArAa59Xs6ramlAVkALIY/4tZA/BfEk6AdtU90HbOFidZv1ComMDH7Yhdj+4o6VtfS7
         8zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8/oYAtjPyZPb8EmkQT3hcEtcqwqMnXaRjCgh07d5xc=;
        b=7MTTwFkduTlLZK8en+rq1ZbTegJCfP5/vz2GhBEnkt8tDyzD47fjZKMTGfNweqarFR
         xjNs7Co4g+VImqHDZGEfHA5kpNpWXL8jw8yaNwp0kXoEf+oGundQRrq5dof4kF67CQCI
         9xOS59Hxx4fAr3NT86PJYuCMRISTYajTCjc0ocBBCSyaCmERMk/C54L+775fgcM9Fu6i
         +m5TPOUvV1G+j899e9zqYVlN9sQTD8rBLUTRdROjNhSGmk+lppzAbQHUBZROzciquwm5
         Qu50uDMfIyFG46wpiKLR0+Q8i1IpAWTr04ZAbZTzQec9qfAeXSk4le6Eh7xGaxF8WAYb
         1Axg==
X-Gm-Message-State: AO0yUKXEwtWAZh2Cu/0bVZxvJuqjuRBY20SmlgtPKLSke7/NLL0qg2bS
        SCbabpWQhGqqXmeTiq4eyahVxFKU3lOfYf8/DvU=
X-Google-Smtp-Source: AK7set8K3c00U//kbjJE44qc1S8meI7YwlTdIqYR/Qhwx3KL2Az0vkfEWSmxc/sRh1kExpTaRHHr1Meug8MqKhLNcxQ=
X-Received: by 2002:a2e:8410:0:b0:290:5166:7c37 with SMTP id
 z16-20020a2e8410000000b0029051667c37mr1821004ljg.191.1675899804817; Wed, 08
 Feb 2023 15:43:24 -0800 (PST)
MIME-Version: 1.0
References: <CALDHRCt5KUezfEZCOWK+zYPM1hP32qwZqcoKw09ZjNw=oQoWKg@mail.gmail.com>
 <ecc41929af982862720209eacfa935178a8e0a1b.camel@sipsolutions.net> <CALDHRCuuZdqVorNzF+DFU8kAUU4eiuCHJgtV3Gtbvwr9mVow9Q@mail.gmail.com>
In-Reply-To: <CALDHRCuuZdqVorNzF+DFU8kAUU4eiuCHJgtV3Gtbvwr9mVow9Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Feb 2023 15:43:13 -0800
Message-ID: <CABBYNZ+iz-NihAPaDCSW2TLodoH3ThDWhZdTPvQtbyx_jnMyhg@mail.gmail.com>
Subject: Re: hci0: Malformed MSFT vendor event: 0x02
To:     Arda Demir <ddmirarda@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Arda,

On Wed, Feb 8, 2023 at 2:00 AM Arda Demir <ddmirarda@gmail.com> wrote:
>
> I don't think the device is broken since bluetooth + wi-fi is fully
> functional and i also read on arch linux forum people get the same
> message on tty with the same hardware. (AX200)
>
> https://bbs.archlinux.org/viewtopic.php?id=276815

I suspect it is some vendor event other than MSFT that we are trying
to parse as MSFT, this normally can be ignored silently when not
understood, but I will check internally what we can do about it.

> On Wed, Feb 8, 2023 at 12:29 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> >
> > On Wed, 2023-02-08 at 12:21 +0300, Arda Demir wrote:
> > > Hello,
> > >
> > > First of all, my bluetooth adapter is;
> > > 04:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
> >
> > You've reached the Wi-Fi team here though - adding the BT list.
> >
> > > I see the following message everytime when i boot the pc on tty.
> > >
> > > "Bluetooth: hci0: Malformed MSFT vendor event: 0x02"
> > >
> > > But bluetooth works well. If it is not critical it shouldn't print on
> > > tty, right?
> >
> > That's generic from net/bluetooth/hci_event.c, not related to the device
> > (apart from the fact that the device might be broken if it's sending
> > this?)
> >
> > johannes
> >



-- 
Luiz Augusto von Dentz
