Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Timeout message from kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: Jeff Sutherland <jeffs@fairwayacademy.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402130917.46561.jeffs@fairwayacademy.org>
References: <200402121636.02074.jeffs@fairwayacademy.org>
	 <1076631244.2671.16.camel@pegasus>
	 <200402130917.46561.jeffs@fairwayacademy.org>
Content-Type: text/plain
Message-Id: <1076682121.2671.53.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 13 Feb 2004 15:22:02 +0100

Hi Jeff,

> l2ping from either end works.  I didn't cross-compile hcidump for the ColdFire 
> board, need to do some makefile wizardry in the parser subdir first.  l2test 
> on both ends just sits there waiting for something, no doubt I'm not invoking 
> it properly.  hcidump on the pc end shows the ping packets arriving from 
> ColdFire.  I guess my connection is basically working.  On the ColdFire 
> board:
> /bin> hciconfig
> hci0:   Type: UART
>         BD Address: 00:0A:4F:00:13:5F ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:289 acl:0 sco:0 events:14 errors:0
>         TX bytes:554 acl:0 sco:0 commands:14 errors:0
> 
> But invoking hcitool still yields:
> /bin> hcitool info 00:0A:4F:00:09:5E
> Requesting information ...
> bcsp_timed_event: Timeout, retransmitting 1 pkts
> Can't create connection: Input/output error
> pid 54: failed 256
> 
> bcsp_timed_event: is a kernel error msg.  I should probably try to set up an 
> l2test session properly next.  Any advice?

with the next update of the BCSP driver I will turn this into a debug
message.

Using l2test is easy and with -h you see all the options ;)

	One side:	l2test -r	/* listen and receive */
	Other side:	l2test -s	/* connect and send */

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
