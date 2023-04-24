Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37ADC7618E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Apr 2023 17:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjDXRfQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Apr 2023 13:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjDXRfO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Apr 2023 13:35:14 -0400
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 10:35:11 PDT
Received: from p3plsmtpa07-09.prod.phx3.secureserver.net (p3plsmtpa07-09.prod.phx3.secureserver.net [173.201.192.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4F55FF7
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Apr 2023 10:35:11 -0700 (PDT)
Received: from [192.168.0.58] ([70.112.164.231])
        by :SMTPAUTH: with ESMTPSA
        id r03apjSJZ9P9cr03bpFRKP; Mon, 24 Apr 2023 10:32:56 -0700
X-CMAE-Analysis: v=2.4 cv=PeY5xAtd c=1 sm=1 tr=0 ts=6446bd48
 a=S3BSAMYkHO6g4MQ2VxJkNg==:117 a=S3BSAMYkHO6g4MQ2VxJkNg==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=EfASa0wiAAAA:8 a=B1eNfF2LPa5xGEud2G8A:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Ogh1Um8Ajkq3hpB3iR5s:22
X-SECURESERVER-ACCT: rg@braneaudio.com
Message-ID: <16ab6b45-caed-f5e1-450f-dba72321014a@braneaudio.com>
Date:   Mon, 24 Apr 2023 12:32:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Is AVCTP Version Really 1.3?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <733a8933-008a-8394-4564-71e49c3a4059@braneaudio.com>
 <CABBYNZKHE8soV+5tOhMGQay7iSCJoOz6Eo4Cy5QEEmXAqXmw3w@mail.gmail.com>
Content-Language: en-US
From:   Richard Greer <rg@braneaudio.com>
In-Reply-To: <CABBYNZKHE8soV+5tOhMGQay7iSCJoOz6Eo4Cy5QEEmXAqXmw3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEXenE4g6S4jWKBo+ASa2ur2YlRzAbKEFlIEHDdS4Y+3f331dkvBGCo/uSAFucXg0rUA0ujKHS1hvFEZlYjBk/Qj6I2/2L1/jnI/CjWJPCq5HziBj5Iw
 AXSK6NImCh+/ZacN3NbTyIQ9TygBhpnCKwRVAEzoOoGJ+9tx4H4xcMyAjLw+UOpy/98KZNmxW0qFGDHo206z/zEwK2XbzAIZFmRcBqgrqS+S3pmNkPCwlxbb
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I have looked at the differences between the 1.3 and 1.4 specifications, and there is only one meaningful change in the document.

In Section 4.3 AVCTP Message Fragmentation, the following is added at the very end of the last paragraph:
     "The interleaving of the fragments of different packets is not allowed."

Looking in profiles/audio/avctp.c, it appears that fragmented packets are not implemented.  That would imply that there cannot be any interleaving of fragments from different packets.

So, I think that just a version change would work.

On 4/21/23 18:44, Luiz Augusto von Dentz wrote:
> Hi Richard,
> 
> It is still marked as 1.3:
> 
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/profiles/audio/avrcp.c#n409
> 
> That said I don't think there is much difference, well we better check
> what was incorporated with these erratas:
> 
> 1.4 Bluetooth AVCTP Protocol Change History
> 1.4.1 Changes from 1.3 to 1.4
> 1.4.1.1 General Changes
>  Incorporation of adopted changes to correct various errata. Relevant
> errata are
> 733, 2689.
> 
> If Tizen qualified it for 1.4 it is most likely just a version change
> that needs to be made, from 0x0103 to 0x0104.
> 
> On Fri, Apr 21, 2023 at 4:26 PM Richard Greer <rg@braneaudio.com> wrote:
>>
>> Hi,
>>
>> I will start by saying that I am not a Bluetooth expert, but just getting started on Bluetooth development.
>>
>> In looking at BlueZ 5.66, it seems that the version of AVCTP being reported is 1.3 (in avrcp_ct_record() in profiles/audio/avrcp.c) which corresponded with what is in doc/supported-features.txt (which looks like it was last updated several years ago).
>>
>> On the BlueZ website there is an entry from 21 Aug, 2014 titled "Bluetooth 4.1 qualification for Tizen BlueZ" that says it was using AVCTP 1.4.
>>
>> AVCTP version 1.3 was deprecated in July, 2013 and officially withdrawn on 1 Feb, 2023.
>>
>> If I were to start working on a product that was going to have Bluetooth in it, I could not get it certified with AVCTP 1.3.  So, I was just sort of hoping that it was a version reporting issue (due to the Tizen BlueZ statement above about it using 1.4 8+ years ago) and not something that still needs to be developed.
>>
>> Anyhow, if someone more familiar with Bluetooth on Linux can explain what is up with the AVCTP version, that would be greatly appreciated.
>>
>>
>> Thanks in advance,
>>
>> Richard Greer
> 
> 
> 
