Return-Path: <rene@soft.uni-linz.ac.at>
Message-ID: <3F9521E4.8010900@soft.uni-linz.ac.at>
Date: Tue, 21 Oct 2003 14:09:08 +0200
From: Rene Mayrhofer <rene@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: command tx timeout and continuous inquiry.
References: <3F86784F.9050608@soft.uni-linz.ac.at>	<1065778372.14923.336.camel@baroque.r			ococosoft.com>		<3F86A88E.4090106@soft.uni-linz.ac.at>	<1065790691.14513.1	73.camel@pegasus>	 	<3F86AF96.7000904@soft.uni-linz.ac.at>	<1065791594.14514.179.camel@pegasus>	 <3F8FB6D9.8030000@soft.uni-linz.ac.at> <1066636708.902.5.camel@pegasus> 	<3F950E33.3070303@soft.uni-linz.ac.at> <1066735933.1005.114.camel@pegasus>
In-Reply-To: <1066735933.1005.114.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

Marcel Holtmann wrote:
> this must be a problem with your code. I checked it with two l2ping
> commands and an inquiry from the command line and it works as expect. I
> have used my Microsoft USB adapter for testing.
> 
> 	hci0:   Type: USB 
> 	        BD Address: 00:50:xx:xx:xx:xx ACL MTU: 192:8  SCO MTU: 64:8
> 	        HCI 16.1.1
> 	        Chip version: BlueCore02
> 	        Max key size: 128 bit
> 	        SCO mapping:  HCI

On my system, I can not confirm this. When I start two l2ping runs, 
"hcitool scan" will never return a result (I have tried a number of 
times). The interesting thing is the following: One l2ping runs in the 
background and I start "hcitool scan". It will take 10 - 24 seconds and 
will only return those devices which are currently _not_ pinged. When I 
start the second l2ping when "hcitool scan" is still running, either:
a) hcitool scan will immediately return (in less than 10 seconds) and 
the l2ping will work
b) hcitool scan will return with "Can't connect.: Device or ressource busy"
I've not found a way to reliably reproduce on of the two, it seems to be 
random which one will happen.

PS: Is libbluetooth thread-safe ? Maybe that could be part of my problem 
with two l2ping sessions from two different threads in the same process ?

best regards,
Rene


-- 
------------------------------------------------
Pervasive 2004:            www.pervasive2004.org
------------------------------------------------
