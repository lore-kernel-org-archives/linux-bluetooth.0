Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4302F91F.7020202@umit.at>
From: David Bannach <david.bannach@umit.at>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] SCO over UART
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
Date: Wed, 17 Aug 2005 10:45:19 +0200

hi,

i'm using an ericsson "ROK 101008" bluetooth module and kernel 2.6.10. 
the module can be connected via usb or rs232. and i found an ericsson 
specific hci command to switch the sco-path to HCI (it is set to PCM by 
default).

using the usb connection (hci_usb) everything works fine and i can send 
and receive audio to/from a headset. however, when connecting the module 
via serial cable (hci_uart) sending and receiving audio does not work. 
the sco connection to the headset is established but there is no sco 
data transferred. i tried to attach the device with different speeds but 
i did not notice any difference. i really need the serial connection 
because usb is not available on the target system. can somebody help me 
with this topic?

# hciconfig hci0 -a
hci0:   Type: UART
        BD Address: 00:80:00:00:00:00 ACL MTU: 672:8 SCO MTU: 64:0
        UP RUNNING
        RX bytes:97 acl:0 sco:0 events:10 errors:0
        TX bytes:50 acl:0 sco:0 commands:9 errors:0
        Features: 0xff 0xfb 0x01 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: ''
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x8103 LMP Ver: 1.1 (0x1) LMP 
Subver: 0x8b40
        Manufacturer: Ericsson Technology Licensing (0)



david



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
