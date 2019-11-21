Return-Path: <SRS0=kdk/=ZN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A5FC432C3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 12:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668392089D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 12:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diH+k44C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKUMaz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:30:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34161 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfKUMay (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Nov 2019 07:30:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so4226738wrr.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2019 04:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hzWya/D1G+UBQfujLNp6jYAwkB/20hRFBZdQduv4QdA=;
        b=diH+k44CV40RzGIyFAGEJCZ/73LnjZg3DXCUq2dRX4gv1GwtxLRB74fAomjPnHBPLV
         6fSyi3x0fOurHszL9G/PnQq4MtmxcxF0/+XMWI4Jt6mFFu+QjikAou3Ed2lhtnwzaecE
         odgLK5dcOMiGwHZhan+dUPhKbm190p9McRTspbJ+8j3oeyk/G6Dngj/GKhJV117hn9v0
         fq2MrEcPvuFRRSiW/XTcCrUl+BgJWCyN9tB3HA86OAc8TMgfy4o5MkGqywpAUJyT1BLy
         B8Q/20bm4SQ9Skqsb00cN1qZ0oA8LtWrAE25x4Z6JPBKi5+imhRL/xqYgsxdHEIPd5jO
         xZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hzWya/D1G+UBQfujLNp6jYAwkB/20hRFBZdQduv4QdA=;
        b=VlnTn8a/boLg9hP5uIf0BRQSyNthbZnDBlz1pq5JaSElGMaVe8zAwkHMAEk4HQhNEE
         R3bINyjj1Di6LdD2bk31FTdujPzvUx15Jqaz+1jWvafvJlHzQytzzSuyj5RVKUJD+rAI
         ytiNJvFg4zcoUuHT5AhwHPsojdFPppbCf5h+rJkIcepSrpXGrq5/L07K7ARAE/V5DIL+
         /Gq9lQ270LZR5VI64yIftNvY57bv9U1A3zh7s3r9tEuTb1UjOecBR0O/DEueOR+4WsS/
         TuZiJRQQxTHYpYt3C8BURvGcZ4RRo56y3I7BdKxX/e/KKPDoGceifbQhcwlovnzR7IwV
         TQZQ==
X-Gm-Message-State: APjAAAX8VvnnTZ39zXJyyrPY615e53+oZAxK9ceh9jRkvcPAiIDehrFt
        LqS6c00/WsIMkKHZzOiNvmk=
X-Google-Smtp-Source: APXvYqzFHAujW1BIAFuoBOGdJfB8171t72wIJWUmkqNsz7sgNdLqSJSHMz4wv0VoawyHjCsHEvpgRQ==
X-Received: by 2002:a5d:5222:: with SMTP id i2mr10320229wra.305.1574339451327;
        Thu, 21 Nov 2019 04:30:51 -0800 (PST)
Received: from mamamia.internal (a89-183-4-151.net-htp.de. [89.183.4.151])
        by smtp.gmail.com with ESMTPSA id 19sm3637228wrc.47.2019.11.21.04.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 04:30:50 -0800 (PST)
Subject: Re: [PATCH v2] bluetooth: bcm: Use HCI_QUIRK_USE_BDADDR_PROPERTY
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <20191119060221.3297340-1-a.heider@gmail.com>
 <4DB6C9B7-8454-449C-90B4-4A1B3AD82495@holtmann.org>
 <e813a126-f0fc-afe8-ad4c-5296f0a2dc06@gmail.com>
 <F632534C-C9CC-4F4F-AA58-F4FC053D4226@holtmann.org>
 <ffa83108-2c0f-26eb-3860-892f65a6e9bd@gmail.com>
 <964E03C9-B14A-4F6A-A6A2-1F52832D4971@holtmann.org>
 <416386e4-b9fb-2e6e-05b9-3a3ae8d0a7aa@gmail.com>
 <90FC7FF6-6C67-416B-A860-5CF1C5130AEB@holtmann.org>
 <ea8372a6-9297-8381-0c04-2676d08e2203@gmail.com>
 <F114B72F-3EA6-44F1-B24B-D4DB75BB7130@holtmann.org>
From:   Andre Heider <a.heider@gmail.com>
Message-ID: <5ab0af61-7294-30dd-7c85-1a3a464f76d8@gmail.com>
Date:   Thu, 21 Nov 2019 13:30:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <F114B72F-3EA6-44F1-B24B-D4DB75BB7130@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 21/11/2019 12:47, Marcel Holtmann wrote:
> Hi Andre,
> 
>>>>>>>>>> Some devices ship with the controller default address, like the
>>>>>>>>>> Orange Pi 3 (BCM4345C5).
>>>>>>>>>>
>>>>>>>>>> Allow the bootloader to set a valid address through the device tree.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Andre Heider <a.heider@gmail.com>
>>>>>>>>>> ---
>>>>>>>>>> drivers/bluetooth/btbcm.c | 1 +
>>>>>>>>>> 1 file changed, 1 insertion(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>>>>>>>>>> index 2d2e6d862068..9d16162d01ea 100644
>>>>>>>>>> --- a/drivers/bluetooth/btbcm.c
>>>>>>>>>> +++ b/drivers/bluetooth/btbcm.c
>>>>>>>>>> @@ -439,6 +439,7 @@ int btbcm_finalize(struct hci_dev *hdev)
>>>>>>>>>> 	btbcm_check_bdaddr(hdev);
>>>>>>>>>>
>>>>>>>>>> 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
>>>>>>>>>> +	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>>>>>>>>>>
>>>>>>>>>> 	return 0;
>>>>>>>>>> }
>>>>>>>>> have you actually tested this? I might be mistaken, but the code that I read in hci_dev_do_open() would drop this into unconfigured state since HCI_QURIK_INVALID_BDADDR is still set.
>>>>>>>>
>>>>>>>> I thought so, but double-checking something obviously failed...
>>>>>>>>
>>>>>>>> What would be an acceptable solution to this HCI_QUIRK_USE_BDADDR_PROPERTY|HCI_QUIRK_INVALID_BDADDR situation?
>>>>>>>>
>>>>>>>> Getting rid of the quirk in the driver in e.g. set_bdaddr() doesn't sound right.
>>>>>>>>
>>>>>>>> How about:
>>>>>>>>
>>>>>>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>>>>>>> index 04bc79359a17..7bc384be89f8 100644
>>>>>>>> --- a/net/bluetooth/hci_core.c
>>>>>>>> +++ b/net/bluetooth/hci_core.c
>>>>>>>> @@ -1470,7 +1470,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
>>>>>>>>          * start up as unconfigured.
>>>>>>>>          */
>>>>>>>>         if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
>>>>>>>> -           test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks))
>>>>>>>> +           (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
>>>>>>>> +            !test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)))
>>>>>>>>             hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
>>>>>>>>
>>>>>>>>         /* For an unconfigured controller it is required to
>>>>>>>>
>>>>>>>> That works for me (double-checked this time ;)
>>>>>>> I am not sure yet. I mean we define what HCI_QUIRK_USE_BDADDR_PROPERTY actually means. Right now it means this:
>>>>>>> 1) Run though ->setup
>>>>>>> 2) If no public BD_ADDR is set, then try to read from DT
>>>>>>> 3) If found, try to set, if set fails, abort dev_up
>>>>>>> Now there is also another problem that no public BD_ADDR means BDADDR_ANY right now. Which means, for Broadcom chips that is never the case. So HCI_QUIRK_USE_BDADDR_PROPERTY doesn’t even work since their invalid addresses are not BDDADDR_ANY.
>>>>>>> The first change needs to be something along these lines:
>>>>>>>                  if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
>>>>>>> -                       if (!bacmp(&hdev->public_addr, BDADDR_ANY))
>>>>>>> +                       if (!bacmp(&hdev->public_addr, BDADDR_ANY) ||
>>>>>>> +                           test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks))
>>>>>>>                                  hci_dev_get_bd_addr_from_property(hdev);
>>>>>>
>>>>>> Maybe I misunderstood, but just for the record: It works for me even without this hunk (with just my hunk above and the v2 bcm patch). The bdaddr via dt is used and the controller works without any userland interaction.
>>>>> then please have a btmon trace and check what BD_ADDR is returned from the Read_BD_Addr command. It could be well that hdev->public_addr is not yet populated with the Broadcom specific hdev->setup and thus it does work. However what happens for the hardware that requires to re-run hdev->setup every time. As I said, we need to get the semantics figure out on what we expect things to be when these quirks are provided.
>>>>
>>>> Ok, so here's what I did:
>>>> - rmmod bt modules
>>>> - start btmon
>>>> - modprobe 'em again
>>>>
>>>> The relevant part looks like:
>>>> < HCI Command: Read BD ADDR (0x04|0x0009) plen 0               #279 [hci0] 95.691010
>>>>> HCI Event: Command Complete (0x0e) plen 10                #280 [hci0] 95.691727
>>>>       Read BD ADDR (0x04|0x0009) ncmd 1
>>>>         Status: Success (0x00)
>>>>         Address: 43:45:C5:00:1F:AC (OUI 43-45-C5)
>>>> ...
>>>> < HCI Command: Broadcom Write BD ADDR (0x3f|0x0001) plen 6               #283 [hci0] 95.692816
>>>>         Address: 02:07:96:3D:D4:52 (OUI 02-07-96)
>>>>> HCI Event: Command Complete (0x0e) plen 4                #284 [hci0] 95.693859
>>>>       Broadcom Write BD ADDR (0x3f|0x0001) ncmd 1
>>>>         Status: Success (0x00)
>>>> < HCI Command: Reset (0x03|0x0003) plen 0               #285 [hci0] 95.693946
>>>>> HCI Event: Command Complete (0x0e) plen 4                #286 [hci0] 95.697468
>>>>       Reset (0x03|0x0003) ncmd 1
>>>>         Status: Success (0x00)
>>>> ...
>>>> < HCI Command: Read BD ADDR (0x04|0x0009) plen 0               #291 [hci0] 95.698995
>>>>> HCI Event: Command Complete (0x0e) plen 10                #292 [hci0] 95.699851
>>>>       Read BD ADDR (0x04|0x0009) ncmd 1
>>>>         Status: Success (0x00)
>>>>         Address: 02:07:96:3D:D4:52 (OUI 02-07-96)
>>>>
>>>> So it seems it gets BDADDR_BCM4345C5 first but a reset after set_bdaddr(what-I-passed-via-devicetree) makes this work?
>>>>
>>>>> What happens on a system that has the patch and doesn’t provide an address via DT?
>>>>
>>>> How about something like (not even compile tested):
>>>>
>>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>>> index 04bc79359a17..40c6cc6bd35f 100644
>>>> --- a/net/bluetooth/hci_core.c
>>>> +++ b/net/bluetooth/hci_core.c
>>>> @@ -1385,6 +1385,7 @@ static void hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
>>>> static int hci_dev_do_open(struct hci_dev *hdev)
>>>> {
>>>>     int ret = 0;
>>>> +   bool valid_bdaddr = false;
>>>>
>>>>     BT_DBG("%s %p", hdev->name, hdev);
>>>>
>>>> @@ -1457,9 +1458,11 @@ static int hci_dev_do_open(struct hci_dev *hdev)
>>>>                 hci_dev_get_bd_addr_from_property(hdev);
>>>>
>>>>             if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
>>>> -               hdev->set_bdaddr)
>>>> +               hdev->set_bdaddr) {
>>>>                 ret = hdev->set_bdaddr(hdev,
>>>>                                &hdev->public_addr);
>>>> +               valid_bdaddr = ret == 0;
>>>> +           }
>>>>         }
>>>>
>>>> setup_failed:
>>>> @@ -1469,8 +1472,11 @@ static int hci_dev_do_open(struct hci_dev *hdev)
>>>>          * In case any of them is set, the controller has to
>>>>          * start up as unconfigured.
>>>>          */
>>>> +       if (!valid_bdaddr)
>>>> +           valid_bdaddr = !test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
>>>> +
>>>>         if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
>>>> -           test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks))
>>>> +           !valid_bdaddr)
>>>>             hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
>>>>
>>>>         /* For an unconfigured controller it is required to
>>> yes, this might actually work. I cleaned this up and added proper comments. Please test the patches I just sent.
>>
>> I just did, and your patches with this v2 on top works on Orange Pi 3 :)
>>
>> Please let me know if I need to do anything to this patch to get it in!
> 
> we still need the patch setting the BDADDR_PROPERTY quirk in the Broadcom driver.

That is the patch at the start of this thread - which I meant by v2 :)

> I would actually make it conditionally for the hardware we know that can provide this / needs this.

I assume you mean the machine and not the bt controller, so how about 
this for v3 then?

--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -440,6 +441,12 @@ int btbcm_finalize(struct hci_dev *hdev)

     set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);

+   /* Some devices ship with the controller default address
+    * Allow the bootloader to set a valid address through the device tree
+    */
+   if (of_machine_is_compatible("xunlong,orangepi-3"))
+       set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
     return 0;
  }
  EXPORT_SYMBOL_GPL(btbcm_finalize);


> We might want to combine this with the no early baudrate change patch.

I'm not subscribed, do you want me to base this on another solution?

Thanks,
Andre
