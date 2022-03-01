Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF1BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 14:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiCAOjQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 09:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiCAOjE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 09:39:04 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Mar 2022 06:37:49 PST
Received: from nmtao101.oxsus-vadesecure.net (mta-101b.oxsus-vadesecure.net [51.81.61.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED047527C0
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 06:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; bh=Qwo7BwYsdTffdYSFMbyWKpcLA7l9NmnDD2upxE
 FsXwI=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1646145165;
 x=1646749965; b=mQGRhLvkvCpR+cbXHwFgVCaTrNfAqSIol+ralwfCjkKoTi9ePBTK2Q+
 OE8AU3W+WMfINci0WBtT3/LDlA5JFGdW8+XPLIdqXmFcfgUaXenTPfmUUZIUcfg6kEtJ+Vr
 p79cge7OInttGrp9acWLw7TeQuHnbL4Mt/nFaicy2GLG7iClvI1G7SAGAZAM37xAvsU6309
 NqNU0tj1NZNMEBhC0jgOTm0iPN/DeCP9Ge0D/hA3aawIi8j3AukCPIx92w5uwE1GUcSAYfo
 UXcJXPkK8pez2zueqWpUIZXjQxCFZn/sqIb9kjw9ilZjE4G3SjoOrHY3cEjD4Hz6/BoeU+o
 Xfw==
Received: from [192.168.1.152] ([104.185.76.86])
 by smtp.oxsus-vadesecure.net ESMTP oxsus1nmtao01p with ngmta
 id 8d81128d-16d8484e6bc1d85e; Tue, 01 Mar 2022 14:32:45 +0000
Message-ID: <72122fe6-8c8b-d26e-9c1d-75462052b503@mindspring.com>
Date:   Tue, 1 Mar 2022 09:32:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Battery1 vs. GATT reporting
Content-Language: en-US
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
References: <f46af838-8b28-79e6-5298-4458b44664ca@mindspring.com>
 <CAO271m=RNShfq+zRQjX=yK8NkUDwknr0mekJsCg_Rny3s0gUgA@mail.gmail.com>
From:   Ed Beroset <beroset@mindspring.com>
In-Reply-To: <CAO271m=RNShfq+zRQjX=yK8NkUDwknr0mekJsCg_Rny3s0gUgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2/28/22 13:31, Sonny Sasaka wrote:
> Hi Ed,
> 
> Your understanding is correct about the purpose of that flag. So I can
> confirm that (1) is true. For (2), I can confirm otherwise, since I am
> able to get both battery values from GATT API and Battery1 API. Here
> is my output:
> 
> ```
> // pair and connect to an LE device with battery service first (e.g an LE Mouse)
> // [bluetoothctl]# gatt.list-attributes
> // [bluetoothctl]# gatt.select-attribute
> /org/bluez/hci0/dev_C6_XX/service000e/char000f
> 
> // via GATT API
> [BluetoothMouse3600:/service000e/char000f]# gatt.read
> Attempting to read /org/bluez/hci0/dev_C6_XX/service000e/char000f
> [CHG] Attribute /org/bluez/hci0/dev_C6_XX/service000e/char000f Value:
>    4d                                               M
>    4d                                               M
> 
> // via Battery API
> [BluetoothMouse3600:/service000e/char000f]# info
> Device C6:XX (random)
>          Name: BluetoothMouse3600
>          Alias: BluetoothMouse3600
>          ...
>          Battery Percentage: 0x4e (78)
> [BluetoothMouse3600:/service000e/char000f]#
> ```
> 
> Could you try the same with bluetoothctl and share the output?

I'm not very sure of how to use bluetoothctl (no man page and I wasn't 
able to find a lot in my searches on the internet) but what I did was to 
pair and list the attributes using gatt.list-attributes, but I didn't 
find anything that I could identify as a battery service or battery 
attribute.  I looked for 180f or 2a19 and found neither:

[sturgeon]# gatt.list-attributes 43:43:A0:12:1F:AC
Primary Service (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0049
	00005071-0000-0000-0000-00a57e401d05
	Vendor specific
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0049/char004a
	00005001-0000-0000-0000-00a57e401d05
	Vendor specific
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0049/char004a/desc004c
	00002900-0000-1000-8000-00805f9b34fb
	Characteristic Extended Properties
Primary Service (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0041
	00006071-0000-0000-0000-00a57e401d05
	Vendor specific
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0041/char0045
	00006002-0000-0000-0000-00a57e401d05
	Vendor specific
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0041/char0045/desc0048
	00002900-0000-1000-8000-00805f9b34fb
	Characteristic Extended Properties
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0041/char0045/desc0047
	00002902-0000-1000-8000-00805f9b34fb
	Client Characteristic Configuration
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0041/char0042
	00006001-0000-0000-0000-00a57e401d05
	Vendor specific
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0041/char0042/desc0044
	00002900-0000-1000-8000-00805f9b34fb
	Characteristic Extended Properties
Primary Service (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029
	00007071-0000-0000-0000-00a57e401d05
	Vendor specific
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0039
	00007006-0000-0000-0000-00a57e401d05
	Vendor specific
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0039/desc003b
	00002900-0000-1000-8000-00805f9b34fb
	Characteristic Extended Properties
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0036
	00007005-0000-0000-0000-00a57e401d05
	Vendor specific
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0036/desc0038
	00002902-0000-1000-8000-00805f9b34fb
	Client Characteristic Configuration
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0033
	00007004-0000-0000-0000-00a57e401d05
	Vendor specific
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0033/desc0035
	00002900-0000-1000-8000-00805f9b34fb
	Characteristic Extended Properties
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0030
	00007003-0000-0000-0000-00a57e401d05
	Vendor specific
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char0030/desc0032
	00002900-0000-1000-8000-00805f9b34fb
	Characteristic Extended Properties
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char002d
	00007002-0000-0000-0000-00a57e401d05
	Vendor specific
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char002d/desc002f
	00002900-0000-1000-8000-00805f9b34fb
	Characteristic Extended Properties
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char002a
	00007001-0000-0000-0000-00a57e401d05
	Vendor specific
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0029/char002a/desc002c
	00002900-0000-1000-8000-00805f9b34fb
	Characteristic Extended Properties
Primary Service (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c
	00008071-0000-0000-0000-00a57e401d05
	Vendor specific
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char0026
	00008003-0000-0000-0000-00a57e401d05
	Vendor specific
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char0026/desc0028
	00002900-0000-1000-8000-00805f9b34fb
	Characteristic Extended Properties
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char0023
	00008004-0000-0000-0000-00a57e401d05
	Vendor specific
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char0023/desc0025
	00002900-0000-1000-8000-00805f9b34fb
	Characteristic Extended Properties
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char0020
	00008002-0000-0000-0000-00a57e401d05
	Vendor specific
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char0020/desc0022
	00002900-0000-1000-8000-00805f9b34fb
	Characteristic Extended Properties
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char001d
	00008001-0000-0000-0000-00a57e401d05
	Vendor specific
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service001c/char001d/desc001f
	00002900-0000-1000-8000-00805f9b34fb
	Characteristic Extended Properties
Primary Service (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0015
	00009071-0000-0000-0000-00a57e401d05
	Vendor specific
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0015/char0019
	00009002-0000-0000-0000-00a57e401d05
	Vendor specific
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0015/char0019/desc001b
	00002902-0000-1000-8000-00805f9b34fb
	Client Characteristic Configuration
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0015/char0016
	00009001-0000-0000-0000-00a57e401d05
	Vendor specific
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0015/char0016/desc0018
	00002900-0000-1000-8000-00805f9b34fb
	Characteristic Extended Properties
Primary Service (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0012
	0000180a-0000-1000-8000-00805f9b34fb
	Device Information
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0012/char0013
	00002a50-0000-1000-8000-00805f9b34fb
	PnP ID
Primary Service (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0008
	00001801-0000-1000-8000-00805f9b34fb
	Generic Attribute Profile
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0008/char000e
	00002b3a-0000-1000-8000-00805f9b34fb
	Server Supported Features
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0008/char000c
	00002b29-0000-1000-8000-00805f9b34fb
	Client Supported Features
Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0008/char0009
	00002a05-0000-1000-8000-00805f9b34fb
	Service Changed
Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_43_43_A0_12_1F_AC/service0008/char0009/desc000b
	00002902-0000-1000-8000-00805f9b34fb
	Client Characteristic Configuration

However when I try info, it correctly reports both the battery service 
and the battery percentage

	Battery Percentage: 0x2b (43)

So I'm not sure how to make the step from gatt.list-attributes to 
gatt.select-attributes.  Any guidance?

Ed

