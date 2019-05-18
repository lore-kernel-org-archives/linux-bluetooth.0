Return-Path: <SRS0=UGHn=TS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93C9C04AAF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 May 2019 16:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0DD2087B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 May 2019 16:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GY2ov/gB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfERQac (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 May 2019 12:30:32 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:38933 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbfERQab (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 May 2019 12:30:31 -0400
Received: by mail-ot1-f45.google.com with SMTP id r7so9444856otn.6
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 May 2019 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GYM2jfgjPzMJE25+f2H8sz/7PmpmaKg2pezUUU4R7X4=;
        b=GY2ov/gBgFacWY50/PbRC1DJVA4jRbI/4Dhw2Xq/3F7IlnrHaEkcz9Keu14RA68CbP
         NueRIbKBdE304Q/Y5BK9ek48ONaPO1k65/WbRmA5BxJEme8mVEgm2HjGflmUluQcA7no
         ldQd8/TLP629Ro7JrXSiD9StbpTSyM8gs4P+WVtuZdEMIgV5f7P5q/F1gpX6Jg1tbYD5
         XMGijfRnqAcHx3AisgmvdCO0GOg/gAFOt5IrGXktwLFNLz/WjXd7E2j6h2P7MMPcz0PH
         i8FdUAhFI6uZ9KF7mQZi/3BbJFDtPXG3vcc2+SObbCg4c24vpxQjNzNASxrsVjuWqKYS
         qijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GYM2jfgjPzMJE25+f2H8sz/7PmpmaKg2pezUUU4R7X4=;
        b=AsHeZmVS0kUyna+eR6xePEa/NhYr+5219hDx7Gazyb5aEMGg+m06I6kr27ohLmJT1K
         AYc4x8mwTsMJrQjMpFlFfuMf59YPrNpUVgaQ2Xze/owuinulg75r3GA0XfS3m0bq6I6+
         vHNJ4qrTtglB3nk6ncl/sxiwUt1i2yXFujt+mns/4eyezdE2TD5NCab7D6ycnrARiI/A
         bffMBEKCHlaQTDLyNhhylUd90JAEbpjwM/UBDeh9xxYthTi+CSBC/imVFJRiUWsMkoDy
         UO3Xqj62WbN/GUD7tbjkKL5NBlJ+x58aXj8UdAYSLbP7k1KBYjxVZb4/SOfdMAWytH5w
         bU8A==
X-Gm-Message-State: APjAAAVzRJu8y7CWTygzSIg+hqdQ+D6xi90M3R68wDdfmb/ZFz+qus7R
        cv8nEUpgNmfn+e0W4vrXPUTFEUOEdmiZjFDvmVU=
X-Google-Smtp-Source: APXvYqw0/ezaFwyC/jx1GXjanxrWhn26nHrWvfZMjbTahzSKOp0UbVKLY7NqlgtU6JHxkWdozo9FNv/kYY2PmMGQqLE=
X-Received: by 2002:a9d:6288:: with SMTP id x8mr10544471otk.79.1558197031064;
 Sat, 18 May 2019 09:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAELgYhdqAxTGA98RsUEOSEA5WfhxGaVn7C_DegAfU13sHx817A@mail.gmail.com>
 <CANxMttCx4uFeVpM9EsYmfg9VoXG45ihpzw=phJcx0Uy53cGD_A@mail.gmail.com>
 <CABBYNZLGgUL6W=-v+stoaukpN5kvt1AHFBQ_vEdh=sqU9JO0LQ@mail.gmail.com>
 <CAELgYhcCBAUr6oQxTnmjBjQfkc8JeTbkXHea64PN+7cWQSqQ=Q@mail.gmail.com> <CANxMttCqEYDZOwTriLqC-q39+JhEJ9KCOsPhRqkjZwE1h-64Gg@mail.gmail.com>
In-Reply-To: <CANxMttCqEYDZOwTriLqC-q39+JhEJ9KCOsPhRqkjZwE1h-64Gg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 18 May 2019 19:30:18 +0300
Message-ID: <CABBYNZKbWAaO9dTnHcV7vCYodRQYEZT8=PBws+=_iip-7Njo2w@mail.gmail.com>
Subject: Re: After kernel update: connect/disconnect forever while attempting
 to auto-reconnect
To:     Alexandre Pereira Nunes <alexandre.nunes@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alexandre,

On Sat, May 18, 2019 at 7:13 PM Alexandre Pereira Nunes
<alexandre.nunes@gmail.com> wrote:
>
> I've attached two btmon sessions: one captured from the text mode and
> another with -w param.
>
> Both on 5.1.2 kernel.

The problem seems to be here:

< ACL Data TX: Handle 512 flags 0x00 dlen 16                #87 [hci0] 9.95=
2984
      L2CAP: Connection Response (0x03) ident 1 len 8
        Destination CID: 0
        Source CID: 65
        Result: Connection refused - security block (0x0003)
        Status: No further information available (0x0000)

Ruling out encryption since HID don't require it:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/profiles/input/serv=
er.c#n294

Are you seeing any of the following logs on the journal:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/profiles/input/serv=
er.c#n181

> Em s=C3=A1b, 18 de mai de 2019 =C3=A0s 05:53, Carlos Pita
> <carlosjosepita@gmail.com> escreveu:
> >
> > Hi Luiz,
> >
> > I've attached the output for a single auto-reconnect/disconnect sequenc=
e.
> >
> > Notice this was using the 4.19.44 kernel, which is the LTS one in Arch
> > Linux. As I've pointed out above, the problem seems like a regression,
> > since it's happening both in older and latest kernels, but not
> > in-between them.
> >
> > Best regards
> > --
> > Carlos



--=20
Luiz Augusto von Dentz
