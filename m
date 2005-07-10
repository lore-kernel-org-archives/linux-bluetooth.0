Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: diNovo/MX900 problem with hidd
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42D04E35.7060109@phealy.com>
References: <42CF0E8E.4040602@phealy.com>
	 <loom.20050709T112217-147@post.gmane.org> <42CFD081.90800@phealy.com>
	 <42D0329D.7090500@phealy.com> <1120941001.18553.125.camel@pegasus>
	 <42D04E35.7060109@phealy.com>
Content-Type: text/plain
Message-Id: <1120982405.18553.133.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 10 Jul 2005 10:00:05 +0200

Hi Patrick,

> Used hcitool cc to connect to my mediapad, authed it, got a valid link key:
> Jul  9 17:09:07 localhost hcid[7758]: link_key_request 
> (sba=00:10:C6:3B:0B:95, dba=00:07:61:12:60:11)
> Jul  9 17:09:07 localhost hcid[7758]: pin_code_request 
> (sba=00:10:C6:3B:0B:95, dba=00:07:61:12:60:11)
> Jul  9 17:09:13 localhost hcid[7758]: link_key_notify 
> (sba=00:10:C6:3B:0B:95)
> Jul  9 17:09:13 localhost hcid[7758]: Saving link key 00:10:C6:3B:0B:95 
> 00:07:61:12:60:11

don't use "hcitool cc" for creating a connection. This is a testing
command only and the kernel will create the low-level ACL connections if
needed.

> hciconfig -a shows:
> hci0:   Type: USB
>         BD Address: 00:10:C6:3B:0B:95 ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>         RX bytes:5867 acl:236 sco:0 events:195 errors:0
>         TX bytes:2150 acl:47 sco:0 commands:47 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'nimitz-0'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering, Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x235 LMP Ver: 1.1 (0x1) LMP Subver: 
> 0x235
>         Manufacturer: Cambridge Silicon Radio (10)

If you enable AUTH and ENCRYPT you set your local device into security
mode 3. Do this only if you really know what you are doing.

> hcitool con shows:
> Connections:
>         < ACL 00:07:61:12:60:11 handle 41 state 1 lm MASTER AUTH ENCRYPT
> 
> Immediately after all this, hidd --search returns "No devices in range 
> or visible"... yet my mediapad lets me type WHILE it is searching.
> As soon as it's done searching, it quits. After three more searches, 
> hidd --search returns "Can't create HID control channel: Connection refused"

What do you expect to find if you are already connected?

> If I push the connect button and then do hidd --search, hidd displays 
> the following:
> Searching ...
>         Connecting to device 00:07:61:12:60:11
> then the pin request window comes up... I put in 1234 on the computer, 
> then am prompted for a pin by the mediapad. I put in 1234, get the 
> 'connected' light, and see the following in /var/log/daemon.log:
> Jul  9 17:18:34 localhost hcid[7758]: link_key_request 
> (sba=00:10:C6:3B:0B:95, dba=00:07:61:12:60:11)
> Jul  9 17:18:34 localhost hcid[7758]: pin_code_request 
> (sba=00:10:C6:3B:0B:95, dba=00:07:61:12:60:11)
> Jul  9 17:18:40 localhost hcid[7758]: link_key_notify 
> (sba=00:10:C6:3B:0B:95)
> Jul  9 17:18:40 localhost hcid[7758]: Replacing link key 
> 00:10:C6:3B:0B:95 00:07:61:12:60:11
> 
> after about another 30 seconds or so, hidd --search returns with "HID 
> create error 110 (Connection timed out)"

For what reason are you always searching? If you are connected once then
you never have to worry about it again. All further re-connects will be
handles by a running "hidd --server".

Use "hcidump -X -V" to see if something strange happens when the
keyboard acts weird.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
