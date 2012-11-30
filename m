Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <50B6ADE7.3070000@globaledgesoft.com>
References: <50B681C7.1030207@globaledgesoft.com>
	<CAJdJm_MCt+dep8XipFonUvRO5uoBiHNZeZm_80+LG7=E0DpTLg@mail.gmail.com>
	<50B6ADE7.3070000@globaledgesoft.com>
Date: Fri, 30 Nov 2012 08:53:15 -0400
Message-ID: <CAJdJm_Ofz+L5z+QuySv_kWPDDByRbHoeVvoJ7JXS6nbOVZh16Q@mail.gmail.com>
Subject: Re: BLE : SMP pairing + LE_Start_encryption
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay <ajay.kv@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ajay,

On Wed, Nov 28, 2012 at 8:35 PM, Ajay <ajay.kv@globaledgesoft.com> wrote:
>         is it possible to create an l2cap connection with cid 0x06 and psm 0
> ?  , so that i can make use of dedicated smp-l2cap channel for data transfer
> . I wanted to try how the remote device is handling on receiving an
> smp_pairing_request . i have seen in l2cap_core.c  , it is getting handled
> inside a switch case (case cid == L2CAP_CID_SMP).

On Linux, all communication over the LE SMP CID is done on the kernel.
So you need to use either increase socket seclevel using setsockopt()
or using "Pair Device" from mgmt API to send the SMP Pairing Request
from userspace.

I don't know how you can send "raw" SMP requests from userspace.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
