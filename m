Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43E07FE9.4060903@hotmail.com>
From: Pippo Caloggero <matheng10@hotmail.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Bluetooth stopped working:Two seamingly  strange things
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
Date: Wed, 01 Feb 2006 10:31:21 +0100

Hi! Recently my bluetooth stopped to work and I'm starting to debug the 
issue and i noticed two strange things:

The first strange thing is that the bluetooth interface does not come up 
automaticaly but i have to manually bring it up with "hciconfig hci0 up"
(if i do not that hcitool dev do not report any bluetooth devices)

The second strange thing is that the name reported for my computer by my 
phone is the same that appears in the output of "hciconfig hci0 -a", 
i.e.,  CSR - bc2 and does not reflect the Name provided in hcid.conf.

Any idea of the cause?

Moreover I have difficulties pairing the lap with, my T610 but don't 
know if it is related.

I'm using debian testing on a Dell D800 and recently upgraded to 2.6.14 
kernel.

hci0:   Type: USB
        BD Address: 00:10:C6:3A:86:E6 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:477 acl:0 sco:0 events:26 errors:0
        TX bytes:102 acl:0 sco:0 commands:23 errors:0
        Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'CSR - bc2'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.2 (0x2) HCI Rev: 0x4f2 LMP Ver: 1.2 (0x2) LMP Subver: 
0x4f2
        Manufacturer: Cambridge Silicon Radio (10)

Thank you in advance


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
