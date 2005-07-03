Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HCID problem? (Help)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <c93f2a2905070219331de8b1a0@mail.gmail.com>
References: <c93f2a29050702074045ad46dd@mail.gmail.com>
	 <1120315516.10273.0.camel@pegasus>
	 <c93f2a2905070219331de8b1a0@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1120404723.10273.63.camel@pegasus>
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
Date: Sun, 03 Jul 2005 17:32:03 +0200

Hi Andy,

> I am using arm-linux 2.4.27-vsr1 from atmel, and libs&utils I am using
> the latest 2.17 version. The kernel version is hard to change. I just
> think hcidump should also report the command status after inquire
> suceed. And since from the hcidump output, the inquire has already
> suceeded, the hcitool output should print the inquire result, but
> not"Inquiry failed.: Connection timed out".

the command status is not allowed after the inquiry succeeded. Please
install the latest hcidump and run it with the "-X -V" parameters.

Your kernel is quite old and I am not going to debug it. Try to include
at least my -mh patch for the 2.4.27 kernel.

> Below is more information: 
> 1. I tried "hcitool inq", "hcitool scan", sdptool and l2ping, only
> l2ping outputs correctly.

This is strange. Do you run your ARM CPU in big endian mode?

> 2. If I don't run hcidump, my Nokia 7650 can connect to the arm box
> via Serial Profile every two times, but if I run hcidump, it can never
> connect succefully.

This actually can't be, because hcidump has no influence.

> 3. Among two data sendings from Nokia to arm box,  one succeed, one
> failed (no data output from hcidump)

Very strange.

> 4. After about 5 times data sending from arm box to Nokia, it does not
> send back data to Nokia any more, and also at that time no more output
> from hcidump.

You might consider buying a Bluetooth sniffer.

> Everything seems to work perfectly between my linux PC and Nokia 7650.

Are you using the same kernel source as on your ARM platform?

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
