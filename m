Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth/gprs problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Marian Gasparovic <marosg@yahoo.com>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <20040422073712.86329.qmail@web20419.mail.yahoo.com>
References: <20040422073712.86329.qmail@web20419.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1082626222.1845.17.camel@merlin>
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
Date: Thu, 22 Apr 2004 11:30:23 +0200

Hi Marian,

> I have i-Tec USB Dongle with Broadcom chip connected
> to my notebook with Debian Woody. I am able to
> establish bluetooth connection to my Siemens S55
> mobile. After I start pppd for GPRS access to Internet
> I get connected. I can ping any server for as long as
> I want. But when I open any web page under Konqueror
> or try ping -f, after couple of seconds (10-20) I
> loose connection. First I see bluetooth going away on
> mobil display, then gprs disconnect and after a minute
> pppd finds it out too. Any suggestions where to look ?
> I tried it with several notebooks, usb bluetooth
> devices and mobiles and only this i-Tec USB Dongle
> makes troubles. Under Windows XP it works without a
> problem.

this can be a dongle problem, because the dongle contains a Broadcom
chip and we already know that under some weird circumstances this is
buggy. But actually I think that your PPP setting are not correct for a
GPRS dialin. Check the some GPRS+PPP HOWTO's.

If you really want to be sure that this is no Bluetooth problem you must
run "hcidump -w <file>" as root and send us the resulting dump file.

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
