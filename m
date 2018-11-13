Return-Path: <SRS0=WHZG=NY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECE8C43441
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Nov 2018 11:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FC420685
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Nov 2018 11:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJrZHNtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FC420685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbeKMVTG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:19:06 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:33489 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732037AbeKMVTG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Nov 2018 16:19:06 -0500
Received: by mail-ot1-f46.google.com with SMTP id i20so4499772otl.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Nov 2018 03:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C2sY9i+ZxoW45MUuuwCMegkAr0aMZEQY7owpQK3GJIg=;
        b=FJrZHNtbQrepulPJXFSkgp99+RhmfB0f/mHbl5KPnpTpRQhcLNzmKH3vDJOE+4I5Tz
         0Qd3elFHQCkxshO4QXae9iK3mfu3GZpoAFXmXtqshpmm73LTM9uN6QCiSd+GoCzS1LWV
         RcE3idVPisTWtXlr85PY9V+mZrCE6PPpShqjP+fRgTqBQRUgCpiKK8y9qMKMX98o2FAx
         cVCGgAA+ipFQqks2OQIdY4zuLkDnZnH57R173xxUOmqBDeP+sIlXu/9CNZ+f/69ZPyfo
         KC8lFFXxlF2gDbMZRpoz+QOijRW3HGSMhGmcfSgCe8n52u+k+LNglRvE+XYFXgmrlFd3
         EGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C2sY9i+ZxoW45MUuuwCMegkAr0aMZEQY7owpQK3GJIg=;
        b=QAK0jwiMAsMhcRnQT8gYk+9bRaKr6Z069ngFFXeJc9EKRMVGiJanAAPX/zJjw5686y
         0UlJP68lCWzQ5T9Mg3uCAGKjP4HPr/HHbvv6DT4TXjfrqKf65MuTwew06tgFwQ8tJI/Z
         pYLXXD1fAw5+xeVKYnaGs4apkpKxCYQmf5llVbgkZp91dZejZ2FIrh1I3b/TBbAIam6L
         kq+XD4loNQE9e4F+92fAVooUsIQ3uAH8b4E5hTk1TgvNAzsggMycnKBz+DcaMb6WUWVk
         PGuZcvgOaIwIxXaqPqzUjQF66Y5rPHdF76bFlLtI7R0sti5dDnEz/HUJvu3E6neieJ4r
         Rwdg==
X-Gm-Message-State: AGRZ1gIUPtWEfqEnKhdvW5o4MFOaG1ARu/ey4IPHdFPjOfWnELWopXqy
        mQal9YBhQkmadOJQ7/a2UC01be6H2s46YgwAR+wz2Q==
X-Google-Smtp-Source: AJdET5cDO/Q/Ikel8KXnI29n6VKYyFTgUnWr2KfdufiRAkrQwtte6olfMGxef7LIdNQiNujOdpn1MbO9GbtDi/BhIa4=
X-Received: by 2002:a9d:4a22:: with SMTP id h31mr2722685otf.254.1542108086090;
 Tue, 13 Nov 2018 03:21:26 -0800 (PST)
MIME-Version: 1.0
References: <CABatt_x1aNftgFVuDxrhyZVs4bGmOZFccjPKU_BpfbGmMWTazA@mail.gmail.com>
 <CABatt_zHbVz+cbb6Vig820W5bdXd+Cd1Jjh02MdqnBiX0WQuEg@mail.gmail.com>
 <CABBYNZJ0uT-qX2njVfFan2vVWaEveDR+waOC3FSZrTfpaBkHew@mail.gmail.com>
 <CABatt_wSMSiW+Fmi5cccAnejMbAAHdNWb-jW0qLcijtdWETHzw@mail.gmail.com>
 <CABatt_yhozRuFjtSsmvHJNyFoFR7tstfuZp9jPdcZpxuCx7z=A@mail.gmail.com>
 <CABatt_zEv6Cksm5buiaiacOdxY4nurmbiX2OdPuQYjqUDKkRCw@mail.gmail.com> <CAO1O6sdawagz6nfL0J=4EZ7YbLGUd2YmMbiJZVqd-BtyqLN0GA@mail.gmail.com>
In-Reply-To: <CAO1O6sdawagz6nfL0J=4EZ7YbLGUd2YmMbiJZVqd-BtyqLN0GA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 13 Nov 2018 13:21:13 +0200
Message-ID: <CABBYNZJJoLbWC5Dm3Gmd23TdFG1KJQUUKL4e+hGit4CzM5Rp5w@mail.gmail.com>
Subject: Re: Operating central and peripheral roles concurrently
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Martin Townsend <mtownsend1973@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Emil, Martin,
On Tue, Nov 13, 2018 at 12:47 PM Emil Lenngren <emil.lenngren@gmail.com> wr=
ote:
>
> Hi,
>
> Den m=C3=A5n 12 nov. 2018 kl 17:19 skrev Martin Townsend <mtownsend1973@g=
mail.com>:
> > I've just been reading the 4.1 spec on GAP and on page 224 it states:
> >
> >
> > "In LE, GAP defines four specific roles: Broadcaster, Observer, Periphe=
ral, and
> > Central. A device may support multiple LE GAP roles provided that the u=
nderly-
> > ing Controller supports those roles or role combinations. However, only=
 one LE
> > GAP role may be supported at a given time. Each role specifies the requ=
ire-
> > ments for the underlying Controller. This allows for Controllers to be =
optimized
> > for specific use cases."
> >
> > Now to me that says a device can support being a central and
> > peripheral but doesn't have to support them concurrently so I'm
> > guessing if the device is in the peripheral role and then wanted to
> > connect to another device you would have to stop being a peripheral
> > (ie drop this connection) and then become a central, make the
> > connection and when finished disconnect and become a peripheral again
> > and wait for the other devices to reconnect to you.  Or am I
> > mis-reading this?
>
> This restriction is lifted in newer versions of the spec. The same
> section in version 4.2 says this:
> "In LE, GAP defines four specific roles: Broadcaster, Observer, Periphera=
l, and
> Central. A device may support multiple LE GAP roles provided that the
> underlying Controller supports those roles or role combinations. Each rol=
e
> specifies the requirements for the underlying Controller. This allows for
> Controllers to be optimized for specific use cases."
>
> If you use the btmon tool you can easily see what combination of
> supported states the controller supports. If you have btmon running
> while you initiate bluetoothd you will see the packet LE Read
> Supported States Command, which contains this info.

In that case we should definitely use these states to determine
instead of assuming the controller don't support Master & Slave state,
though it would be great if Martin provides the HCI traces where it is
failing and if indeed is the controller not support it or some other
bug.

--=20
Luiz Augusto von Dentz
