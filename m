Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: cuanyu <s4048156@student.uq.edu.au>
Reply-To: s4048156@student.uq.edu.au
To: bluez-devel <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1085049688.4556.37.camel@tom.mshome>
Mime-Version: 1.0
Subject: [Bluez-devel] I can't hstest to replay the audio file recorded by hstest
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 20 May 2004 20:41:28 +1000

Sorry for repeating this question again. But my last post is in a very
bad style, so I decide to make it clear.
I am using Fedor core 1 and all the USB Bluetooth option are selected as
module. I am using a CSR based USB dongle and here is its information:
I have changed my bluetooth dongle and it is based on CSR chip:
[cuanyu@tom sbin]$ ./hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:02:72:02:02:E7 ACL MTU: 192:8  SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)
[cuanyu@tom sbin]$ ./hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:02:72:02:02:E7 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 16.4 (bc02x)
Right now I can use hstest to record the audio from the headset very
well and the file could be replayed by sox like this:
sox -t raw -r 8000 -c 1 -w -s recorded -t ossdsp -w -s /dev/dsp

But I can't replay the recorded file by "hstest play recorded ...". All
I can hear is just very sharp noise. The SCO packets are routed through
HCI instead of the PCM interface because I can see SCO packets in the
hcidump result. 



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
