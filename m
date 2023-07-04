Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85243EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jul 2023 04:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjGDEIq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jul 2023 00:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGDEIp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jul 2023 00:08:45 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 21:08:44 PDT
Received: from mx2.ucr.edu (mx2.ucr.edu [138.23.62.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DD1BD
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jul 2023 21:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688443724; x=1719979724;
  h=mime-version:subject:from:in-reply-to:date:cc:
   content-transfer-encoding:message-id:references:to;
  bh=6UVlEepawDuM/VPstT4lRiIdcxjkv6S//tPe9iRIdiM=;
  b=sp/LmvHWo0PTi4zAxif3tNCiApVge9lNvjv085MS3rGNgX2KMb28wcKb
   fgp4r8R/Y1HMpQDUVNCTxgmTEEnQnAR17yYxMqfNgnLgUzjN8L4cR+QGG
   rW1BR1wvx/aMTvBA0vhAdFZAMfV7LwTs9cDM6lcR6FIZkNpqsaMfE9TkG
   iRmXoSAYXRxcwALJNwff5o/zPy/VcsYE7/MUtUd2JjqG30UNYYmRuNHH+
   WQN3OTh13kaVAJKmagdbCWoUQn76U74Dn9h1VuQ6dXby9Kui0sl+PdQVz
   ILZiiGxRLIe0itC2vBZSc3oU7kgHpq3Ewzg+G4fjgPpQIqVa/YO/os/WO
   w==;
Received: from mail-pf1-f198.google.com ([209.85.210.198])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2023 21:07:40 -0700
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-668728bb904so6888645b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jul 2023 21:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688443660; x=1691035660;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYbBPoCQXFspNQ4UhnwzJ1YkFLkhsAyZYQXFXB1aF9s=;
        b=Dn4kbeLJ3vxRZvD2Pq8zvlqa8BwoeZrvFfK3lH2tOp60YiFlw8+BxkdcM1KU/cpoQM
         leFCM6XX0iLMyYEUmBTsD7GqA5TgcrlFAURLgCR7dlAkimlNHjAKxO6SV0OXPoBGXWqu
         AMc8U1VC1csj7uFxUqGr4GrWWmyril7WDmDXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688443660; x=1691035660;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYbBPoCQXFspNQ4UhnwzJ1YkFLkhsAyZYQXFXB1aF9s=;
        b=AJ19V+cYgPx573h6VqIWFFDB/Ba/nmtgTkXz//68J1i9bhwkaUjxJtWmP7Rx5ndcyK
         ydLRd7htPSm/HowL99xTA8LX6LMnMzzn2597djRAQ9UA0361JsC5jLKicgQooSvt3r2I
         02McNGJ1wYtn7ZKcsTJ1KCYA5lerLTW6vaLphJ0Ra8NidhIiuD1hE+dqfUkXRXmnjUpi
         2UH9wJUg9KHwPCfquVq/Sr1HhGxydqfXJx9VOxpBxcwDmbr4oRWvXN8Xkq1TWSeQ4GNT
         5kZt0GNSAr5+jJz510PEvckHPPFFTgYMEBEzqsv4yHDHighparsJvfYRVnhPf/QMPk+j
         2SAw==
X-Gm-Message-State: ABy/qLa7GfEl2eWL8dOE+5SL9GTzfbYrHNDvc9AbiB/u74Gtcl4tZRvM
        zlrmwWAdhgkCKOYu5XIwAgkVQxjtPsg+K477FU71X2b6J/KGCvoULljtPByrSCoJSINF7DpcXpH
        puHGjnUPmWakzPW0x6tB9en5pdWpJGA==
X-Received: by 2002:a05:6a00:15c9:b0:674:8fe0:126f with SMTP id o9-20020a056a0015c900b006748fe0126fmr17355222pfu.27.1688443660220;
        Mon, 03 Jul 2023 21:07:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFu1EI5tuQFJaO3ExIznCFEi5jbLwstf56rh2tmnRfS/qBauGTXaI+xw/iaiHP6ytS9nSbEHw==
X-Received: by 2002:a05:6a00:15c9:b0:674:8fe0:126f with SMTP id o9-20020a056a0015c900b006748fe0126fmr17355207pfu.27.1688443659871;
        Mon, 03 Jul 2023 21:07:39 -0700 (PDT)
Received: from smtpclient.apple ([2601:600:9080:8720:d48c:dec1:96d1:7ea5])
        by smtp.gmail.com with ESMTPSA id x24-20020aa784d8000000b0065438394fa4sm7457264pfn.90.2023.07.03.21.07.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jul 2023 21:07:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: How to reproduce the BUG general protection fault in
 hci_uart_tty_ioctl?
From:   Weiteng Chen <wchen130@ucr.edu>
In-Reply-To: <20230704030131.GY5866@linux-l9pv.suse>
Date:   Mon, 3 Jul 2023 21:07:38 -0700
Cc:     Yu Hao <yhao016@ucr.edu>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <191B9131-6E47-49B6-8089-108E2B12B9DC@ucr.edu>
References: <20230628150140.GU21539@linux-l9pv.suse>
 <CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com>
 <20230704030131.GY5866@linux-l9pv.suse>
To:     joeyli <jlee@suse.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joey,

Sorry for my late response.

=
https://elixir.bootlin.com/linux/v6.3-rc7/source/drivers/bluetooth/hci_ldi=
sc.c#L764

switch (cmd) {
        case HCIUARTSETPROTO:
                if (!test_and_set_bit(HCI_UART_PROTO_SET, &hu->flags)) {
                        printk(=E2=80=9Ctest_and_set_bit=E2=80=A6=E2=80=9D=
) // insert a prink to make the race easy to trigger
                        err =3D hci_uart_set_proto(hu, arg);
                        if (err)
                                clear_bit(HCI_UART_PROTO_SET, =
&hu->flags);
                } else
                        err =3D -EBUSY;
                break;

        case HCIUARTGETPROTO:
                if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
                        err =3D hu->proto->id;  =E2=86=90- null pointer =
deference
                else
                        err =3D -EUNATCH;
                break;

This is a race condition between HCIUARTSETPROTO and HCIUARTGETPROTO. =
HCI_UART_PROTO_SET is set before hu->proto is set and thus it may =
dereference a null pointer.

To easily trigger this bug, I inserted a prink in the source code so =
that the C producer can easily trigger the bug. Please let me know if =
you have any questions.

Best,
Weiteng Chen

> On Jul 3, 2023, at 8:01 PM, joeyli <jlee@suse.com> wrote:
>=20
> Hi,
>=20
> On Wed, Jun 28, 2023 at 06:57:47PM -0700, Yu Hao wrote:
>> Hi Weiteng,
>>=20
>> Could you give more info about the bug, e.g., kernel configuration,
>> qemu arguments.
>>=20
>=20
> Base on kernel code, looks that the HCIUARTSETPROTO and =
HCIUARTGETPROTO
> blocks in hci_uart_tty_ioctl() should use hci_uart->proto_lock.=20
>=20
> I have run the C reproducer a couple of days in qemu, but it did not
> reproduce issue until now.
>=20
> Does anyone know how to reproduce this issue easily?
>=20
> Thanks
> Joey Lee
>>=20
>> On Wed, Jun 28, 2023 at 8:02=E2=80=AFAM joeyli <jlee@suse.com> wrote:
>>>=20
>>> Hi Yu Hao,
>>>=20
>>> I am looking at your "BUG: general protection fault in =
hci_uart_tty_ioctl":
>>>=20
>>> =
https://lore.kernel.org/all/CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBPD=
eCO2g@mail.gmail.com/
>>>=20
>>> I am trying the C reproducer in your URL, but it is not success yet:
>>> https://gist.github.com/ZHYfeng/a3e3ff2bdfea5ed5de5475f0b54d55cb
>>>=20
>>> I am using v6.2 mainline kernel to run the C reproducer.
>>>=20
>>> Could you please provide suggestions for how to reproduce this =
issue?
>>> And what is your qemu environment for reproducing issue?
>>>=20
>>> Thanks a lot!
>>> Joey Lee

