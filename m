Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7812C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 22:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiHKWAR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 18:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiHKWAP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 18:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68939A5
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660255210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3JHI90ddFAY9rwCXY8u7ccK2VfYkPxy8GVOK0E00A/Y=;
        b=RINojJs3bHuFxGY+cQ2kfwYW8tjYdTG56owqhbKDjO0QwKdZSX6odiD4td9WmkdOSnJgU8
        CIDjJlas1xvnx0G2P8zTX4EPegeIqFHn/90Ora8p/3Bvcwn4kobG7YCBJxHiFGZ5ixTdBO
        MkOEclwIg/pk+myweaFjLi18/M6QpI8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-L2Jct4LrORSwTCjES6cyxA-1; Thu, 11 Aug 2022 18:00:08 -0400
X-MC-Unique: L2Jct4LrORSwTCjES6cyxA-1
Received: by mail-ed1-f69.google.com with SMTP id b13-20020a056402350d00b0043dfc84c533so11511227edd.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 15:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3JHI90ddFAY9rwCXY8u7ccK2VfYkPxy8GVOK0E00A/Y=;
        b=hJXP1R1/BnQ3XeIV2s431SGkpsUJifWe2mf9zK8VmyP92C3k1ecZuhGF/iTuTXD07u
         X+ZKbNZIoMpX/sYRE2vXN4cE1Rf6kUz37YciezER0R1EJ6xfATVMz6kWXTQ7HDmjXwpI
         8ZPhZ0PWT3Abf1IJAaHWZN/3l7GWcZGIyNIPh/SEItmu5sckwsLW3i/PjKtFAG2sJmFy
         H8fm6vdAj6IipqJ/kpOIrYXBuPyP4bi+GAXFeM+YJnqbDN68BUsV1bgLEPKUAT9wb7LY
         ibxGofjkEfjhA2AvZlDP9Q+AejDskG3vG1EoZ1SqzlLG37Ib2OuxVu17yKTs1KyPsiC3
         qLmg==
X-Gm-Message-State: ACgBeo36PrVGXvFS/tio7IK9qmIXZyxON95TTz7XT4tP434MvkwKBqWR
        jAYJCvxkLd0o+2oozb4f+Aa0ussLUujaJy/r5M2QVmPujAZlFnQqUnG2zci7aiJHBf5+sck+rI0
        w9/E0SdeiXCDotNGhQACtEiFL2zgP
X-Received: by 2002:a17:906:9c82:b0:6df:c5f0:d456 with SMTP id fj2-20020a1709069c8200b006dfc5f0d456mr730445ejc.287.1660255207345;
        Thu, 11 Aug 2022 15:00:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5kawM7o6JO01IK/EP1DGtFydqeWd6YiF9cpbtJ1/r8CEYYnE0AifoF0y94EAP5GAe0/FV4bg==
X-Received: by 2002:a17:906:9c82:b0:6df:c5f0:d456 with SMTP id fj2-20020a1709069c8200b006dfc5f0d456mr730438ejc.287.1660255207164;
        Thu, 11 Aug 2022 15:00:07 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ds13-20020a170907724d00b0071cef8bafc3sm131403ejc.1.2022.08.11.15.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 15:00:06 -0700 (PDT)
Message-ID: <285798a1-82df-398b-ce29-3e841c2e90cd@redhat.com>
Date:   Fri, 12 Aug 2022 00:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] Bluetooth: hci_event: Fix vendor (unknown) opcode
 status handling
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
References: <20220811120103.47669-1-hdegoede@redhat.com>
 <CABBYNZL2TjDFCx3EFnYRhe2JCSh3YAgBPiNAHpk1Ya+e3sDtxQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CABBYNZL2TjDFCx3EFnYRhe2JCSh3YAgBPiNAHpk1Ya+e3sDtxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 8/11/22 22:27, Luiz Augusto von Dentz wrote:
> Hi Hans,
> 
> On Thu, Aug 11, 2022 at 5:01 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Commit c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to
>> handle Command Complete") was (presumably) meant to only refactor things
>> without any functional changes.
>>
>> But it does have one undesirable side-effect, before *status would always
>> be set to skb->data[0] and it might be overridden by some of the opcode
>> specific handling. While now it always set by the opcode specific handlers.
>> This means that if the opcode is not known *status does not get set any
>> more at all!
>>
>> This behavior change has broken bluetooth support for BCM4343A0 HCIs,
>> the hci_bcm.c code tries to configure UART attached HCIs at a higher
>> baudraute using vendor specific opcodes. The BCM4343A0 does not
>> support this and this used to simply fail:
>>
>> [   25.646442] Bluetooth: hci0: BCM: failed to write clock (-56)
>> [   25.646481] Bluetooth: hci0: Failed to set baudrate
>>
>> After which things would continue with the initial baudraute. But now
>> that hci_cmd_complete_evt() no longer sets status for unknown opcodes
>> *status is left at 0. This causes the hci_bcm.c code to think the baudraute
>> has been changed on the HCI side and to also adjust the UART baudrate,
>> after which communication with the HCI is broken, leading to:
>>
>> [   28.579042] Bluetooth: hci0: command 0x0c03 tx timeout
>> [   36.961601] Bluetooth: hci0: BCM: Reset failed (-110)
>>
>> And non working bluetooth. Fix this by restoring the previous
>> default "*status = skb->data[0]" handling for unknown opcodes.
>>
>> Fixes: c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to handle Command Complete")
>> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> - Add a comment that byte 0 containing the status is not guaranteed
>>   by the Bluetooth specification
>> ---
>>  net/bluetooth/hci_event.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index af17dfb20e01..eb43afd5549a 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -3996,6 +3996,26 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
>>                         break;
>>                 }
>>         }
>> +       if (i == ARRAY_SIZE(hci_cc_table)) {
>> +               /* Unknown opcode, assume byte 0 contains the status, so
>> +                * that e.g. __hci_cmd_sync() properly returns errors
>> +                * for vendor specific commands send by HCI drivers.
>> +                *
>> +                * Note that the specification does not specify that
>> +                * byte 0 is the status:
>> +                *
>> +                * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
>> +                * page 2189:
>> +                *
>> +                * Return_Parameters:
>> +                * Size: Depends on command
>> +                *
>> +                * For now using byte 0 seems to work fine, but in the future
>> +                * this may need to be updated so that drivers using vendor
>> +                * commands can specify their own completion handler.
>> +                */
>> +               *status = skb->data[0];
>> +       }
>>
>>         handle_cmd_cnt_and_timer(hdev, ev->ncmd);
>>
>> --
>> 2.37.1
> 
> Not sure why CI bot didn't respond to the list but this patch was
> already applied yesterday:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=84a0a27ea39a9caed74d80a78666a91a9ea5e12b

Great, thank you.

Regards,

Hans

