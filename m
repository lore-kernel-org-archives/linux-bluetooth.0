Return-Path: <survivor@uni-paderborn.de>
Message-ID: <4166B45C.1000802@uni-paderborn.de>
Date: Fri, 08 Oct 2004 17:38:04 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: read_RSSI and others not thread-safe?
References: <41668ADE.7010004@uni-paderborn.de>	 <4166A8D8.3080707@uni-paderborn.de> <1097249347.4407.21.camel@pegasus>
In-Reply-To: <1097249347.4407.21.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

if there is no pre-filtering then a process could open a socket to hci, 
set the event filter to "all events" and receive events which are 
results of other processes/sockets? Is this really true?

Regards
Stefan

Marcel Holtmann schrieb:

>Hi Stefan,
>  
>
>there is no pre-filtering for this kind of stuff. Feel free to send in a
>patch for checking the connection handle.
>
>Regards
>
>Marcel
>
>
>  
>
