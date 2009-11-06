Return-Path: <cyrus@holtmann.org>
Message-ID: <4AF3F0EC.3050703@gmail.com>
Date: Fri, 06 Nov 2009 10:48:28 +0100
From: sancane <sancane@gmail.com>
MIME-Version: 1.0
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Problems opening connections for an HDP implementation.
References: <200911051551.40829.jcaden@libresoft.es>
In-Reply-To: <200911051551.40829.jcaden@libresoft.es>
Content-Type: text/plain; charset=ISO-8859-1
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi José,

José Antonio Santos Cadenas escribió:
> Hi everybody,
> 
> I am developing a free/open source implementation of HDP using sancane's MCAP 
> implementation. I am using ERTM and STREAMING mode provided by Gustavo's 
> patches from 3th October. I've been testing my implementation between two 
> computers (both of them using the previously mentioned profiles). This test 
> seems working correctly but I am also trying to test it against a Nonin Onix 
> II 9560BT PulseOximeter (certified by Continua). This device is using HDP but 
> when I try to test my HDP implementation I've observed that the MCAP control 
> channel L2CAP connection is not correctly opened (see trace bellow)
> 
> ...
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 46 packets 1
>> ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 49704 scid 0x0041
> < ACL data: handle 46 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
>       Connection successful
> ....
> 
> There is a thread waiting for incoming connections on this psm, but it is 
> never waked up from the recv system call.
> 

MCAP control channels are simply L2CAP socket with ERTM enabled. Current
implementations waits in a recv call for incoming connections. When a
device connect with you, the thread is waked up to create an MCAP
Communications Link (MCL). Since here, all negotiations are established
using MCAP commands.
At a minimum, the l2cap connection should be opened before MCAP working
thread will be waked up.
I suspect that the problem is that the l2cap with ERMT connections is
not opened.

> .....
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 46 packets 1
>> HCI Event: Link Key Request (0x17) plen 6
>     bdaddr 00:1C:05:00:19:56
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>     bdaddr 00:1C:05:00:19:56 key DD4D176E23CDB1D95334CD8A7D077773
>> HCI Event: Command Complete (0x0e) plen 10
>     Link Key Request Reply (0x01|0x000b) ncmd 1
>     status 0x00 bdaddr 00:1C:05:00:19:56
>> HCI Event: Encrypt Change (0x08) plen 4
>     status 0x00 handle 46 encrypt 0x01
> < HCI Command: Read RSSI (0x05|0x0005) plen 2
>     handle 46
> ....
> This part of the trace is repeated until local host closes L2CAP connection.
> ....
> 
> < ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0040
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 46 packets 1
>> ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0040
> ....
> 
>> HCI Event: Command Complete (0x0e) plen 7
>     Read Transmit Power Level (0x03|0x002d) ncmd 1
>     status 0x00 handle 46 level 3
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>     handle 46 reason 0x13
>     Reason: Remote User Terminated Connection
>> HCI Event: Command Status (0x0f) plen 4
>     Disconnect (0x01|0x0006) status 0x00 ncmd 1
>> HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 46 reason 0x16
>     Reason: Connection Terminated by Local Host
> 
> 
> What am I doing wrong? Why the connection to this socket is not finished?
> 
> If you are interested in the complete trace I can send it to you.
> 
> 
> Thank you very much.
> Regards.
> 
> Jose.
> 


