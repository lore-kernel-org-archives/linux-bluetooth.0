Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: command tx timeout and continuous inquiry.
From: Marcel Holtmann <marcel@holtmann.org>
To: Rene Mayrhofer <rene@soft.uni-linz.ac.at>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3F9521E4.8010900@soft.uni-linz.ac.at>
References: 
	<3F86784F.9050608@soft.uni-linz.ac.at>	<1065778372.14923.336.camel@baroque.r
				ococosoft.com>		<3F86A88E.4090106@soft.uni-linz.ac.at>	<1065790691.14513.
	1	73.camel@pegasus>	
		<3F86AF96.7000904@soft.uni-linz.ac.at>	<1065791594.14514.179.camel@pegasus>
		 <3F8FB6D9.8030000@soft.uni-linz.ac.at> <1066636708.902.5.camel@pegasus>
		<3F950E33.3070303@soft.uni-linz.ac.at> <1066735933.1005.114.camel@pegasus>
	 <3F9521E4.8010900@soft.uni-linz.ac.at>
Content-Type: text/plain
Message-Id: <1066738444.13788.124.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 21 Oct 2003 14:13:59 +0200

Hi Rene,

> On my system, I can not confirm this. When I start two l2ping runs, 
> "hcitool scan" will never return a result (I have tried a number of 
> times). The interesting thing is the following: One l2ping runs in the 
> background and I start "hcitool scan". It will take 10 - 24 seconds and 
> will only return those devices which are currently _not_ pinged. When I 
> start the second l2ping when "hcitool scan" is still running, either:
> a) hcitool scan will immediately return (in less than 10 seconds) and 
> the l2ping will work
> b) hcitool scan will return with "Can't connect.: Device or ressource busy"
> I've not found a way to reliably reproduce on of the two, it seems to be 
> random which one will happen.

it is ok that devices with active connections don't answer inquiry scans
and you need to use --flush with hcitool to disable the kernel side
inquiry cache.

> PS: Is libbluetooth thread-safe ? Maybe that could be part of my problem 
> with two l2ping sessions from two different threads in the same process ?

I don't see any problems here, because you only use socket programming.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
