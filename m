Return-Path: <SRS0=DUSx=ST=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775FDC282DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Apr 2019 18:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4210A20663
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Apr 2019 18:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxnMSiw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbfDQSwX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:52:23 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:36962 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfDQSwX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Apr 2019 14:52:23 -0400
Received: by mail-pg1-f169.google.com with SMTP id e6so12418977pgc.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2019 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxYsYXozaJ4ud8f2A7S4XO7GpeX0MbslYzMkCJgNp+U=;
        b=qxnMSiw7M4dsxTPg+j8QK0DnA72j//umn9wPSCgoMuKxBeSZQiWpJaOY6e9TpX6ktI
         cE7UcKAKTUoiz04eFeV48N2MY7RF6pYeekeJksv9HuT6Esr1RyqJChsLT9zAAn13OBxS
         VHmSSaSQjLxZXlv6r+ZqDtg9OmWlS24Ivb634Y5zcJrd6+D+t0PGvKl5MGlqyCNNEgXF
         ouuFxynaHe9++Yx5DErWt0jLsvQpwrWDw2Dv5lGye4iWf1vmW/xPfCA6kLecRwMW5M5h
         WKAiu56lKH4AkFqGTedGyFkWE0ifttldFpguvzoInxtizgUNtB8kr/9ednOewC2TGAIo
         zW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxYsYXozaJ4ud8f2A7S4XO7GpeX0MbslYzMkCJgNp+U=;
        b=oZcgU2IgwiMtamSxV/0K3nzzaBpD2yPpIHkBXUy7qFt8H84f9rxbzHRrOBzOB3LMpe
         7Np7leyi80iIL5O2aV/ONN+e+V/y/kGbgGFGfUQ+BWGzT5BdMJsEDZGA30IHKhdut+YV
         ORwiWnFHKss/GxWYjinUhE2y88zluDRvqokhYs7ezOpbGiGvPmPSF5gBs0Nj4uYUjs9J
         y3K43ey9pTZhZr4Zd+sjIL8Tr/0+biUkHccOsB25wNYFbrYxOhgvJOq9treEnoClQ5a7
         vuS7/QW7TYxHX1ABPmZUP4i6q01+HqzWbo+sO/J5oOqydqex29Hj3NtAlE6vH7ngdcoH
         +1aQ==
X-Gm-Message-State: APjAAAWvLbHp4E4cD0TNlljq9ENCdK6T0u+lZK2pL+fmq6KGHYD1vMd6
        lFOVu19czKB/MNauHtGFwjY2rzTYHSAFFEof7SU=
X-Google-Smtp-Source: APXvYqyqtGwgb1ZJYyWdO7YldEQCABBBentSZ4SCNx6EeeDHghlpdH3VaeSelvSkn0p81B5uaT8BRvShMJTUdUnKaks=
X-Received: by 2002:a65:5342:: with SMTP id w2mr62292576pgr.220.1555527142668;
 Wed, 17 Apr 2019 11:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <87ee5fc2175747e1a7cf5b50bad819d4@ausx13mpc124.AMER.DELL.COM>
 <CAO1O6seYhTMHrgCQ+9gPCo_UOtXfhh9mRCVoUosP_Eq0FXD=sw@mail.gmail.com>
 <bcaa44382c80428ba59b743678be0b18@ausx13mpc120.AMER.DELL.COM>
 <CAO1O6sebmS8P0EVVL=U+eFFq+u0NdtbHUP0dO1D+LPa4vXOWqg@mail.gmail.com> <f3d5e376e4364350b06b665d4351fac9@ausx13mpc120.AMER.DELL.COM>
In-Reply-To: <f3d5e376e4364350b06b665d4351fac9@ausx13mpc120.AMER.DELL.COM>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Wed, 17 Apr 2019 20:52:12 +0200
Message-ID: <CAO1O6sc4UD2QVaTt9sbO6e7GzdnqN++SzwhphX5CUX0CeHZGKQ@mail.gmail.com>
Subject: Re: Pairing failure with BLE 4.0
To:     YouRen.Chen@dellteam.com,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc:     Jared.Dominguez@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Den ons 17 apr. 2019 kl 20:46 skrev <YouRen.Chen@dellteam.com>:
> > Could you try remove these two lines at
> > https://github.com/torvalds/linux/blob/v5.0/net/bluetooth/smp.c#L693
> > to see if it works (also make sure by looking at the log later that those bits
> > were not set in the Key Distribution field)?:
> > local_dist |= SMP_DIST_LINK_KEY;
> > remote_dist |= SMP_DIST_LINK_KEY;
> >
> > We have seen the exact same problem when Android 6 was released.
> > However they have a workaround that they don't set the LinkKey bit if they
> > suspect the device doesn't support it. I think they look at the advertising data
> > which indicates in the flags that it doesn't support BR/EDR. I think BlueZ
> > should do the same to workaround these incompatibility issues.
> >
> > /Emil
>
> Sorry for the late response, the pairing process succeeds when the two
> lines are removed from smp.c. I'm inquiring whether we have a patch
> that already addresses this issue and if not, how it can be implemented.

Good. Tell me if you need help with the patch on the peripheral side.

> Just to make sure I understand this correctly, the PN557W sees the Link
> Bit and returns Invalid Parameters because the bit is nonzero, correct?
> This causes the pairing process to fail. By commenting out those two
> lines, we are telling the master to not set the link bit to 1 before sending
> the parameters?
>
> /Joey

Exactly.

/Emil
