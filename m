Return-Path: <survivor@uni-paderborn.de>
Message-ID: <4148C1AA.1080200@uni-paderborn.de>
Date: Thu, 16 Sep 2004 00:26:50 +0200
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
I'll give it a try tomorrow.
I already tried the lingering option to be able to close the socket 
directly after the last send, but it didn't work for me. I had to put a 
sleep 1000 (ms) to prevent read errors. As much as I understood the man 
pages....

"When enabled, a *close 
<http://www.die.net/doc/linux/man/man2/close.2.html>*(2) or *shutdown 
<http://www.die.net/doc/linux/man/man2/shutdown.2.html>*(2) will not 
return until all queued messages for the socket have been successfully 
sent or the linger timeout has been reached. Otherwise, the call returns 
immediately and the closing is done in the background. When the socket 
is closed as part of *exit*(2), it always lingers in the background."

...disabling linger makes also a clean shutdown in the background. Is 
there also a timeout for background lingering?

Anyway, thanks a lot for your help. I really appreciate it. I'll test 
your linger suggestion tomorrow. But I'm still of the opinion that l2cap 
should not return errno 16 to connection attempts to reachable devices 
even if a connection attempt is in progress to an unreachable device. 
There should be some concurrency possible.

Regards
Stefan
