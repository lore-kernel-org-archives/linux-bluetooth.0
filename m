Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Sebastian Roth <sebiroth@web.de>
Message-ID: <cv7vnn$b2i$1@sea.gmane.org>
References: <cv4qgt$8h4$1@sea.gmane.org> <4215FC4A.20504@dark-reality.de> <cv50e9$tm3$1@sea.gmane.org> <42161CC7.1090800@dark-reality.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <42161CC7.1090800@dark-reality.de>
Subject: [Bluez-devel] Re: mystic AT-Command
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 19 Feb 2005 19:18:49 +0100

Hi Lars,

google shows me that this AT command enables/disables voice recognition.
So I think this behavior of the headset isn't wrong in principle. What
do you think?

 > the check in btsco.c for AT+BVRA=1 was only added because I had no
 > understanding why my headset sometimes used this, and sometimes the
 > expected AT+CKPD=200 - it was because btsco sometimes used the wrong
 > channel. Now this should not happen any more as we have (hopefully)
 > proper channel auto-detection.
Thanks, this explains the check!

 > You can try to remove AT+BVRA=1 from btsco.c:
Have done this already and it works! When initially asking this my idea
was to have this change merged into the cvs.

Thanks for your great help.

Best regards,
Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
