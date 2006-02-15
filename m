Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43F35C5A.4090005@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] A2DP doesnt work after a clean reset
References: <43F354E6.2040209@cs.bgu.ac.il>
In-Reply-To: <43F354E6.2040209@cs.bgu.ac.il>
Content-Type: text/plain; charset=UTF-8
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
Date: Wed, 15 Feb 2006 09:52:42 -0700

Niv

it looks like a problem with the pairing being "half" broken. There are
some tips near the bottom of the bluetooth-alsa.sf.net page for
resetting the pairing.

Brad

> $ mpg123 --au -
> "mp3/imogen_heap/speak_for_yourself/goodnight_and_go.mp3" |
> /usr/bin/a2play -v 00:0D:44:44:90:F3
> 
> 
> High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
> 
> Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
> Uses code from various people. See 'README' for more!
> THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!
> subbands = 8 blocks = 16 bitpool = 32
> Title  : 02                              Artist: Imogen
> Heap                  Album  : Speak For Yourself              Year  : 2005
> Comment:                                 Genre :
> Pop                         
> Directory: mp3/imogen_heap/speak_for_yourself/
> Playing MPEG stream from goodnight_and_go.mp3 ...
> MPEG 1.0 layer III, 128 kbit/s, 44100 Hz joint-stereo
> len=2048
> Header size=28
> Sample Rate:44100
> Channels:2
> Using address: 00:0D:44:44:90:F3
> Warning: failed to connect to SDP server: Function not implemented
> Found A2DP Sink at the destination
> Can't connect to F3:90:44:44:0D:00. Function not implemented(38)
> cannot open psm_cmd = 25
> 
> 
> HCI sniffer - Bluetooth packet analyzer ver 1.29
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>    bdaddr 00:0D:44:44:90:F3 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>> HCI Event: Command Status (0x0f) plen 4
>    Create Connection (0x01|0x0005) status 0x00 ncmd 1
>> HCI Event: Connect Complete (0x03) plen 11
>    status 0x22 handle 41 bdaddr 00:0D:44:44:90:F3 type ACL encrypt 0x00
>    Error: LMP Response Timeout
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>    bdaddr 00:0D:44:44:90:F3 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>> HCI Event: Command Status (0x0f) plen 4
>    Create Connection (0x01|0x0005) status 0x00 ncmd 1
>> HCI Event: Connect Complete (0x03) plen 11
>    status 0x22 handle 42 bdaddr 00:0D:44:44:90:F3 type ACL encrypt 0x00
>    Error: LMP Response Timeout
> 
> 
> $uname -a
> 
> Linux blacky 2.6.15-ck3 #7 Sat Feb 11 23:00:51 IST 2006 i686 AMD
> Athlon(tm) XP 3200+ AuthenticAMD GNU/Linux
> 
> 
> 
> I had to take the adaptor out of the usb , and back in again, then it
> worked.
> 
>   status 0x00
> < HCI Command: Write Class of Device (0x03|0x0024) plen 3
>    class 0x3e0100
>> HCI Event: Command Complete (0x0e) plen 4
>    Write Class of Device (0x03|0x0024) ncmd 1
>    status 0x00
> < HCI Command: Read Local Name (0x03|0x0014) plen 0
>> HCI Event: Command Complete (0x0e) plen 252
>    Read Local Name (0x03|0x0014) ncmd 1
>    status 0x00 name 'blacky does BT device (0)'
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>    bdaddr 00:0D:44:44:90:F3 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>> HCI Event: Command Status (0x0f) plen 4
>    Create Connection (0x01|0x0005) status 0x00 ncmd 1
>> HCI Event: Link Key Request (0x17) plen 6
>    bdaddr 00:0D:44:44:90:F3
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>    bdaddr 00:0D:44:44:90:F3 key A5F320868AAF3646F25E668A28C35E9C
>> HCI Event: Command Complete (0x0e) plen 10
>    Link Key Request Reply (0x01|0x000b) ncmd 1
>    status 0x00 bdaddr 00:0D:44:44:90:F3
>> HCI Event: Connect Complete (0x03) plen 11
>    status 0x00 handle 41 bdaddr 00:0D:44:44:90:F3 type ACL encrypt 0x00
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>    handle 41 policy 0x0f
>    Link policy: RSWITCH HOLD SNIFF PARK
> < ACL data: handle 41 flags 0x02 dlen 52
>    L2CAP(s): Echo req: dlen 44
>    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
>    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
>    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
>> HCI Event: Number of Completed Packets (0x13) plen 5
>    handle 41 packets 1
>> HCI Event: Command Complete (0x0e) plen 6
>    Write Link Policy Settings (0x02|0x000d) ncmd 1
>    status 0x00 handle 41
>> ACL data: handle 41 flags 0x02 dlen 52
>    L2CAP(s): Echo rsp: dlen 44
>    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
>    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
>    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
>> HCI Event: Max Slots Change (0x1b) plen 3
>    handle 41 slots 5
> < ACL data: handle 41 flags 0x02 dlen 52
>    L2CAP(s): Echo req: dlen 44
>    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
>    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
>    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
>> HCI Event: Number of Completed Packets (0x13) plen 5
>    handle 41 packets 1
> < ACL data: handle 41 flags 0x02 dlen 52
>    L2CAP(s): Echo req: dlen 44
>    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
>    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
>    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
>> HCI Event: Number of Completed Packets (0x13) plen 5
>    handle 41 packets 1
> < ACL data: handle 41 flags 0x02 dlen 52
>    L2CAP(s): Echo req: dlen 44
>    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
>    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
>    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
>> HCI Event: Number of Completed Packets (0x13) plen 5
>    handle 41 packets 1
> 
> 
>> HCI Event: Number of Completed Packets (0x13) plen 5
>    handle 41 packets 1
> < ACL data: handle 41 flags 0x02 dlen 52
>    L2CAP(s): Echo req: dlen 44
>    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
>    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
>    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
> < ACL data: handle 41 flags 0x02 dlen 52
>    L2CAP(s): Echo req: dlen 44
>    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
>    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
>    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
>> HCI Event: Disconn Complete (0x05) plen 4
>    status 0x00 handle 41 reason 0x08
>    Reason: Connection Timeout
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>    bdaddr 00:0D:44:44:90:F3 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>> HCI Event: Command Status (0x0f) plen 4
>    Create Connection (0x01|0x0005) status 0x00 ncmd 1
>> HCI Event: Link Key Request (0x17) plen 6
>    bdaddr 00:0D:44:44:90:F3
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>    bdaddr 00:0D:44:44:90:F3 key A5F320868AAF3646F25E668A28C35E9C
>> HCI Event: Command Complete (0x0e) plen 10
>    Link Key Request Reply (0x01|0x000b) ncmd 1
>    status 0x00 bdaddr 00:0D:44:44:90:F3
>> HCI Event: Connect Complete (0x03) plen 11
>    status 0x00 handle 42 bdaddr 00:0D:44:44:90:F3 type ACL encrypt 0x00
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>    handle 42 policy 0x0f
>    Link policy: RSWITCH HOLD SNIFF PARK
> < ACL data: handle 42 flags 0x02 dlen 52
>    L2CAP(s): Echo req: dlen 44
>    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
>    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
>    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
>> HCI Event: Number of Completed Packets (0x13) plen 5
>    handle 42 packets 1
>> HCI Event: Command Complete (0x0e) plen 6
>    Write Link Policy Settings (0x02|0x000d) ncmd 1
>    status 0x00 handle 42
>> HCI Event: Max Slots Change (0x1b) plen 3
>    handle 42 slots 5
> < ACL data: handle 42 flags 0x02 dlen 52
>    L2CAP(s): Echo req: dlen 44
>    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
>    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
>    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
>> HCI Event: Number of Completed Packets (0x13) plen 5
>    handle 42 packets 1
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>    handle 42 reason 0x13
>    Reason: Remote User Terminated Connection
>> HCI Event: Command Status (0x0f) plen 4
>    Disconnect (0x01|0x0006) status 0x00 ncmd 1
>> HCI Event: Disconn Complete (0x05) plen 4
>    status 0x00 handle 42 reason 0x16
>    Reason: Connection Terminated by Local Host
> Receive failed: Broken pipe
> < HCI Command: Reset (0x03|0x0003) plen 0
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
