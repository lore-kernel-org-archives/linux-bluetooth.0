Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030211122302.04281ca8@mail1.qualcomm.com>
Date: Tue, 11 Feb 2003 13:09:17 -0800
To: Maksim Yevmenkin <Maksim.Yevmenkin@cw.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] How do I obtain a free PSM  automatically?
Cc: Alexandros Karypidis <karypid@inf.uth.gr>, Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, bluez-devel@lists.sourceforge.net
In-Reply-To: <3E4956A6.3CC2A841@cw.com>
References: <1044653775.32672.14.camel@pegasus.local>
	<5.1.0.14.2.20030210123957.0417f4c0@mail1.qualcomm.com>
	<200302111822.44704.karypid@inf.uth.gr>
	<5.1.0.14.2.20030211103102.0438d370@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

At 12:01 PM 2/11/2003 -0800, Maksim Yevmenkin wrote:
>> btw Originally PSM was supposed to be assigned by Bluetooth SIG. ie. Just like
>> well known IP port. And then some "clever" people came up with the idea of dynamic
>> PSMs (probably the same people decided that PSM field needs 'an extension
>> bit' and made half of the PSMs space invalid). Unfortunately those "clever"
>> people didn't realize that [:[dynamic CID] is stupid.
>
>well there is nothing *really* wrong with extenstion. 
In Bluetooth case there is :). They simply reduced available number of PSMs by half.
Current spec does not permit PSM field to be longer than two bytes.
Actually it's not even half it a quarter because first bit of the second byte must 
always be 0. So only 16384 out of 65535 are available.

>i think it is just a safeguard. however i think this is way to optimistic.
>i just can't imagine that Bluetooth can ever use up all 65536
>or even 32768) PSMs. IP has lived with 65536 ports since the
>day one. 
My point exactly.

>i missed "dynamic PSM" stuff. was it somewhere is spec?
Here is PSM definition from 1.1 spec
----
Protocol/Service Multiplexor (PSM): 2 octets (minimum)
The PSM field is two octets (minimum) in length. The structure of the PSM
field is based on the ISO 3309 extension mechanism for address fields. All
PSM values must be ODD, that is, the least significant bit of the least signifi-cant
octet must be ’1’. Also, all PSM values must be assigned such that the
least significant bit of the most significant octet equals ’0’. This allows the
PSM field to be extended beyond 16 bits. PSM values are separated into
two ranges. Values in the first range are assigned by the Bluetooth SIG and
indicate protocols. The second range of values are dynamically allocated
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
and used in conjunction with the Service Discovery Protocol (SDP). The
dynamically assigned values may be used to support multiple implementa-tions
of a particular protocol

PSM value Description
0x0001   Service Discovery Protocol
0x0003   RFCOMM
0x0005   Telephony Control Protocol
<0x1000 RESERVED
[0x1001-0xFFFF] DYNAMICALLY ASSIGNED
        ^^^^^^^^^^^^^^^^^^^
----
btw Fellas according to the extension bit rules 0xFFFF is illegal PSM. 
0xfeff is the last legal one.

>> When you add [dynamic DLCI] op top for RFCOMM sessions it becomes ridiculous :).
>> And I'm not even sure what to call it when you add [dynamic OBEX channel] ;-)
>
>whoa! i missed them too :) what exactly dynamic DLCI and 
>dynamic OBEX channel mean? does it mean that user select
>channel (DLCI) and give to server app? or does it mean
>that server app itself somehow figures out available DCLI
>and get it? 
Same as PSM. Server allocates RFCOMM channel number dynamically and registers it with SDP.

>and what the hell is dynamic OBEX channel? OBEX works
>over RFCOMM so it needs RFCOMM channel (DLCI), right?
OBEX has Connection Id and stuff. So it also does it's own multiplexing.

>> Anyhow, we may have to provide dynamic PSM and DLCI service just because it may
>> become a common thing on other platforms and stacks.
>
>examples please :) what platforms/stacks do support these features? 
I believe Widcomm BTW supports it.
And if I remember correctly Palm OS stack has something like that too.

>how they use it? 
Server dynamically allocates PSM and registers it with SDP.

Max
