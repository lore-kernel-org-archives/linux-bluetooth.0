Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <001001c809df$6a76d9b0$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <47092B7D.5000404@free.fr><d89ddf300710071722k2ac2074dqe0dfc16ac960f982@mail.gmail.com><4709E3EA.1010205@free.fr><2d5a2c100710080640m69180310r93e52f8dac91624a@mail.gmail.com><470A3A00.3000909@free.fr>
	<1191862431.12212.10.camel@aeonflux.holtmann.net>
Date: Mon, 8 Oct 2007 21:14:14 +0200
MIME-Version: 1.0
Subject: [Bluez-devel] Socket concurrency / first tests
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

I have been working on socket concurrency tests in the last days, i.e. 
opening RFCOMM sockets to a maximum number of remote devices (mobile phones 
in this case). I have used a usual "connect" with blocking sockets - 
socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM). Each connection is 
performed to a different mobile phone, I have a row of phones on my desk :)

I'm using a 2.6.22.12 kernel with BlueZ 3.20 libs/utils, and from 1 to 4 
bluetooth dongles (Bt 2.0 EDR USB 2.0, an USB 2.0 hub connected to an USB 
2.0 port). "passkey-agent --default 0000 &" running.

1) With one bluetooth dongle only : I can successfully open up to 7 
concurrent connections to 7 mobile phones, then a sleep(60), then close the 
socket. I simply create one process for each connect() to each device and 
launch them all as fast as possible. It's working fine except :
- when one mobile host is down (I have intentionally switched one off) then 
all next "connect" are delayed, and usually lead to a "connection timeout" 
or "operation now in progress" when leaving the "connect".
- when a pairing is required it is about the same, all the rest seems 
delayed.

2) With more dongles, trying to perform (still at the same time) a connect() 
to one phone on hci0, another on hci1 etc ... up to hci3 (i.e. only 4 
connects to 4 devices), I always get connections errors, and the first 
connection try seems to get a lot of time.

I will certainly come back tomorrow with some hcidumps, but basically I have 
the feeling that some operations are blocking, and I also wonder about the 
blocking connect() timeout, which sometimes makes connect() exit with a 
E_INPROGRESS or a connection timeout -in my opinion- a bit too quickly.

If someone could help me in my investigations it would be really great !!

Best regards,
Oli 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
