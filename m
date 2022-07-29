Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53433C00144
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jul 2022 21:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbiG2VgU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 17:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239326AbiG2VgS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 17:36:18 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D75D863F0
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 14:36:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id m20so705415ejx.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 14:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Prm2w9wicmT8MLF5Kddt6IXpuSCdCKlmftWqTaL5fuU=;
        b=E6PRYIfANjdzA+reC9iOxn0qrf3U9WLuqEuyB36RfUcTAayTobecO+cuZDq55e49Y9
         zlERAlpgKL73FxX6TYUh6Ow6epyUSUVJ4D/Fl4G30IigmifAKPLJziIJtukJmd9pWpdc
         qXXfiGZ/qJJB+M86lIV2QPeFxoJT97zvYImYxSRC/uTPY2dXlrtv6mg2qXoK2wMNHd+D
         XTWjPgDh50Zapjc7LywdrkvjzY9+YGuSc/C4HKiFCjqwP3rsjCDwZXlqzWJqmQ5he5lQ
         Io2wQ6ZQoetHSpFQN3rKi7F4b/azl7TmXTwCzVSo43pcYaHl4bbeLZMwq2ziTLnZsXax
         lT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Prm2w9wicmT8MLF5Kddt6IXpuSCdCKlmftWqTaL5fuU=;
        b=H0k+qzv/Xwgl60hjIQPUaaH/oN09zvyMn67C5OYWd40cJ5oJsE28fpCbCyhgKKZHfy
         x0X50Ou4PG7v+wsuLIDK8KKqSOaXzyhj8Eo8Ao/oCBPqw0j/YOlgCch4lTyeBfIDFJEE
         Z41XMQNxfgekdpnN3TIfm1jrmf5A4Ts49pQkJzHYbUlyIqfHm5jyhvyoULcw8/bTkSLT
         RwvWdddk+moJfMXmI4RlLDZn1zKl/MoP9EekhipdIq7+o/EiMDeTw4ddSktNfEwYdk9Y
         Y6HWS05jMYOx13H05PLKBeZS5GEQqjkL6I9QRbWjKXuJa7qXApLHFO7avQ52tDVgcIAX
         ra6g==
X-Gm-Message-State: AJIora9oSOrl74l3AFz0n3Vo/cooUzbUayBLw1z0f2przBsbOULkCJ0t
        OlMEec818EGT6qAa2ebf2c8UyDNM/quxWBF6TNA=
X-Google-Smtp-Source: AGRyM1tFNeLZZHbMzBunqLcqNUYRPiU61uIXSqtoxQUBTE823tn4VRuOq4M7k5LKGM7mTCFe5W9WyXcUXMGuO/NIdVk=
X-Received: by 2002:a17:907:7255:b0:72b:50b8:82d6 with SMTP id
 ds21-20020a170907725500b0072b50b882d6mr4406850ejc.677.1659130575751; Fri, 29
 Jul 2022 14:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR13MB57559335C977722C016544F1FE999@SJ0PR13MB5755.namprd13.prod.outlook.com>
In-Reply-To: <SJ0PR13MB57559335C977722C016544F1FE999@SJ0PR13MB5755.namprd13.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 29 Jul 2022 14:36:04 -0700
Message-ID: <CABBYNZKmoOK+RprcySXBN07k4M9i0apA7Obb0Z8Y+LSDbU=EkA@mail.gmail.com>
Subject: Re: GattCharacteristic1 WriteValue fails parameter validation in a
 GATT Client
To:     John Klug <John.Klug@multitech.com>
Cc:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John,

On Fri, Jul 29, 2022 at 1:48 PM John Klug <John.Klug@multitech.com> wrote:
>
> I see this is in the example-gatt-server, but not in a client.  Does anyone have this in an example?  Ideally written in C or C++ with libgio.
>
> My issue is that the parameter list is rejected when I use libgio:
>
> Error message: Method "WriteValue" with signature "aya{sv}" on interface "org.bluez.GattCharacteristic1" doesn't exist

This is for a GATT Server, application implements WriteValue, or for
GATT client, bluetoothd implementation of WriteValue? In case of the
later you need to check if you are generating the message with the
right signature, for instance this is how we construct the WriteValue
parameters on bluetoothctl:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/client/gatt.c#n714

> Turning on bluetoothd  -d, I am not seeing this error.  I see my service appear.  gdbus introspection shows the interface and the WriteValue method, but the call to WriteValue does not seem to generate any debug output in bluetoothd.
>
> I wrote this up in https://discourse.gnome.org/t/how-does-one-find-the-valid-signatures-in-d-bus-for-an-interface-method/10579/6
>
> I have tried both Ubuntu 20.04 on a PC, and on an ARM 32bit processor I have tried Linux 5.4.199 with BlueZ 5.64.
>
> How does one write to a gatt characteristic in a client if one is not to use WriteValue?

You can use AcquireWrite and then write directly to the fd received.

-- 
Luiz Augusto von Dentz
