Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5968CC19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 17:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiHKRP1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbiHKROx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 13:14:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0E525DF
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 09:59:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y13so34489588ejp.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=e1XhQuKgXhDIRbX6GYRatH3nNLVQwZ4FGZDOa6QbM6A=;
        b=MY7wTEdes+KKmocrSfpz3B8A43V5h10B899ERNO8pwXJ6y0DHVnUY5PbNNozOGLF7M
         4fRrAm7AyBI42zcfoH0wnAFVq6j0oahUIuQ6WMVICcSo2nI4V5TAA1Gk8IQdRVdh2p6m
         dwTqhNwI4PXKY+j2sPkuPfy7oBY10O0AXXnFvWpVVE7mruJj6r/hkV1NiCaPRSx/lJpS
         z2pfLYEKyzmz1VpbFv7FEj4s8ekhqCfEMWIkgO0M4G0miDZKRzTTBc1Gb2HTuaFPcz9k
         yLMigstMq/xwWi48EYDtPA9DUKc20wI+SNMTOBo/C2/z+pseo+GaxrcgHojC0eQsrVUh
         RwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=e1XhQuKgXhDIRbX6GYRatH3nNLVQwZ4FGZDOa6QbM6A=;
        b=cEQTOvlbWrajMCwrxgdDp6UryeK23io98oQ5Kpho0m3kP1uRvY6mzFsw8BmzTNUSmY
         eBCtGiQrLjzTWDN/J58BtO50EWcQHIGJZCQZsp1XT+IGjiAego4U1c0LzEUAeMND1deO
         3xc5Yu2olTdrhUwNgMjzbTf7FvGTTytJxf49zj0YJm/9mQOD1Gn4Kar6GZj6HSzQkYPI
         Cm7Ci0kTK/LT1fQk0S5lDBWzxTEWtKX/Fb5FVF39Ii0rysoTeeL7yvTgOuS5cdb6w/IK
         1WQty6CspdS4AHvYJP5vrOF3yzwmaeM3qpKRxeLai0Y0i/Bij8B0kiXNcnHZogvXEtkL
         /mTw==
X-Gm-Message-State: ACgBeo2+4YV7h47EjElM9nzIbwroeRxV6ERYKeiMYGgPAz3cMneOdAIG
        8pDMgJHPY9E+WNjqPLr1sl4akpQGSUPw4v2DCMajkoqJxNI=
X-Google-Smtp-Source: AA6agR7p3IKe3jfhy4rjN6E45RjLCoxyD+hc7IZ1NQuhWv9+1tAMPGfkRDrvTr6xzScuZpxa+oHZJ6AeeKDWtd7NzwM=
X-Received: by 2002:a17:906:29d:b0:6f0:18d8:7be0 with SMTP id
 29-20020a170906029d00b006f018d87be0mr24268669ejf.561.1660237194282; Thu, 11
 Aug 2022 09:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR13MB57558411E93695C02DCF7166FE649@SJ0PR13MB5755.namprd13.prod.outlook.com>
In-Reply-To: <SJ0PR13MB57558411E93695C02DCF7166FE649@SJ0PR13MB5755.namprd13.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 11 Aug 2022 09:59:42 -0700
Message-ID: <CABBYNZ+Vx8fwqdt1nZSaK6+Xs=X_Z1adBVX=5XAvYPajFLmpwQ@mail.gmail.com>
Subject: Re: Are Parameter types in GATT meaningless?
To:     John Klug <John.Klug@multitech.com>
Cc:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John,

On Thu, Aug 11, 2022 at 8:16 AM John Klug <John.Klug@multitech.com> wrote:
>
> The manufacturer of the GATT service gives the types of two different services:
>
> uint16
>
> uint8[32]
>
> Should uint16 be uint8[2]?
>
>
> I am using the libgio interface to D-BUS.  This uses GVariants.
> I am using the WriteValue method of GattCharacteristic1.
>
> For the uint16 case, I find that if I use:
>
> (aya{sv})
>
> then I do not get an immediate error from a bad parameter type list (signature).
>
> If I use:
>
> (qa{sv})
>
> Then I get the error:
>
> Error message: GDBus.Error:org.freedesktop.DBus.Error.UnknownMethod: Method "WriteValue" with signature "qa{sv}" on interface "org.bluez.GattCharacteristic1" doesn't exist
>
> For the uint8[32] case I use (aya{sv}) which is what I would expect, and I get no error from the WriteValue.
>
> Are byte arrays used in all cases with GATT from a D-Bus perspective?
>
> Here is the message that fails which was logged by dbus-monitor:
>
>   uint16 2
>    array [
>       dict entry(
>          string "type"
>          variant             string "request"
>       )
>    ]
> error time=1660229364.819130 sender=:1.0 -> destination=:1.197 error_name=org.freedesktop.DBus.Error.UnknownMethod reply_serial=16
>    string "Method "WriteValue" with signature "qa{sv}" on interface "org.bluez.GattCharacteristic1" doesn't exist
> "
>
> While this message/parameter list does not provoke an error:
>
>    array of bytes [
>       00 02
>    ]
>    array [
>       dict entry(
>          string "type"
>          variant             string "request"
>       )
>    ]

WriteValue always expects a byte array (ay) as the first argument
which follows ATT/GATT Write/WriteLong procedures so the attribute
specific data need to be encoded as byte array (little-endian), btw
this is documented in the D-Bus API and you can check how it done by
the likes of bluetoothctl.



--
Luiz Augusto von Dentz
