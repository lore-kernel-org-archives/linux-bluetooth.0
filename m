Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5281FC43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jul 2022 18:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiGLSdQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Jul 2022 14:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiGLSdP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Jul 2022 14:33:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED29C84F9
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jul 2022 11:33:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r9so7381003lfp.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jul 2022 11:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dup+uwY3XFwHXrwD/dYtv/4PGIz7Zfa98eTRBqsQ5Qw=;
        b=N1uk0PVINDYsGsMWswXbcHvPAoJQuzAAD7XuNo3aBULPvz9h1S6Jvtjm8up3y13nsY
         3tpmMH9CpSA+Ycwh3sn9TdcWf5lekftGAAH/pfiCuReCgNeuq8lQjEkN74meebc16bJ7
         PT/s7RCEZbBfJ0igUIT4E0/vvlScUik3LhXKplgZ+ovepasck0/4eownX2SvXcTq2zvA
         hLMUW0pzHUdlP6IioyO4h/BikaXNZOiqmzPpLhk0C0KzuaD7kSTCn39VK/NHarJ0weg+
         akG4yNBtBoNYFk5HAFgdFg7tK5/zdaG5l7QLeANO4+8tTji5UpSpzoV/nmdBrSaO4W3d
         zXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dup+uwY3XFwHXrwD/dYtv/4PGIz7Zfa98eTRBqsQ5Qw=;
        b=npdshfTEZV0bUZkn4prylcCcVRrjacbF0LCjxItjr1LZck8oui2WeiAcyIT5FugBHB
         mhx6vfWDW7+ddnyuCKlCH5KXrkzclNPhgcJiDOb4GH6Ui3JUunm8nQXtacEcHttlPaCF
         WRffv3FuRLbNhj6KThiezEmamU27/yIczDX9CR1EJAR3/OVDj2oh9FG8w9oUuEfxeK5P
         3SwUYPYC02aZdvt4ftygBnCHBxT3GDu5I/dP27ONc8qmXdOxZs9AYKyomGwv9pnrdfpx
         l7L4i4ides5M5b2Pl4j3sV1P5UQ4ZCL0/flcOA00XFBYSaVWFboBYsIaau+qdkEFE2cY
         117w==
X-Gm-Message-State: AJIora/wir+vpVSPHCvYLpDS+YcQtUPagjSeD+5HmsT8bG4MKoZN6dNO
        +XqKUUkh+OE5DLuuTCGL9MWTyKO0v9UsbfH+vJY=
X-Google-Smtp-Source: AGRyM1tn8PA0i5G39gLNUNi/Rc7rOXr0x6JVNCQDdz8yY5EseCzbSDVHOF8iZtm4/dXWTOwMxNKxaPvNtwXlNbDXcRk=
X-Received: by 2002:a05:6512:1048:b0:489:ddda:d2a3 with SMTP id
 c8-20020a056512104800b00489dddad2a3mr7602572lfb.57.1657650791966; Tue, 12 Jul
 2022 11:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR13MB5755315F09CF8B49984DE12FFE869@SJ0PR13MB5755.namprd13.prod.outlook.com>
In-Reply-To: <SJ0PR13MB5755315F09CF8B49984DE12FFE869@SJ0PR13MB5755.namprd13.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Jul 2022 11:33:00 -0700
Message-ID: <CABBYNZ+ei7=TXw_gP8keZaCyz5igABLxYxUnmBhAe35wAXoR0g@mail.gmail.com>
Subject: Re: How does bluetoothctl work from the command line with gatt?
To:     John Klug <John.Klug@multitech.com>
Cc:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John,

On Tue, Jul 12, 2022 at 11:09 AM John Klug <John.Klug@multitech.com> wrote:
>
> How does one do the following in bluetoothctl from a script and command line that one would do in gatttool as follows:
>
> # gatttool -i hci0 -b $bd_addr -u 2a29 --char-read
> handle: 0x0017  value: 54 65 78 61 73 20 49 6e 73 74 72 75 6d 65 6e 74 73
> # gatttool -i hci0 -b $bd_addr --char-desc | grep -i aa22
> handle = 0x002f, uuid = f000aa22-0451-4000-b000-000000000000
> # gatttool -i hci0 -b $bd_addr -a 0x002f --char-write-req -n 01
> Characteristic value was written successfully
>
>
> For instance:
>
> # bluetoothctl connect CC:78:AB:7E:87:07
> Attempting to connect to CC:78:AB:7E:87:07
> Connection successful
> # bluetoothctl gatt.select-attribute 2a29
> # bluetoothctl gatt.read
> No attribute selected
> # bluetoothctl gatt.select-attribute f000aa22-0451-4000-b000-000000000000
> # bluetoothctl gatt.acquire-write
> No attribute selected
> # bluetoothctl gatt.write 0x01
> No attribute selected

You will probably need to wait for the daemon to resolve the services
which will then export the attributes as D-Bus objects that can be
accessed by bluetoothctl, note that some services are handled
internally by bluetoothd (e.g. GAP and GATT services) which perhaps is
the case of 0x2a29, although we don't currently have any D-Bus
property for Manufacturer like we do for name
(org.bluez.Device1.Name).

-- 
Luiz Augusto von Dentz
