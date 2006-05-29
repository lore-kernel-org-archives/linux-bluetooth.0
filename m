Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 29 May 2006 09:42:21 +0200
Message-ID: <96B7A15232D6CF42836BFD428AD6B6034E5096@deexmb01.de.icap.com>
From: "Guido Reimer" <G.Reimer@de.icap.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth-alsa: a2recv stutteringsound	from	WM5.0
	AKU2.0
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


Brad,

Found this in Registry:

Bluetooth\AudioGateway:
	BTAGExtModule = BTAGExt.dll
	BTAGBModule   = \Windows\BthAGPhonebook.dll
	Capability	  = 37
	NoRoleSwitch  = 1
	SupportCLI	  = 0

Bluetooth\A2DP\Devices\1:
	Address	  = C4 A1 01 72 02 00 00 00

Bluetooth\Device\00027201a1c4:
	Class		  = 2098180 (0x200404)
	Name		  = BlueZ at mycomputer (0)
	Trusted	  = 1

Bluetooth\l2cap:
	ConfigTimeout     = 120 (0x000078)
	ConnectPacketType = 0
	ERTX              = 300 (0x00012C)
	IdleConnect       = 10
	IdlePhys          = 10
	LinkPolicy        = 15
      NoRoleSwitch      = 1
	PicoCabable       = 0
      RTX               = 60
      ScanModeControl   = 1


Does this give any informations to you?


Guido



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
