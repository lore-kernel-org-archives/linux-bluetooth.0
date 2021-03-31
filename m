Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6235DC433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 18:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3016C6101A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 18:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbhCaSh5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Mar 2021 14:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbhCaShh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Mar 2021 14:37:37 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D29C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 11:37:36 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n8so20918439oie.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WNdKPpEEgREo0/r3qCSRYVX1Las4vO7eN+eIF7C0v40=;
        b=LqMQErbq+Fz9dDU1bhqsIB1DaBRQnpehFomPIr9/lmzqF9zDeWmQPomrj33c51HdsN
         pvOhFzVFKRrondwJKny2+xi32DmVFnzTMrxpGK28yQNESstGTmH+GYMEVHncE07MjChN
         EsQfRpcupMU4xRL7pCmUyO6VUeOrhsasrRqxpZP6dl09wBsDom9msXRpZVgjToLSzW2K
         FbOmd5u+bXCzYdeC5h/M0JyQg0jC+gxmdDf5AodaybkQUAX36SA5qG9gTYgG32ojVWEK
         hDAqwTqma6gkK3KR/eapbqmCGnArZlJOyUkssUnJY7uqiHk44NYI/CklVstFRCp4PaXU
         XFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WNdKPpEEgREo0/r3qCSRYVX1Las4vO7eN+eIF7C0v40=;
        b=JFPuJ3kMzGrFM8Lam/t4ysatRIWabCMSXbn0gQ8bX9bRvsI/guM7Z/jzQ6B1HvIZCm
         sTU3l9/22aCrbcEDdfy2xI21BcywwaAM8SO9QApVKeT5O39msY1I+6Y/WnL+Xh29UzXn
         jK2J+xwripIe2ogaDW6Uaf1f/28V222gU449CZuyLkX8wx7SfbpUt4Djh9IQnI7QCI/5
         mMFX6J5a6dfNU7rfuvHa/G4LCBCBDZbWHilKxc1JYtMpKeX9D7o1nYKLC3yIunPyb9ms
         UJrwjHQRO+1yL0rDpRn5sBvZ03Jn16h4gdX9KhTcUn9SuaJsgzVtmHfjtLYaEtQbqGQj
         tVdw==
X-Gm-Message-State: AOAM533tCyPSy3zZoELcD5iB2YXTQ072XyHesqAIHYL5idRTWIBC0A3A
        YxSmPguLzdp/f3k9eiN4GdOAnDCAKzWIvvgZ72CeBXEb/2qUKA==
X-Google-Smtp-Source: ABdhPJyqzE2pGZPJGrLjI8Wt5g0Mi5Mhdy3FNJz3Wwe3SP+kr6/tbJVtR6T5CHhKIdM4QRJlTLgdcTC36iF36Pu51tQ=
X-Received: by 2002:aca:c4c7:: with SMTP id u190mr3167581oif.161.1617215856228;
 Wed, 31 Mar 2021 11:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <e2fb3695-5596-18c7-0bf1-fc701ba780f8@posteo.de>
In-Reply-To: <e2fb3695-5596-18c7-0bf1-fc701ba780f8@posteo.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 31 Mar 2021 11:37:25 -0700
Message-ID: <CABBYNZJkscA_h7j3rWB-AiDrDa7=XjwFBxx3zOhw50hXSSSH-Q@mail.gmail.com>
Subject: Re: cannot get a2dp profile enabled
To:     "mailinglisten@posteo.de" <mailinglisten@posteo.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Mar 31, 2021 at 7:55 AM mailinglisten@posteo.de
<mailinglisten@posteo.de> wrote:
>
> Hello,
>
> I hope this is the place to ask for user questions, bluez.org offers no
> other mailing list....

People start using github for this type of problems:

https://github.com/bluez/bluez/issues

> I have a Jabra headphone/headset device and pulseaudio can=C2=B4t activat=
e
> the a2dp_sink, I want to be sure, A2DP is properly enabled in bluez.
>
> bluetoothctl info MAC-OF-HEADPHONE says:
>
> UUID: Advanced Audio Distribu.. (0000110d-0000-1000-8000-00805f9b34fb)
>
> Thus, the device supports a2dp.
>
> At the bottom I put output from "show CONTROLLER-MAC".
>
> I tried
>
> register-service 0000110d-0000-1000-8000-00805f9b34fb
>
> to no avail, still no a2dp_sink in pulseaudio.
>
> How can I ensure using bluetoothctl that a2dp is really enabled in bluez?
>
> I=C2=B4m not sure, if I deal with a bluetooth or pulseaudio issue, I want=
 to
> exclude a misconfigured bt device.
>
> I=C2=B4m using bluez 5.48 and kernel 5.11.3.
>
> Thank you very much in advance!
>
>
>
> This is the output from bluetoothctl show CONTROLLER-MAC:
>
>
> Controller 00:F4:8D:C9:40:5E (public)
>         Name: foobar
>         Alias: onboard
>         Class: 0x007c010c
>         Powered: yes
>         Discoverable: no
>         Pairable: yes
>         UUID: Message Notification Se..
> (00001133-0000-1000-8000-00805f9b34fb)
>         UUID: A/V Remote Control
> (0000110e-0000-1000-8000-00805f9b34fb)
>         UUID: OBEX Object Push
> (00001105-0000-1000-8000-00805f9b34fb)
>         UUID: Message Access Server
> (00001132-0000-1000-8000-00805f9b34fb)
>         UUID: IrMC Sync
> (00001104-0000-1000-8000-00805f9b34fb)
>         UUID: PnP Information
> (00001200-0000-1000-8000-00805f9b34fb)
>         UUID: Vendor specific
> (00005005-0000-1000-8000-0002ee000001)
>         UUID: Headset AG
> (00001112-0000-1000-8000-00805f9b34fb)
>         UUID: A/V Remote Control Target
> (0000110c-0000-1000-8000-00805f9b34fb)
>         UUID: Headset
> (00001108-0000-1000-8000-00805f9b34fb)
>         UUID: Phonebook Access Server
> (0000112f-0000-1000-8000-00805f9b34fb)
>         UUID: Audio Sink
> (0000110b-0000-1000-8000-00805f9b34fb)
>         UUID: Generic Access Profile
> (00001800-0000-1000-8000-00805f9b34fb)
>         UUID: Generic Attribute Profile
> (00001801-0000-1000-8000-00805f9b34fb)
>         UUID: Handsfree Audio Gateway
> (0000111f-0000-1000-8000-00805f9b34fb)
>         UUID: Audio Source
> (0000110a-0000-1000-8000-00805f9b34fb)
>         UUID: OBEX File Transfer
> (00001106-0000-1000-8000-00805f9b34fb)
>         UUID: Handsfree
> (0000111e-0000-1000-8000-00805f9b34fb)
>         Modalias: usb:v1D6Bp0246d0530
>         Discovering: no

It seems you have all the profiles necessary, perhaps there is some
interoperability problem, try checking bluetoothd and btmon logs.

--=20
Luiz Augusto von Dentz
