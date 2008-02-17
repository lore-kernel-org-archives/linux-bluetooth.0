Return-Path: <cyrus@holtmann.org>
Date: Sun, 17 Feb 2008 05:20:27 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <961486.61640.qm@web8409.mail.in.yahoo.com>
Message-ID: <alpine.LNX.1.00.0802170508090.10914@nge2.ngu.pk>
References: <961486.61640.qm@web8409.mail.in.yahoo.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Headset not playing audio HELP PLEASE
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


On Fri, 15 Feb 2008, pramod gurav wrote:

-> I just tried changing some lines in /usr/src/linux/net/bluetooth/hci_event.c
-> and compiled the kernel..

You can't just change values unless you know kernel/bluetooth programming ;)


-> SCO MTU: 64:8 this has changed 
-> but new problem is hwen I press button on HS link req comes but the connection is different this time
-> [root@localhost Pramod]# hcitool conn
-> Connections:
->         > ACL 00:0F:DE:B1:02:42 handle 0 state 2 lm SLAVE
-> previously it used to be as
-> ->

That's what mine looks like before I press the button- then it does the 
pass/auth step.


-> [Pramod@localhost ~]$ aplay -D bluetooth -f S16_LE test.raw
-> there is a long wait and connections are
-> [root@localhost Pramod]# hcitool conn
-> Connections:
->         > ACL 00:0F:DE:B1:02:43 handle 0 state 2 lm SLAVE 
->         < ACL 00:0F:DE:B1:02:42 handle 0 state 5 lm MASTER
-> 
->  00:0F:DE:B1:02:43 this is not my HS address(there is no other device near here)
-> 00:0F:DE:B1:02:42 this one is mine.

That's odd. Never saw a second address like that before...

-> planning to recompile the kernel with original hci_event.c

According to the Gentoo Wiki, your HS does work with modern kernel/bluez. BTW, 
last time when everything looked right but you didn't hear anything, did you 
remember to turn up the alsa sound? When I reboot, alsa is always set to 0. I 
use rexima/aumix to turn up the volumn. That's a common oversight. Other than 
that, I really don't know why it's working.

-> As you said there might be a incompatibility issues in one of them(HS/dongle)

The headset seems OK, from the wiki. You might look up the dongle, if you 
didn't already.


-> Can it happen that I might require to play the audio with certain frequency, rate or parameters which are supported by my HS(Its a Sony Ericsson HBH-602)?

Not totally sure, but mine didn't require them. I'm assuming it used the 
defaults in that case.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
