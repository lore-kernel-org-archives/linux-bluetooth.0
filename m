Return-Path: <SRS0=4ALD=QH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC9CC282D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 16:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370E02085B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 16:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo6F0C/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388143AbfAaQQQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:16:16 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:40846 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388068AbfAaQPq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Jan 2019 11:15:46 -0500
Received: by mail-pf1-f179.google.com with SMTP id i12so1680823pfo.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jan 2019 08:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6klv9rnAEB4lKEa2q4Av0OE1ba6cIYEobffYZYhzmZs=;
        b=Bo6F0C/4q7ZwRM10J7KWxmqAXixpp99NA7BxiGtSA/4u0bbX577L+8937cVavNOG+Y
         0Alyl1q8iqE/sfCmzpvfzylLQA/CnV/E4la5skTcjHvdypUnIxPSUTvL+1kjkmCW4WWd
         ZT8cdWIUYd94E4+JgXNAKZrtUDqXL6Kgew2H/OAcy7J1D2/mtdT/FzcbzilRTGbmtvQg
         9EddE9tkQ7Rnm+JajfnUd66VH5xWPohyULJ2INhEFL5a+4g40lW8ysiUWOfMakyKxakk
         zbBakeE5oegQr2/c8r+bEE55KfgVs6yrpieA1+nw2e61pa6/xAaqVFkZMK+QCcGQKJOG
         TRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6klv9rnAEB4lKEa2q4Av0OE1ba6cIYEobffYZYhzmZs=;
        b=jETs/t2cao6l7NnHIYRVhWX+Yf4QApIH/mi7OaHkGW/HCuNGd815t5TDqyzXxYPHG8
         VS3Ym5QBcHjBJY9t/B1dVxLuH62UCjIT97iYwhqFjYLcP5n8wg+xKq/TbCa9k1a1Fi+r
         hbAzPiPGp7nZ/hwO4FlI7FqZBEFPZw0ffYsMWpa0gWk/ubDNfTIPn89IiiM6CqcO/gES
         dczbs3rH0jiT1/I3zjFYFd3XAcwkABtTAU+ywvtyHlpimaMXXFruweneKw57tJtXrJ2F
         EYrulHlsaR6x8Uh0Dds5aroByADoPNl77m7jcIrAwMEce3HyCyJBHPzVJ1j00yJ5X9Nh
         DTfg==
X-Gm-Message-State: AJcUuke3y0aC59qkyFnHIun/BGZ9dSrlo7MhCvO86Gj0/0WWv20zMDi6
        KzXDUXW+ZzNclx1o9V2eikmVCgJKQuKmaEhq0L2cGWhZ
X-Google-Smtp-Source: ALg8bN5WkXZ7ZfM63CQwAzLcGNIPhAsXCybuR4EuyMWX/t7Z/JTVylGBHz2WrctJRks9R7myhBwA3XzdyUk/l+WFN8w=
X-Received: by 2002:a63:ac1a:: with SMTP id v26mr32504437pge.293.1548951345147;
 Thu, 31 Jan 2019 08:15:45 -0800 (PST)
MIME-Version: 1.0
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Thu, 31 Jan 2019 17:15:35 +0100
Message-ID: <CAO1O6scUuK1K+zLjyQA12HtY9nNdR=Q8MeuruC2GKvaJPH0knA@mail.gmail.com>
Subject: Flag for specifying write type to WriteValue in gatt-api.
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I was looking through the quite lengthy discussion at
https://github.com/WebBluetoothCG/web-bluetooth/issues/238 on the
issue that in Web-Bluetooth, only a single "write value" API is
available, causing Web-Bluetooth to decide on its own if Write With
Response or Write Without Response should be used, in case both are
supported by the characteristic.

But in the Bluetooth spec about Write Without Response:

"This sub-procedure is used to write a Characteristic Value to a
server when the client knows the Characteristic Value Handle and the
client does not need an acknowledgement that the write was
successfully performed."

Basically, it says it's up to the client/application to decide if an
acknowledgement is needed or not, and hence it's the app that should
decide if Write With or Without Response should be used. The "client"
can't mean a bluetooth stack here since it can of course not know if
an acknowledgement is needed or not.

I noticed that according to gatt-api.txt, BlueZ has the same
limitation in the WriteValue method, in that the stack chooses the
write type "arbitrarily" if both write types are supported (or really
the Write With Response is chosen, which might cause unwanted
latency). Therefore I suggest that an option should be added to the
WriteValue method, for example "write-without-response" (bool) to
force Write Without Response.

Note how iOS has a write type parameter to the write method, and
Android has a write type property you set before you execute the
write.

I see that it might be possible to achieve the same result with
AcquireWrite -> write to socket -> release but that wouldn't be a good
solution for bluetooth stacks built on top of BlueZ that would like to
differentiate between the two write types (such as Web-Bluetooth)
since AcquireWrite can fail, for example if two apps write the value
at the same time (I guess the lock is exclusive?). It also seems like
unnecessary overhead to open and close sockets.

/Emil
