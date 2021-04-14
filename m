Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FB8C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Apr 2021 04:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECE2611F2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Apr 2021 04:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhDNEqs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Apr 2021 00:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhDNEqr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Apr 2021 00:46:47 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1032C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 21:46:21 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id 6so16011733ilt.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 21:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z/my2eeTYJz5C1+UYN7ekEQuNMRdplOxa3URBXmI9qo=;
        b=P0Kmv05tR4Go5gedbIs1raPd9GG5WhQWyKeJNWokI7rpObdFGmozDcBNJO/cOFM8NT
         d1IfCig4hzmd0/Hiu+pPE05lzYtaZT9FrgOzuIad4TPVD8VkTufrNtaigHixWPYP7A70
         /HjeV8sPsJQkqe0gg5AquxxKHu/G7v/OaoGhX140WeWnhpcP+JMgY6BYIfdVB5gmqLfc
         sOfehxHwN9AEbM1WsfcGpkAqVoieh8qyV70viWkFn+7dkJfgMLyy81NP7FEWS6hv0kE2
         2VGCByP/ExqC8EYyHyzlqH4Xuf2H0PjzYBxN/xSG7iM69lUF+hj5BlzOW/dnSNS20vMh
         qgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z/my2eeTYJz5C1+UYN7ekEQuNMRdplOxa3URBXmI9qo=;
        b=hpOoC0NS0RLYYqjM64J0ZdRldxl/oQak51X1phsBJJhGKj66bgagvE+yo0aeDxbUEi
         6Ij45IUfesD1znsMFtOVp4L9Pz9WgV3rCZpVo+yngCPXTctvuekowCOh/F6WN1lA+8dv
         428hbXoqHVVExr6PyiYp91AzInrsiU25lpduO9KNiixuxaCWT2RpxN0UCQo4IV/+bNCz
         ddM3lZLnjIVEmaS80292SwZic8tT16MoFqS2GMLa2Ja1CxsiWkHAFETqrhFUKe19/yLw
         UsVIvdet5HduW2WkN7R8niU05XSEle3r16RcyWi6jgYkFXqk+Vqet1LMohs37DWoeKzb
         +AJw==
X-Gm-Message-State: AOAM531vW99KVgE2glgAYwrBL//xklYQsg3d0B4HXDrmRgF3jqMIgYzE
        X4TIsRnAQQcRgvPVPqD7ZMhu+Uml9eRsxfeZkg==
X-Google-Smtp-Source: ABdhPJxmhZeMvnwccW2LKIYoB0QhZ0bLGO32HsuKv32BkrvHXWpGhdZhxC+6Tr21XzgVfA5tmyV4fHeYaJLrvdzybXU=
X-Received: by 2002:a92:ccd0:: with SMTP id u16mr30901119ilq.6.1618375581382;
 Tue, 13 Apr 2021 21:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAC9s0NYWacb=SH8P9zr_66CZnD6HC4yHkY_o2wk08oeSwn+Syw@mail.gmail.com>
 <BYAPR14MB2887AB8A9D781267F8F4B2EEE64F9@BYAPR14MB2887.namprd14.prod.outlook.com>
 <CABBYNZLDgfRarPODF+c2PWvgi1zeUiy5QfmXY5UVkwVkoLJ3zg@mail.gmail.com>
In-Reply-To: <CABBYNZLDgfRarPODF+c2PWvgi1zeUiy5QfmXY5UVkwVkoLJ3zg@mail.gmail.com>
From:   Kenny Bian <kennybian@gmail.com>
Date:   Tue, 13 Apr 2021 21:46:20 -0700
Message-ID: <CAC9s0Na0h5VRC8dc6sPmuQWOd0v2mvOfAnqq_sO0+BfLcjJAtw@mail.gmail.com>
Subject: Re: Disabled bluetooth cache. But the app still getting wrong data?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jamie, Luiz,

Thanks for your info.

Luiz, to answer your questions:
BlueZ doesn't seem to emit "Service Changed Indication". Or it does
emit it, but we don't know how to verify it.
Yes, BlueZ acts as a GATT server which runs on Linux.

So my questions:
How can I tell if "Service Changed Indication" is working? I need to
show it to our app developers that the GATT server does send the
"Service Changed Indication" when there is a service change.
By disabling the GATT's cache in "/etc/bluetooth/main.conf", the
"Service Changed Indication" is disabled?
Can "Service Changed Indication" be enabled in a conf file? Or should
it be done in the Python code? Could you please help find out that
info?
Our GATT server is based on the Python code
examples(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test).
I don't know how to enable "Service Changed Indication" or "Robust
Caching" in Python code on the GATT server side. There is no document
or code samples about that. Please let me know if there is any
document or Python code example.

Thanks!
Kenny

On Tue, Apr 13, 2021 at 2:57 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Jamie, Brian,
>
> On Tue, Apr 13, 2021 at 2:03 AM Jamie Mccrae
> <Jamie.Mccrae@lairdconnect.com> wrote:
> >
> > Hi Kenny,
> > Why not just add the service changed indication as you refer to below? =
It was purposely designed for this specific purpose, you're trying to work =
around an issue created because you don't want to use the feature that prev=
ents this issue. Any workaround is just that, a workaround, and might not w=
ork as intended.
>
> Yep, and while at it implement the so called Robust Caching feature so
> we can detect if anything has changed by reading the DB Hash.
>
> > Thanks,
> > Jamie
> >
> > -----Original Message-----
> > From: Kenny Bian <kennybian@gmail.com>
> > Sent: 13 April 2021 06:59
> > To: linux-bluetooth@vger.kernel.org
> > Subject: Disabled bluetooth cache. But the app still getting wrong data=
?
> >
> > EXTERNAL EMAIL: Be careful with attachments and links.
> >
> > Previously we had an issue: if there is a change of characteristics in =
the new build of our firmware, then the app will get the wrong data.
> > By saying changed characteristics, it can be an added or removed charac=
teristic, or adding notification to an existing characteristic.
> > In order to keep the pairing information, the "/var/lib/bluetooth"
> > folder is copied over to the new build's partition. We realized that th=
ere is no "service changed indication". The app can't handle the changed se=
rvices. So we disabled the bluetooth cache by set this in
> > "/etc/bluetooth/main.conf":
> > [GATT]
> > Cache =3D no
>
> When you say the app can't handle changed service do you mean BlueZ
> doesn't emit changes to the attributes (via Service Changed) or is it
> really the application not being able to handle the changes?
>
> > But recently, we saw the problem again even if the bluetooth cache is
> > disabled: in the build number 101, a characteristic is removed. But whe=
n we upgrade the build from 100 to 101, the app gets the wrong data. We loo=
ked at the log. When the app tries to read temperature by using the tempera=
ture UUID, somehow the bluetooth service we created received the request to=
 read the "device name"(device name UUID). So the "device name" is returned=
 to the app as the temperature. This looks like the same behavior as the bl=
uetooth cache is not disabled. I looked at the "/var/lib/bluetooth/[BT_MAC]=
/cache" folder. There is no "[Attributes]" section in the files in the fold=
er. That means the disabled cache seems working.
>
> So BlueZ is acting as the server, right? The Cache only applies to the
> client portion, there is no such thing as disabling the remote cache.
> I don't see any incoming Read By Group Request from the remote so it
> is very likely that it has cached the values, there is no Read By Type
> for the DB Hash either which is quite surprising to me since that is
> required for stacks supporting Robust Caching which I believe is the
> case of iOS.
>
> Anyway, I would check that the following lines are being triggered:
>
> When starting:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database=
.c#n3798
>
> On connect:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database=
.c#n3741
>
> If those lines are not being triggered it is likely a client problem
> which for some reason had not subscribed to received service changes
> for some reason, if it doesn't subscribe to service changes then it
> shall not cache any attribute and attempt to rediscover on every
> connection.
>
> > The only way to fix this issue is to force exit the mobile app on the p=
hone and "Forget This Device" in iOS or "Unpair" in Android.
> >
> > I looked at the btmon(see attached). For the working btmon log, there i=
s "Attribute group list: XX entries" under "ACL Data TX". But there is no "=
Attribute group list: XX entries" under "ACL Data TX" in the attached probl=
ematic btmon log.
> >
> > Questions:
> > 1. How is it possible that this still happens even if the bluetooth cac=
he is disabled?
> > 2. Is this the problem on the Linux side which runs the GATT server or =
on the mobile side?
> > 3. Is there anything else we should look into?
> >
> > We're going to release our product soon. This is a critical issue for u=
s. Please help if you have any suggestions.
> >
> > Thanks!
> > THIS MESSAGE, ANY ATTACHMENT(S), AND THE INFORMATION CONTAINED HEREIN M=
AY BE PROPRIETARY TO LAIRD CONNECTIVITY, INC. AND/OR ANOTHER PARTY, AND MAY=
 FURTHER BE INTENDED TO BE KEPT CONFIDENTIAL. IF YOU ARE NOT THE INTENDED R=
ECIPIENT, PLEASE DELETE THE EMAIL AND ANY ATTACHMENTS, AND IMMEDIATELY NOTI=
FY THE SENDER BY RETURN EMAIL. THIS MESSAGE AND ITS CONTENTS ARE THE PROPER=
TY OF LAIRD CONNECTIVITY, INC. AND MAY NOT BE REPRODUCED OR USED WITHOUT TH=
E EXPRESS WRITTEN CONSENT OF LAIRD CONNECTIVITY, INC.
>
>
>
> --
> Luiz Augusto von Dentz
