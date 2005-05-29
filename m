Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Miernik <miernik@ffii.org>
Message-ID: <20050529225647.10F7.0.NOFFLE@localhost.localdomain.local>
References: <20050529221527.10F1.1.NOFFLE@localhost.localdomain.local>
Subject: [Bluez-users] Re: Can't create connection: Input/output error - more info
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
Date: Mon, 30 May 2005 00:56:47 +0200

Miernik <miernik@ffii.org> wrote:
> Follow-up to my post a whle ago, about connecting Aplle Wireless
> Keyboard to PCMCIA SPHINX PICO Card.

That post didn't go through, so I am posting again my original post:

I have a PCMCIA SPHINX PICO Card bluetooth adapter, and I want to use
the Apple Wireless Keyboard with it.

I use Debian GNU/Linux sid.

The card seems to get configured OK:

szrenica:~# hciconfig -a
hci0:   Type: UART
        BD Address: 00:80:37:15:4B:AF ACL MTU: 672:10 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:7056 acl:0 sco:0 events:172 errors:0
        TX bytes:1596 acl:0 sco:0 commands:95 errors:0
        Features: 0x07 0xea 0x31 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'szrenica-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0xb LMP Ver: 1.1 (0x1) LMP Subver:
0x300
        Manufacturer: Ericsson Technology Licensing (0)

szrenica:~#

When I scan for it, it looks OK:

szrenica:~# hcitool scan --flush
Scanning ...
        00:60:57:AC:BA:5B       DonSolvon.com
        00:0A:95:3E:C4:35       Apple Wireless Keyboard
szrenica:~# hcitool inq --flush
Inquiring ...
        00:60:57:AC:BA:5B       clock offset: 0x6437    class: 0x500204
        00:0A:95:3E:C4:35       clock offset: 0x57cc    class: 0x002540


Problems start when I try to request info or connect?



szrenica:~# hcitool info 00:0A:95:3E:C4:35
Requesting information ...
Can't create connection: Input/output error
szrenica:~# hcitool cc 00:0A:95:3E:C4:35
Can't create connection: Input/output error


The second bluetooth device which lies around here, behaves the same:

szrenica:~# hcitool info 00:60:57:AC:BA:5B
Requesting information ...
Can't create connection: Input/output error
szrenica:~# hcitool cc 00:60:57:AC:BA:5B
Can't create connection: Input/output error
szrenica:~#


Am I doing something wrong?



And after I do a l2ping 00:0A:95:3E:C4:35 and after that press any key
on the keyboard, and then run hcitool, I get this like below:

szrenica:~# hcitool info 00:0A:95:3E:C4:35
Requesting information ...
        BD Address:  00:0A:95:3E:C4:35
szrenica:~# 


And output of hcidump command while runnung the above:

< HCI Command: Remote Name Request (0x01|0x0019) plen 10
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1


(here waits for some time)


> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x08 bdaddr 00:0A:95:3E:C4:35 name ''
    Error: Connection Timeout
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x08
    Reason: Connection Timeout
< HCI Command: Read Remote Version Information (0x01|0x001d) plen 2
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 0
> HCI Event: Read Remote Ver Info Complete (0x0c) plen 8
> HCI Event: Command Complete (0x0e) plen 4
    Unknown (0x00|0x0000) ncmd 1
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Read Remote Supported Features (0x0b) plen 11
> HCI Event: Command Complete (0x0e) plen 4
    Unknown (0x00|0x0000) ncmd 1


But cc doesn't work even then.

-- 
Miernik             _________________________  xmpp:miernik@amessage.info
___________________/_______________________/      mailto:miernik@ffii.org
Protect Europe from a legal disaster. Petition against software patents
http://www.noepatents.org/index_html?LANG=en



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
