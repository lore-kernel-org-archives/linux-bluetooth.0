Return-Path: <survivor@uni-paderborn.de>
Message-ID: <41484B1B.2000000@uni-paderborn.de>
Date: Wed, 15 Sep 2004 16:00:59 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   =?ISO-8859-1?Q?Bernd_E=DFmann?= <psycho@uni-paderborn.de>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
References: <41470C59.2050909@uni-paderborn.de>	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de>	 <1095189878.5695.201.camel@pegasus>  <41474870.3020204@uni-paderborn.de>	 <1095191352.5695.205.camel@pegasus>  <41475033.3030209@uni-paderborn.de>	 <1095196325.5263.3.camel@pegasus>  <414780B0.2070908@uni-paderborn.de> <1095234376.5263.10.camel@pegasus>
In-Reply-To: <1095234376.5263.10.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hello again!

Marcel Holtmann schrieb:

>There are more than one timeouts in the BlueZ stack. Even the ACL
>disconnect timeout is different for the initiator and the acceptor of
>and ACL connection. Keep an eye on the HCI disconnect events on each of
>your devices and compare the timestamps.
>
>  
>
Hmmm, these timeouts are really difficult. I've written a script 
"l2client.sh" (see below) using bluez-utils' l2test to make sure the 
problem is not inside of my code. I also included the output of a 
testrun. Take a look at it!

#### BEGIN SCRIPT l2client.sh ####

#!/bin/bash

ROUNDS=10
SLEEP=`which sleep`
TSLEEP=5
SERVER1="00:02:72:B1:1D:6C"
SERVER2="00:02:72:B1:1D:62"

for i in `seq 1 $ROUNDS`;
do
        printf "Round $i of $ROUNDS\n"

        printf "Connecting to Server $SERVER1...\n"
        l2test -s -N 1 $SERVER1
        printf "\n"

        printf "Connecting to Server $SERVER2...\n"
        l2test -s -N 1 $SERVER2 &
        printf "Waiting for $TSLEEP seconds...\n"
        $SLEEP ${TSLEEP}s
        printf "\n"
done

printf "l2client.sh terminating.\n"

#### END SCRIPT l2client.sh ####

I ran "l2client.sh" on 00:02:72:B1:59:46 and "l2test -r" on 
00:02:72:B1:1D:6C and 00:02:72:B1:1D:62. 
After the 2nd round, I pulled out dongle 00:02:72:B1:1D:62. See what 
happens...

#### BEGIN OUTPUT OF SCRIPT l2client.sh ####

Round 1 of 10
Connecting to Server 00:02:72:B1:1D:6C...
l2test[4385]: Connected [imtu 672, omtu 672, flush_to 65535]
l2test[4385]: Sending ...
l2test[4385]: Closing channel ...
l2test[4385]: Done
l2test[4385]: Exit

Connecting to Server 00:02:72:B1:1D:62...
Waiting for 5 seconds...
l2test[4386]: Connected [imtu 672, omtu 672, flush_to 65535]
l2test[4386]: Sending ...
l2test[4386]: Closing channel ...
l2test[4386]: Done
l2test[4386]: Exit

Round 2 of 10
Connecting to Server 00:02:72:B1:1D:6C...
l2test[4388]: Connected [imtu 672, omtu 672, flush_to 65535]
l2test[4388]: Sending ...
l2test[4388]: Closing channel ...
l2test[4388]: Done
l2test[4388]: Exit

Connecting to Server 00:02:72:B1:1D:62...
Waiting for 5 seconds...
l2test[4389]: Connected [imtu 672, omtu 672, flush_to 65535]
l2test[4389]: Sending ...
l2test[4389]: Closing channel ...
l2test[4389]: Done
l2test[4389]: Exit

Round 3 of 10
Connecting to Server 00:02:72:B1:1D:6C...
l2test[4391]: Connected [imtu 672, omtu 672, flush_to 65535]
l2test[4391]: Sending ...
l2test[4391]: Closing channel ...
l2test[4391]: Done
l2test[4391]: Exit

Connecting to Server 00:02:72:B1:1D:62...
Waiting for 5 seconds...

Round 4 of 10
Connecting to Server 00:02:72:B1:1D:6C...
l2test[4394]: Can't connect. Device or resource busy(16)

Connecting to Server 00:02:72:B1:1D:62...
Waiting for 5 seconds...

Round 5 of 10
Connecting to Server 00:02:72:B1:1D:6C...
l2test[4397]: Can't connect. Device or resource busy(16)

Connecting to Server 00:02:72:B1:1D:62...
Waiting for 5 seconds...

Round 6 of 10
Connecting to Server 00:02:72:B1:1D:6C...
l2test[4400]: Can't connect. Device or resource busy(16)

Connecting to Server 00:02:72:B1:1D:62...
Waiting for 5 seconds...

Round 7 of 10
Connecting to Server 00:02:72:B1:1D:6C...
l2test[4403]: Can't connect. Device or resource busy(16)

Connecting to Server 00:02:72:B1:1D:62...
Waiting for 5 seconds...
l2test[4404]: Can't connect. Host is down(112)
l2test[4401]: Can't connect. Host is down(112)
l2test[4398]: Can't connect. Host is down(112)
l2test[4395]: Can't connect. Host is down(112)
l2test[4392]: Can't connect. Host is down(112)

Round 8 of 10
Connecting to Server 00:02:72:B1:1D:6C...
l2test[4406]: Connected [imtu 672, omtu 672, flush_to 65535]
l2test[4406]: Sending ...
l2test[4406]: Closing channel ...
l2test[4406]: Done
l2test[4406]: Exit

Connecting to Server 00:02:72:B1:1D:62...
Waiting for 5 seconds...

Round 9 of 10
Connecting to Server 00:02:72:B1:1D:6C...
l2test[4409]: Can't connect. Device or resource busy(16)

Connecting to Server 00:02:72:B1:1D:62...
Waiting for 5 seconds...

Round 10 of 10
Connecting to Server 00:02:72:B1:1D:6C...
l2test[4412]: Can't connect. Device or resource busy(16)

Connecting to Server 00:02:72:B1:1D:62...
Waiting for 5 seconds...

l2client.sh terminating.
l2test[4413]: Can't connect. Host is down(112)
l2test[4407]: Can't connect. Host is down(112)
l2test[4410]: Can't connect. Host is down(112)

#### END OUTPUT OF SCRIPT l2client.sh ####

After "l2client.sh" tries to contact the unreachable host 
00:02:72:B1:1D:62, all connection attempts to the reachable hist 
00:02:72:B1:1D:6C fail with errno 16. Just before round 8, all  
connection attempts to 00:02:72:B1:1D:62 fail together with errno 112 
and in round 8 the connection attempt to 00:02:72:B1:1D:6C succeeds. But 
even after one more connection attempt to the unreachable 
00:02:72:B1:1D:62, the connection attempts to 00:02:72:B1:1D:6C fail 
again. After "l2client.sh" has already terminated, the remaining 
backgrounded l2sends fail.

So there is really a problem if I don't wait for connect to fail with 
errno 112. My Location Awareness App of course can't afford to wait for 
20 seconds. But how to solve this? I hope to get another dongle this 
evening, so I can equip the client with it and test if the dongle matters.

Regards
Stefan
