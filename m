Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Palm hotsync over BT
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1127142348.24203.95.camel@wyatt.hadess.net>
References: <1126826943.17881.20.camel@wyatt.hadess.net>
	 <1126844669.5934.7.camel@localhost.localdomain>
	 <1127142348.24203.95.camel@wyatt.hadess.net>
Content-Type: text/plain
Message-Id: <1127216159.5168.11.camel@localhost.localdomain>
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
Date: Tue, 20 Sep 2005 13:35:58 +0200

Hi Bastien,

> > The pilot-link library should be extended to do everything by itself.
> > This means the service registration and the RFCOMM channel handling to
> > map the HotSync protocol over RFCOMM.
> 
> Do you know which channel it is supposed to connect to on the Palm?
> Something like that is supposed to work:
> 
> $ sdptool add HOTSYNC
> $ rfcomm bind  0 <palm bdaddr> <channel num>
> $ pilot-xfer -p /dev/rfcomm0 -l
> 
> Right now, with the few channels I tried, the Palm complains about the
> port already being used by another application.

the Palm will establish the RFCOMM link. I think it is not possible to
establish a HotSync connection from the PC.

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
