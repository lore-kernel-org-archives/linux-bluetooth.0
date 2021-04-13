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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57380C43460
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 17:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 375E5611AD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 17:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345771AbhDMRT0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Apr 2021 13:19:26 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:43689 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347114AbhDMRTL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Apr 2021 13:19:11 -0400
Received: by mail-il1-f177.google.com with SMTP id d2so14700626ilm.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 10:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5uHiRLeZzAv5M3e25T0ivzloHaMjuhDcrnjFs/WF3RE=;
        b=Ysrf5DuAYJbgAI7PDnPGqbbds9TqMTSzYgTIheqAC5hc7nx9DR4Rlph8sTQe2EU6Qm
         gS7HomaFzuoP0Okc/PJ9/9yxXlS2DCVJAJd7N03ZuPptQHz3/l03Uswrfh5OgqYX3C0g
         +XUEzqIUVeJJEV3IWLHzSWFvhK3WmLJcVZRHtrupPnhy1HQ1nDAdMxrjIakJKXJd6Rd6
         qINNDquYc8rzBtDorsp1N3X0DnIX772Nolz9lctmr67intWFqkioj8KWawrVH0iOhzVD
         gEanZtyb52d4FiRextgYWrgk93I4xGTi8K8SUoW4kz5ybXQ/Y/ZLcAYF7xi/AO/V8O80
         FdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5uHiRLeZzAv5M3e25T0ivzloHaMjuhDcrnjFs/WF3RE=;
        b=EPWZqU2h/BbS9f1ftAqYOufi1w0lP5vS2d+pSBh3vu62T2nKh6D+yswIBrziDY87Mx
         c8AlqV3G82egE1MRClcwoSoB4nEweEN/RpVhjTVw2Ep+h829RymrbHAH62XghrdXq690
         ugqkH7JYnd56rSdsnUM87Zgau+/0iJhU06kmS0VhZq+fVT3JU1ayKHNt83yNeTT1uHc9
         c8zogmspG0288UCuUNPnPW7TBJqMGddwbr4u6VcaE/PBNXApW4YpkycUxo49X+x3JX27
         c3keZLNbVUViFWL7RxJjPro7NdcXBFIrQGwZ9p9F2dz67A31fjwyJsgR1Vsa+OOmE2UH
         0N+w==
X-Gm-Message-State: AOAM533PgHYWRqkRaiW/a+h713ipE/JgqaPNYmEmDBwTMi99t8RzFr1/
        VCQ6uu1ewgo3Tmm2/OTjX6dZ2d5CDNg6K9vrhw==
X-Google-Smtp-Source: ABdhPJys/P012iwJK+ethO10bonP7YxGkjxdQy7hpB1quqPgbRu4p2E3l0sX/DlnlPgkNTZpVAZcBdiv6Z9hjzhxyqs=
X-Received: by 2002:a05:6e02:2197:: with SMTP id j23mr818036ila.269.1618334271738;
 Tue, 13 Apr 2021 10:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAC9s0NYWacb=SH8P9zr_66CZnD6HC4yHkY_o2wk08oeSwn+Syw@mail.gmail.com>
 <BYAPR14MB2887AB8A9D781267F8F4B2EEE64F9@BYAPR14MB2887.namprd14.prod.outlook.com>
In-Reply-To: <BYAPR14MB2887AB8A9D781267F8F4B2EEE64F9@BYAPR14MB2887.namprd14.prod.outlook.com>
From:   Kenny Bian <kennybian@gmail.com>
Date:   Tue, 13 Apr 2021 10:17:40 -0700
Message-ID: <CAC9s0NYCJD58F4iWb2JZhcy-X1Ax-5U9Pphc_SXQKYV9BkdmjA@mail.gmail.com>
Subject: Re: Disabled bluetooth cache. But the app still getting wrong data?
To:     Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jamie,

Thank you for your email. Do you know how to add "Service Changed
Indication"? We would like to support that. But we don't know how to
do it.

In fact, I posted the question before:
https://www.spinics.net/lists/linux-bluetooth/msg89959.html. It seems
"If you are registering the services with Bluetoothd then it should
generate the service change". Our GATT server is based on
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-s=
erver.
By saying "registering the services", does it mean our code should
call "RegisterApplication()"? We did call RegisterApplication(). But
we never saw the "[ServiceChanged]"
section(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/setting=
s-storage.txt#n321).
Please let us know if you know how to add "Service Changed
Indication".

Thanks!
Kenny

Kenny

On Mon, Apr 12, 2021 at 11:39 PM Jamie Mccrae
<Jamie.Mccrae@lairdconnect.com> wrote:
>
> Hi Kenny,
> Why not just add the service changed indication as you refer to below? It=
 was purposely designed for this specific purpose, you're trying to work ar=
ound an issue created because you don't want to use the feature that preven=
ts this issue. Any workaround is just that, a workaround, and might not wor=
k as intended.
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
>
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
>
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
