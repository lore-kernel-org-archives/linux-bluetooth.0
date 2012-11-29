Return-Path: <cyrus@holtmann.org>
Message-ID: <50B6ADE7.3070000@globaledgesoft.com>
Date: Thu, 29 Nov 2012 06:05:51 +0530
From: Ajay <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: BLE : SMP pairing + LE_Start_encryption
References: <50B681C7.1030207@globaledgesoft.com> <CAJdJm_MCt+dep8XipFonUvRO5uoBiHNZeZm_80+LG7=E0DpTLg@mail.gmail.com>
In-Reply-To: <CAJdJm_MCt+dep8XipFonUvRO5uoBiHNZeZm_80+LG7=E0DpTLg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 30 November 2012 05:38 PM, Anderson Lizardo wrote:
> Hi Ajay,
>
> On Wed, Nov 28, 2012 at 5:27 PM, Ajay <ajay.kv@globaledgesoft.com> wrote:
>>
>> Hi,
>>          how do i do smp pairing and ltk key distribution using l2cap socket
>> connection?  does bluez provide any tools for LE pairing . my ultimate
>> result should be enabling LE_start_encryption , which requires ltk key
>> distribution (which is a part of LE_pairing).
>
> Either using mgmt API to do pairing (see mgmt_create_bonding() in
> src/mgmt.c from bluez sources and doc/mgmt-api.txt for how to do this)
> or increase socket security level to at least medium using
> setsockopt() (see set_sec_level() in btio/btio.c for how to do this).
>
> In summary, you will need to use BlueZ code as reference if you want
> to do these things on your own. The easier route is to use BlueZ D-Bus
> API to do pairing.
>
> Regards,
>
  thanks  Anderson ,
   sorry if im confusing you .
	is it possible to create an l2cap connection with cid 0x06 and psm 0 ? 
  , so that i can make use of dedicated smp-l2cap channel for data 
transfer . I wanted to try how the remote device is handling on 
receiving an smp_pairing_request . i have seen in l2cap_core.c	 , it is 
getting handled inside a switch case (case cid == L2CAP_CID_SMP).

-- 
Thanks & regards

  AJAY KV
  GlobalEdge software Ltd
  8892753703
