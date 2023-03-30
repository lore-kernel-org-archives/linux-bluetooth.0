Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601D8C761A6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 18:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjC3SZx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjC3SZw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 14:25:52 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A81EB5C
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 11:25:50 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id cz11so17021787vsb.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 11:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680200749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIREIejjlh/VKlfJrG38Ro0jLus9doz0InmCMF4gmQw=;
        b=jGw73kaijzFYzWw4qke1VL5o1/nOowAp6JfGHzcd7h5awmsLlQx3nGNuJVli8L3sd/
         jeTlwbHb7GsWizLWOekQ9YMaBhAisChe4zYizOMwIr/tT/qhLXDLoTC3zJXb7F/3v8hp
         RtxxNXweF5EuU4akEJuskuA7YDuroE9jBZ4tBzbeRnHEBAolFNqdrjpF7/j/69c4hkPv
         bv1neEsWUoRLGBGwBqgvUg5lkF5rTGU0JZgHfw3jIT5W0p/byZHDSa19LG3JXaMqeZGq
         CtXm4OpPZCW+dOMHDzMNp0PDDI1b/+qrdw6bM9MkJNBEsuFF0AIxcoru7ObV/8Sh2we3
         0ZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680200749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIREIejjlh/VKlfJrG38Ro0jLus9doz0InmCMF4gmQw=;
        b=jb7us+mdi7ooxnWmkGxp+moCHHdyTxAjBCGsYUAcCeMTYhBUdzEAnliDaSNPuNbH+e
         ERfwIvX9FrElNgdLWTh7y3pcFo4OlsDBHH4hMxt9zrQLdznhSy7UfjSsfq5G9ZRTZkDN
         MHcEymA4a6auvVt7b0Oz3clwMGeD93B80mWZkXkzmOlxsA+msJ4Eael3uyxLeFY8Jn5u
         XvRIh3/jsjgs5a2+1S/NIIyKc1XyhYpq+eT8db6WSJlSys49UQ+pkK5KnQSa/Y1nyznt
         LV/amrLmLonB/9ELVn+iYiUc3htqdcFw2h82ctR6plI0bEyyAHlangGID2EYrMYBzJbr
         ZxUw==
X-Gm-Message-State: AAQBX9efUaCnJVIbpT7PEaioE0yMD+ts6WcJkU78hr5Arag7YPoA3T1j
        AC0FkkeWxcKVkkzJmOrMUFhK/doZn5uQ3IKE0aGPZKd5thY=
X-Google-Smtp-Source: AKy350Z6clniyIGS3qSeIfj1SP0SKOOjwJETVuIBVOuSs5Slzxf987fL9H97FP1RvJno3xK14fVRDduaD4GKuN9Omzg=
X-Received: by 2002:a67:cb8e:0:b0:426:1175:13d2 with SMTP id
 h14-20020a67cb8e000000b00426117513d2mr13187006vsl.2.1680200749564; Thu, 30
 Mar 2023 11:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <6950dd49-7436-ebef-eb88-940597472ce1@tavla.de>
 <CABBYNZJMcEX6-9nQgoYccc7W=yEetNjjCMXSzP=Aa-4r4X_puw@mail.gmail.com>
 <56921851-be55-1380-2185-111335edaeb0@tavla.de> <96ab0304-09e0-7bd9-944c-09ab03a21b67@tavla.de>
In-Reply-To: <96ab0304-09e0-7bd9-944c-09ab03a21b67@tavla.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 30 Mar 2023 11:25:36 -0700
Message-ID: <CABBYNZ+ydQdL=GhKAMUZ-qqdu=xX+sTxVNJmMWO60=XBLWoTaA@mail.gmail.com>
Subject: Re: How to Automatically Re-Connect Bluetooth HID over GATT (HOG)
 Device when BlueZ Plugin "hog" is Disabled
To:     Martin Petzold <martin.petzold@tavla.de>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Martin,

On Thu, Mar 30, 2023 at 11:16=E2=80=AFAM Martin Petzold <martin.petzold@tav=
la.de> wrote:
>
> Dear Luiz,
>
> I now have another issue with remote control HID integration
> (non-system; direct implementation).
>
> I am using Java with d-bus BlueZ 5.55 on Debian Linux. I have "hid" and
> "input" plugin disabled on bluetooth startup.
>
> I have one remote integrated and working. With this one after boot and
> while application startup I iterate over all paired devices with
> existing HID service (check for existing service UUID) and then iterate
> all Report characteristics and enabling notifying for all of them (if
> supported). Everything is running well with this (legacy) remote. After
> pairing it also auto-connects using my own registered object manager, as
> suggested by you.
>
> Now we received our final custom remote control from our manufacturer
> (other chip) and this approach does not work any more. I have tried a
> lot of things now. Once the remote control is paired (which is also
> somehow still buggy) and I rebooted the system with our application, the
> device is found in the list as paired, BUT I cannot access the HID
> service any more. Therefore, I cannot enable notifying for this remote.
>
> What I realized is, that this remote control seems to have something
> like MAC address randomization enabled (probably for security reasons).
> It also does not propagate device information unless I start pairing
> mode. Because of MAC address randomization it also seems that pairing is
> buggy - only works sometimes with some special procedure.
>
> I know this remote works, because if I connected in manually via
> bluetoothctl sometimes I works with enabling of notifying. Also directly
> after pairing it seemed to work.
>
> Have you seen something like this before? What should I do?

It is probably using the privacy (aka Resolvable Private Address/RPA),
there were quite a few fixes since 5.55 so you might want to update
your version to the latest to see if pairing works properly, note that
the D-Bus object might use the RPA address when it is first paired but
after that if you restart the daemon it will use the Identity Address,
so the any code using the device objects shall not attempt to store
and access the object based on their addresses since that can change
due to these conditions.
