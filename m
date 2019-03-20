Return-Path: <SRS0=+K9s=RX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE1C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Mar 2019 15:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73EE2183E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Mar 2019 15:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuX8wGkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfCTPxn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:53:43 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:40649 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfCTPxn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Mar 2019 11:53:43 -0400
Received: by mail-oi1-f180.google.com with SMTP id 3so1550584oir.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2019 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5T50tR+U0geo+pYCkqAwDCrIHLpWX0VnoSSC2EfrmLk=;
        b=NuX8wGkEkCryZ1/p2NhETfolMwaVunSfQlxswv3BXZ7AAoSRlR7ez/fvQd4/WsAh6d
         X8raxi1Qb/pHrUhMdxN6WTkJkYbaokXBHsE9laUHAS7j1Ksl+tZgBbDdmgrCYHktw6WX
         dnqCzUMHprgKWC1hvKh8E7ysy+cIu7LD+WYn9HL3fKJTLMPdy/4zvX/NMCTNZGzKADH3
         IYzcEIkKVu/9V/v//ykslPO8B8B7+hIwfS0N585OcsJkZq446rbRjFqUHmREWuOLynsG
         pU0FlJN/TxBevVObJZP47U8J0m0eNO36QzgHoxUTFR4wgoRTrV2t1Gn6angUHvCRvCIr
         vGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=5T50tR+U0geo+pYCkqAwDCrIHLpWX0VnoSSC2EfrmLk=;
        b=IkC3xi+41XpwZsee1ayUkBtjg+ENNZ1bQWAkre7whGxD+f0Nxl6JYbYM2kw2LADhvP
         zjm8nFjBs4REIsdLppHQ+5OG55Jt30e9PQDO1HWwd6U/xaw4//3c90PQSUD6f6bWtVre
         waIkXX/zwUTkYY+3MX9kAnMtZiUPYUSgkL8QDEVi8mdW1lXwRzfUAm75zIbQMQFBahWY
         eUryGYEdFBr0MnNOhJzVZDLE4R8LfPsh0+kkDj8l4k/QoMAeLB/fXcbThrFgVoeU5uOg
         yjfELV8pQIYJ8DgKsmnnr0pBiu0cXfrgVLlsoQa0q0mhKzrtFCjvydMoVTdqyL/P6KQE
         lymA==
X-Gm-Message-State: APjAAAWAnBVXq5FUMcptp9dq8hTHvIoyrEfYFY69DZFDXKPnje1jRa/m
        epLL0Owlv+dnPEBH9Dy9v+PQzLYPTQV1aNA2380=
X-Google-Smtp-Source: APXvYqzaYS2uryBmLe+fX27fkZPlfHPioFLKrlJcRuvRArI+6eBthNk0SXpxa3+Nk6imUhorA1QbmEuQhNEzBRKT7S0=
X-Received: by 2002:aca:edc7:: with SMTP id l190mr5956160oih.92.1553097222506;
 Wed, 20 Mar 2019 08:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAGuyqoGXTArrUiWKkX9AGkUAa0qAhXGn2b5sgPiaDM968MmzQw@mail.gmail.com>
 <CABBYNZKOisJtGZV6fq7h58yhHvw=B_9BqiNLnwgMAP8rdM2jQA@mail.gmail.com>
In-Reply-To: <CABBYNZKOisJtGZV6fq7h58yhHvw=B_9BqiNLnwgMAP8rdM2jQA@mail.gmail.com>
From:   Miguel Sancho <miguel.a.sancho@gmail.com>
Date:   Wed, 20 Mar 2019 16:53:30 +0100
Message-ID: <CAGuyqoFbadJA_2U_s15ZeNUS-Rb12XL76eCmAh=9GFXbdjaZog@mail.gmail.com>
Subject: Re: BlueZ 5.50: Avoid service discovery in every connection
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz, thanks for answering,
I checked:
1) Cache=3Dalways. I do not see differences executing bluetoothd without
main.conf or running it with: bluetoothd -n -d -f main.conf (with
Cache equal to "always")
2) the info/attributes files are being written in the device cache, no
change, just the file dates are refreshed
3) the multiple Read Requests / Read by Group Requests are sent every
time the device connects

Is there another configuration apart from Cache that I can help here?
Thanks
Miguel

El mar., 19 mar. 2019 a las 21:19, Luiz Augusto von Dentz
(<luiz.dentz@gmail.com>) escribi=C3=B3:
>
> Hi Miguel,
>
> On Tue, Mar 19, 2019 at 3:25 PM Miguel Sancho <miguel.a.sancho@gmail.com>=
 wrote:
> >
> > Hi,
> > using Bluez 5.50 to pair do a BLE device, I am seeing that there is
> > Service Discovery every time the peripheral is connected:
> > ReadRequest
> > ReadRequest
> > ....
> > Read By Group Type Request
> > Read By Group Type Request
> > Read By Group Type Request
> > ...
> > This behavior continues even if the remote device is marked as trusted.
> > how can this be avoided?
>
> That shouldn't happen, do you have the bluetoothd logs of that? Also
> make sure you don't have Cache=3Doff:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n83
>
> By default bluetoothd should always cache attributes, but there
> perhaps you either disable it or the device is sending service changed
> which invalidates the cache, though we don't actually discard the
> cache but attempt to check if the services have really changed.
>
> > Thanks in advance
> > Miguel
>
>
>
> --
> Luiz Augusto von Dentz
