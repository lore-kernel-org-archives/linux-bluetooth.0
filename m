Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <survivor@uni-paderborn.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Bernd =?ISO-8859-1?Q?E=DFmann?= <psycho@uni-paderborn.de>
In-Reply-To: <41496D78.3080807@uni-paderborn.de>
References: <41470C59.2050909@uni-paderborn.de>
	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de>
	 <1095189878.5695.201.camel@pegasus>  <41474870.3020204@uni-paderborn.de>
	 <1095191352.5695.205.camel@pegasus>  <41475033.3030209@uni-paderborn.de>
	 <1095196325.5263.3.camel@pegasus>  <414780B0.2070908@uni-paderborn.de>
	 <1095234376.5263.10.camel@pegasus>  <41484B1B.2000000@uni-paderborn.de>
	 <1095282542.19426.9.camel@pegasus>  <41496B2C.1030103@uni-paderborn.de>
	 <1095330875.19426.28.camel@pegasus>  <41496D78.3080807@uni-paderborn.de>
Content-Type: text/plain
Message-Id: <1095332448.19426.50.camel@pegasus>
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
Date: Thu, 16 Sep 2004 13:00:48 +0200

Hi Stefan,

> > > Your suggestions have no effect for me. Still errno 16. I think at the 
> > > moment it is not possible to connect concurrently via l2cap if one 
> > > device is down. But as a workaround I can use non-blocking connect (but 
> > > with a timeout of 60 seconds just to prevent deadlocks) and simply 
> > > reduce the pageto. My connection attempts are sequential anyway because 
> > > of the master-slave-limit. But I would suggest to change the behavior of 
> > > l2cap to allow more concurrent connection attempts even if some devices 
> > > are down.
> > >     
> > use hcidump and check the result code of the failing HCI connection
> > complete event. Look them up in the Bluetooth specification. This may
> > lights this behaviour a little bit more up.
> > 
> I guess you mean one paging process at one time per device? :)

there is always an underlaying creation of an ACL link and this fails
for you. The Bluetooth error codes don't map 1:1 to Unix error codes, so
use hcidump to find out the Bluetooth error and look up what it means.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
