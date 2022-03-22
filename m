Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4795C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 06:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiCVGGV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 02:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiCVGGU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 02:06:20 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F93AD4C
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 23:04:52 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2db2add4516so179531957b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 23:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yviPRoNCsxnnkW3G+JqFsi5JehNjFkYYjatmXaXYQm4=;
        b=BneRAjS6qMqGNPzt+IONjDb2LHUMmeC+2i3PL+czkdq6FJh6Ic6ablrCq8Vf1h568/
         ouoazn+JGYRRvDcQgKIJn2Q1TGGlmawwrl5vash9Q/+wTpfvR+vQu9a4Kx5OxzHEW7q6
         k+RlflnKeyL8KM9JmuftbnEFw1+zIBSsqYnlNIaU/TF1yA1bX20fVOKgWZKr3fc4ghYP
         otf712kEPfx0fmTuW4NSR6DBGxB23lMpWawXK3UuLidrefvbqZ7ONkmwHNN6l5zUrsDs
         4MAxZFwbESG6Yv5Wob5bbjmZuaUrmehGkJcfXihJ+T2JJodrzESzrDb1gqK7eDWEVrDf
         9Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yviPRoNCsxnnkW3G+JqFsi5JehNjFkYYjatmXaXYQm4=;
        b=Zhcmq8JHk4SUVEMJFElyuuge3Hb8dDuaYyHPaIxO+t8+jdLk1PaarLrVp+ogKHXZ8D
         4sSPhuZLQaOq4jvF33eqctKBWWenLkznWLmBsNcBzZsJih1tsgBJpV7A1HDvVnys/Jm7
         KbzlkrA58XJyecL2k77ak200ogKoT/6PM12AE8H4I+S32Y5YSJms25+LVQ97ggY4a0EO
         VU6HDTbCCuGAB7Nblmyi9T6hEHJRI0GQ2aEHsbN2J7RQYKTOsGHx94UAwzc6NC35noo7
         /wTxfiBWSOGJuzbgrAJWtbgTh0DJj49Yw6HPQ/ZH+QpjYJqGU1Old8lIQlp+IfX8hS6S
         bi+Q==
X-Gm-Message-State: AOAM530VfG0xWGtLy8B4DWNyPdDZlO2YdDnfddD2XwZkTawmjRZKeH3q
        m2OK/SfXpH3zJiijQ3vQtEa49n4TvQrOM3AY7rbXR6Nz
X-Google-Smtp-Source: ABdhPJwaqooaHeYI3Ei2AJLL7qEWb7xIoJCjmCSqCokF1EOlEfFaGvUEn7ASQWCSlD+xo+ZTUL4ftAVF4owL9IoiVwM=
X-Received: by 2002:a81:9ace:0:b0:2e6:5069:5f9e with SMTP id
 r197-20020a819ace000000b002e650695f9emr5526810ywg.317.1647929091421; Mon, 21
 Mar 2022 23:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <CANFkB1ydGuwKRjusy3U0HCQo8E88XbZTh_UdPZ8wujt7P5KKnQ@mail.gmail.com>
 <CABBYNZLjV3PQ7Hm3PJZcTcs64aLzWLBNfooSYuZmSywv0RJG0g@mail.gmail.com>
In-Reply-To: <CABBYNZLjV3PQ7Hm3PJZcTcs64aLzWLBNfooSYuZmSywv0RJG0g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Mar 2022 23:04:40 -0700
Message-ID: <CABBYNZKu9fEUs9XEbOcq8fMRML4qKxsq3HpSed69LGZ6WSUDRQ@mail.gmail.com>
Subject: Re: GATT issue, possible bluez bug?
To:     Adam Pigg <adam@piggz.co.uk>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Adam,

On Mon, Mar 21, 2022 at 5:43 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Adam,
>
> On Mon, Mar 21, 2022 at 4:03 PM Adam Pigg <adam@piggz.co.uk> wrote:
> >
> > Hi
> >
> > A bit of background, I write a linux desktop/mobile app called
> > Amazfish which interfaces with several watches over BLE using their
> > GATT services.  To do this, I use the bluez dbus api (technically a
> > thin wrapper around it I wrote called qble
> > https://github.com/piggz/qble)
> >
> > All has been good so far, I support several generations of
> > Huami/Amazfit watches, as well as the open source Pinetime and
> > Bangle.js.  For the Amazfit watches, i have implementations for older
> > devies such as the Bip, and newer ones such as the GTS.
> >
> > Much of the reverse engineering comes from the Android Gadget Bridge
> > project, which supports many more devices.
> >
> > My community of users donated to buy me a newer device called a GTR2,
> > which, according to the GB devs uses the same protocol as the slightly
> > older GTS, and the packet captures I have from Android would support
> > this.
> >
> > But this is where my trouble starts with Bluez, my existing
> > implementation doesnt work at all.  Normally, after a connection, I
> > would wait for the ServicesResolved signal, which happens pretty fast
> > on all other devices, but on the GTR2, it takes about 30 seconds, by
> > which time, the watch has disconnected. (i get a disconnected signal
> > immediately after the ServicesResolved signal)
> >
> > To rule out my code, I have tried several things:
> > Gatttool
> > With gattool, i can connect, get the services, enable a notification,
> > write a value and get the expected results seemingly fine
> >
> > Python-gatt (using the bluez dbus api)
> > Im unable to iterate the services, like my app, it takes 30 seconds to
> > get the signal and then swiftly disconnects
> >
> > Gattlib (https://github.com/labapart/gattlib)
> > Gattlib is interesting as it appears to have "borrowed" much of its
> > code directly from bluez.  When built against the system bluez, if the
> > version is > 5.42, it will use the dbus api.  When I do this, again im
> > unable to list services on the watch.  However, if I edit the build to
> > force it to use its internal gatt implementation, which appears to be
> > the same one used by gatttool, then, it IS able to interrogate the
> > watch.
> >
> > I have attached 3 files
> > 1. test python program which should print services, and associated btmon
> > 2. btmon output while using gatttool
> > 3. btmon output running gattlib discover example
> >
> > Note, other than discovery, I havnt been able to get gattlib to
> > read/write/notify!
> >
> > It seems as though I may be triggering a bug in the bluez dbus api?
> > Can anyone suggest anything?
>
> What version are you using? I would first try with the latest to see
> if that something already fixed.

Btw, please use bluetoothctl instead of gatttool, gatttool may
actually conflict with the bluetoothd.

-- 
Luiz Augusto von Dentz
