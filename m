Return-Path: <SRS0=Qms+=2J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0119C43603
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 04:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C942082E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 04:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huIP5AIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfLSE0L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Dec 2019 23:26:11 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:46183 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfLSE0K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Dec 2019 23:26:10 -0500
Received: by mail-lj1-f175.google.com with SMTP id m26so2203534ljc.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Dec 2019 20:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=a4x0+DdHJJaL/vlOuojrdXqU/lC8RD1KG9FEeRdiN5s=;
        b=huIP5AIqmV4UBq/2nrlQ8tblOu1fjLNX7KZ5oqwC4UGnQZSLvY60gLyOQUHpaoNqtY
         EZUC7pLi315W09lTvO7qvJqCK+8tmN2+sxIKHOkr1tjLZ2KSAG09TZtIxzBhf4tAk32S
         KVZqkSw593U5qcTG/BFIUseIfKHWE5HHSOGUt63bAsoRGVwWa1cCuDGE80qk92lGRz83
         FxLFhp5pwyGq2fNyfhZyHesMvRlAGk5RZZx+DNuk5SYQ7/54Tqv6HCb+aPa6Y/oc3Ty3
         A48wPym5lRvJFs5NDAajy+dqOM/tzBQ8XY+zMk3jSXpENOOa1hhLVaoxsOJfGDRv5Mkt
         Fx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=a4x0+DdHJJaL/vlOuojrdXqU/lC8RD1KG9FEeRdiN5s=;
        b=DiYRtC15xtCtVIe+8VkGLcHcm6qUf1bvcjv1BeH3fRXlKdUoV3jLAUjoKHzN/D1gxm
         iLpQtpri7eTkE0LgGYwNDFTjT82yBnwmuOz7FzwfPI4sYo+6T65NsWZ0TwtHEr40xyr1
         VTKqGCVon8ow98NYA4JcvaJQj4eQo1Cvm1ol3DiWDZTSf/QyKX+7nt00byc0spOav5Yb
         f2U3pXo6A1dgnuDzbSTsteCwPKzi3IbKnoSQCajQRWI+Zz9ZMCJJZLyBVH9EgRcruhKg
         U4f6zG69lYTkFoffMmfTeFFEmbrN1P3/mIVva0oRqukmaJd8oeYv1FEIwJ6kjZqqmA83
         9MlQ==
X-Gm-Message-State: APjAAAUwNplHY2Yi1aq2nvUogViME4XSsIGa84BgIlul1SejzaFUlvhg
        1H6f49tyUvQbIUsBjynolcUNM6sFovweUoiGFYC98AY4
X-Google-Smtp-Source: APXvYqzCUcrTflMj5e4wSWMt1WeVrey4QFR8LZ1oMyPi5nF9chjWXfu8sPx191W15FLQ65P5V8aPoR+/Za00+nmat0I=
X-Received: by 2002:a2e:8613:: with SMTP id a19mr4355756lji.210.1576729568418;
 Wed, 18 Dec 2019 20:26:08 -0800 (PST)
MIME-Version: 1.0
From:   Charles Manning <cdhmanning@gmail.com>
Date:   Thu, 19 Dec 2019 17:25:57 +1300
Message-ID: <CAE21AQps-et6iCNh=BH0YXAD8CM=it-Ncw6kbKTEyVpDe1poOg@mail.gmail.com>
Subject: Preventing connection from initiating a pairing
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi All

I've been getting my head around using BlueZ and libbluetooth and have
achieved all the behaviour I want except one bit.

I have an embedded Linux device that is connecting to a PC using Bluez

They have been paired. Whenever the Linux device turns on, it
automatically connects to the PC. All fine so far.

If the PC then unpairs while the linux device is off, the PC loses
it's pairing info but the Linux device retains its now stale pairing
info.

The Linux device things it is still paired and attempts to connect,
causing  the PC to pop up a pairing request. I do not want that
behaviour. I want the Linux device to not try connecting if the PC has
lost its pairing info.

What I want is either some way to confirm there is a valid pairing
still in place before connecting or some way of setting the Linux
device to only connect if the pairing is still valid, or some other
mechanism by which I can prevent the pairing attempt.

Is there some way to do that?

Thanks for your help.

Thanks

Charles
