Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MSI MS-6970 (BToes) firmware upgrade
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Ruzicka <pavouk@pavouk.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>, cijoml@volny.cz
In-Reply-To: <200407161045.10846.pavouk@pavouk.org>
References: <200407131225.15448.pavouk@pavouk.org>
	 <200407152241.30155.cijoml@volny.cz> <1089959822.4517.52.camel@pegasus>
	 <200407161045.10846.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1089968030.4517.89.camel@pegasus>
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
Date: Fri, 16 Jul 2004 10:53:51 +0200

Hi Pavel,

> > The only dongle that can be easily updated using the Apple firmware is
> > from D-Link. And I only had success with the B3 revision. The B4 is not
> > working and I broke another dongle of mine.
> 
> Can you tell me, if firmware for D-link use different key than firmware
> for MSI?

I don't know, but I think so. You can check the USB vendor and product
id for your dongle. If it is not the CSR default 0a12:0001 you shouldn't
even think about a firmware upgrade.

> It's possible to get this information from DFU file?

Not that I know.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
