Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBC8C54EBD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Jan 2023 08:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbjAIIk1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Jan 2023 03:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbjAIIkR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Jan 2023 03:40:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136AF14020
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jan 2023 00:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673253562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J1F19OootqSJo02/5nq51ccGj2gFAyI3aLRBvhLG6VY=;
        b=daP5KIUgzKAKdsShlblGcrp4VMQq674jgufrBxHBaXx9G++DeduXV2lyvOMa8AJHsxZ0DI
        hKzksUzNyQreF3/D1uuUjzjH7O/rPMJcP3CkjAoTJ1gjW3xg2jg5u3CIvqPVG7XL0IW0JH
        6Srt/cvwOZzA9Y0Xp5+I88GuojL8GvI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-LEHJ2jT8PQGLYxbkwRFYuw-1; Mon, 09 Jan 2023 03:39:18 -0500
X-MC-Unique: LEHJ2jT8PQGLYxbkwRFYuw-1
Received: by mail-ed1-f71.google.com with SMTP id r14-20020a05640251ce00b0047d67ab2019so4767693edd.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jan 2023 00:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1F19OootqSJo02/5nq51ccGj2gFAyI3aLRBvhLG6VY=;
        b=kN4vMJdw8itARPQie+dpRaR2yKyObEwQUbIJk/iwTrZMdVVMhLd3Mitj5IlRhf+/a4
         /ceZbT41r8P0UV2nDxBCIZFwymXlKmpxnS9dUsISSVS6Ei9ARPvWknglvje2spXelOFl
         zwm01H3lbxFRV8qCfk3g0dfzRm1rSDotZ8Ez0YFwvJ/yQ5++YKIEQg9VDIwOIjhdBlGO
         DsXIEw/KdHOIVnLygmsZJZtrJ6vwrtIj4uufV/qjyXNEkEiVTz02Bv46FjE9Ol9GlKU4
         E3Pd4S2ZOmpHc3l5O0yXI9YvQwzbjEQa5ma0q3Z9AnVAuEkTX43NL/mmDCNX4I9B2KHc
         +2lQ==
X-Gm-Message-State: AFqh2koJjpz7HPZTSL08/gQvLJPk7KHsSTnnJVbUPGad2eJBMHHumqLs
        /gwl3+aWO3uD0TpsIwV6NSDRjpXwRY6LDU4S+ngUqeLFpjc3Bo8WPQwleYOEtRDRcsX3Ic9Z+YV
        CXiMqFpJQXGuoi2Zhuy0QlGT29cAo
X-Received: by 2002:a05:6402:1cce:b0:472:1b3b:35f1 with SMTP id ds14-20020a0564021cce00b004721b3b35f1mr71459270edb.21.1673253557330;
        Mon, 09 Jan 2023 00:39:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvQHoqNFDBv5b+KRfQQPCDn8dbqFoFTle6LxtPDIi5nK+QwX7m5tX1huyDBGiicuZ1OooY54w==
X-Received: by 2002:a05:6402:1cce:b0:472:1b3b:35f1 with SMTP id ds14-20020a0564021cce00b004721b3b35f1mr71459255edb.21.1673253557102;
        Mon, 09 Jan 2023 00:39:17 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t18-20020aa7d712000000b0046b4e0fae75sm3413735edq.40.2023.01.09.00.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 00:39:16 -0800 (PST)
Message-ID: <101825b0-3d27-28dd-d70b-d4df1321b132@redhat.com>
Date:   Mon, 9 Jan 2023 09:39:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/8] HID: remove some unneeded exported symbols from hid.h
Content-Language: en-US, nl
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        David Rheinsberg <david.rheinsberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
References: <20221222-hid-v1-0-f4a6c35487a5@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221222-hid-v1-0-f4a6c35487a5@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 12/22/22 06:10, Thomas Weißschuh wrote:
> Small cleanup to get rid of exports of the lowlevel hid drivers and to make
> them const.

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans


> 
> To: Hans de Goede <hdegoede@redhat.com>
> To: Jiri Kosina <jikos@kernel.org>
> To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> To: David Rheinsberg <david.rheinsberg@gmail.com>
> To: Marcel Holtmann <marcel@holtmann.org>
> To: Johan Hedberg <johan.hedberg@gmail.com>
> To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Cc: linux-bluetooth@vger.kernel.org
> Cc: netdev@vger.kernel.org
> 
> ---
> Thomas Weißschuh (8):
>       HID: letsketch: Use hid_is_usb()
>       HID: usbhid: Make hid_is_usb() non-inline
>       HID: Remove unused function hid_is_using_ll_driver()
>       HID: Unexport struct usb_hid_driver
>       HID: Unexport struct uhid_hid_driver
>       HID: Unexport struct hidp_hid_driver
>       HID: Unexport struct i2c_hid_ll_driver
>       HID: Make lowlevel driver structs const
> 
>  drivers/hid/hid-letsketch.c        |  2 +-
>  drivers/hid/i2c-hid/i2c-hid-core.c |  3 +--
>  drivers/hid/uhid.c                 |  3 +--
>  drivers/hid/usbhid/hid-core.c      |  9 +++++++--
>  include/linux/hid.h                | 18 ++----------------
>  net/bluetooth/hidp/core.c          |  3 +--
>  6 files changed, 13 insertions(+), 25 deletions(-)
> ---
> base-commit: d264dd3bbbd16b56239e889023fbe49413a58eaf
> change-id: 20221222-hid-b9551f9fa236
> 
> Best regards,

