Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74877C2BA17
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4604820672
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NtxHMgcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDFSYa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:24:30 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35469 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgDFSYa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 14:24:30 -0400
Received: by mail-ua1-f65.google.com with SMTP id a6so319877uao.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8ZERAQIsOeA9+9QhHsLGZtE1muSv1tW/0JrDnxBwKc=;
        b=NtxHMgcsQR3IpYSCNs0eGRlDajwaIa9MPyo5xfw8TTp2uwImZt2f5NKuEwL4JsQhqT
         ftBLT3yE0bek7vrsxCAakpHaOsi7vY4ncebV6/YNKNu7Hk0dyvqX26q6KJ06/RjMy8As
         7R2161bUdJyJ0+wTHaSvyEU5OcBs4/OGpn4DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8ZERAQIsOeA9+9QhHsLGZtE1muSv1tW/0JrDnxBwKc=;
        b=EaWqnVssOSipI4DMaHhkq6ESHnFiQmre8E0jHhZE+faOE1yr5/7GkuKPmWBv6dEJj+
         UlRH+LlLSNxmxcV2VEFp5T4e//DC5diLbkHQxpF7nEacXdissIouf/IX9Y3tOa7wUjxw
         jvoBO1awyylnj5xbAD3xihLeRHwtuwCoY/GCmQ1NbVA5VYMVqYy2gvC+4YabLUFrvBIE
         ix29Phe1nTdKNvE+ffUj+VSpbqjxPBJG2fElVkB/rde7kVbjdvKA2bEJNesG34T7LT+v
         9GnUT+/WZMI1xRNlR1q2Kyk5wNCArV2rLYDqidU4BBWCywSWUZ6hJ1hSliyB81v0PcnJ
         zqHQ==
X-Gm-Message-State: AGi0PuZGlMn0OgN+1ctXWjCE8gTj+KVaRDxyZf6VMeQwoaXr3UGuB8o+
        ddTouqnH8YlFGZdA0Xmm+yT/wGuNR0LvuwUQcDp1d1Gh
X-Google-Smtp-Source: APiQypL5k70RJ/j1Hcbt7SbPnG2fmGhZNhsphsGW71+sTZqH9pJnCjGePYd14uiyWY24ZlAchYqLMZCpiXBB/H7/swk=
X-Received: by 2002:ab0:911:: with SMTP id w17mr710975uag.60.1586197467055;
 Mon, 06 Apr 2020 11:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200406180331.891822-1-marcel@holtmann.org>
In-Reply-To: <20200406180331.891822-1-marcel@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 6 Apr 2020 11:24:15 -0700
Message-ID: <CANFp7mXe3QtkKL8+TgTp=jwvpydABhDkiXks=3h4+op20rWhGQ@mail.gmail.com>
Subject: Re: [PATCH] doc: Add commands and event for handling device flags
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Apr 6, 2020 at 11:03 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> ---
>  doc/mgmt-api.txt | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 39f23c456080..ac5b6c97d64a 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3138,6 +3138,74 @@ Read Security Information Command
>                                 Invalid Index
>
>
> +Get Device Flags Command
> +========================
> +
> +       Command Code:           0x0049
> +       Controller Index:       <controller id>
> +       Command Parameters:     Address (6 Octets)
> +                               Address_Type (1 Octet)
> +       Return Parameters:      Address (6 Octets)
> +                               Address_Type (1 Octet)
> +                               Supported_Flags (4 Octets)
> +                               Current_Flags (4 Octets)
> +
> +       This command is used to retrieve additional flags and settings
> +       for devices that are added via Add Device command.
> +
> +       Possible values for the Address_Type parameter:
> +               0       BR/EDR
> +               1       LE Public
> +               2       LE Random
> +
> +       The Flags parameters are a bitmask with currently the following
> +       available bits:
> +
> +               0       Remote Wakeup enabled
> +
> +       This command generates a Command Complete event on success
> +       or a Command Status event on failure.
> +
> +        Possible errors:       Invalid Parameters
> +                               Invalid Index
> +
> +

Get device flags looks good to me.

> +Set Device Flags Command
> +========================
> +
> +       Command Code:           0x004a
> +       Controller Index:       <controller id>
> +       Command Parameters:     Address (6 Octets)
> +                               Address_Type (1 Octet)
> +                               Current_Flags (4 Octets)

I would prefer to use a mask and value rather than current_flags here.

> +       Return Parameters:      Address (6 Octets)
> +                               Address_Type (1 Octet)

Prefer to also return an updated_mask and current_flags. This
simplifies completion for userspace. Otherwise, we would need to keep
a "pending flags" value on the device structure.

> +
> +       This command is used to configure additional flags and settings
> +       for devices that are added via Add Device command.
> +
> +       Possible values for the Address_Type parameter:
> +               0       BR/EDR
> +               1       LE Public
> +               2       LE Random
> +
> +       The list of supported Flags can be retrieved via the Get Device
> +       Flags or Device Flags Changed command. Selecting unsupported flags
> +       will result in an Invalid Parameter error;
> +
> +       Refer to the Get Device Flags command for a detailed description
> +       of the Flags parameters.
> +
> +       This command can be used when the controller is not powered and
> +       all settings will be programmed once powered.
> +
> +       This command generates a Command Complete event on success
> +       or a Command Status event on failure.
> +
> +        Possible errors:       Invalid Parameters
> +                               Invalid Index
> +
> +
>  Command Complete Event
>  ======================
>
> @@ -4004,6 +4072,7 @@ Extended Controller Information Changed Event
>         The event will only be sent to management sockets other than the
>         one through which the change was triggered.
>
> +
>  PHY Configuration Changed Event
>  ===============================
>
> @@ -4020,3 +4089,30 @@ PHY Configuration Changed Event
>         one through which the change was triggered.
>
>         Refer Get PHY Configuration command for PHYs parameter.
> +
> +
> +Device Flags Changed Event
> +==========================
> +
> +       Event Code:             0x0027
> +       Controller Index:       <controller id>
> +       Event Parameters:       Address (6 Octets)
> +                               Address_Type (1 Octet)
> +                               Supported_Flags (4 Octets)
> +                               Current_Flags (4 Octets)
> +
> +       This event indicates that the device flags have been changed via
> +       the Set Device Flags command or that a new device has been added
> +       via the Add Device command. In the latter case it is send right
> +       after the Device Added event.
> +
> +       Possible values for the Address_Type parameter:
> +               0       BR/EDR
> +               1       LE Public
> +               2       LE Random
> +
> +       The event will only be sent to management sockets other than the
> +       one through which the command was sent.
> +
> +       In case this event is triggered by Add Device then it is sent to
> +       all management sockets.

Event looks good to me.

> --
> 2.25.1
>
