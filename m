Return-Path: <survivor@uni-paderborn.de>
Message-ID: <41496B2C.1030103@uni-paderborn.de>
Date: Thu, 16 Sep 2004 12:30:04 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   =?ISO-8859-1?Q?Bernd_E=DFmann?= <psycho@uni-paderborn.de>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
References: <41470C59.2050909@uni-paderborn.de>	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de>	 <1095189878.5695.201.camel@pegasus>  <41474870.3020204@uni-paderborn.de>	 <1095191352.5695.205.camel@pegasus>  <41475033.3030209@uni-paderborn.de>	 <1095196325.5263.3.camel@pegasus>  <414780B0.2070908@uni-paderborn.de>	 <1095234376.5263.10.camel@pegasus>  <41484B1B.2000000@uni-paderborn.de> <1095282542.19426.9.camel@pegasus>
In-Reply-To: <1095282542.19426.9.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel!

Marcel Holtmann schrieb:

>use the linger support of the L2CAP socket and put a "sleep 2" between
>the first and the second l2test call.
>
>  
>
Your suggestions have no effect for me. Still errno 16. I think at the 
moment it is not possible to connect concurrently via l2cap if one 
device is down. But as a workaround I can use non-blocking connect (but 
with a timeout of 60 seconds just to prevent deadlocks) and simply 
reduce the pageto. My connection attempts are sequential anyway because 
of the master-slave-limit. But I would suggest to change the behavior of 
l2cap to allow more concurrent connection attempts even if some devices 
are down.

Regards
Stefan
