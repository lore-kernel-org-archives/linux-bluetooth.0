Return-Path: <rene@soft.uni-linz.ac.at>
Message-ID: <3F86B2CB.2090906@soft.uni-linz.ac.at>
Date: Fri, 10 Oct 2003 15:23:23 +0200
From: Rene Mayrhofer <rene@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: command tx timeout and continuous inquiry.
References: <3F86784F.9050608@soft.uni-linz.ac.at>	<1065778372.14923.336.camel@baroque.r	ococosoft.com> 	<3F86A88E.4090106@soft.uni-linz.ac.at>	<1065790691.14513.173.camel@pegasus>  <3F86AF96.7000904@soft.uni-linz.ac.at> <1065791594.14514.179.camel@pegasus>
In-Reply-To: <1065791594.14514.179.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel (again),

Marcel Holtmann wrote:
> it is a HCI 14.7 with max encryption of 56 bits.
> 
> 
>>So it's a hardware problem ?
> 
> 
> No, it's a problem of the firmware inside the dongle. Ask Acer for an
> update if they provide one.
Ok, I'll try to get an update (hopefully there is one...). Is my 
conclusion correct that I am not expecting too much from the Bluetooth 
protocol and that the following should work (and is already supported by 
bluez in 2.4.22):

Device 1:
- background thread for continuous inquiry with about 3 seconds between 
the hci_inquiry calls
- fer each MAC address found by the inquiry, another thread which uses 
L2CAP connections (via Bluetooth address familiy sockets) to send "ping" 
packets to measure the latency and link quality. The connection will be 
created, a single ping packet will be sent and the connection will be 
closed again. Then 100-500 ms delay and again opening the connection. 
(Is it necessary to close the connection between the link quality checks 
? I currently do that to release the devices for other communication - 
if they support more piconets at the same time, I could also leave the 
connection open.)

Device x:
- continuous inquiry
- possibly communication with other devices (those connections will stay 
up longer than the "ping" connections).

Am I doing anything stupid in this setup ?

Thanks for your quick answers,
Rene


-- 
------------------------------------------------
Pervasive 2004:            www.pervasive2004.org
------------------------------------------------
