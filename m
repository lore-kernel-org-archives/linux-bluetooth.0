Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Andres Meyer <andres.meyer@computer.org>
Message-ID: <loom.20041114T204627-795@post.gmane.org>
References: <loom.20041114T133356-876@post.gmane.org> <1100449789.21403.47.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: BlueLogic Wingkey problems
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 14 Nov 2004 19:53:19 +0000 (UTC)

Marcel Holtmann <marcel <at> holtmann.org> writes: 
 
> first I need some more information about this device 
>  
>  hcitool inq 
>  hcitool scan 
>  hcitool info 00:xx:xx:xx:xx:xx 
 
bash-2.05b# hcitool inq 
Inquiring ... 
        00:02:72:40:8A:DC       clock offset: 0x582d    class: 0x002540 
bash-2.05b# hcitool scan 
Scanning ... 
        00:02:72:40:8A:DC       BlueLogic Keyboard 
bash-2.05b# hcitool info 00:02:72:40:8A:DC 
Requesting information ... 
        BD Address:  00:02:72:40:8A:DC 
        Device Name: BlueLogic Keyboard 
        LMP Version: 1.1 (0x1) LMP Subversion: 0x1a5 
        Manufacturer: Cambridge Silicon Radio (10) 
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00 
                <3-slot packets> <5-slot packets> <encryption> <slot offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode> 
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
                <power control> <transparent SCO> 
  
> Then compile the libs2 CVS repository and run 
>  
>  ./test/sdptest records 00:xx:xx:xx:xx:xx > sdp_records.txt 
>  
> and send me the file sdp_records.txt. 
 
Sorry, I only have a gmane interface for now (no attachements) -> inline. I can 
resend with an attachement tomorrow. 
 
bash-2.05b# ./sdptest records 00:02:72:40:8A:DC 
Sequence 
        Attribute 0x0000 - Service record handle 
                UINT32 0x00010000 
        Attribute 0x0001 - Service class ID list 
                Sequence 
                        UUID16 0x1124 - Human Interface Device Service 
        Attribute 0x0004 - Protocol descriptor list 
                Sequence 
                        Sequence 
                                UUID16 0x0100 - L2CAP 
                                UINT16 0x0011 
                        Sequence 
                                UUID16 0x0011 - HIDP 
        Attribute 0x0006 - Language base attribute ID list 
                Sequence 
                        UINT16 0x656e 
                        UINT16 0x006a 
                        UINT16 0x0100 
        Attribute 0x0009 - Bluetooth profile descriptor list 
                Sequence 
                        Sequence 
                                UUID16 0x0011 - HIDP 
                                UINT16 0x0100 
        Attribute 0x000d - Additional protocol descriptor lists 
                Sequence 
                        Sequence 
                                UUID16 0x0100 - L2CAP 
                                UINT16 0x0013 
                        Sequence 
                                UUID16 0x0011 - HIDP 
        Attribute 0x0200 
                UINT16 0x0100 
        Attribute 0x0201 
                UINT16 0x0111 
        Attribute 0x0202 
                UINT8 0x40 
        Attribute 0x0203 
                UINT8 0x21 
        Attribute 0x0204 
                Bool True 
        Attribute 0x0205 
                Bool True 
        Attribute 0x0206 
                Sequence 
                        Sequence 
                                UINT8 0x22 
                                String 05 01 09 06 a1 01 85 01 05 07 19 e0 29 
e7 15 00 25 01 75 01 95 08 81 02 95 01 7508 81 01 95 05 75 01 05 08 19 01 29 05 
91 02 95 01 75 03 91 01 95 05 75 08 15 00 25 65 05 07 19 00 29 ff 81 00 c0 05 
0109 02 a1 01 85 02 09 01 a1 00 05 09 19 01 29 03 15 00 25 01 95 03 75 01 81 02 
95 01 75 05 81 01 05 01 09 30 09 31 09 3815 81 25 7f 95 03 75 08 81 06 c0 c0 05 
0c 09 01 a1 01 85 03 15 00 25 01 09 e9 09 ea 75 01 95 02 81 02 95 06 81 01 c0 
0501 09 80 a1 01 85 04 19 81 29 83 15 00 25 01 75 01 95 03 81 02 75 05 95 01 81 
01 c0 05 0c 09 01 a1 01 85 05 95 08 75 0115 00 25 01 0a 93 01 0a cd 00 0a b7 00 
0a e2 00 0a ea 00 0a e9 00 0a 2a 02 0a 23 02 81 02 05 0c 0a 27 02 0a 8a 01 0a 
2602 15 00 25 01 95 03 75 01 81 02 95 05 75 01 81 01 c0 
        Attribute 0x0207 
                Sequence 
                        Sequence 
                                UINT16 0x0309 
                                UINT16 0x0100 
        Attribute 0x0208 
                Bool False 
        Attribute 0x0209 
                Bool True 
        Attribute 0x020a 
                Bool True 
        Attribute 0x020b 
                UINT16 0x0100 
        Attribute 0x020c 
                UINT16 0x1f40 
        Attribute 0x020d 
                Bool False 
        Attribute 0x020e 
                Bool True 
 
 
 
> > config:  
> > - vanilla 2.6.9 kernel  
> > - x86  
> > - tried with planet and epox usb bt adapters  
> > - gentoo setup, with hidd etc. installed and enabled.  
>  
> Use a 2.6.9-mh3 kernel and see if this helps. 
 
will try this as soon as I have time (hopefully tomorrow). 
 
Thx, that was a very fast response. 
 
Andres 
 
 
 
 



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
