Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2BBC433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 18:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3FF64F44
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 18:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhCQSP2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbhCQSPV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Mar 2021 14:15:21 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8216BC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Mar 2021 11:15:21 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u6so35420028oic.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Mar 2021 11:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LnMWPuBEDtn8VC3SG0BhkMt+o44BPIjDmTZv0X4sxIk=;
        b=ipNQSHUN0D60Q3JF6SNEqsGYn/v4jMRw9WdVLGUwfMrXoln4+H/YQ/ncHGRVTjXt07
         6K6xC4GdWa4vQuc/f5cNBa6dUVEQBV19fLGY5iJgYHBWW24+9ONBitG6wZYlEe/lL6Ql
         5PJGzMKpDTYvdatAs3JvwUjpVEUv59O4s9OZvCebmtOwsu1fbX1R5QzM72g5Zin1JLuo
         waAuZuGnr38g5GZUhWSV6zdu4jSIXUvUecuePGTuoTe+yezCt8OHzMTyenGXZRQjCss7
         y5E/ubAcV0exv42+VVWYXlrP757waMslsSYF/8EmzW/bG1W8KuayFqesUNeznJ7dYTrF
         vTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnMWPuBEDtn8VC3SG0BhkMt+o44BPIjDmTZv0X4sxIk=;
        b=Vug/3ZA8i3uSGq5l7mwr5TispCM0PFrFHdSmV560WByuJp3eX7TsnKShFIonta2MR+
         jKeGK+wUtVvXrlO2IlagUw5CidZhPc+LOQC5uMWSSbBvCX09GhfmBZYg9tpcUT4TfDEi
         s0gWhJKm8cvMJcpdaLLIvHUYwSiiiCiIwDslqLjjzMCoJVbFY8iJoec0PRxRphAeHmRW
         wk/f6mURELcl61IiSxhW09am7Tce2F3GgP/VZEYia4HBvtk1wXNYTdE7BrxjZ0thZe22
         TfXQJublTM8VEaNtyjvZyOsXOTiV2yPKC0LG8bV+/cKxvaCsKIino3Uvt7OSeH0GTkoj
         DoiQ==
X-Gm-Message-State: AOAM531t8aw4mCFYrR50nWBT/qT1H7ulbEEP3s2LA11ChpEgAr9N9Mw8
        9xe78g6Er/E16ocpyzTJ7fZjFRR5MdxOPbLHAcc=
X-Google-Smtp-Source: ABdhPJyTUQCp2djw8Xirm+zTfHU+rChiJh2d+DgWt2WBAIBDNvuWlTKg0GGYNQVK5rPg/8sMkK6/NmxyrIK8UGuP2LI=
X-Received: by 2002:a05:6808:1290:: with SMTP id a16mr29024oiw.161.1616004920862;
 Wed, 17 Mar 2021 11:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAC9s0NZrReFB-6_JwHFqJtLwqSuYGzKbZMvDeKYzh+Jof9iUjg@mail.gmail.com>
In-Reply-To: <CAC9s0NZrReFB-6_JwHFqJtLwqSuYGzKbZMvDeKYzh+Jof9iUjg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 Mar 2021 11:15:09 -0700
Message-ID: <CABBYNZJJ5Jymk=51E-aeWE4VyXGvXsgSjftYRJY47_tNzzJWHA@mail.gmail.com>
Subject: Re: Have to delete "/var/lib/bluetooth" folder in order to get all
 service characteristics available
To:     Kenny Bian <kennybian@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kenny,

On Wed, Mar 17, 2021 at 12:40 AM Kenny Bian <kennybian@gmail.com> wrote:
>
> In order to keep the pairing information, we carry over the
> "/var/lib/bluetooth" folder from an older build to the new build in
> the Linux system when doing firmware upgrade. This way, our end user
> doesn't have to choose "Forget This Device" each time after the
> firmware upgrade. Otherwise, our end user has to "Forget This Device"
> and re-pair because the pairing info can't be found in the Linux
> device. We also set the GATT cache as "no" in
> "/etc/bluetooth/main.conf". Then the mobile app won't crash when there
> is any "service changed" such as adding notification to some existing
> characteristics.

But the cache only applies to client, service changed is for the
server not sure why your mobile would be crashing with that, or is it
disabling ServiceChanged indications with that? If there is no
indication that would explain why the services are not updated since
the mobile OS won't notice any changes on the database.

> We organize our characteristics under the services. There are 10
> services on the Linux device. Each service has 5 to 10
> characteristics. However, we found a new problem recently. The problem
> is: the first 8 services are fine. But the last one or two services
> only have the service UUID listed in nRF or our mobile app. There are
> no characteristics showing up under these one or two services. This
> caused our mobile app can't read the characteristics data under these
> problematic services. I checked the nRF. It's the same thing. nRF only
> shows the last one or two services with the service UUIDs. There are
> no characteristics listed under those 2 services.
>
> In order to fix this issue, we have to do these(let's call it "The Steps"):
> - Remove the "/var/lib/bluetooth" folder from the Linux system
> - Restart our BlueZ based service in Python in the Linux system
> - Choose "Forget This Device" on the iPhone. After this operation, the
> "/var/lib/bluetooth" is generated in the Linux device.
> - Connect to the device from our mobile app or from nRF. We can see
> all of the 10 services in the list. Each characteristic under the
> service can be seen.
> - We are able to read the data by using our mobile app or by using nRF
>
> I compared the files in the "/var/lib/bluetooth" folder. As we
> disabled the GATT cache, there is no "cache" folder. There are only 2
> files in the folder. Here is the folder structure:
> /var/lib/bluetooth:
>     |
>     +----00:11:22:33:44:55/
>         |
>         +----6C:92:11:87:11:25/
>             |
>             +----attributes
>             +----info
>
> I kept one copy of the files after the firmware upgrade. I also kept a
> copy of the files after the folder was re-generated. I compared the
> file "attributes" and "info". For the attributes, they are the same.
> For the "info" file, there are only 3 differences:
> [General]
> Name=PhoneX
> . . .
>
> [SlaveLongTermKey]
> Key=252256E19E26F3ED9FD0B99B7B5B0193
> . . .
>
> [LinkKey]
> Key=1B593296571E2C48CF6952E60395E304
> . . .
>
>
> I don't think these differences could cause the issue. But the fact
> is, if I delete the "/var/lib/bluetooth" folder and go thru "The
> Steps" above, the problem will be gone. All of the services will have
> their characteristics showing up in nRF. The data can be read from the
> characteristics. This means the folder "/var/lib/bluetooth" is related
> to the issue. But I don't know why.
>
> Here is also another thing. I subscribed to the "PropertiesChanged"
> signal. In the callback function "properties_changed", I print out the
> "changed". Here is the code to subscribe the "PropertiesChanged":
>
>         bus.add_signal_receiver(
>             properties_changed,
>             dbus_interface="org.freedesktop.DBus.Properties",
>             signal_name="PropertiesChanged",
>             arg0="org.bluez.Device1",
>             path_keyword="path",
>         )
>
> If the folder "/var/lib/bluetooth" is removed and go thru "The Steps",
> I saw the log like this:
> dbus.Dictionary({dbus.String('UUIDs'):
> dbus.Array([dbus.String('00000000-deca-fade-deca-deafdecacafe'),
> dbus.String('00001000-0000-1000-8000-00805f9b34fb'),
> dbus.String('0000110a-0000-1000-8000-00805f9b34fb'),
> dbus.String('0000110c-0000-1000-8000-00805f9b34fb'),
> dbus.String('0000110e-0000-1000-8000-00805f9b34fb'),
> dbus.String('00001116-0000-1000-8000-00805f9b34fb'),
> dbus.String('0000111f-0000-1000-8000-00805f9b34fb'),
> dbus.String('0000112f-0000-1000-8000-00805f9b34fb'),
> dbus.String('00001132-0000-1000-8000-00805f9b34fb'),
> dbus.String('00001200-0000-1000-8000-00805f9b34fb'),
> dbus.String('00001800-0000-1000-8000-00805f9b34fb'),
> dbus.String('00001801-0000-1000-8000-00805f9b34fb'),
> dbus.String('00001805-0000-1000-8000-00805f9b34fb'),
> dbus.String('0000180a-0000-1000-8000-00805f9b34fb'),
> dbus.String('0000180f-0000-1000-8000-00805f9b34fb'),
> dbus.String('02030302-1d19-415f-86f2-22a2106a0a77'),
> dbus.String('7905f431-b5ce-4e99-a40f-4b1e122d00d0'),
> dbus.String('89d3502b-0f36-433a-8ef4-c502ad55f8dc'),
> dbus.String('9fa480e0-4967-4542-9390-d343dc5d04ae'),
> dbus.String('d0611e78-bbb4-4591-a5f8-487910ae4366')],
> signature=dbus.Signature('s'), variant_level=1),
> dbus.String('ServicesResolved'): dbus.Boolean(True, variant_level=1)},
> signature=dbus.Signature('sv'))
>
> If I check the log after the firmware is upgraded without deleting the
> "/var/lib/bluetooth" folder, the log looks like this:
> dbus.Dictionary({dbus.String('ServicesResolved'): dbus.Boolean(True,
> variant_level=1)}, signature=dbus.Signature('sv'))
>
> As we can see, they are different. Is it something to do with D-Bus?
>
> We understand that if we don't carry over the "/var/lib/bluetooth"
> folder, then there is no this issue. But our end user will have to
> choose "Forget This Device" each time after the firmware is upgraded.
> Otherwise, the end user can't connect to the Linux device because the
> pairing info can't be found. Is there a way to fix this issue? Namely,
> is there a way to keep the pairing info and also avoid this issue?

This sounds like ServiceChanged is not being properly propagated when
you do the firmware update, do you have ServiceChanged entry on the
storage:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/settings-storage.txt#n321

Is there any indication on btmon when you first connect after doing
the firmware update?

-- 
Luiz Augusto von Dentz
