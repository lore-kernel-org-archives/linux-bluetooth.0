Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <402D4959.10704@handgranat.org>
From: Sunnan <sunnan@handgranat.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] apple wireless mouse on apple ibook (g4, builtin
 usb)
References: <402D07B8.8030504@handgranat.org>	 <1076694675.2671.191.camel@pegasus>  <402D1E8C.6020301@handgranat.org>	 <1076702197.18588.11.camel@pegasus>  <402D381D.1000306@handgranat.org> <1076709007.18588.39.camel@pegasus>
In-Reply-To: <1076709007.18588.39.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 13 Feb 2004 23:02:01 +0100

Marcel Holtmann wrote:
> the version of utils2 have a big endian problem, which I have now fixed
> in CVS.

Lucky! I always become happy when I find a bug.

> Try your version from bluez-utils-2.4. Better you call it with
> the full path "/sbin/hciconfig -a".


slowstorm/home/sunnan/.dl/mouseemu% sudo /sbin/hciconfig -a
hci0:   Type: USB
         BD Address: 00:0D:93:04:19:15 ACL MTU: 192:8  SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:593 acl:2 sco:0 events:40 errors:0
         TX bytes:670 acl:2 sco:0 commands:28 errors:0
         Features: 0xff 0xff 0x0f 0x00 0x18 0x18 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'slowstorm-0'
         Class: 0x000100
         Service Classes: Unspecified
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x385 LMP Ver: 1.1 (0x1) LMP 
Subver: 0x385
         Manufacturer: Cambridge Silicon Radio (10)



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
