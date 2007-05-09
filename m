Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46417C35.8010906@a1.net>
Date: Wed, 09 May 2007 09:45:57 +0200
From: Patrick Steiner <patrick.steiner@a1.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <463EEAA8.3080706@a1.net>
In-Reply-To: <463EEAA8.3080706@a1.net>
Subject: Re: [Bluez-users] Bluetooth only works after restart from Windows
 (dell wireless 350 problem)
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

Patrick Steiner wrote:
> hi,
>
> i have a dell d420 now for a few days, but bluetooth wont work.
>
> bluetooth isnt available if i start the notebook, but if i restart the 
> notebook from a windows (where bluetooth works) bluetooth works out of 
> the box.
> this problem is also confirmed on a dell d620 notebook.
>
> any ideas how i can fix this problem?
>
> regards,
>  patrick
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>   
i did some testing so i found out something more about the problem.

i have got a dell d420 notebook (with windows vista preinstalled)
and a dell d620 notebook (with windows xp preinstalled)

both devices have got a dell wireless 250 bluetooth device inside.

if i boot a ubuntu 7.04 live-cd bluetooth works out of the box on the 
dell d620 (xp)

hci0:    Type: USB
    BD Address: 00:16:41:DD:57:39 ACL MTU: 384:8 SCO MTU: 64:8
    UP RUNNING PSCAN ISCAN
    RX bytes:685 acl:0 sco:0 events:21 errors:0
    TX bytes:326 acl:0 sco:0 commands:20 errors:0
    Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
    Link policy: RSWITCH HOLD SNIFF PARK
    Link mode: SLAVE ACCEPT
    Name: 'ubuntu-0'
    Class: 0x3e0100
    Service Classes: Networking, Rendering, Capturing, Object Transfer, 
Audio
    Device Class: Computer, Uncategorized
    HCI Ver: 2.0 (0x3) HCI Rev: 0x976 LMP Ver: 2.0 (0x3) LMP Subver: 0x976
    Manufacturer: Cambridge Silicon Radio (10)

if i boot ubuntu 7.04 live-cd bluetooth doesnt work. hciconfig -a doesnt 
shown any device.
after rebooting into windows vista and rebooting back (no power off) 
with the live-cd hciconfig -a shows something.
and bluetooth works.

hci0:    Type: USB
    BD Address: 00:1A:6B:11:6B:0C ACL MTU: 384:8 SCO MTU: 64:8
    UP RUNNING PSCAN ISCAN
    RX bytes:593 acl:0 sco:0 events:37 errors:0
    TX bytes:323 acl:0 sco:0 commands:19 errors:0
    Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
    Link policy: RSWITCH HOLD SNIFF PARK
    Link mode: SLAVE ACCEPT
    Name: 'MOONY1'
    Class: 0x12010c
    Service Classes: Networking, Object Transfer
    Device Class: Computer, Laptop
    HCI Ver: 2.0 (0x3) HCI Rev: 0xdd2 LMP Ver: 2.0 (0x3) LMP Subver: 0xdd2
    Manufacturer: Cambridge Silicon Radio (10)


so this can only be a fireware problem or?

regards,
 patrick


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
