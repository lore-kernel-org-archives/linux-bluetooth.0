Return-Path: <SRS0=WHZG=NY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726B5C43441
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Nov 2018 10:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3726522419
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Nov 2018 10:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUCxEXRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3726522419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeKMUpa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:45:30 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:39592 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732153AbeKMUpa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Nov 2018 15:45:30 -0500
Received: by mail-pl1-f175.google.com with SMTP id b5-v6so5811725pla.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Nov 2018 02:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GH7+V+lQy/EoXFev1a2RM5UVQebqeHY8eQ2EUcB2nTQ=;
        b=VUCxEXRNkLhOhZ1bMPa3IooCEPTY/buTXSJwOJKOT0ZV5/g199Ln6sRvAx8NJH+80O
         RGPmHuG4nAlgXHfnV0DoBOGAvNZzTMjOslBE7PLgaY6siwkKG29YP7e1zBoTKrWA3soH
         FuHgW6iHtbkVwj1Jqwok15NQGGcRS5vd/nnMPgK6lCildZHhzyIF0wRSV8MNYEhYPRPE
         rhWBnPFS+hUI8DQZnd+cjOY4kR6PZxGs2QJsPZhTaa/QRsbHyvU8oak2YQpghJwst9U2
         7pob3ZkkzxN22+9j1hzNipZ9wYDO6QL1460nTGV6x7nH/T7M8711r8lEZJ6wm5djJIf+
         DrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GH7+V+lQy/EoXFev1a2RM5UVQebqeHY8eQ2EUcB2nTQ=;
        b=aWiM1oy+iN8w4wMJZxDu8dty8cVAfDzHr1d97VUglBPEno8+H/WVFgVPCPHZzdjQf9
         OZjDjOygCDe1txl3JcHxFpFPMOJwBi5ISV0apcTStZkdct6zR77wwAajIiPfJkKCYwjK
         uqqBjhh9+HaIcxEDT4ITLcAvUCJ5uWfWxZIefwsC7rkd7HHWphCQ8Nn+W9qKHeEu3qIs
         4ZF/e0No1UvRXDFOeOaBtriGtbCBnsneYWZpQQvfGh4r0nVbJhoHYFEA2ZEqDUQPcWaL
         Qkf0DarEVEVo3IwhUhyI2RYmW40FL9uZOEKstP2uBOLPb1qG9aEXzlySZByiZN7XsbJX
         qnFg==
X-Gm-Message-State: AGRZ1gLo4YgbdkZO7t8CFitKUn9IsmrGEqePDXe6ir1nPGmUHgYS5oeW
        /JwTMH0UF/YYJXPyYgbt31iQ3s8OvFVH95sW7/tHsdbE
X-Google-Smtp-Source: AJdET5etjAc44340I769wmig3u026WPj0q/svrDf3SErme6snI2CJ66YGEhuMtomZtq/+enDH79YmpqUZ0W5CH8Cc10=
X-Received: by 2002:a17:902:f08f:: with SMTP id go15mr4638265plb.332.1542106077612;
 Tue, 13 Nov 2018 02:47:57 -0800 (PST)
MIME-Version: 1.0
References: <CABatt_x1aNftgFVuDxrhyZVs4bGmOZFccjPKU_BpfbGmMWTazA@mail.gmail.com>
 <CABatt_zHbVz+cbb6Vig820W5bdXd+Cd1Jjh02MdqnBiX0WQuEg@mail.gmail.com>
 <CABBYNZJ0uT-qX2njVfFan2vVWaEveDR+waOC3FSZrTfpaBkHew@mail.gmail.com>
 <CABatt_wSMSiW+Fmi5cccAnejMbAAHdNWb-jW0qLcijtdWETHzw@mail.gmail.com>
 <CABatt_yhozRuFjtSsmvHJNyFoFR7tstfuZp9jPdcZpxuCx7z=A@mail.gmail.com> <CABatt_zEv6Cksm5buiaiacOdxY4nurmbiX2OdPuQYjqUDKkRCw@mail.gmail.com>
In-Reply-To: <CABatt_zEv6Cksm5buiaiacOdxY4nurmbiX2OdPuQYjqUDKkRCw@mail.gmail.com>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Tue, 13 Nov 2018 11:47:49 +0100
Message-ID: <CAO1O6sdawagz6nfL0J=4EZ7YbLGUd2YmMbiJZVqd-BtyqLN0GA@mail.gmail.com>
Subject: Re: Operating central and peripheral roles concurrently
To:     mtownsend1973@gmail.com
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Den m=C3=A5n 12 nov. 2018 kl 17:19 skrev Martin Townsend <mtownsend1973@gma=
il.com>:
> I've just been reading the 4.1 spec on GAP and on page 224 it states:
>
>
> "In LE, GAP defines four specific roles: Broadcaster, Observer, Periphera=
l, and
> Central. A device may support multiple LE GAP roles provided that the und=
erly-
> ing Controller supports those roles or role combinations. However, only o=
ne LE
> GAP role may be supported at a given time. Each role specifies the requir=
e-
> ments for the underlying Controller. This allows for Controllers to be op=
timized
> for specific use cases."
>
> Now to me that says a device can support being a central and
> peripheral but doesn't have to support them concurrently so I'm
> guessing if the device is in the peripheral role and then wanted to
> connect to another device you would have to stop being a peripheral
> (ie drop this connection) and then become a central, make the
> connection and when finished disconnect and become a peripheral again
> and wait for the other devices to reconnect to you.  Or am I
> mis-reading this?

This restriction is lifted in newer versions of the spec. The same
section in version 4.2 says this:
"In LE, GAP defines four specific roles: Broadcaster, Observer, Peripheral,=
 and
Central. A device may support multiple LE GAP roles provided that the
underlying Controller supports those roles or role combinations. Each role
specifies the requirements for the underlying Controller. This allows for
Controllers to be optimized for specific use cases."

If you use the btmon tool you can easily see what combination of
supported states the controller supports. If you have btmon running
while you initiate bluetoothd you will see the packet LE Read
Supported States Command, which contains this info.
