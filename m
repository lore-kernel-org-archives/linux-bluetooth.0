Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <survivor@uni-paderborn.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41475033.3030209@uni-paderborn.de>
References: <41470C59.2050909@uni-paderborn.de>
	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de>
	 <1095189878.5695.201.camel@pegasus>  <41474870.3020204@uni-paderborn.de>
	 <1095191352.5695.205.camel@pegasus>  <41475033.3030209@uni-paderborn.de>
Content-Type: text/plain
Message-Id: <1095196325.5263.3.camel@pegasus>
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
Date: Tue, 14 Sep 2004 23:12:06 +0200

Hi Stefan,

> > your firmware is HCI 16.4 which is good, but you are going to create a
> > scatternet on your client and that can be the problem. Looks like this
> > is an internal problem of the CSR firmware. 
> You mean the dongles try to create a scatternet (with packet routing
> and so on) on their own? I always thought a scatternet has to be
> implemented outside the hard-/firmware.

no, you only create a scatternet. This means when one device must be
member of two different piconets.

> Is there a way to upgrade it? Are there better dongles the University
> could buy?

You can upgrade the D-Link DBT-120 Rev. B3 with the Apple firmware
update package to HCI 18.1.

> > Try to introduce some delays
> > between the connections and see if that helps.
> >   
> I'm experimenting with delays and timeouts for three days now. It
> helps... a bit, but not really good. I just tried to switch
> master-slave, but it doesn't really help. 

I think you should avoid the role-switching and keep the listening
applications as slaves. In this case the client creates the piconet and
can keep both servers in the same piconet.

> One year ago, I wrote another Location Awareness App on top of a
> modified JBlueZ and it just used ACL links to measure RSSI and LQ. It
> worked. I probably have to take care of the ACLs myself (does L2CAP
> use existing ACLs?). The only drawback: The App has to run as root :(.

The L2CAP creates the same ACL links, so this can't be the problem.

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
