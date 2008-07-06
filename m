Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <g4oikf$lpd$1@ger.gmane.org>
References: <g4m2nu$j88$1@ger.gmane.org>
	<1215278356.4349.19.camel@californication> <g4oikf$lpd$1@ger.gmane.org>
Date: Sun, 06 Jul 2008 13:00:02 +0200
Message-Id: <1215342002.7112.10.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Override default inquiry mode?
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

Hi Norbert,
 
> >> I have got one of those tiny bluetooth USB adapters
> >> (http://www.anycom.com/products/bluetooth_it_pc_accessoires/?id=102&group_id=3,
> >> Broadcom chipset) and want to use it on my EEE PC. However, it does not work as
> >> I hoped.
> >>
> >> The adapter only works after setting the inquiry mode from RSSI/Extended to
> >> standard mode using
> >> hciconfig hcio reset
> >> hciconfig hci0 inqmode 0
> >>
> >> Is there any way to tell the bluetooth stack (i.e. in one of its config files)
> >> to always use the standard mode for this adapter, or even for all adapters?
> > 
> > what is your problem with using a better inquiry mode? We haven't had
> > any problem with this in a long long time. Your application might be
> > broken actually if it can't deal with more advanced inquiry modes.
> 
> The problem is notwith my application but with hciconfig and hcitool:
> 
> asus-931342168:/root> hciconfig -a
> hci0:   Type: USB
>          BD Address: 00:0A:3A:82:06:80 ACL MTU: 1021:8 SCO MTU: 64:1
>          UP RUNNING
>          RX bytes:163 acl:0 sco:0 events:19 errors:0
>          TX bytes:564 acl:0 sco:0 commands:19 errors:0
>          Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: RSWITCH HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
> Can't read local name on hci0: Input/output error (5)
> asus-931342168:/root> hcitool scan
> Scanning ...
> Inquiry failed: Connection timed out
> 
> I guess it is a problem with the bluetooth adapter's firmware.
> 
> > However hcid.conf should have a inqmode setting.
> 
> I'll try. Is there a hcid.conf reference? man hcid.conf does not show a 
> inqmode setting.

you might have to load hci_usb driver with reset=1 module parameter.

Regards

Marcel



-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
