Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Vesa Halttunen <vesuri@jormas.com>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087767604.4781.52.camel@pegasus>
References: <1087757523.839.10.camel@pc.vesuri.net>
	 <1087767604.4781.52.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1087760721.1232.5.camel@pc.vesuri.net>
Mime-Version: 1.0
Subject: [Bluez-users] Re: Jerky MX900 mouse movement with 2.6.7-mh1, hidp and hidd
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
Date: Sun, 20 Jun 2004 22:45:21 +0300

Hi,

On Mon, 2004-06-21 at 00:40, Marcel Holtmann wrote:
> > I'm now running kernel 2.6.7-mh1 and I have the hidp module loaded and
> > hidd running. The keyboard works fine but mouse movement is very jerky.
> > There pointer lags behind and stops for approximately 100ms (or
> > whatever) every 0.5 seconds. This happens both on the console with GPM
> > and in X.
> Do you enabled role switch and sniff mode support?

No, I didn't. Should I, and if so, how?

>  Show us the output of "hciconfig -a".

Here goes (BD addresses removed :)

hci0:   Type: USB
        BD Address: ..:..:..:..:..:.. ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:289613 acl:17357 sco:0 events:121 errors:0
        TX bytes:1569 acl:60 sco:0 commands:26 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x34e LMP Ver: 1.1 (0x1) LMP Subver:
0x34e
        Manufacturer: Cambridge Silicon Radio (10)

For the mouse hcitool info gives me:

Requesting information ...
        BD Address:  ..:..:..:..:..:..
        Device Name: Logitech MX900 Mouse
        LMP Version: 1.1 (0x1) LMP Subversion: 0x350
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role
switch>
                <hold mode> <sniff mode> <park state> <RSSI> <channel
quality>
                <SCO link> <HV2 packets> <HV3 packets> <u-law log>
<A-law log>
                <CVSD> <paging scheme> <power control> <transparent SCO>


-Vesa
-- 
            · Vesa Halttunen - http://www.jormas.com/~vesuri/ ·



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
