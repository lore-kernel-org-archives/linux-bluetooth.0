Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: Eran <eran_l@over-here.org>
Subject: Re: [Bluez-users] Ambicom BT2000E card, can't get hciattach to work
Cc: bluez-users@lists.sourceforge.net
References: <4086DDFC.5000107@over-here.org> <200404220027.02236.pavouk@pavouk.org> <4086FFD9.50104@over-here.org>
In-Reply-To: <4086FFD9.50104@over-here.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404221124.34165.pavouk@pavouk.org>
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
Date: Thu, 22 Apr 2004 11:24:33 +0200

Hello,

> Sorry I forgot to mention it - but hciconfig shows a fully 'up and
> running' interface. I use the bt950_cs driver.
> I further checked and most hcitool commands work except the link quality.

I don't try link quality. It's possible, that this function doesn't work with 
this driver or your BT devices doesn't have established connection.

> I Have tried removing the bluetooth.conf from my pcmcia/ directory and
> use hciattach with /dev/ttyS03, but no success here as well (could not
> find correct parameters). Why is it the preferred way?

Because there are more BT cards with BT950 uart and ericsson chipset which
supposedly works with serial_cs driver and hciattach.
It's better to have for all these cards only one universal driver.

It's possible, that BT2000E requires some special initialization which 
hciattach doesn't know, but I'am not expert.

Best regards,

Pavel Ruzicka



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
