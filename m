Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problems with nc6 with bluez support
From: Marcel Holtmann <marcel@holtmann.org>
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200401221042.53134.mtortonesi@ing.unife.it>
References: <200401221042.53134.mtortonesi@ing.unife.it>
Content-Type: text/plain
Message-Id: <1074767225.7263.65.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 22 Jan 2004 11:27:05 +0100

Hi Mauro,

> i have just modified nc6 (an advanced IPv6-enabled nc clone) to support 
> connections over bluetooth. normal connections over l2cap seem to work fine 
> (although i have not been able to tranfer audio data over l2cap yet) but when 
> i try to perform data tranfers over sco the 

looks like nice stuff and if I find some extra time I will test it. But
you should forget about the SCO transfers. SCO is for audio transmission
(voice) only. Use L2CAP (SOCK_SEQPACKET) and RFCOMM (SOCK_STREAM).

> i am using kernel 2.4.25-pre6 and 2.4.22 on my test hosts. perhaps i should 
> switch to 2.6-series kernels? i am not sure about this, since l2test and 
> scotest from bluez-utils 2.3 seem to work fine on these kernel.

The 2.4.25-pre6 is still fine. If you get a problem with a 2.4 kernel
apply the latest of my -mh patches.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
