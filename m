Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5F7C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 20:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242151AbiCNUK6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 16:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiCNUK5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 16:10:57 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A1913D05
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 13:09:47 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2e5757b57caso22111087b3.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqQiqOZ7RfIulelz5E8LT0ePHyMzupzCrkiHv77NoHo=;
        b=LlOUUxAMsO8Vtg/2IzK3ioAaVvp+k4BfLFsXyxYxclX8xPxXJkyeRwUYA8hztAyH9B
         hrv+l6g3BdJxU5FPjiIkTyUMKQ6VkKKXgOjmIkNyKz5rwXILgr4PaHPYKG7xv4lmwvUn
         iSORa4gHoAcyYGAqMninRiMpTRBvTdXD8gzLrjebyNGdgqyTl3TYo2cLwDtgUuZy5Xth
         UvFzTGbh3hrUtTsbbcW/zby61tbzD5l0iHR1p1dbEJwUgncEU5jr4xa4g7pYQCOo5HOf
         7/MyQ+Ka5t03cFjAA0KHoRv/ol4daeULmDo/A4Sr1l54pN07leyM0YFMyIbvqzvAi+IB
         bFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqQiqOZ7RfIulelz5E8LT0ePHyMzupzCrkiHv77NoHo=;
        b=JmfG338mM0HzN7TdoM5f5YpXem7g0nR19MqU8OQsTFZax/Rpix1P1UyefvPrtdu6Ty
         F5PfG0cGUgFQeOi3eMMqLfKv/7iCsEU5uT1Ob+mnxmd+P3LacLfyPOvu1C1KVzjCzQsn
         u5qUqvLHohZ9X+IYNdGt+l/0UVi16L2bexi4FCMc3XDxf2v53Edl4LiNvwJDwXYYV4JP
         cy8vODuUc6dL143CRaYhTeoPvZ1eIi23s3ztbAO3FrpmmHzksfYkvp+lln2514aAA97o
         GhHwxpGPV9MzffEhZiCq4KwTQMKxbT63xm8Yv1KybRFrQRT1F32S7hN3o10yNZrmlbcC
         JXqw==
X-Gm-Message-State: AOAM530N6uBoBvSmKZoZTgk+bQoDDI2vhch2uKlHbmSGkkK86gUIarJs
        HcC2Y8MMU7YOdhr1OJwgB6No3A+Xk5nzsNsqG/m5ZMvx
X-Google-Smtp-Source: ABdhPJxOeYkRDKhgb4yHNzGewGk6i4uuDCW5C1rKyd0pxQrL3wQIT1wKl2Khhqb6zX9oc08J67NqFhO/c+TFr1XK2ZQ=
X-Received: by 2002:a81:f0c:0:b0:2d6:83ab:7605 with SMTP id
 12-20020a810f0c000000b002d683ab7605mr20598547ywp.150.1647288586417; Mon, 14
 Mar 2022 13:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220125185305.2419774-1-luiz.dentz@gmail.com>
 <20220314135044.2040-1-mike@fireburn.co.uk> <CABBYNZJfVnjuo9JPtapiHrfoXUoDYRQ0eMmh3n6-hx--jb=hSQ@mail.gmail.com>
 <CAHbf0-GUYcuj_rFdXAZ-VS-gY_mmbx2-05UdQ3W1VRxbFDkgwQ@mail.gmail.com>
In-Reply-To: <CAHbf0-GUYcuj_rFdXAZ-VS-gY_mmbx2-05UdQ3W1VRxbFDkgwQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Mar 2022 13:09:35 -0700
Message-ID: <CABBYNZKAFgQJWyPuNiQ0+ejwKPgQ02CCTS9QEkVzdmJNt2Wesw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Fix HCI_EV_VENDOR max_len
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Mar 14, 2022 at 11:31 AM Mike Lothian <mike@fireburn.co.uk> wrote:
>
> On Mon, 14 Mar 2022 at 17:30, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> >
> > We fixed this a while back:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/net/bluetooth/hci_event.c?id=314d8cd2787418c5ac6b02035c344644f47b292b
> >
> > --
> > Luiz Augusto von Dentz
>
> Yes, and it looks like that commit is queued for kernel 5.18. I was
> hoping you could get it added into 5.17 where I'm seeing spurious
> messages during boot, before it's released
>

Can we perhaps merge it to bluetooth.git so we send a pr to be included in 5.17?


-- 
Luiz Augusto von Dentz
