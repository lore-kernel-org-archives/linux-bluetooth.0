Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?iso-8859-1?q?S=E9rgio_Fernandes?= <sergiofernandes@clix.pt>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200404112025.35020.sergiofernandes@clix.pt>
Subject: [Bluez-users] Can't compile utils2
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
Date: Sun, 11 Apr 2004 20:25:35 +0100

I followed the directions in http://www.bueche.ch/comp/mx900/mx900.html but i 
get this error, after the ./configure. I created a new user account fetched 
all from cvs but ..... I think i'll give up for now ....

[sergio@johor utils2]$ ./configure --prefix=/opt/bluetooth/ 
--with-bluetooth=/opt/bluetooth/
checking whether to enable maintainer-specific portions of Makefiles... no
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ANSI C... none needed
checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
checking for a BSD-compatible install... /usr/bin/install -c
checking for ranlib... ranlib
checking for bison... bison -y
checking for flex... flex
checking for yywrap in -lfl... yes
checking lex output file root... lex.yy
checking whether yytext is a pointer... yes
checking how to run the C preprocessor... gcc -E
checking for egrep... grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking bluetooth/bluetooth.h usability... yes
checking bluetooth/bluetooth.h presence... yes
checking for bluetooth/bluetooth.h... yes
checking for bt_inquiry in -lbluetooth... yes
configure: creating ./config.status
config.status: creating Makefile
config.status: creating lib/Makefile
config.status: creating hci/Makefile
config.status: creating hid/Makefile
config.status: creating isdn/Makefile
config.status: creating compat/Makefile
config.status: creating config.h
config.status: executing depfiles commands
[sergio@johor utils2]$ make
make  all-recursive
make[1]: Entering directory `/home/sergio/data/util/bluez-cvs/utils2'
Making all in lib
make[2]: Entering directory `/home/sergio/data/util/bluez-cvs/utils2/lib'
if gcc -DHAVE_CONFIG_H -I. -I. -I..     -Wall -g -O2 -MT watch.o -MD -MP -MF 
".deps/watch.Tpo" -c -o watch.o watch.c; \
then mv -f ".deps/watch.Tpo" ".deps/watch.Po"; else rm -f ".deps/watch.Tpo"; 
exit 1; fi
if gcc -DHAVE_CONFIG_H -I. -I. -I..     -Wall -g -O2 -MT process.o -MD -MP -MF 
".deps/process.Tpo" -c -o process.o process.c; \
then mv -f ".deps/process.Tpo" ".deps/process.Po"; else rm -f 
".deps/process.Tpo"; exit 1; fi
rm -f libhelper.a
ar cru libhelper.a watch.o process.o
ranlib libhelper.a
make[2]: Leaving directory `/home/sergio/data/util/bluez-cvs/utils2/lib'
Making all in hci
make[2]: Entering directory `/home/sergio/data/util/bluez-cvs/utils2/hci'
if gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/opt/bluetooth//include    -Wall -g -O2 
-MT hcisecfilter.o -MD -MP -MF ".deps/hcisecfilter.Tpo" -c -o hcisecfilter.o 
hcisecfilter.c; \
then mv -f ".deps/hcisecfilter.Tpo" ".deps/hcisecfilter.Po"; else rm -f 
".deps/hcisecfilter.Tpo"; exit 1; fi
gcc  -Wall -g -O2  -L/opt/bluetooth//lib  -lbluetooth -o hcisecfilter  
hcisecfilter.o
if gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/opt/bluetooth//include    -Wall -g -O2 
-MT hciconfig.o -MD -MP -MF ".deps/hciconfig.Tpo" -c -o hciconfig.o 
hciconfig.c; \
then mv -f ".deps/hciconfig.Tpo" ".deps/hciconfig.Po"; else rm -f 
".deps/hciconfig.Tpo"; exit 1; fi
if gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/opt/bluetooth//include    -Wall -g -O2 
-MT ericsson.o -MD -MP -MF ".deps/ericsson.Tpo" -c -o ericsson.o ericsson.c; 
\
then mv -f ".deps/ericsson.Tpo" ".deps/ericsson.Po"; else rm -f 
".deps/ericsson.Tpo"; exit 1; fi
if gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/opt/bluetooth//include    -Wall -g -O2 
-MT csr.o -MD -MP -MF ".deps/csr.Tpo" -c -o csr.o csr.c; \
then mv -f ".deps/csr.Tpo" ".deps/csr.Po"; else rm -f ".deps/csr.Tpo"; exit 1; 
fi
gcc  -Wall -g -O2  -L/opt/bluetooth//lib  -lbluetooth -o hciconfig  
hciconfig.o ericsson.o csr.o
hciconfig.o(.text+0x2b): In function `print_dev_hdr':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:56: undefined 
reference to `ba2str'
hciconfig.o(.text+0x38):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:58: 
undefined reference to `hci_typetostr'
hciconfig.o(.text+0x4d3): In function `cmd_up':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:189: undefined 
reference to `hci_devup'
hciconfig.o(.text+0x523): In function `cmd_down':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:199: undefined 
reference to `hci_devdown'
hciconfig.o(.text+0x6ca): In function `cmd_pkttype':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:240: undefined 
reference to `hci_set_pkt_type'
hciconfig.o(.text+0x7c6): In function `cmd_linkpol':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:267: undefined 
reference to `hci_set_link_policy'
hciconfig.o(.text+0x91c): In function `cmd_linkmode':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:301: undefined 
reference to `hci_set_link_mode'
hciconfig.o(.text+0x9cc): In function `cmd_scan':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:331: undefined 
reference to `hci_open'
hciconfig.o(.text+0xaab):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:356: 
undefined reference to `hci_write_scan_enable'
hciconfig.o(.text+0xabe):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:375: 
undefined reference to `hci_close'
hciconfig.o(.text+0xadd):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:366: 
undefined reference to `hci_close'
hciconfig.o(.text+0xb0e):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:364: 
undefined reference to `hci_read_scan_enable'
hciconfig.o(.text+0xb99): In function `cmd_auth':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:394: undefined 
reference to `hci_open'
hciconfig.o(.text+0xbe4):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:407: 
undefined reference to `hci_write_authentication_enable'
hciconfig.o(.text+0xbf4):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:426: 
undefined reference to `hci_close'
hciconfig.o(.text+0xc11):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:417: 
undefined reference to `hci_close'
hciconfig.o(.text+0xc39):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:415: 
undefined reference to `hci_read_authentication_enable'
hciconfig.o(.text+0xcd9): In function `cmd_encrypt':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:446: undefined 
reference to `hci_open'
hciconfig.o(.text+0xd24):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:459: 
undefined reference to `hci_write_encryption_mode'
hciconfig.o(.text+0xd34):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:478: 
undefined reference to `hci_close'
hciconfig.o(.text+0xd51):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:469: 
undefined reference to `hci_close'
hciconfig.o(.text+0xd79):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:467: 
undefined reference to `hci_read_encryption_mode'
hciconfig.o(.text+0xe09): In function `cmd_pintype':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:497: undefined 
reference to `hci_open'
hciconfig.o(.text+0xe54):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:510: 
undefined reference to `hci_write_pin_type'
hciconfig.o(.text+0xe64):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:529: 
undefined reference to `hci_close'
hciconfig.o(.text+0xe81):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:520: 
undefined reference to `hci_close'
hciconfig.o(.text+0xea9):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:518: 
undefined reference to `hci_read_pin_type'
hciconfig.o(.text+0xf19): In function `cmd_name':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:536: undefined 
reference to `hci_open'
hciconfig.o(.text+0xf3b):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:542: 
undefined reference to `hci_write_local_name'
hciconfig.o(.text+0xf4b):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:560: 
undefined reference to `hci_close'
hciconfig.o(.text+0xf68):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:552: 
undefined reference to `hci_close'
hciconfig.o(.text+0xf87):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:550: 
undefined reference to `hci_read_local_name'
hciconfig.o(.text+0xfe5): In function `cmd_class':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:567: undefined 
reference to `hci_open'
hciconfig.o(.text+0x1025):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:577: 
undefined reference to `hci_write_class_of_device'
hciconfig.o(.text+0x1035):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:596: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1051):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:587: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1069):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:585: 
undefined reference to `hci_read_class_of_device'
hciconfig.o(.text+0x10d6): In function `cmd_voice':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:608: undefined 
reference to `hci_open'
hciconfig.o(.text+0x1109):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:616: 
undefined reference to `hci_write_voice_setting'
hciconfig.o(.text+0x1119):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:648: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1136):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:627: 
undefined reference to `hci_close'
hciconfig.o(.text+0x114e):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:625: 
undefined reference to `hci_read_voice_setting'
hciconfig.o(.text+0x1286): In function `cmd_iac':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:655: undefined 
reference to `hci_open'
hciconfig.o(.text+0x132d):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:684: 
undefined reference to `hci_write_current_iac_lap'
hciconfig.o(.text+0x1347):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:726: 
undefined reference to `hci_close'
hciconfig.o(.text+0x136e):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:712: 
undefined reference to `hci_close'
hciconfig.o(.text+0x13bb):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:696: 
undefined reference to `hci_read_number_of_supported_iac'
hciconfig.o(.text+0x13f8):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:708: 
undefined reference to `hci_read_current_iac_lap'
hciconfig.o(.text+0x14c9): In function `cmd_connto':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:733: undefined 
reference to `hci_open'
hciconfig.o(.text+0x1514):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:746: 
undefined reference to `hci_write_connection_accept_timeout'
hciconfig.o(.text+0x1524):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:767: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1541):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:756: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1569):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:754: 
undefined reference to `hci_read_connection_accept_timeout'
hciconfig.o(.text+0x15e9): In function `cmd_pageto':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:774: undefined 
reference to `hci_open'
hciconfig.o(.text+0x1634):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:787: 
undefined reference to `hci_write_page_timeout'
hciconfig.o(.text+0x1644):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:808: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1661):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:797: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1689):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:795: 
undefined reference to `hci_read_page_timeout'
hciconfig.o(.text+0x1769): In function `cmd_holdact':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:839: undefined 
reference to `hci_open'
hciconfig.o(.text+0x17b4):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:852: 
undefined reference to `hci_write_hold_mode_activity'
hciconfig.o(.text+0x17c4):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:871: 
undefined reference to `hci_close'
hciconfig.o(.text+0x17e1):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:862: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1809):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:860: 
undefined reference to `hci_read_hold_mode_activity'
hciconfig.o(.text+0x1899): In function `cmd_inqmode':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:890: undefined 
reference to `hci_open'
hciconfig.o(.text+0x18e4):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:903: 
undefined reference to `hci_write_inquiry_mode'
hciconfig.o(.text+0x18f4):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:922: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1911):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:913: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1939):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:911: 
undefined reference to `hci_read_inquiry_mode'
hciconfig.o(.text+0x19e9): In function `cmd_pscanmode':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:945: undefined 
reference to `hci_open'
hciconfig.o(.text+0x1a34):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:958: 
undefined reference to `hci_write_page_scan_mode'
hciconfig.o(.text+0x1a44):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:977: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1a61):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:968: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1a89):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:966: 
undefined reference to `hci_read_page_scan_mode'
hciconfig.o(.text+0x1b19): In function `cmd_pscantype':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:996: undefined 
reference to `hci_open'
hciconfig.o(.text+0x1b64):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1009: 
undefined reference to `hci_write_page_scan_type'
hciconfig.o(.text+0x1b74):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1028: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1b91):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1019: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1bb9):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1017: 
undefined reference to `hci_read_page_scan_type'
hciconfig.o(.text+0x1c29): In function `cmd_pscanact':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1035: undefined 
reference to `hci_open'
hciconfig.o(.text+0x1c89):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1051: 
undefined reference to `hci_write_page_scan_activity'
hciconfig.o(.text+0x1c99):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1075: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1cb6):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1061: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1ce0):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1059: 
undefined reference to `hci_read_page_scan_activity'
hciconfig.o(.text+0x1da9): In function `cmd_iscantype':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1094: undefined 
reference to `hci_open'
hciconfig.o(.text+0x1df4):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1107: 
undefined reference to `hci_write_inquiry_scan_type'
hciconfig.o(.text+0x1e04):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1126: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1e21):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1117: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1e49):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1115: 
undefined reference to `hci_read_inquiry_scan_type'
hciconfig.o(.text+0x1eb9): In function `cmd_iscanact':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1133: undefined 
reference to `hci_open'
hciconfig.o(.text+0x1f19):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1149: 
undefined reference to `hci_write_inquiry_scan_activity'
hciconfig.o(.text+0x1f29):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1175: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1f46):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1161: 
undefined reference to `hci_close'
hciconfig.o(.text+0x1f70):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1158: 
undefined reference to `hci_read_inquiry_scan_activity'
hciconfig.o(.text+0x2039): In function `cmd_afhmode':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1194: undefined 
reference to `hci_open'
hciconfig.o(.text+0x2084):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1207: 
undefined reference to `hci_write_afh_channel_assessment_mode'
hciconfig.o(.text+0x2094):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1226: 
undefined reference to `hci_close'
hciconfig.o(.text+0x20b1):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1217: 
undefined reference to `hci_close'
hciconfig.o(.text+0x20d9):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1215: 
undefined reference to `hci_read_afh_channel_assessment_mode'
hciconfig.o(.text+0x2144): In function `cmd_newunitkey':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1233: undefined 
reference to `hci_open'
hciconfig.o(.text+0x2156):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1238: 
undefined reference to `hci_create_new_unit_key'
hciconfig.o(.text+0x2180):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1240: 
undefined reference to `hci_close'
hciconfig.o(.text+0x21dd): In function `cmd_features':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1258: undefined 
reference to `hci_open'
hciconfig.o(.text+0x21fa):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1263: 
undefined reference to `hci_read_local_extended_features'
hciconfig.o(.text+0x2225):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1279: 
undefined reference to `hci_close'
hciconfig.o(.text+0x227a):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1266: 
undefined reference to `hci_close'
hciconfig.o(.text+0x22b6): In function `cmd_commands':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1287: undefined 
reference to `hci_open'
hciconfig.o(.text+0x22d3):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1292: 
undefined reference to `hci_read_local_supported_commands'
hciconfig.o(.text+0x2306):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1311: 
undefined reference to `hci_close'
hciconfig.o(.text+0x2395):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1294: 
undefined reference to `hci_close'
hciconfig.o(.text+0x23d5): In function `cmd_version':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1320: undefined 
reference to `hci_open'
hciconfig.o(.text+0x23fe):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1325: 
undefined reference to `hci_read_local_version_information'
hciconfig.o(.text+0x2422):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1337: 
undefined reference to `bt_compidtostr'
hciconfig.o(.text+0x243c):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1337: 
undefined reference to `hci_vertostr'
hciconfig.o(.text+0x2455):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1337: 
undefined reference to `hci_vertostr'
hciconfig.o(.text+0x246b):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1343: 
undefined reference to `hci_close'
hciconfig.o(.text+0x2487):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1328: 
undefined reference to `hci_close'
hciconfig.o(.text+0x24c8): In function `cmd_revision':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1353: undefined 
reference to `hci_open'
hciconfig.o(.text+0x24ed):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1358: 
undefined reference to `hci_read_local_version_information'
hciconfig.o(.text+0x2549):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1426: 
undefined reference to `hci_close'
hciconfig.o(.text+0x2565):/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1376: 
undefined reference to `hci_close'
hciconfig.o(.text+0x2990): In function `__print_dev_info':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1491: undefined 
reference to `hci_devinfo'
hciconfig.o(.text+0x29c2): In function `print_dev_list':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1499: undefined 
reference to `hci_foreach'
hciconfig.o(.text+0x2b37): In function `main':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1601: undefined 
reference to `hci_devinfo'
hciconfig.o(.text+0x216b): In function `cmd_newunitkey':
/home/sergio/data/util/bluez-cvs/utils2/hci/hciconfig.c:1244: undefined 
reference to `hci_close'
ericsson.o(.text+0x55): In function `ericsson_read_revision_information':
/home/sergio/data/util/bluez-cvs/utils2/hci/ericsson.c:59: undefined reference 
to `hci_send_request'
ericsson.o(.text+0xa8):/home/sergio/data/util/bluez-cvs/utils2/hci/ericsson.c:63: 
undefined reference to `hci_errno'
csr.o(.text+0x1d0): In function `csr_read_varid_uint16':
/home/sergio/data/util/bluez-cvs/utils2/hci/csr.c:301: undefined reference to 
`hci_send_request'
csr.o(.text+0x340): In function `csr_read_pskey_uint16':
/home/sergio/data/util/bluez-cvs/utils2/hci/csr.c:341: undefined reference to 
`hci_send_request'
collect2: ld returned 1 exit status
make[2]: *** [hciconfig] Error 1
make[2]: Leaving directory `/home/sergio/data/util/bluez-cvs/utils2/hci'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/sergio/data/util/bluez-cvs/utils2'
make: *** [all] Error 2




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
