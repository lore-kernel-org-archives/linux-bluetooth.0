Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] diNovo kbd / mice / mediapad
From: Marcel Holtmann <marcel@holtmann.org>
To: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1078857187.2354.3.camel@amd-01.home>
References: <1078857187.2354.3.camel@amd-01.home>
Content-Type: text/plain
Message-Id: <1078873003.10671.100.camel@pegasus>
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
Date: Tue, 09 Mar 2004 23:56:43 +0100

Hi Alexandre,

> Charles Bueche has updated his website (MX900 mouse) to add this nano
> HOWTO for the use of Logitech's diNovo keyboard, mouse and MediaPad.
> 
> Please, don't hesitate to make comments.
> 
> http://www.bueche.ch/comp/mx900/feedback/ghisoli_alexandre_mx900_with_hub.txt

nice ;)

However the name of the USB host controller module is uhci-hcd and I
don't find the multi-byte patch for hid-core.c in 2.6.3 or in the latest
snapshot. It seems that Vojtech Pavlik haven't sent it to Linus.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
