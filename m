Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <survivor@uni-paderborn.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41474870.3020204@uni-paderborn.de>
References: <41470C59.2050909@uni-paderborn.de>
	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de>
	 <1095189878.5695.201.camel@pegasus>  <41474870.3020204@uni-paderborn.de>
Content-Type: text/plain
Message-Id: <1095191352.5695.205.camel@pegasus>
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
Date: Tue, 14 Sep 2004 21:49:13 +0200

Hi Stefan,

> >Are you sure that both of your listining servers are set for switching
> >the role to master after connection? Remember that the connecting device
> >is master in the first place.
> >
> Yes, I'm aware of that, but I don't know if this is a problem. It looks 
> like this at the client:

your firmware is HCI 16.4 which is good, but you are going to create a
scatternet on your client and that can be the problem. Looks like this
is an internal problem of the CSR firmware. Try to introduce some delays
between the connections and see if that helps.

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
