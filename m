Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <survivor@uni-paderborn.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <414780B0.2070908@uni-paderborn.de>
References: <41470C59.2050909@uni-paderborn.de>
	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de>
	 <1095189878.5695.201.camel@pegasus>  <41474870.3020204@uni-paderborn.de>
	 <1095191352.5695.205.camel@pegasus>  <41475033.3030209@uni-paderborn.de>
	 <1095196325.5263.3.camel@pegasus>  <414780B0.2070908@uni-paderborn.de>
Content-Type: text/plain
Message-Id: <1095234376.5263.10.camel@pegasus>
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
Date: Wed, 15 Sep 2004 09:46:16 +0200

Hi Stefan,

> > > Is there a way to upgrade it? Are there better dongles the University
> > > could buy?
> > >     
> > You can upgrade the D-Link DBT-120 Rev. B3 with the Apple firmware
> > update package to HCI 18.1.
> > 
> Would that solve the problem? Actually, is it a known problem?

only if there was a bug in previous CSR firmwares, but on the other hand
the HCI 18.x firmwares are Bluetooth 1.2 capable.

> Btw, I read something about getting RSSI via Inquiry. Is it possible
> with BlueZ? This could be used to faster decrease the backoff if the
> unavailable device is found by inquiry and probably with a good RSSI
> near 0.

You need a CSR dongle with HCI 18.x firmware, a newer Silicon Wave or
the AVM BlueFRITZ! USB v2.0 to use inquiry with RSSI. The support is
already included in BlueZ.

> > > One year ago, I wrote another Location Awareness App on top of a
> > > modified JBlueZ and it just used ACL links to measure RSSI and LQ. It
> > > worked. I probably have to take care of the ACLs myself (does L2CAP
> > > use existing ACLs?). The only drawback: The App has to run as root :(.
> > >     
> > The L2CAP creates the same ACL links, so this can't be the problem.
> > 
> Yes, but I could disconnect faster on timeout and make L2CAP throw a
> clean error instead of behaving strange. 
> 
> Connections:
>         < ACL 00:02:72:B1:1D:62 handle 0 state 5 lm MASTER
>         < ACL 00:02:72:B1:1D:6C handle 45 state 1 lm MASTER
> 
> stargazer:~ # hcitool dc 00:02:72:B1:1D:62
> Disconnect failed: Input/output error
> 
> The connection to 62 persists even 5 minutes after I pulled the 62
> Dongle out. A manual disconnect failed. This simply can't be! I
> sometimes even have to reboot because BlueZ or something is confused.
> I think there is a serious problem. I'll do further testing tomorrow.

There are more than one timeouts in the BlueZ stack. Even the ACL
disconnect timeout is different for the initiator and the acceptor of
and ACL connection. Keep an eye on the HCI disconnect events on each of
your devices and compare the timestamps.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
