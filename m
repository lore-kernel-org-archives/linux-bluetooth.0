Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Content-Type: text/plain; charset=us-ascii
Subject: Problems with L2CAP: deferred setup and MTU
Date: Wed, 19 Jan 2011 17:10:51 -0200
Message-Id: <5E5308B0-BA11-46A2-B7A9-22CD4ADBCF80@signove.com>
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v1082)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am currently investigating two problems with L2CAP sockets. Since I am not a kernel guy, I will take an indefinite amount of time to find and fix them; perhaps someone else can find and fix it in 5 minutes, so I think it is worth reporting.

First problem is ERTM x MTU, sockets configured with a MTU != 672. Normal sockets exchange MTU in initialization:

./l2test -P 4099 -I 1000 -O 1000
l2test[3211]: Connect from 00:1B:DC:0F:C8:A9 [imtu 1000, omtu 1000, flush_to 65535, mode 0, handle 12, class 0x480100]

but ERTM sockets seem to ignore the setsockopt() value and exchange the default size (672):

./l2test -P 4099 -I 1000 -O 1000 -X ERTM
l2test[3228]: Connect from 00:1B:DC:0F:C8:A9 [imtu 1000, omtu 672, flush_to 65535, mode 3, handle 11, class 0x480100]

(obviously the initiator side uses the same parameters)


Second problem is about deferred setup in accept()ed sockets. Sometimes POLLOUT times out (or waits forever if timeout is 0). The following read(buf, 1) works, and the connection works normally after this. 

The pattern seems to be: the first accept()ed socket of a process works ok regarding POLLOUT; the following connections do not.

This is normally not a problem, but if you try to read MTU using getsockopt() right after connection is set up, and if POLLOUT failed, MTU values are not updated. If you sleep a small amount of time like 0.1s then getsockopt() returns the expected values.

Finally, I have noted that playing with deferred setup sockets yields frequent kernel panics, like 1 in 3 rounds. This has prevented me to find more elaborate patterns (like ERTM x normal sockets etc.). The panics happen at listen() side; the connect() side is not affected. (Tested with 2.6.36 stock and bluetooth-next).

--
Elvis