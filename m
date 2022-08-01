Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF67C00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 16:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiHAQeD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 12:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiHAQeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 12:34:02 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF8D357F3
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 09:34:00 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso8584310otv.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Aug 2022 09:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9B2i4grwI/XhViJb4OfP8/IBJigM7VowAoOLHphbaKM=;
        b=rbJdai2OGyvs1+FMgPoiP7kHpAmB0eVNCtsseusm+BUvIowWZxRJm/SsShApJDhARQ
         EYMxYz008+1XwwPLmrStYoSI6/XIFisGRxqGjV/BQndigz4x2iXvP7Ff4gjA7o1HuaKl
         bLBaBvCM4jZfBt1D+zBlIOZ3QMJwYoWKDq5lMhjIkIjhAOOJHOLq77DQZ0phNn1qRYuP
         VTFatpV+CN8kNC2MCsGwwVYQBPOyRh4IBIFcBqqkIXuQrdLssVydzBqWdJFkfEJb0xNy
         87ycOrkhP16Gv/9gJPq7z9OuO3Jki1/Q21kgIjJYTUocOWmT3xsoioo20prBS6BfKF+E
         H9PQ==
X-Gm-Message-State: AJIora9N+J+60GOGynQXY3bSKLq/ZqiVFAt57gn8BD1JYh54sOxWFgnr
        OhaPSZmZwWhWsnsYvlyeKm7vVwtmrPvU6pJA3SRslTbNj28=
X-Google-Smtp-Source: AGRyM1vMVTBf5+s2JhFW4rPtm0nChn/GFAjV5A/moPJH9QJ9e018YX/Kd/T8vUB7yjf9/Vy3GJHSd2rHvZYXb61Bb8c=
X-Received: by 2002:a05:6830:140f:b0:61c:df39:3be3 with SMTP id
 v15-20020a056830140f00b0061cdf393be3mr6010921otp.285.1659371640288; Mon, 01
 Aug 2022 09:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR13MB57559335C977722C016544F1FE999@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <CABBYNZKmoOK+RprcySXBN07k4M9i0apA7Obb0Z8Y+LSDbU=EkA@mail.gmail.com> <SJ0PR13MB575566D9D75BB003E05B65E1FE9A9@SJ0PR13MB5755.namprd13.prod.outlook.com>
In-Reply-To: <SJ0PR13MB575566D9D75BB003E05B65E1FE9A9@SJ0PR13MB5755.namprd13.prod.outlook.com>
From:   Adam Pigg <adam@piggz.co.uk>
Date:   Mon, 1 Aug 2022 17:33:48 +0100
Message-ID: <CANFkB1wRz9Rmh32UqCHtzinSyWNy4-6Un4cxZbtJya6brNt9Pw@mail.gmail.com>
Subject: Re: GattCharacteristic1 WriteValue fails parameter validation in a
 GATT Client
To:     John Klug <John.Klug@multitech.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 1 Aug 2022 at 17:11, John Klug <John.Klug@multitech.com> wrote:
>
> Luiz Augusto von Dentz writes:
>
> >You can use AcquireWrite and then write directly to the fd received.
>
> I tried AcquireWrite as you suggest.  The result was "NotSupported".  I
> should mention that I have tried Nordic's NRF Connect on Android with
> the same GATT Server, and it is able to write to this
> UUID/characteristic just fine.
>
>
> Using "dbus-monitor --system" I see both read and write flags on my characteristic "service0021/char0046" with the correct UUID:
>
>
> signal time=1659368288.691466 sender=:1.3649 -> destination=(null
> destination) serial=968 path=/;
> interface=org.freedesktop.DBus.ObjectManager; member=InterfacesAdded
>
>    object path "/org/bluez/hci0/dev_CC_F9_57_89_8B_D8/service0021/char0046"
>    array [
>       dict entry(
>          string "org.freedesktop.DBus.Introspectable"
>          array [
>          ]
>       )
>       dict entry(
>          string "org.bluez.GattCharacteristic1"
>          array [
>             dict entry(
>                string "UUID"
>                variant                   string "edf50100-681e-4b92-999c-e16b3a8bc047"
>             )
>             dict entry(
>                string "Service"
>                variant                   object path "/org/bluez/hci0/dev_CC_F9_57_89_8B_D8/service0021"
>             )
>             dict entry(
>                string "Value"
>                variant                   array [
>                   ]
>             )
>             dict entry(
>                string "Flags"
>                variant                   array [
>                      string "read"
>                      string "write"
>                   ]
>             )
>          ]
>       )
>       dict entry(
>          string "org.freedesktop.DBus.Properties"
>          array [
>          ]
>       )
>    ]
>
>
>
> However, AcquireWrite replies with "Not Supported" which is the text I see in the error message in my program:
>
>
> method call time=1659368290.693590 sender=:1.3987 ->
> destination=org.bluez serial=10
> path=/org/bluez/hci0/dev_CC_F9_57_89_8B_D8/service0021/char0046;
> interface=org.bluez.GattCharacteristic1; member=AcquireWrite
>
>    array [
>    ]
> error time=1659368290.693700 sender=:1.3649 -> destination=:1.3987 error_name=org.bluez.Error.NotSupported reply_serial=10
>    string "Operation is not supported"
>
> Any ideas on where in the BlueZ source I could look for this?  Does anyone have an example of doing a GATT Write from a client?

I have a watch companion application called Amazfish which does a lot
of writing using the DBUS api.  I wrote a simple Qt style wrapper
around the dbus part which is at https://github.com/piggz/qble , and
the app is at https://github.com/piggz/harbour-amazfish . Perhaps
something in there will help you.

Adam
>
>
>
> John Klug
