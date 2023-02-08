Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF81C636CC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Feb 2023 10:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjBHKTJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Feb 2023 05:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjBHKS5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Feb 2023 05:18:57 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6C01BF8
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Feb 2023 02:18:23 -0800 (PST)
Received: from [192.168.0.4] (ip5f5aea6d.dynamic.kabel-deutschland.de [95.90.234.109])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id F2B1361CC457B;
        Wed,  8 Feb 2023 11:17:48 +0100 (CET)
Message-ID: <b7874cdd-5066-8bf2-02b2-2443d68a238c@molgen.mpg.de>
Date:   Wed, 8 Feb 2023 11:17:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: hci0: Malformed MSFT vendor event: 0x02
Content-Language: en-US
To:     Arda Demir <ddmirarda@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <CALDHRCt5KUezfEZCOWK+zYPM1hP32qwZqcoKw09ZjNw=oQoWKg@mail.gmail.com>
 <ecc41929af982862720209eacfa935178a8e0a1b.camel@sipsolutions.net>
 <CALDHRCuuZdqVorNzF+DFU8kAUU4eiuCHJgtV3Gtbvwr9mVow9Q@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CALDHRCuuZdqVorNzF+DFU8kAUU4eiuCHJgtV3Gtbvwr9mVow9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Arda,


Please use interleaved style when replying.

Am 08.02.23 um 10:54 schrieb Arda Demir:
> I don't think the device is broken since bluetooth + wi-fi is fully
> functional and i also read on arch linux forum people get the same
> message on tty with the same hardware. (AX200)
> 
> https://bbs.archlinux.org/viewtopic.php?id=276815
> 
> On Wed, Feb 8, 2023 at 12:29 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>>
>> On Wed, 2023-02-08 at 12:21 +0300, Arda Demir wrote:
>>> Hello,
>>>
>>> First of all, my bluetooth adapter is;
>>> 04:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
>>
>> You've reached the Wi-Fi team here though - adding the BT list.
>>
>>> I see the following message everytime when i boot the pc on tty.
>>>
>>> "Bluetooth: hci0: Malformed MSFT vendor event: 0x02"
>>>
>>> But bluetooth works well. If it is not critical it shouldn't print on
>>> tty, right?
>>
>> That's generic from net/bluetooth/hci_event.c, not related to the device
>> (apart from the fact that the device might be broken if it's sending
>> this?)

The message seems to originate from `net/bluetooth/msft.c`:

```
static void *msft_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
                            u8 ev, size_t len)
{
         void *data;

         data = skb_pull_data(skb, len);
         if (!data)
                 bt_dev_err(hdev, "Malformed MSFT vendor event: 0x%02x", 
ev);

         return data;
}
```

I recommend to create a bug report at the Linux kernel Bugzilla [1], 
where you attach the output of `dmesg`.

Additionally, I suggest to not load the Bluetooth modules like btusb 
during startup, and only later load it with `btmon` running.

Please reply with the bug report number/URL, if you created the bug report.


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/
