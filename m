Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] l2test: Send failed. Invalid argument(22)
From: Marcel Holtmann <marcel@holtmann.org>
To: aquamala@o2.pl
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040506204859.GA2483@reynevan>
References: <20040506204859.GA2483@reynevan>
Content-Type: text/plain
Message-Id: <1083877861.4420.84.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 06 May 2004 23:11:01 +0200

Hi Przemek,

> I'm trying to test (almost) my implementation of L2CAP.
> This is what i do:
> 
> $ ./l2test -s -N 20 -S 00:0A:3A:53:12:4A 00:80:37:16:30:8B
> 
> Unfortunetly, I get:
> 
> l2test[2445]: Connected [imtu 672, omtu 512, flush_to 65535]
> l2test[2445]: Sending ...
> l2test[2445]: Send failed. Invalid argument(22)
> 
> No data is send. Just after L2CAP connection is established my 
> module is receiving Disconnection Request packet.
> 
> Please, tell me, what does that "Invalid argument(22)" mean.

you are using BlueZ to test your own implementation of L2CAP. Sounds
nice, but you already got all you need. Run hcidump and see what is
going on the HCI level. If you are looking for the error code than check
errno and the L2CAP source code. From a quick view it looks like your
data is bigger than your MTU. L2CAP is sequential packet and not a
stream.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
