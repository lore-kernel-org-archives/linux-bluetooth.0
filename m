Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth Voice Setting
Message-ID: <HCEOIFALKKLBLJPENPNOKEGHCAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <4396F9AD.9020203@xmission.com>
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
Date: Wed, 7 Dec 2005 15:06:10 -0000

Hi Brad,

> Run "hciconfig hci0 revision" as root and show us the output.
>
> Also see http://bluetooth-alsa.sourceforge.net/index.html#help
>

Some more information:

**bluez packages were downloaded from the website


**[root@mdk10-voipgsm root]# hcitool info 00:0e:6d:34:bd:b1
Requesting information ...
        BD Address:  00:0e:6d:34:bd:b1
        Device Name: Nokia6310i
        LMP Version: 1.1 (0x1) LMP Subversion: 0x23b
        Manufacturer: Nokia Mobile Phones (1)
        Features: 0xbf 0x28 0x21 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <sniff mode> <SCO link>
                <HV3 packets> <CVSD> <flow control (MB)

**[root@mdk10-voipgsm root]# uname -r
2.6.3-7mdk (Mandrake 10)

**

[root@mdk10-voipgsm root]# hcitool con
Connections:
        < ACL 00:0E:6D:7A:B1:FA handle 40 state 1 lm MASTER			#When asterisk
is started and 6310i is initialised
[root@mdk10-voipgsm root]# hcitool con
Connections:
        > SCO 00:0E:6D:34:BD:B1 handle 46 state 1 lm SLAVE			#When a call is
made from the soft phone
        < ACL 00:0E:6D:34:BD:B1 handle 43 state 1 lm MASTER ENCRYPT
[root@mdk10-voipgsm root]# hcitool con
Connections:
        < ACL 00:0E:6D:34:BD:B1 handle 43 state 1 lm MASTER ENCRYPT	#After
hangup of soft phone



Kind Regards

Khaled






-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
