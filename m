Return-Path: <SRS0=3ySR=RW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5647FC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 20:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E141213F2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 20:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INapnYe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCSUT2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:19:28 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:42632 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfCSUT2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Mar 2019 16:19:28 -0400
Received: by mail-oi1-f177.google.com with SMTP id w139so8307295oie.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2019 13:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8VMVfVEz9TNJJhIwxWMwwy8lPWJzSaekf9Rqfd38HvI=;
        b=INapnYe8b7dV7WsO0e7jx0AiruqcLAeCftVK004OxaI84sycacNbEl+LA1xj+oz2Iz
         P2MjQ4hQNZdwham+2IGA3q1iza4RfnzkCEt25yiD0G5J20iQk+0zUO2X/InTD7Rnp+EX
         t64ibP98DBO7NIzJux1eIWGjaP/mNpn4CeqTOBk+qzUXhugUENlGY33J8v1ioy2rdofO
         5LjqTLSC6YkRREOuqZrc7QQbMvXTwH4ygdUhBzHQPJMFoiPcUqnV6NV3WGTdW5/I86W9
         AfP4UwNLJS/9kbZMmSIagQS4/OcGn9T72HaiMeiEOdZyBTIiC0oDo9tAyL8PYXmPEwmF
         +xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VMVfVEz9TNJJhIwxWMwwy8lPWJzSaekf9Rqfd38HvI=;
        b=dCSaqBJwoR8PHYd7ZI61xRh3P0sjFWUTD3NBq5+06AzvCKjMKS9OWllynrDRN0TGy8
         Oz1Izs/Wew0JBr/+seAh1qpkhYgBSnqEWVComxA9uxdtaHGFvwqBB/RTdQmDAec2hQK6
         mfO2JhKJBKinN7eucqW8r0mbWSrhHNwITd1rHT77vTz4UQo77UHUQpT3cl+4W6wgtDB4
         teR/2LrPbmSUxxuvBURE+MXYKqaUvPzHmdZcBZtzvPqABNAr6rQV67sP8odIsC88QYjk
         gBZ1NcJXL6vmq6EBzmQeT1qCDDiqxKywDXEklmp9CejJS0yFycCm+PvG+xVKTGX9G/50
         4a6w==
X-Gm-Message-State: APjAAAWls0sXPKwztDUl6b6OCwt+2LvKmUUUWwVFEA2l7riSafeozEfh
        AUwKLK5hurxT0P7w50xkxJyfpVRYVdQU1bwwN2U=
X-Google-Smtp-Source: APXvYqzwq2DkH64dh/LKYPvC+4ZLjCpXOQZzsI+8dGj3A+oS8+7s4GtdJ80WwiA5RrAWOX/kNn4X+w3Z82h0jvZEpmk=
X-Received: by 2002:aca:4a0a:: with SMTP id x10mr2694712oia.82.1553026767260;
 Tue, 19 Mar 2019 13:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAGuyqoGXTArrUiWKkX9AGkUAa0qAhXGn2b5sgPiaDM968MmzQw@mail.gmail.com>
In-Reply-To: <CAGuyqoGXTArrUiWKkX9AGkUAa0qAhXGn2b5sgPiaDM968MmzQw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 19 Mar 2019 22:19:16 +0200
Message-ID: <CABBYNZKOisJtGZV6fq7h58yhHvw=B_9BqiNLnwgMAP8rdM2jQA@mail.gmail.com>
Subject: Re: BlueZ 5.50: Avoid service discovery in every connection
To:     Miguel Sancho <miguel.a.sancho@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miguel,

On Tue, Mar 19, 2019 at 3:25 PM Miguel Sancho <miguel.a.sancho@gmail.com> wrote:
>
> Hi,
> using Bluez 5.50 to pair do a BLE device, I am seeing that there is
> Service Discovery every time the peripheral is connected:
> ReadRequest
> ReadRequest
> ....
> Read By Group Type Request
> Read By Group Type Request
> Read By Group Type Request
> ...
> This behavior continues even if the remote device is marked as trusted.
> how can this be avoided?

That shouldn't happen, do you have the bluetoothd logs of that? Also
make sure you don't have Cache=off:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n83

By default bluetoothd should always cache attributes, but there
perhaps you either disable it or the device is sending service changed
which invalidates the cache, though we don't actually discard the
cache but attempt to check if the services have really changed.

> Thanks in advance
> Miguel



-- 
Luiz Augusto von Dentz
