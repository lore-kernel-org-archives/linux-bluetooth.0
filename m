Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4461A33F.1060702@killesreiter.de>
From: Gerhard Killesreiter <gerhard@killesreiter.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] SCO for non-CSR based devices?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 10 May 2006 10:24:31 +0200

Hi there!

I've recently purchased a bluetooth headset and discovered that my 
bluetooth adapter (a pcmcia card, 
http://www.sphinx-elektronik.de/deutsch/bluetooth/picocard.htm) isn't 
supported by bluetooth-alsa as there is no SCO support for this type of 
device.

During my searches on the web I noticed a kernel patch that was recently 
posted to this list 
(http://article.gmane.org/gmane.linux.bluez.devel/7579). I had a look 
and indeed my card has the problem which is mentioned there, namely it 
displays SCO MTU: 64:0 (Complete output of hciconf -a is at the end of 
this mail).

Now my question is: Would this kernel patch potentially allow me to use 
my card with bluetooth-alsa? Or is the actual problem unrelated? I am 
willing to recompile my kernel and apply this patch or test others, but 
I am really no kernel hacker and so I'd appreciate some input.

Of course, I could simply go and buy a CSR based bluetooth adapter, but 
that's boring. ;)

Cheers,
    Gerhard


hci0:   Type: PCCARD
        BD Address: 00:80:37:15:74:E6 ACL MTU: 672:10 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:125 acl:0 sco:0 events:15 errors:0
        TX bytes:322 acl:0 sco:0 commands:14 errors:0
        Features: 0x07 0xea 0x31 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'theo-dhcp-42-0'
        Class: 0x100100
        Service Classes:
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0xb LMP Ver: 1.1 (0x1) LMP Subver: 0x300
        Manufacturer: Ericsson Technology Licensing (0)



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
