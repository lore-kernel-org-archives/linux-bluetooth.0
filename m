Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF165C43217
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Feb 2022 13:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiBUNWc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Feb 2022 08:22:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358973AbiBUNWb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Feb 2022 08:22:31 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5453620F7D
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Feb 2022 05:22:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j22so980902wrb.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Feb 2022 05:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=KlPTgSK6szS9lcxY/xVKhSDXprVxiwHj841AYvFn2CQ=;
        b=nrqN0IBbS4RLc+xPqRNjGqPJF87i0sAQ3kPBo/0ifOVJkp+2DCVUyst7LWCIzH7dl+
         m96X7vVVQJ8ck4EFaCXyZeBJiQUtjgPOqHJLHXVvOcOV6NTLVc8tA22qotEtbDZ/77vG
         XuW7WZmvBgVHRY9DIDTtdQOqGiYh7vV5OsPNpXXomsuR3b6yGkSLl53piuX7EVEtrLtL
         c7e6Ot6MtCdKBj26gqvnyOi3RK3Ge4RViZ5A277D/Agj2KN/gDBsjuxdq9WVBQlkqoa3
         ZMW2gGbp5XynVagNz97OGJEEqxtmNygTwPeT5gCnnrgJAXZE1qh93KNSmSCgILI/Cdsb
         nG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=KlPTgSK6szS9lcxY/xVKhSDXprVxiwHj841AYvFn2CQ=;
        b=kdMWLNOztoXIARlYEDthO3iOW9+JwwIk5b/Z6EeJby2AB5R1MwzvfoeubN/xW1jv7B
         BOFVlxE3EMm3knyUMXd2Fs9wibXAClt5gsmyaWYS3Ue6IlEc9tzU73AJSNh/Iog/SNwk
         sWs7Pa1F78bzxsJfnJNwlQCjPQJp0CIg34dKWXMfjXR3ut+pmbgA5IZi6BL4llPYi4dO
         RCHPaIy6CP2jvgbnJ8xMIf/JCoBhcsmGKRAQPdMk2HoSYJI5ELuWqkacMSjnbbdPJv3f
         1n8plKwA7IzSe98GN4+E/wL7icYdDbcdiZ0rXwV32m/Bzwdr6ljAQhmTcMb+6iYdZKFQ
         ih/g==
X-Gm-Message-State: AOAM532+6bkeHHC2XXWL20vZmkfEZDV4st5nLiLWIaZULDnoAIp6r8NR
        vzeSowrSmAjo9GfpGygpGe8=
X-Google-Smtp-Source: ABdhPJwmOZ3H0nnQYg7bxKQI4IZ/aavYAV8IWVrpLfnLEIU42q0c5i64xam8Kv+x/SHOt7wrmc0ZdQ==
X-Received: by 2002:adf:ec07:0:b0:1e3:1ef2:5ff6 with SMTP id x7-20020adfec07000000b001e31ef25ff6mr15764502wrn.255.1645449725717;
        Mon, 21 Feb 2022 05:22:05 -0800 (PST)
Received: from [192.168.1.10] (4e691f2a.skybroadband.com. [78.105.31.42])
        by smtp.googlemail.com with ESMTPSA id b10sm57076719wrd.8.2022.02.21.05.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 05:22:05 -0800 (PST)
Message-ID: <9ad505e1-7b59-7ebf-378b-23a6c0e25802@googlemail.com>
Date:   Mon, 21 Feb 2022 13:22:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Chris Clayton <chris2553@googlemail.com>
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
To:     Chris Murphy <lists@colorremedies.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluetooth <linux-bluetooth@vger.kernel.org>
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtTdiPNkV1_b478_LkG11TMOPEdDGHTjf5LfZJpwWrK+bg@mail.gmail.com>
 <CAJCQCtTNk25u6sm_Xqt8qzf7mM5kmOrnXyD6pT1GKJ5z5-Kqbw@mail.gmail.com>
 <CAJCQCtRYKbTQ16eUq2qODZ=dE=HB6pZpLNswdqMbiWw+DBE9KQ@mail.gmail.com>
 <CABBYNZKfy-ntFhbx0TStNwFiwxCF4sPVaHS4wDbef0shb=pawg@mail.gmail.com>
 <CAJCQCtRiTQ1BTEHugxhS-zmXFG4qi4WLxsRyZsG9-_Q0isM+7Q@mail.gmail.com>
 <CAJCQCtS35JeABLDBaNpfgxjq+ZJ9rZgwtRnSYLNm8tMwtdYGMw@mail.gmail.com>
 <CABBYNZKTSe83iP4tm36we4cpAbeGUbEw9frZD1wCM9yo1zry5w@mail.gmail.com>
 <CAJCQCtTpHQe2co3fLNs5csKQchmwH=3YwQOvFnuc2nhjRseVnw@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CAJCQCtTpHQe2co3fLNs5csKQchmwH=3YwQOvFnuc2nhjRseVnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Sorry folks, clicked Send instead of Save Draft in my earlier message.

Anyway...

On 18/02/2022 03:49, Chris Murphy wrote:
> On Thu, Feb 17, 2022 at 5:15 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Chris,
>>
>> On Thu, Feb 17, 2022 at 3:36 PM Chris Murphy <lists@colorremedies.com> wrote:
>>>
>>> OK I started over, and for now keeping the reporting constrained to
>>> the hardware I personally have on hand.
>>>
>>> Hardware:
>>> Lenovo Thinkpad X1 Carbon Gen 7
>>> Bus 001 Device 004: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
>>> Jefferson Peak (JfP)
>>> Sony 1000XM3 headset
>>> bluez-5.63-3.fc36.x86_64
>>>
>>> kernel 5.17.0-rc4
>>> * remove the paired headset with bluetoothctl
>>> * reset the headset so it's not longer paired either
>>> * put the headset in pairing mode
>>> * GNOME Settings Bluetooth panel sees -> LE_WH-1000XM3, Not Setup
>>> * click on Not Setup and nothing happens
>>
>> Well from the logs it doesn't seem the GNOME Setting is trying to do
>> anything, have you tried bluetoothctl> connect <address>
> 
> `bluetoothctl scan on`  does see the device
> $ bluetoothctl pair 38:18:4C:24:2D:1D
> Device 38:18:4C:24:2D:1D not available
> $ bluetoothctl connect 38:18:4C:24:2D:1D
> Device 38:18:4C:24:2D:1D not available
> 
> $ journalctl -b -o short-monotonic --no-hostname | grep -i blue
> https://drive.google.com/file/d/1x9EDvDx6XUowyRy2056n6uW-4PLx5KRb/view?usp=sharing
> 
> 

I too am experiencing the problem that already-paired devices fail to connect to my laptop when running a 5.17 kernel.

Extract from dmesg shows:
[    3.825684] Bluetooth: hci0: Waiting for firmware download to complete
[    3.825910] Bluetooth: hci0: Firmware loaded in 1551910 usecs
[    3.825910] Bluetooth: hci0: unexpected event 0xff length: 5 > 0
[    3.825936] Bluetooth: hci0: Waiting for device to boot
[    3.839948] Bluetooth: hci0: unexpected event 0xff length: 7 > 0
[    3.839973] Bluetooth: hci0: Device booted in 13715 usecs
[    3.840205] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-0-4.ddc
[    3.843002] Bluetooth: hci0: Applying Intel DDC parameters completed
[    3.843926] Bluetooth: hci0: Firmware revision 0.4 build 125 week 46 2021

Extract from lshw shows:
                   description: Bluetooth wireless interface
                   product: AX201 Bluetooth
                   vendor: Intel Corp.
                   physical id: e
                   bus info: usb@1:e
                   version: 0.02
                   capabilities: bluetooth usb-2.01
                   configuration: driver=btusb maxpower=100mA speed=12Mbit/s

I don't know whether this will help, but I've found that the problem only occurs when boot from cold (i.e power on the
laptop. If I then do a warm reboot, my bluetooh devices connect successfully. The significant difference may be that on
a cold start, the firmware needs to loaded whereas on a warm reboot I see:

[    2.000989] Bluetooth: hci0: Firmware already loaded

Hope this helps. I am happy to test any fixes or provide additional diagnostics, but I'm not subscribed so please cc me.

Chris

> 
> --
> Chris Murphy
> 
