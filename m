Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <30238633.1124977021953.JavaMail.Administrator@appsrv>
From: Ivy <ivy@cashette.com>
To: bluez-devel@lists.sourceforge.net
Cc: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Send packets using scotest  over bluetooth
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
Date: Thu, 25 Aug 2005 06:37:01 -0700 (PDT)

Hi,

       I have two bluetooth tongles with Linux machines. I am trying to send voice over bluetooth.  For test purpose, i m using scotest program. SCO test program generates some packets with 0x7F (except First 6 Bytes). scotest program connect with another PC,authunicated successfully and starts sending data . between  i ma running hcidump -XR in the sending machine. But i am not seeing any data like going out ... But another system receiving completly 0xFF ..  MY dongle info. 

          my kernel version is 2.6.9-1.667 (FC3). anotherend 2.6.12-4. i have loaded sco modules and bluetooth service also running...

[root@ivy ~]# hciconfig hci0 version version
hci0:   Type: USB
        BD Address: 00:0B:0D:04:30:86 ACL MTU: 120:20 SCO MTU: 64:0
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x757
        Manufacturer: Silicon Wave (11)
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x757
        Manufacturer: Silicon Wave (11)

[root@ivy ~]# hciconfig hci0 features
hci0:   Type: USB
        BD Address: 00:0B:0D:04:30:86 ACL MTU: 120:20 SCO MTU: 64:0
        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
                <enhanced iscan> <interlaced iscan> <interlaced pscan>
                <AFH cap. slave> <AFH class. slave> <AFH cap. master>
                <AFH class. master>


Anytips to debug ...

Ivy
__________________________
Free 2500MB email. Stops spam 100%. No banner ads. No popup ads. http://www.cashette.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
