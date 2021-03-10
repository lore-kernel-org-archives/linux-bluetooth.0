Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBEDC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Mar 2021 06:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996E264FE8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Mar 2021 06:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhCJG4L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Mar 2021 01:56:11 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42134 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhCJGzu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Mar 2021 01:55:50 -0500
Received: from marcel-macbook.holtmann.net (p4fefc126.dip0.t-ipconnect.de [79.239.193.38])
        by mail.holtmann.org (Postfix) with ESMTPSA id 46A18CED43;
        Wed, 10 Mar 2021 08:03:24 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] Bluetooth: Fix for L2CAP/LE/CFC/BV-15-C
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZ+=uF6ouH0G3JPHNSKbLKwfAcnGfoFPj2vUhGdBkwhKgw@mail.gmail.com>
Date:   Wed, 10 Mar 2021 07:55:48 +0100
Cc:     Szymon Janc <szymon.janc@codecoup.pl>,
        Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <BFAD40D1-8C69-48D9-BC13-441D8EFE3AF4@holtmann.org>
References: <20210222103021.20923-1-magdalena.kasenberg@codecoup.pl>
 <CABBYNZ+3njOxCGKE0cvxkw574=U5Uv7+HHn885MrVFaoO3NpNQ@mail.gmail.com>
 <ECCE8B1E-C097-4FED-B11F-6294E22E6009@holtmann.org> <5591810.MhkbZ0Pkbq@ix>
 <CABBYNZ+=uF6ouH0G3JPHNSKbLKwfAcnGfoFPj2vUhGdBkwhKgw@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>>>>> This is required for the qualification test L2CAP/LE/CFC/BV-15-C
>>>>>> 
>>>>>> Implementation does not allow to set different key size for SMP and
>>>>>> L2CAP, which is needed for a current specification of the test. This fix
>>>>>> workarounds it with the debugfs variable le_l2cap_min_key_size.
>>>>>> 
>>>>>> Logs from the test when the IUT uses a min and max l2cap encryption key
>>>>>> size 16. $ echo 16 >
>>>>>> /sys/kernel/debug/bluetooth/hci0/le_l2cap_min_key_size The lower tester
>>>>>> uses a key size 7.
>>>>>> 
>>>>>>> ACL Data RX: Handle 99 flags 0x02 dlen 11                #34 [hci0]
>>>>>>> 25.007392>>>>
>>>>>>   SMP: Pairing Request (0x01) len 6
>>>>>> 
>>>>>>     IO capability: DisplayYesNo (0x01)
>>>>>>     OOB data: Authentication data not present (0x00)
>>>>>>     Authentication requirement: Bonding, No MITM, SC, No Keypresses
>>>>>>     (0x09)
>>>>>>     Max encryption key size: 7
>>>>>>     Initiator key distribution: <none> (0x00)
>>>>>>     Responder key distribution: <none> (0x00)
>>>>>> 
>>>>>> < ACL Data TX: Handle 99 flags 0x00 dlen 11                #35 [hci0]
>>>>>> 25.007591>>>
>>>>>>   SMP: Pairing Response (0x02) len 6
>>>>>> 
>>>>>>     IO capability: KeyboardDisplay (0x04)
>>>>>>     OOB data: Authentication data not present (0x00)
>>>>>>     Authentication requirement: Bonding, No MITM, SC, No Keypresses
>>>>>>     (0x09)
>>>>>>     Max encryption key size: 16
>>>>>>     Initiator key distribution: <none> (0x00)
>>>>>>     Responder key distribution: <none> (0x00)
>>>>>> 
>>>>>> @ MGMT Event: New Long Term Key (0x000a) plen 37      {0x0001} [hci0]
>>>>>> 28.788872>>>
>>>>>>     Store hint: Yes (0x01)
>>>>>>     LE Address: C0:DE:C0:FF:FF:01 (OUI C0-DE-C0)
>>>>>>     Key type: Unauthenticated key from P-256 (0x02)
>>>>>>     Master: 0x00
>>>>>>     Encryption size: 7
>>>>>>     Diversifier: 0000
>>>>>>     Randomizer: 0000000000000000
>>>>>>     Key: 529e11e8c7b9f5000000000000000000
>>>>>> 
>>>>>> <snip>
>>>>>> 
>>>>>> After pairing with key size 7, L2CAP connection is requested which
>>>>>> requires key size 16.
>>>>>> 
>>>>>>> ACL Data RX: Handle 99 flags 0x02 dlen 18                #56 [hci0]
>>>>>>> 34.998084>>>>
>>>>>>   LE L2CAP: LE Connection Request (0x14) ident 3 len 10
>>>>>> 
>>>>>>     PSM: 244 (0x00f4)
>>>>>>     Source CID: 64
>>>>>>     MTU: 256
>>>>>>     MPS: 284
>>>>>>     Credits: 1
>>>>>> 
>>>>>> < ACL Data TX: Handle 99 flags 0x00 dlen 18                #57 [hci0]
>>>>>> 34.998325>>>
>>>>>>   LE L2CAP: LE Connection Response (0x15) ident 3 len 10
>>>>>> 
>>>>>>     Destination CID: 0
>>>>>>     MTU: 0
>>>>>>     MPS: 0
>>>>>>     Credits: 0
>>>>>>     Result: Connection refused - insufficient encryption key size
>>>>>>     (0x0007)
>>>>>> 
>>>>>> Signed-off-by: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
>>>>>> Reviewed-by: Szymon Janc <szymon.janc@codecoup.pl>
>>>>>> Cc: Szymon Janc <szymon.janc@codecoup.pl>
>>>>>> ---
>>>>>> include/net/bluetooth/hci_core.h |  1 +
>>>>>> net/bluetooth/hci_core.c         |  1 +
>>>>>> net/bluetooth/hci_debugfs.c      | 30 ++++++++++++++++++++++++++++++
>>>>>> net/bluetooth/l2cap_core.c       | 25 +++++++++++++++++++++++++
>>>>>> 4 files changed, 57 insertions(+)
>>>>>> 
>>>>>> diff --git a/include/net/bluetooth/hci_core.h
>>>>>> b/include/net/bluetooth/hci_core.h index ebdd4afe30d2..0bf0543efec5
>>>>>> 100644
>>>>>> --- a/include/net/bluetooth/hci_core.h
>>>>>> +++ b/include/net/bluetooth/hci_core.h
>>>>>> @@ -379,6 +379,7 @@ struct hci_dev {
>>>>>> 
>>>>>>    __u16           auth_payload_timeout;
>>>>>>    __u8            min_enc_key_size;
>>>>>>    __u8            max_enc_key_size;
>>>>>> 
>>>>>> +     __u8            le_l2cap_min_key_size;
>>>>>> 
>>>>>>    __u8            pairing_opts;
>>>>>>    __u8            ssp_debug_mode;
>>>>>>    __u8            hw_error_code;
>>>>>> 
>>>>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>>>>> index b0d9c36acc03..9ef4b39b380c 100644
>>>>>> --- a/net/bluetooth/hci_core.c
>>>>>> +++ b/net/bluetooth/hci_core.c
>>>>>> @@ -3788,6 +3788,7 @@ struct hci_dev *hci_alloc_dev(void)
>>>>>> 
>>>>>>    hdev->conn_info_max_age = DEFAULT_CONN_INFO_MAX_AGE;
>>>>>>    hdev->auth_payload_timeout = DEFAULT_AUTH_PAYLOAD_TIMEOUT;
>>>>>>    hdev->min_enc_key_size = HCI_MIN_ENC_KEY_SIZE;
>>>>>> 
>>>>>> +     hdev->le_l2cap_min_key_size = HCI_MIN_ENC_KEY_SIZE;
>>>>> 
>>>>> so I am not a fan of doing this with another variable and managing
>>>>> through debugfs. Can we pass the qualification test case by using
>>>>> BT_SECURITY_FIPS (which will enforce 128-bit key size)?>
>>>> I guess that will depend if PTS supports MITM which afaik it is
>>>> required with BT_SECURITY_FIPS, from the logs it looks like it doesn't
>>>> support it so we end up with an unauthenticated key so the error would
>>>> probably be different.
>>> 
>>> we should give this a try ..
>> 
>> PTS is not supporting GAP in this test at all, but since it is cat D test we
>> can run it with our own LT (nimBLE).
>> 
>> Using BT_SECURITY_FIPS will not do since it requires 128bit key to get to
>> FIPS level so with lower key size it fails on SMP.
>> 
>> BTW We are going to propose TSE which would allow to have alternative pass
>> case in this test with early fail on SMP so that it can be handled as GAP
>> configuration, not L2CAP. But for now, we have to handle it as defined in test
>> spec.
> 
> Do we have a ticket for that already? It sounds rather strange that
> test like this are being added when the security level already have
> requirements for key size, it is as if the spec is testing that the
> stack support the use of custom security level e.g. use level 3 but
> requires 128-bit keys, which imo breaks the security level as one can
> no longer expect the levels work the same regardless the
> implementation.
> 
>>> 
>>>>> If not then we might want to add a socket option to set min/max
>>>>> encryption key size requirement on a per socket basis.>
>>>> Yep, it seems to be a common trend to have such tests on upper layers
>>>> (ATT/GATT also have such encryption key size), even though it is more
>>>> of a GAP test and perhaps could have been done at SMP level.
>>> 
>>> .. however maybe we just deprecate BT_SECURITY or migrate it into something
>>> that allows specifying the details of a security level with extra
>>> parameters. I made the BT_SECURITY implementation in the kernel extendable.
>>> So we could also just add extra possible settings.
>> 
>> I'd not do it on per socket basis, pretty much the same as bluetoothd is not
>> handling keysize on per characteristic but as a global setting. If one needs
>> to use only full key size he will rather be set it globally. And apparently
>> no-one is using that anyway..
> 
> IMO it shouldn't, the spec is very clear on the requirements for
> security mode/level, adding different requirements on top of the level
> is the real problem here and adding it may possible create IOP
> problems as we are experiencing here since when we bump the security
> level it is no longer able to pair so the whole idea of having a
> dedicated error for key size seems flawed since it breaks the security
> level model.

I have the feeling that it might be better to add an option to also define the security level via socket options. So you can either use the pre-defined ones or just build your own. That way we can add new levels via userspace changes. I am almost certain that with future specs, we have to add new security levels since everybody is pondering on legacy pairing etc. So the FIPS level might be just too much, but you want Secure Connections and 128-bit key size, but are fine with just works.

And I wouldn’t be surprised if an upgrade from AES-128 has to happen at some point as well.

Regards

Marcel

