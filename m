Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] throughput query
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de4657604112307276221ff99@mail.gmail.com>
References: <2de4657604112307276221ff99@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1101224463.27351.2.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 23 Nov 2004 16:41:03 +0100

Hi Manjunath,

> I am using anycom bt dongles. i set up a bt connection with pan/bnep.
> i use i-perf to measure the throughput ..and i get abt 620kbps. I then
> change to DH5 packet and measure the throughput.....and it is abt
> 300kbps.  Is this because of asymmetric and symmetric channels
> respectively.
> logically,use of  DM packets gives a lower througput compared to DH packets. 

how often must I say this? Don't change the packet types. Enable all of
them and let the link manager select the best one.

> How is that hcitool is able to set the packet type in a connection?

See above.

> Isn't there some sort of communication with the LM and baseband??

What do you mean?

> Similarly, can't i change the transmit power level???

No, you can't change that.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
