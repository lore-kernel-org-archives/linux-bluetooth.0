Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42109EB0.9090506@gmail.com>
From: Alberto Pianon <alberto.pianon@gmail.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-devel] Re: btsco (and SuSE 9.2)
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
Date: Mon, 14 Feb 2005 13:50:56 +0100

I've tried to build the btsco kernel module on SuSE 9.2
I just had to uninstall automake1.9 and install v1.7, and change "/source" to "/build" in the makefile of the module.
I followed all the instructions I found on http://bluetooth-alsa.sourceforge.net/
Everything worked without errors, but when I come to "modprobe snd_bt_sco" it says "FATAL: Module snd_bt_sco
not found".
I tried to locate the module, and it is in "/lib/modules/2.6.8-24.11-default/extra/snd-bt-sco.ko"
I tried with insmod, but it says "error inserting 'snd-bt-sco.ko': -1 Unknown symbol in module"
I tried with "modprobe snd-bt-sco" but it says always "FATAL: Module snd_bt_sco not found".
Did anyone manage to make it work on SuSE 9.2?
thanks,
Alberto





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
