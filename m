Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486BFC433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 21:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF0F61249
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 21:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhDMV5n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbhDMV5m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Apr 2021 17:57:42 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9FCC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 14:57:22 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id d12so18496201oiw.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 14:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sUWIt/7pRjW3IpMlWYsAMBcyzn4hw7rvu20e98BsW3A=;
        b=sJOedLBYmawmkHTaGEXVWAxFz3ftqe+3fq6UDy2hzzbNQm+r5N8qtSwlkMaag6GZVS
         jaPY9BuNX2VKhC/0mDXmC4ocaCpwMWyibjeUOLM7KO3dswNWVbMMpHkXJ/no6hq9frYs
         3CKQ/IQtXriP2sQCXYIdTM5CpIo5BdpcQvfN+gUVWA71DqtlMPdAPlhRQ5x6yC7j7WCl
         v0kAVIqD29s0GbC8PoUPTzHxWE1b75d+92JWX2mLNLFH3tk17aJ6DAHwb1rViAJrggmV
         GuB8f0DTMDTPnbPEYkoOM103Bdyckl/iaM+sxWMGB2BnemguGD3d7xVzM32nxNfmQdi7
         3RpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sUWIt/7pRjW3IpMlWYsAMBcyzn4hw7rvu20e98BsW3A=;
        b=Xl9UHmA5fCMWviPZOWsYyIWqmoRheiEocFCy0ZAyovhkTYz2fSVv2AWdThpLKg+Q25
         pCtbdmSYEETrZwyNz0u0ji+QpBycKAPhTM88Om2vTosTUZmJboyCJkuVG2lUJnIyJzmc
         uyexPuHKxcAI2QRh6Nlt0G9dwewmTmOXxvLqCqnefraofguMvokEFP9XL2dXHsTlshCx
         D00TaLXBitdQ5YGiXHhS3w6GLSbol9szCG9T22I00XnAXXLBuDjwusOnSw6Fo6iGuy9a
         puMCQUMupGqVxm/vTVVdFZg5k9K7byxeB1K0dqqxl80WmnxeABkWCHo5ygjTaPOIaJ45
         5mkw==
X-Gm-Message-State: AOAM532g56zOaU1ENsE22ILdvYgQKhJpuVYIWnMKoXUJ/9pZfp8CG7cA
        j07p1k4D9sfVRAy9+gmJr3ZS1nGGImVDwSncXalI6x1xaT63PA==
X-Google-Smtp-Source: ABdhPJxS29ejeDORgWFH3XBCc0IIFRy+6XgFq6LefDECiaakxqYb19F+2E+Ekp24gcCAP8FLRfMlhwUaNFVi2Y6aoPk=
X-Received: by 2002:a05:6808:1313:: with SMTP id y19mr1516769oiv.161.1618351041596;
 Tue, 13 Apr 2021 14:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAC9s0NYWacb=SH8P9zr_66CZnD6HC4yHkY_o2wk08oeSwn+Syw@mail.gmail.com>
 <BYAPR14MB2887AB8A9D781267F8F4B2EEE64F9@BYAPR14MB2887.namprd14.prod.outlook.com>
In-Reply-To: <BYAPR14MB2887AB8A9D781267F8F4B2EEE64F9@BYAPR14MB2887.namprd14.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 13 Apr 2021 14:57:10 -0700
Message-ID: <CABBYNZLDgfRarPODF+c2PWvgi1zeUiy5QfmXY5UVkwVkoLJ3zg@mail.gmail.com>
Subject: Re: Disabled bluetooth cache. But the app still getting wrong data?
To:     Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>
Cc:     Kenny Bian <kennybian@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jamie, Brian,

On Tue, Apr 13, 2021 at 2:03 AM Jamie Mccrae
<Jamie.Mccrae@lairdconnect.com> wrote:
>
> Hi Kenny,
> Why not just add the service changed indication as you refer to below? It=
 was purposely designed for this specific purpose, you're trying to work ar=
ound an issue created because you don't want to use the feature that preven=
ts this issue. Any workaround is just that, a workaround, and might not wor=
k as intended.

Yep, and while at it implement the so called Robust Caching feature so
we can detect if anything has changed by reading the DB Hash.

> Thanks,
> Jamie
>
> -----Original Message-----
> From: Kenny Bian <kennybian@gmail.com>
> Sent: 13 April 2021 06:59
> To: linux-bluetooth@vger.kernel.org
> Subject: Disabled bluetooth cache. But the app still getting wrong data?
>
> EXTERNAL EMAIL: Be careful with attachments and links.
>
> Previously we had an issue: if there is a change of characteristics in th=
e new build of our firmware, then the app will get the wrong data.
> By saying changed characteristics, it can be an added or removed characte=
ristic, or adding notification to an existing characteristic.
> In order to keep the pairing information, the "/var/lib/bluetooth"
> folder is copied over to the new build's partition. We realized that ther=
e is no "service changed indication". The app can't handle the changed serv=
ices. So we disabled the bluetooth cache by set this in
> "/etc/bluetooth/main.conf":
> [GATT]
> Cache =3D no

When you say the app can't handle changed service do you mean BlueZ
doesn't emit changes to the attributes (via Service Changed) or is it
really the application not being able to handle the changes?

> But recently, we saw the problem again even if the bluetooth cache is
> disabled: in the build number 101, a characteristic is removed. But when =
we upgrade the build from 100 to 101, the app gets the wrong data. We looke=
d at the log. When the app tries to read temperature by using the temperatu=
re UUID, somehow the bluetooth service we created received the request to r=
ead the "device name"(device name UUID). So the "device name" is returned t=
o the app as the temperature. This looks like the same behavior as the blue=
tooth cache is not disabled. I looked at the "/var/lib/bluetooth/[BT_MAC]/c=
ache" folder. There is no "[Attributes]" section in the files in the folder=
. That means the disabled cache seems working.

So BlueZ is acting as the server, right? The Cache only applies to the
client portion, there is no such thing as disabling the remote cache.
I don't see any incoming Read By Group Request from the remote so it
is very likely that it has cached the values, there is no Read By Type
for the DB Hash either which is quite surprising to me since that is
required for stacks supporting Robust Caching which I believe is the
case of iOS.

Anyway, I would check that the following lines are being triggered:

When starting:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c=
#n3798

On connect:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c=
#n3741

If those lines are not being triggered it is likely a client problem
which for some reason had not subscribed to received service changes
for some reason, if it doesn't subscribe to service changes then it
shall not cache any attribute and attempt to rediscover on every
connection.

> The only way to fix this issue is to force exit the mobile app on the pho=
ne and "Forget This Device" in iOS or "Unpair" in Android.
>
> I looked at the btmon(see attached). For the working btmon log, there is =
"Attribute group list: XX entries" under "ACL Data TX". But there is no "At=
tribute group list: XX entries" under "ACL Data TX" in the attached problem=
atic btmon log.
>
> Questions:
> 1. How is it possible that this still happens even if the bluetooth cache=
 is disabled?
> 2. Is this the problem on the Linux side which runs the GATT server or on=
 the mobile side?
> 3. Is there anything else we should look into?
>
> We're going to release our product soon. This is a critical issue for us.=
 Please help if you have any suggestions.
>
> Thanks!
> THIS MESSAGE, ANY ATTACHMENT(S), AND THE INFORMATION CONTAINED HEREIN MAY=
 BE PROPRIETARY TO LAIRD CONNECTIVITY, INC. AND/OR ANOTHER PARTY, AND MAY F=
URTHER BE INTENDED TO BE KEPT CONFIDENTIAL. IF YOU ARE NOT THE INTENDED REC=
IPIENT, PLEASE DELETE THE EMAIL AND ANY ATTACHMENTS, AND IMMEDIATELY NOTIFY=
 THE SENDER BY RETURN EMAIL. THIS MESSAGE AND ITS CONTENTS ARE THE PROPERTY=
 OF LAIRD CONNECTIVITY, INC. AND MAY NOT BE REPRODUCED OR USED WITHOUT THE =
EXPRESS WRITTEN CONSENT OF LAIRD CONNECTIVITY, INC.



--=20
Luiz Augusto von Dentz
