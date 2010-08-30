Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>
Date: Mon, 30 Aug 2010 09:58:36 +0300
Subject: RE: [PATCH] Bluetooth: BT_SECURITY_HIGH requires 16 digit pin code
Message-ID: <99B09243E1A5DA4898CDD8B7001114480977FD6D9C@EXMB04.eu.tieto.com>
References: <1282909460-19337-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20100827195550.GA11191@vigoh>
In-Reply-To: <20100827195550.GA11191@vigoh>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Oops, I missed that. It was done automatically somehow. It wasn't my intention of doing this.
Will fix it.

Thanks,

/Waldek 

>-----Original Message-----
>From: Gustavo F. Padovan [mailto:pao@profusion.mobi] On Behalf 
>Of Gustavo F. Padovan
>Sent: Friday, August 27, 2010 9:56 PM
>To: Rymarkiewicz Waldemar
>Cc: linux-bluetooth@vger.kernel.org; 
>par-gunnar.p.hjalmdahl@stericsson.com; 
>joakim.xj.ceder@stericsson.com; johan.hedberg@gmail.com
>Subject: Re: [PATCH] Bluetooth: BT_SECURITY_HIGH requires 16 
>digit pin code
>
>Hi Waldemar,
>
>* Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> 
>[2010-08-27 13:44:20 +0200]:
>
>> The security level BT_SECURITY_HIGH expects secure connection and a 
>> minimum 16 digit pin code used for bonding. It's requitred 
>by the Sim 
>> Access Profile.
>> 
>> Patch on behalf of ST-Ericsson SA.
>> 
>> Signed-off-by: Waldemar Rymarkiewicz 
><waldemar.rymarkiewicz@tieto.com>
>> ---
>>  include/net/bluetooth/hci.h      |   17 +++++++
>>  include/net/bluetooth/hci_core.h |    4 ++
>>  net/bluetooth/hci_conn.c         |   97 
>+++++++++++++++++++++++++++++++-------
>>  net/bluetooth/hci_event.c        |    4 ++
>>  net/bluetooth/hci_sock.c         |    3 +
>>  net/bluetooth/rfcomm/core.c      |   10 ++++-
>>  6 files changed, 116 insertions(+), 19 deletions(-)  mode change 
>> 100644 => 100755 include/net/bluetooth/hci.h  mode change 100644 => 
>> 100755 include/net/bluetooth/hci_core.h  mode change 100644 
>=> 100755 
>> net/bluetooth/hci_conn.c  mode change 100644 => 100755 
>> net/bluetooth/hci_event.c  mode change 100644 => 100755 
>> net/bluetooth/rfcomm/core.c
>
>You are changing the files modes. Don't do that.
>
>--
>Gustavo F. Padovan
>ProFUSION embedded systems - http://profusion.mobi
>