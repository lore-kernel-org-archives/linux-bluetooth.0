Return-Path: <survivor@uni-paderborn.de>
Message-ID: <4166BA03.9050106@uni-paderborn.de>
Date: Fri, 08 Oct 2004 18:02:11 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: read_RSSI and others not thread-safe?
References: <41668ADE.7010004@uni-paderborn.de>	 <4166A8D8.3080707@uni-paderborn.de> <1097249347.4407.21.camel@pegasus>	 <4166B45C.1000802@uni-paderborn.de> <1097250057.4407.25.camel@pegasus>
In-Reply-To: <1097250057.4407.25.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel!

Ok, but I don't understand why my problem occurs. Look at this:
- thread T1 does hci_send_req(read_RSSI), waits for event E1
- thread T2 does hci_send_req(read_RSSI), waits for event E2
- Lets assume E2 comes earlier than E1
Why do BOTH threads receive E2? When is an event consumed?

Regards
Stefan

Marcel Holtmann schrieb:

>Hi Stefan,
>  
>
>it is a raw socket and every process can get all events. It is not
>possible to prevent this and actually the HCI itself is not designed for
>something like this. However you must be root to get some special
>events.
>
>Regards
>
>Marcel
>
>
>  
>
