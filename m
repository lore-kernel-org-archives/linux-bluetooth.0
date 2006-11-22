Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <004f01c70dc0$dd7d3240$44a54256@claudia>
References: <004f01c70dc0$dd7d3240$44a54256@claudia>
Date: Wed, 22 Nov 2006 08:02:24 +0100
Message-Id: <1164178944.23477.26.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] higher rate than 115 kbits/s with an uart channel
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Michael,

do you mind sending ASCII emails only. I hate the crappy Microsoft
Windows HTML stuff. This is a Linux mailing ;)

> I work with a Bluetooth Kit of Semtech-Xemics which is connected
> 
> to a laptop with a Serial/USB adapter (supporting a max rate of 500
> kbits/s).
> 
> I have a specific command to setup the uart channel of the Kit. 
> 
> At Bluez side, I setup the uart rate with the command :
> 
> "hciattach /dev/ttyUSB0 any 230400" (for 230,4 kbits/s) 
> 
> as I would like to work with a higher rate than 115 kbits/s.
> 
> But, at this rate, I couldn't control or setup the kit.
> 
> The "hciconfig -a" gives :
> 
> hci0: Type: UART
> 
> BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
> 
> DOWN
> 
> RX bytes:10 acl:0 sco:0 events:0 errors:10
> 
> TX bytes:4 acl:0 sco:0 commands:1 errors:0
> 
> at Rx side, all the packets are with errors. 
> 
> What do I miss ? 
> 
> Do I have to setup the uart channel rate somewhere else in bluez ? 
> 
> The "hciconfig hci0 up" gives :
> 
> Can't init device hci0: Connection timed out (110)
> 
> For information, at 115 kbits/s, all is fine.

You must make sure that your device boots up with the higher baud rate
or you have to write a init routine for hciattach to change it. Check
the manual for your developer kit.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
