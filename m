Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED52C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 11:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbiHKLwd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 07:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbiHKLwT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 07:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83AB995E77
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660218737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BHGYpPVOToJJW83BwikwQkKAUWoo3Emiqyb5NZjYFwU=;
        b=WbJVkwFz5rhQ6HGDwzc8ToCsHVlooQrs43OI1xUOFzGkwvfKdthe2lS1MXsCoDrRzWp0xR
        FwQpRGjffA3IIw5WesU8/Zn2S0OK2HHo7FhZc1KyUxBlZrpTM1KO07K3TExUG15SRUa/bP
        6sjFHL9T3gG7ihQQWeRtop7shfoh4e4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-WovKcL9qM8O3erjNvztQ6w-1; Thu, 11 Aug 2022 07:52:14 -0400
X-MC-Unique: WovKcL9qM8O3erjNvztQ6w-1
Received: by mail-ej1-f72.google.com with SMTP id gb41-20020a170907962900b00730961131a7so5399701ejc.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 04:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BHGYpPVOToJJW83BwikwQkKAUWoo3Emiqyb5NZjYFwU=;
        b=XYSUezFrtSqSETzqLoGLqxXHbbObSTdmyDbxc0vAlMOyz8/hgUfN+/BxnmOrW6orJS
         Z6LpAi7B/a/j0vZViCaFR590HMCA/HshRG8qYFCtfdBC/4cgTnNKKminCI137v+lBsQ6
         A6cINg74C5YKDSw9QKYYHwIhKlYdbgebdwE4zrkzkbTRiFyUwfSh2pNkqwiSp+bwVH1y
         KrGUrtTFoXp7bNPvdftYjt99fU38kk4RDwlfx5HnKed7v4SiP7Dim0zgadsc2uqcnrZp
         esV+feLVxLuB8R+roAFGw+OIlFHhD+Z7eUSHePWHgclwI8LzKSknBurjFu9KTbwZrvaR
         IEsg==
X-Gm-Message-State: ACgBeo13YP9UQk/sfDbtXFAequqrNwFLwPgnIMylaq0eRIcDDm0nQEGv
        kTtBdB+11j0WMa87zVCuY9upodk9Gh2UfWkr89SXko9MRP1UJStjmki+Nm5I8kitotO2N7Jzx7L
        Hgc4iApRh3LcACCC40b4JOl5LvNZ0
X-Received: by 2002:a17:906:d7a9:b0:731:2189:4f58 with SMTP id pk9-20020a170906d7a900b0073121894f58mr18015573ejb.471.1660218732815;
        Thu, 11 Aug 2022 04:52:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7pW+wfNPjyic5s9NfSTYkUOmWkOIvVTV3xaAsa6JoVtqiVDU1xphRC7xUwvAPKSlmSPuUKvw==
X-Received: by 2002:a17:906:d7a9:b0:731:2189:4f58 with SMTP id pk9-20020a170906d7a900b0073121894f58mr18015557ejb.471.1660218732575;
        Thu, 11 Aug 2022 04:52:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id cf6-20020a0564020b8600b00442d5054a51sm1870300edb.87.2022.08.11.04.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 04:52:11 -0700 (PDT)
Message-ID: <065a9f83-e99f-1540-528a-83eb0203e206@redhat.com>
Date:   Thu, 11 Aug 2022 13:52:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] Bluetooth: hci_event: Fix vendor (unknown) opcode status
 handling
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
References: <20220807205740.777363-1-hdegoede@redhat.com>
 <CABBYNZLwKJcEoaHzihV92LhvPAAOB7p8vfX9rc=8Z_U61Zjt2A@mail.gmail.com>
 <CABBYNZ+kUVT5K_+jiGn6eU=yOde+3Fmq6KHPmyawgbZMCseh1A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CABBYNZ+kUVT5K_+jiGn6eU=yOde+3Fmq6KHPmyawgbZMCseh1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 8/11/22 00:26, Luiz Augusto von Dentz wrote:
> Hi Hans,
> 
> On Mon, Aug 8, 2022 at 12:58 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Hans,
>>
>> On Sun, Aug 7, 2022 at 1:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Commit c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to
>>> handle Command Complete") was (presumably) meant to only refactor things
>>> without any functional changes.
>>>
>>> But it does have one undesirable side-effect, before *status would always
>>> be set to skb->data[0] and it might be overridden by some of the opcode
>>> specific handling. While now it always set by the opcode specific handlers.
>>> This means that if the opcode is not known *status does not get set any
>>> more at all!
>>>
>>> This behavior change has broken bluetooth support for BCM4343A0 HCIs,
>>> the hci_bcm.c code tries to configure UART attached HCIs at a higher
>>> baudraute using vendor specific opcodes. The BCM4343A0 does not
>>> support this and this used to simply fail:
>>>
>>> [   25.646442] Bluetooth: hci0: BCM: failed to write clock (-56)
>>> [   25.646481] Bluetooth: hci0: Failed to set baudrate
>>>
>>> After which things would continue with the initial baudraute. But now
>>> that hci_cmd_complete_evt() no longer sets status for unknown opcodes
>>> *status is left at 0. This causes the hci_bcm.c code to think the baudraute
>>> has been changed on the HCI side and to also adjust the UART baudrate,
>>> after which communication with the HCI is broken, leading to:
>>>
>>> [   28.579042] Bluetooth: hci0: command 0x0c03 tx timeout
>>> [   36.961601] Bluetooth: hci0: BCM: Reset failed (-110)
>>>
>>> And non working bluetooth. Fix this by restoring the previous
>>> default "*status = skb->data[0]" handling for unknown opcodes.
>>>
>>> Fixes: c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to handle Command Complete")
>>> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>  net/bluetooth/hci_event.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>> index af17dfb20e01..fda31d558ded 100644
>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -3996,6 +3996,13 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
>>>                         break;
>>>                 }
>>>         }
>>> +       if (i == ARRAY_SIZE(hci_cc_table)) {
>>> +               /* Unknown opcode, assume byte 0 contains the status, so
>>> +                * that e.g. __hci_cmd_sync() properly returns errors
>>> +                * for vendor specific commands send by HCI drivers.
>>> +                */
>>> +               *status = skb->data[0];
>>> +       }
>>
>> The format of return parameters in command is not defined by the spec:
>>
>> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
>> page 2189:
>>
>> Return_Parameters:
>> Size: Depends on command
>>
>> This is the return parameter(s) for the command specified in the
>> Command_Opcode event parameter. See each command’s definition for
>> the list of return parameters associated with that command.
>>
>> So assuming the status is the first by is not quite right, although
>> for the standard ones that seems to be valid, I think the best way to
>> resolve this would have been to check if it a vendor command and then
>> have the driver handle it or perhaps have some means for the driver to
>> register it vendor_cc_table, we can perhaps have this as a workaround
>> for now and only really change how we parse the cc for vendor commands
>> if a vendor decide not to have a status as first parameter but Id
>> probably leave a comment that quoting the spec that reminds us this
>> code may need changing.
> 
> Are you still planning to send updates for this, I consider this quite
> urgent given that it can break support with some vendors.

Right, sorry for being a bit slow. I will prepare + email a version 2
adding a comment that byte 0 being the status is not guaranteed with
vendor commands right away.

Regards,

Hans



> 
>>>         handle_cmd_cnt_and_timer(hdev, ev->ncmd);
>>>
>>> --
>>> 2.37.1
>>>
>>
>>
>> --
>> Luiz Augusto von Dentz
> 
> 
> 

