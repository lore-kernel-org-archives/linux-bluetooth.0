Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7666C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 15:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiCAPof (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 10:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiCAPof (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 10:44:35 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752604E3A9
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 07:43:53 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s14so22603785edw.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Mar 2022 07:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2xcusGa5B/lPWKP2kC9x6mQn1ZKLt2hgYYezw4HTlI=;
        b=fRKHhSWp3dDv0mXmKzt4Z9rM8/u9POHm0yl7j81wC26K5qsynktKEdpvd5+qbOieEs
         g/ZCdLYLbZEa5AGnjwCoHo/t9R/8IEe5I8O/0wyQtXUcFxMRKYO2WbDYm3Unz2MXPlpj
         9/ot7Xpa7U4XYqpptQwtr8++GwxZOZi6huF10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2xcusGa5B/lPWKP2kC9x6mQn1ZKLt2hgYYezw4HTlI=;
        b=QfI7PboqkWgDqgjQ7W4BkzMIxW6Fr1IiWpoML7UIGZa/uhC19deOaFLPKne2eqeGBC
         IZ4xPncEmLMXVFZ4IjmFnBWEIhC+Tr15+AeBsQc+uCb2jBhPP6WzpPYICjOTj9IFAmOG
         b9jSRZumQHJziL8JRINmgK7Esai9fvaPlWnonG/HUcxi+KB+Ip+XK5RuXWVYCqyYebts
         1eFsDleg9vPeJzlXHUnhQtb+iDWdc9DtLd/FoEDxfurFfJZrKDhcizT7kWg+hUzSnl/i
         1eMr78DUuXTn8DoZwYKa50gCNuvF0RkMG8Y4ZHpQVjNHRWjKCDynU4uSm1huQb4+pO2X
         +jZQ==
X-Gm-Message-State: AOAM5305P4jddr+m3KTV/WVO2cC9+AgNC+y7MNSQWiL/dFvXzuPf2CQZ
        TiZ4cH4gnoDhtJxR4q7n6V9K/lFJfjKaHg==
X-Google-Smtp-Source: ABdhPJzr9vbUsw6BNzJq/AGzHE/zyDP7K0lpSMsABeAgVIlJqL/e8GzzFCp4M0XS/ca1iwESzuGRww==
X-Received: by 2002:a05:6402:5191:b0:40f:b9e0:4d1b with SMTP id q17-20020a056402519100b0040fb9e04d1bmr25258416edd.149.1646149431369;
        Tue, 01 Mar 2022 07:43:51 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id b2-20020a17090630c200b006d58f94acecsm5375724ejb.210.2022.03.01.07.43.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 07:43:50 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id s1so22511377edd.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Mar 2022 07:43:50 -0800 (PST)
X-Received: by 2002:a50:9d47:0:b0:40f:9d3d:97b6 with SMTP id
 j7-20020a509d47000000b0040f9d3d97b6mr25623418edk.392.1646149430100; Tue, 01
 Mar 2022 07:43:50 -0800 (PST)
MIME-Version: 1.0
References: <f46af838-8b28-79e6-5298-4458b44664ca@mindspring.com>
 <CAO271m=RNShfq+zRQjX=yK8NkUDwknr0mekJsCg_Rny3s0gUgA@mail.gmail.com> <72122fe6-8c8b-d26e-9c1d-75462052b503@mindspring.com>
In-Reply-To: <72122fe6-8c8b-d26e-9c1d-75462052b503@mindspring.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 1 Mar 2022 07:43:38 -0800
X-Gmail-Original-Message-ID: <CAO271m=-nxu238MKCtM-Kc1T88UOO4V2qyon0zF3ifVcThBsPA@mail.gmail.com>
Message-ID: <CAO271m=-nxu238MKCtM-Kc1T88UOO4V2qyon0zF3ifVcThBsPA@mail.gmail.com>
Subject: Re: Battery1 vs. GATT reporting
To:     Ed Beroset <beroset@mindspring.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ed,

What I do is call `gatt.select-attribute` on the characteristic called
"Battery Level", but it is not shown in your case. So maybe this is
the bug that you are encountering. What is the exact version of your
BlueZ (commit sha if possible)? Could you also try tip of tree to see
if this is already fixed?

On Tue, Mar 1, 2022 at 6:32 AM Ed Beroset <beroset@mindspring.com> wrote:
>
> On 2/28/22 13:31, Sonny Sasaka wrote:
> > Hi Ed,
> >
> > Your understanding is correct about the purpose of that flag. So I can
> > confirm that (1) is true. For (2), I can confirm otherwise, since I am
> > able to get both battery values from GATT API and Battery1 API. Here
> > is my output:
> >
> > ```
> > // pair and connect to an LE device with battery service first (e.g an LE Mouse)
> > // [bluetoothctl]# gatt.list-attributes
> > // [bluetoothctl]# gatt.select-attribute
> > /org/bluez/hci0/dev_C6_XX/service000e/char000f
> >
> > // via GATT API
> > [BluetoothMouse3600:/service000e/char000f]# gatt.read
> > Attempting to read /org/bluez/hci0/dev_C6_XX/service000e/char000f
> > [CHG] Attribute /org/bluez/hci0/dev_C6_XX/service000e/char000f Value:
> >    4d                                               M
> >    4d                                               M
> >
> > // via Battery API
> > [BluetoothMouse3600:/service000e/char000f]# info
> > Device C6:XX (random)
> >          Name: BluetoothMouse3600
> >          Alias: BluetoothMouse3600
> >          ...
> >          Battery Percentage: 0x4e (78)
> > [BluetoothMouse3600:/service000e/char000f]#
> > ```
> >
> > Could you try the same with bluetoothctl and share the output?
>
> I'm not very sure of how to use bluetoothctl (no man page and I wasn't
> able to find a lot in my searches on the internet) but what I did was to
> pair and list the attributes using gatt.list-attributes, but I didn't
> find anything that I could identify as a battery service or battery
> attribute.  I looked for 180f or 2a19 and found neither:
>
>  [sturgeon] # gatt.list-attributes 43:43:A0:12:1F:AC
> Primary Service (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0049
>         00005071-0000-0000-0000-00a57e401d05
>         Vendor specific
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0049/char004a
>         00005001-0000-0000-0000-00a57e401d05
>         Vendor specific
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0049/char004a/desc004c
>         00002900-0000-1000-8000-00805f9b34fb
>         Characteristic Extended Properties
> Primary Service (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0041
>         00006071-0000-0000-0000-00a57e401d05
>         Vendor specific
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0041/char0045
>         00006002-0000-0000-0000-00a57e401d05
>         Vendor specific
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0041/char0045/desc0048
>         00002900-0000-1000-8000-00805f9b34fb
>         Characteristic Extended Properties
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0041/char0045/desc0047
>         00002902-0000-1000-8000-00805f9b34fb
>         Client Characteristic Configuration
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0041/char0042
>         00006001-0000-0000-0000-00a57e401d05
>         Vendor specific
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0041/char0042/desc0044
>         00002900-0000-1000-8000-00805f9b34fb
>         Characteristic Extended Properties
> Primary Service (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029
>         00007071-0000-0000-0000-00a57e401d05
>         Vendor specific
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0039
>         00007006-0000-0000-0000-00a57e401d05
>         Vendor specific
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0039/desc003b
>         00002900-0000-1000-8000-00805f9b34fb
>         Characteristic Extended Properties
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0036
>         00007005-0000-0000-0000-00a57e401d05
>         Vendor specific
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0036/desc0038
>         00002902-0000-1000-8000-00805f9b34fb
>         Client Characteristic Configuration
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0033
>         00007004-0000-0000-0000-00a57e401d05
>         Vendor specific
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0033/desc0035
>         00002900-0000-1000-8000-00805f9b34fb
>         Characteristic Extended Properties
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0030
>         00007003-0000-0000-0000-00a57e401d05
>         Vendor specific
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0030/desc0032
>         00002900-0000-1000-8000-00805f9b34fb
>         Characteristic Extended Properties
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char002d
>         00007002-0000-0000-0000-00a57e401d05
>         Vendor specific
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char002d/desc002f
>         00002900-0000-1000-8000-00805f9b34fb
>         Characteristic Extended Properties
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char002a
>         00007001-0000-0000-0000-00a57e401d05
>         Vendor specific
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char002a/desc002c
>         00002900-0000-1000-8000-00805f9b34fb
>         Characteristic Extended Properties
> Primary Service (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c
>         00008071-0000-0000-0000-00a57e401d05
>         Vendor specific
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char0026
>         00008003-0000-0000-0000-00a57e401d05
>         Vendor specific
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char0026/desc0028
>         00002900-0000-1000-8000-00805f9b34fb
>         Characteristic Extended Properties
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char0023
>         00008004-0000-0000-0000-00a57e401d05
>         Vendor specific
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char0023/desc0025
>         00002900-0000-1000-8000-00805f9b34fb
>         Characteristic Extended Properties
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char0020
>         00008002-0000-0000-0000-00a57e401d05
>         Vendor specific
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char0020/desc0022
>         00002900-0000-1000-8000-00805f9b34fb
>         Characteristic Extended Properties
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char001d
>         00008001-0000-0000-0000-00a57e401d05
>         Vendor specific
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char001d/desc001f
>         00002900-0000-1000-8000-00805f9b34fb
>         Characteristic Extended Properties
> Primary Service (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0015
>         00009071-0000-0000-0000-00a57e401d05
>         Vendor specific
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0015/char0019
>         00009002-0000-0000-0000-00a57e401d05
>         Vendor specific
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0015/char0019/desc001b
>         00002902-0000-1000-8000-00805f9b34fb
>         Client Characteristic Configuration
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0015/char0016
>         00009001-0000-0000-0000-00a57e401d05
>         Vendor specific
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0015/char0016/desc0018
>         00002900-0000-1000-8000-00805f9b34fb
>         Characteristic Extended Properties
> Primary Service (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0012
>         0000180a-0000-1000-8000-00805f9b34fb
>         Device Information
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0012/char0013
>         00002a50-0000-1000-8000-00805f9b34fb
>         PnP ID
> Primary Service (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0008
>         00001801-0000-1000-8000-00805f9b34fb
>         Generic Attribute Profile
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0008/char000e
>         00002b3a-0000-1000-8000-00805f9b34fb
>         Server Supported Features
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0008/char000c
>         00002b29-0000-1000-8000-00805f9b34fb
>         Client Supported Features
> Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0008/char0009
>         00002a05-0000-1000-8000-00805f9b34fb
>         Service Changed
> Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0008/char0009/desc000b
>         00002902-0000-1000-8000-00805f9b34fb
>         Client Characteristic Configuration
>
> However when I try info, it correctly reports both the battery service
> and the battery percentage
>
>         Battery Percentage: 0x2b (43)
>
> So I'm not sure how to make the step from gatt.list-attributes to
> gatt.select-attributes.  Any guidance?
>
> Ed
>
