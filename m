Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <survivor@uni-paderborn.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Bernd =?ISO-8859-1?Q?E=DFmann?= <psycho@uni-paderborn.de>
In-Reply-To: <41484B1B.2000000@uni-paderborn.de>
References: <41470C59.2050909@uni-paderborn.de>
	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de>
	 <1095189878.5695.201.camel@pegasus>  <41474870.3020204@uni-paderborn.de>
	 <1095191352.5695.205.camel@pegasus>  <41475033.3030209@uni-paderborn.de>
	 <1095196325.5263.3.camel@pegasus>  <414780B0.2070908@uni-paderborn.de>
	 <1095234376.5263.10.camel@pegasus>  <41484B1B.2000000@uni-paderborn.de>
Content-Type: text/plain
Message-Id: <1095282542.19426.9.camel@pegasus>
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
Date: Wed, 15 Sep 2004 23:09:02 +0200

Hi Stefan,

> Hmmm, these timeouts are really difficult. I've written a script 
> "l2client.sh" (see below) using bluez-utils' l2test to make sure the 
> problem is not inside of my code. I also included the output of a 
> testrun. Take a look at it!
> 
> #### BEGIN SCRIPT l2client.sh ####
> 
> #!/bin/bash
> 
> ROUNDS=10
> SLEEP=`which sleep`
> TSLEEP=5
> SERVER1="00:02:72:B1:1D:6C"
> SERVER2="00:02:72:B1:1D:62"
> 
> for i in `seq 1 $ROUNDS`;
> do
>         printf "Round $i of $ROUNDS\n"
> 
>         printf "Connecting to Server $SERVER1...\n"
>         l2test -s -N 1 $SERVER1
>         printf "\n"
> 
>         printf "Connecting to Server $SERVER2...\n"
>         l2test -s -N 1 $SERVER2 &
>         printf "Waiting for $TSLEEP seconds...\n"
>         $SLEEP ${TSLEEP}s
>         printf "\n"
> done
> 
> printf "l2client.sh terminating.\n"
> 
> #### END SCRIPT l2client.sh ####

use the linger support of the L2CAP socket and put a "sleep 2" between
the first and the second l2test call.

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
