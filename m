Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problems with nc6 with bluez support
References: <200401221042.53134.mtortonesi@ing.unife.it>
In-Reply-To: <200401221042.53134.mtortonesi@ing.unife.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401221127.57516.mtortonesi@ing.unife.it>
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
Date: Thu, 22 Jan 2004 11:27:57 +0100

On Thursday 22 January 2004 10:42, Mauro Tortonesi wrote:
> hi to everybody,
>
> i have just modified nc6 (an advanced IPv6-enabled nc clone) to support
> connections over bluetooth. normal connections over l2cap seem to work fine
> (although i have not been able to tranfer audio data over l2cap yet) but
> when i try to perform data tranfers over sco the

sorry, i sent the email before it was finished :-( i was saying that when i 
try to perform data tranfers over sco the bluez/usb subsystem on the 
receiving host hangs: my dlink dbt120 usb dongle is shut down (the 2 leds 
switch off) and the system does not recognize it anymore even if i unplug it 
and plug it in again. and if i then replace the dlink dbt120 with an anycom 
220 usb dongle nothing changes: the green led of the anycom dongle lits but 
the usb subsystem does not even recognize the peripheral.

the system keeps refusing to recognize usb dongles even if i unload and reload 
the hci_usb, bluez, sco and l2cap modules and the hcid and sdpd daemons. 

how can i solve these problesm? do you have any clues?

> i am using kernel 2.4.25-pre6 and 2.4.22 on my test hosts. perhaps i should
> switch to 2.6-series kernels? i am not sure about this, since l2test and
> scotest from bluez-utils 2.3 seem to work fine on these kernel.
>
>
> P.S.: i have not officially released the bluez-enabled version of nc6 yet,
> but if you are interested you can find the latest cvs sources here:
>
>       http://cvs.deepspace6.net/view/nc6

-- 
Aequam memento rebus in arduis servare mentem...

Mauro Tortonesi                 mtortonesi@ing.unife.it
                                mauro@deepspace6.net
                                mauro@ferrara.linux.it
Deep Space 6 - IPv6 with Linux  http://www.deepspace6.net
Ferrara Linux User Group        http://www.ferrara.linux.it





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
