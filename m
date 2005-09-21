Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid.conf : security auto - pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <432E89E8.3040809@ubuntu.com>
References: <432E89E8.3040809@ubuntu.com>
Content-Type: text/plain
Message-Id: <1127295151.495.22.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Wed, 21 Sep 2005 11:32:31 +0200

Hi Charles,

> Issint the "auto" option suppose to work for outgoing connections also?
> 
> when I do .... 
> 
> bash$ rfcomm connect 0 xx:xx:xx:xx:xx:xx
> 
> my cellphone askes for a pin, I type it in and then the cumputer it 
> brings up bluepin asking for a pin. issint is suppose to the the default 
> one in /etc/bluetooth/pin ?

the /etc/bluetooth/pin is only used for incoming connection. For
outgoing connections the /var/lib/bluetooth/<bdaddr>/pincodes can be
used. Look at the source code for details, because I never made this
feature public.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
