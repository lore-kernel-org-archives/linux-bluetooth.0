Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 12 Sep 2007 12:38:34 +0300
From: Niv <nivw2002@fastmail.fm>
In-reply-to: <46E6D9E3.7050605@fastmail.fm>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-id: <46E7B39A.1050703@fastmail.fm>
MIME-version: 1.0
References: <46E6D9E3.7050605@fastmail.fm>
Subject: Re: [Bluez-users] palm doesnt discover pc
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

update: I switched to an old dongle and I can now discover the pc:

works:
HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c
        Manufacturer: Cambridge Silicon Radio (10)

doesnt work:
 HCI Ver: 2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP Subver: 0x7a6
        Manufacturer: Cambridge Silicon Radio (10)

this is odd as I bought this by the bluez developers advice.
its a bluetake BT007Ex

does anyone use such an adaptor with current bluez? is my device defected?

Niv
Niv wrote:
> when I scan for bluetooth in my palm E2 I dont see the pc. I do see the
> cellular and a pc running a previous version of bluez:
> my kernel: 2.6.21-gentoo
> bluez-libs-3.18 bluez-utils-3.18 bluez-hcidump-1.40
> I run hcidump -X and I dont get anything when initiating the scan from
> the palm.
> 
> however, I can find and ping the palm from the pc:
> 
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr 00:07:E0:56:6B:53 mode 2 clkoffset 0x0000
>> HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>> HCI Event: Read Remote Supported Features (0x0b) plen 11
>     status 0x00 handle 42
>     Features: 0xff 0xff 0x0d 0x00 0x00 0x00 0x00 0x00
>> HCI Event: Remote Name Req Complete (0x07) plen 255
>     status 0x00 bdaddr 00:07:E0:56:6B:53 name 'E2'
>> ACL data: handle 42 flags 0x02 dlen 28
>     L2CAP(s): Echo rsp: dlen 20
>     41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54
> < ACL data: handle 42 flags 0x02 dlen 52
>     L2CAP(s): Echo req: dlen 44
>     41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54
>     55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63 64 65 66 67 68
>     41 42 43 44
> 
> how can I turn my pc to be discoverable?
> 
> /etc/bluetooth/hcid.conf:
> #
> # HCI daemon configuration file.
> #
> 
> # HCId options
> options {
> 	# Automatically initialize new devices
> 	autoinit yes;
> 
> 	# Security Manager mode
> 	#   none - Security manager disabled
> 	#   auto - Use local PIN for incoming connections
> 	#   user - Always ask user for a PIN
> 	#
> 	security auto;
> 
> 	# Pairing mode
> 	#   none  - Pairing disabled
> 	#   multi - Allow pairing with already paired devices
> 	#   once  - Pair once and deny successive attempts
> 	pairing multi;
> 
> 	# Default PIN code for incoming connections
> 	passkey /etc/bluetooth/pin-helper;
> }
> 
> # Default settings for HCI devices
> device {
> 	# Local device name
> 	#   %d - device id
> 	#   %h - host name
> 	##name "BlueZ on %h (%d)";
> 	name "BlueZ on %h (%d)";
> 
> 	# Local device class
> 	## old ?
> 	class 0x3e0100;
> 	##new?? class 0x000100;
> 
> 	# Default packet type
> 	#pkt_type DH1,DM1,HV1;
> 
> 	# Inquiry and Page scan
> 	iscan enable; pscan enable;
> 
> 	# Default link mode
> 	#   none   - no specific policy
> 	#   accept - always accept incoming connections
> 	#   master - become master on incoming connections,
> 	#            deny role switch on outgoing connections
> 	lm accept;
> 
> 	# Default link policy
> 	#   none    - no specific policy
> 	#   rswitch - allow role switch
> 	#   hold    - allow hold mode
> 	#   sniff   - allow sniff mode
> 	#   park    - allow park mode
> 	lp rswitch,hold,sniff,park;
> }
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
