Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <cvjv6b$bfn$1@sea.gmane.org>
References: <7aa80ced0502222239dd01830@mail.gmail.com>	 <cvh9lh$2b0$1@sea.gmane.org>	 <7aa80ced05022223273b5bba4c@mail.gmail.com>	 <cvhkqf$2b0$2@sea.gmane.org>	 <7aa80ced0502230228296ac5e7@mail.gmail.com>	 <cvhrtb$kn9$1@sea.gmane.org> <7aa80ced05022322584f751610@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <7aa80ced05022322584f751610@mail.gmail.com>
Subject: [Bluez-users] Re: Can't able to send data in both direction
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
Date: Thu, 24 Feb 2005 08:23:30 +0100

Hi Mohan,

I'm sorry. I have not made this point clear!

>                   Can you tell me whether the send program is working
> after making the device up using "hciconfig hci0 up" on the SiW dongle
> side?
Yes, after starting `hcid' (or using `hciconfig hci0 up') I was able to
connect and send data in both directions.

Wugh? What's this? hciconfig shows a "Transilica, Inc." chip to me.
Don't know why but I thought that this dongle has a SiW chip in it.

Are you able to send data using another programm? Please try l2ping to
see if both directions work.

Best regards,
Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
