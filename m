Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Riku Voipio <riku.voipio@iki.fi>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Oops in hci_usb
Message-ID: <20040503193747.GA21331@kos.to>
References: <20040501173626.GA3866@kos.to> <1083587205.4666.0.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1083587205.4666.0.camel@pegasus>
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
Date: Mon, 3 May 2004 22:37:48 +0300

On Mon, May 03, 2004 at 02:26:45PM +0200, Marcel Holtmann wrote:
> Hi Riku,
> do you enabled CONFIG_BT_HCIUSB_SCO in your kernel? If yes, disable it
> and try again.

Thanks for everyone for help!

Getting rid SCO option and updating to 2.6.6-RC3 makes the bluetooth 
on x40 work like a charm, no more oops and pairing worked first try. 
I can try 2.6.6-RC3 with CONFIG_BT_HCIUSB_SCO if you want to track 
the problem deeper. 

Attached are hcitool info/hconfig -a of the gadgets:

Thinkpad x40
hci0:   Type: USB
        BD Address: 00:20:E0:74:xx:xx ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:18298 acl:611 sco:0 events:344 errors:0
        TX bytes:5109 acl:203 sco:0 commands:69 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'wombat-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1 (0x1) LMP Subver: 0x222
        Manufacturer: Cambridge Silicon Radio (10)

Siemens S55
        BD Address:  00:01:E3:04:xx:xx
        Device Name: xxxx
        LMP Version: 1.1 (0x1) LMP Subversion: 0x555
        Manufacturer: Infineon Technologies AG (9)
        Features: 0xef 0xea 0x19 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <role switch> <hold mode> <sniff mode> <RSSI>
                <SCO link> <HV3 packets> <u-law log> <A-law log>
                <CVSD> <transparent SCO>


-- 
Riku Voipio  	       | riku.voipio at iki.fi         |
kirkkonummentie 33     |    +358 44 5000343          --+--
02140 Espoo            |                               |
dark> A bad analogy is like leaky screwdriver          |


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
