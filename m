Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] AVM AP-X and DUN profile
From: Marcel Holtmann <marcel@holtmann.org>
To: Bernd.Jucknischke@web.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403030832.19665.Bernd.Jucknischke@web.de>
References: <200403030832.19665.Bernd.Jucknischke@web.de>
Content-Type: text/plain
Message-Id: <1078320979.2787.68.camel@pegasus>
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
Date: Wed, 03 Mar 2004 14:36:19 +0100

Hi Bernd,

> yesterday I have upgraded the firmware of my AP-X and tried to connect to the 
> internet via the DUN service (They stated that the DUN part would have been 
> improved...). I have proceeded according to Cees' HOWTO and made use of a 
> working internet connection, which I normally use with my old modem (I've 
> changed /dev/ttyS0 to /dev/rfcomm0). So far so good, dialling worked, but the 
> connection got stuck in the LCP process. Here is the log output:

I never had real success with DUN and an AP-X device and actually I
don't know where the problem is. However you can use CMTP and the CIP
profile for dialin. Here are some details

	http://www.holtmann.org/linux/bluetooth/isdn.html

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
