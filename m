Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?iso-8859-1?q?S=E9rgio_Alcides_Fernandes?= <sergiofernandes@clix.pt>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404082156.34239.sergiofernandes@clix.pt>
Subject: [Bluez-users] error compiling utils2
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
Date: Thu, 8 Apr 2004 21:56:34 +0100

Thks Marcel, but now i get this error compiling utils2:

/root/utils2/hci/hciconfig.c:56: undefined reference to `ba2str'
hciconfig.o(.text+0x38):/root/utils2/hci/hciconfig.c:58: undefined referenc=
e=20
to `hci_typetostr'
hciconfig.o(.text+0x4d3): In function `cmd_up':
/root/utils2/hci/hciconfig.c:189: undefined reference to `hci_devup'
hciconfig.o(.text+0x523): In function `cmd_down':
/root/utils2/hci/hciconfig.c:199: undefined reference to `hci_devdown'
hciconfig.o(.text+0x6ca): In function `cmd_pkttype':
/root/utils2/hci/hciconfig.c:240: undefined reference to `hci_set_pkt_type'
hciconfig.o(.text+0x7c6): In function `cmd_linkpol':
/root/utils2/hci/hciconfig.c:267: undefined reference to `hci_set_link_poli=
cy'
hciconfig.o(.text+0x91c): In function `cmd_linkmode':
/root/utils2/hci/hciconfig.c:301: undefined reference to `hci_set_link_mode'
hciconfig.o(.text+0x9cc): In function `cmd_scan':
/root/utils2/hci/hciconfig.c:331: undefined reference to `hci_open'
hciconfig.o(.text+0xaab):/root/utils2/hci/hciconfig.c:356: undefined refere=
nce=20
to `hci_write_scan_enable'
hciconfig.o(.text+0xabe):/root/utils2/hci/hciconfig.c:375: undefined refere=
nce=20
to `hci_close'
hciconfig.o(.text+0xadd):/root/utils2/hci/hciconfig.c:366: undefined refere=
nce=20
to `hci_close'
hciconfig.o(.text+0xb0e):/root/utils2/hci/hciconfig.c:364: undefined refere=
nce=20
to `hci_read_scan_enable'
hciconfig.o(.text+0xb99): In function `cmd_auth':
/root/utils2/hci/hciconfig.c:394: undefined reference to `hci_open'
hciconfig.o(.text+0xbe4):/root/utils2/hci/hciconfig.c:407: undefined refere=
nce=20
to `hci_write_authentication_enable'
hciconfig.o(.text+0xbf4):/root/utils2/hci/hciconfig.c:426: undefined refere=
nce=20
to `hci_close'
hciconfig.o(.text+0xc11):/root/utils2/hci/hciconfig.c:417: undefined refere=
nce=20
to `hci_close'
hciconfig.o(.text+0xc39):/root/utils2/hci/hciconfig.c:415: undefined refere=
nce=20
to `hci_read_authentication_enable'
hciconfig.o(.text+0xcd9): In function `cmd_encrypt':
/root/utils2/hci/hciconfig.c:446: undefined reference to `hci_open'
hciconfig.o(.text+0xd24):/root/utils2/hci/hciconfig.c:459: undefined refere=
nce=20
to `hci_write_encryption_mode'
hciconfig.o(.text+0xd34):/root/utils2/hci/hciconfig.c:478: undefined refere=
nce=20
to `hci_close'
hciconfig.o(.text+0xd51):/root/utils2/hci/hciconfig.c:469: undefined refere=
nce=20
to `hci_close'
hciconfig.o(.text+0xd79):/root/utils2/hci/hciconfig.c:467: undefined refere=
nce=20
to `hci_read_encryption_mode'
hciconfig.o(.text+0xe09): In function `cmd_pintype':
/root/utils2/hci/hciconfig.c:497: undefined reference to `hci_open'
hciconfig.o(.text+0xe54):/root/utils2/hci/hciconfig.c:510: undefined refere=
nce=20
to `hci_write_pin_type'
hciconfig.o(.text+0xe64):/root/utils2/hci/hciconfig.c:529: undefined refere=
nce=20
to `hci_close'
hciconfig.o(.text+0xe81):/root/utils2/hci/hciconfig.c:520: undefined refere=
nce=20
to `hci_close'
hciconfig.o(.text+0xea9):/root/utils2/hci/hciconfig.c:518: undefined refere=
nce=20
to `hci_read_pin_type'
hciconfig.o(.text+0xf19): In function `cmd_name':
/root/utils2/hci/hciconfig.c:536: undefined reference to `hci_open'
hciconfig.o(.text+0xf3b):/root/utils2/hci/hciconfig.c:542: undefined refere=
nce=20
to `hci_write_local_name'
hciconfig.o(.text+0xf4b):/root/utils2/hci/hciconfig.c:560: undefined refere=
nce=20
to `hci_close'
hciconfig.o(.text+0xf68):/root/utils2/hci/hciconfig.c:552: undefined refere=
nce=20
to `hci_close'
hciconfig.o(.text+0xf87):/root/utils2/hci/hciconfig.c:550: undefined refere=
nce=20
to `hci_read_local_name'
hciconfig.o(.text+0xfe5): In function `cmd_class':
/root/utils2/hci/hciconfig.c:567: undefined reference to `hci_open'
hciconfig.o(.text+0x1025):/root/utils2/hci/hciconfig.c:577: undefined=20
reference to `hci_write_class_of_device'
hciconfig.o(.text+0x1035):/root/utils2/hci/hciconfig.c:596: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1051):/root/utils2/hci/hciconfig.c:587: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1069):/root/utils2/hci/hciconfig.c:585: undefined=20
reference to `hci_read_class_of_device'
hciconfig.o(.text+0x10d6): In function `cmd_voice':
/root/utils2/hci/hciconfig.c:608: undefined reference to `hci_open'
hciconfig.o(.text+0x1109):/root/utils2/hci/hciconfig.c:616: undefined=20
reference to `hci_write_voice_setting'
hciconfig.o(.text+0x1119):/root/utils2/hci/hciconfig.c:648: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1136):/root/utils2/hci/hciconfig.c:627: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x114e):/root/utils2/hci/hciconfig.c:625: undefined=20
reference to `hci_read_voice_setting'
hciconfig.o(.text+0x1286): In function `cmd_iac':
/root/utils2/hci/hciconfig.c:655: undefined reference to `hci_open'
hciconfig.o(.text+0x132d):/root/utils2/hci/hciconfig.c:684: undefined=20
reference to `hci_write_current_iac_lap'
hciconfig.o(.text+0x1347):/root/utils2/hci/hciconfig.c:726: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x136e):/root/utils2/hci/hciconfig.c:712: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x13bb):/root/utils2/hci/hciconfig.c:696: undefined=20
reference to `hci_read_number_of_supported_iac'
hciconfig.o(.text+0x13f8):/root/utils2/hci/hciconfig.c:708: undefined=20
reference to `hci_read_current_iac_lap'
hciconfig.o(.text+0x14c9): In function `cmd_connto':
/root/utils2/hci/hciconfig.c:733: undefined reference to `hci_open'
hciconfig.o(.text+0x1514):/root/utils2/hci/hciconfig.c:746: undefined=20
reference to `hci_write_connection_accept_timeout'
hciconfig.o(.text+0x1524):/root/utils2/hci/hciconfig.c:767: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1541):/root/utils2/hci/hciconfig.c:756: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1569):/root/utils2/hci/hciconfig.c:754: undefined=20
reference to `hci_read_connection_accept_timeout'
hciconfig.o(.text+0x15e9): In function `cmd_pageto':
/root/utils2/hci/hciconfig.c:774: undefined reference to `hci_open'
hciconfig.o(.text+0x1634):/root/utils2/hci/hciconfig.c:787: undefined=20
reference to `hci_write_page_timeout'
hciconfig.o(.text+0x1644):/root/utils2/hci/hciconfig.c:808: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1661):/root/utils2/hci/hciconfig.c:797: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1689):/root/utils2/hci/hciconfig.c:795: undefined=20
reference to `hci_read_page_timeout'
hciconfig.o(.text+0x1769): In function `cmd_holdact':
/root/utils2/hci/hciconfig.c:839: undefined reference to `hci_open'
hciconfig.o(.text+0x17b4):/root/utils2/hci/hciconfig.c:852: undefined=20
reference to `hci_write_hold_mode_activity'
hciconfig.o(.text+0x17c4):/root/utils2/hci/hciconfig.c:871: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x17e1):/root/utils2/hci/hciconfig.c:862: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1809):/root/utils2/hci/hciconfig.c:860: undefined=20
reference to `hci_read_hold_mode_activity'
hciconfig.o(.text+0x1899): In function `cmd_inqmode':
/root/utils2/hci/hciconfig.c:890: undefined reference to `hci_open'
hciconfig.o(.text+0x18e4):/root/utils2/hci/hciconfig.c:903: undefined=20
reference to `hci_write_inquiry_mode'
hciconfig.o(.text+0x18f4):/root/utils2/hci/hciconfig.c:922: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1911):/root/utils2/hci/hciconfig.c:913: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1939):/root/utils2/hci/hciconfig.c:911: undefined=20
reference to `hci_read_inquiry_mode'
hciconfig.o(.text+0x19e9): In function `cmd_pscanmode':
/root/utils2/hci/hciconfig.c:945: undefined reference to `hci_open'
hciconfig.o(.text+0x1a34):/root/utils2/hci/hciconfig.c:958: undefined=20
reference to `hci_write_page_scan_mode'
hciconfig.o(.text+0x1a44):/root/utils2/hci/hciconfig.c:977: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1a61):/root/utils2/hci/hciconfig.c:968: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1a89):/root/utils2/hci/hciconfig.c:966: undefined=20
reference to `hci_read_page_scan_mode'
hciconfig.o(.text+0x1b19): In function `cmd_pscantype':
/root/utils2/hci/hciconfig.c:996: undefined reference to `hci_open'
hciconfig.o(.text+0x1b64):/root/utils2/hci/hciconfig.c:1009: undefined=20
reference to `hci_write_page_scan_type'
hciconfig.o(.text+0x1b74):/root/utils2/hci/hciconfig.c:1028: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1b91):/root/utils2/hci/hciconfig.c:1019: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1bb9):/root/utils2/hci/hciconfig.c:1017: undefined=20
reference to `hci_read_page_scan_type'
hciconfig.o(.text+0x1c29): In function `cmd_pscanact':
/root/utils2/hci/hciconfig.c:1035: undefined reference to `hci_open'
hciconfig.o(.text+0x1c89):/root/utils2/hci/hciconfig.c:1051: undefined=20
reference to `hci_write_page_scan_activity'
hciconfig.o(.text+0x1c99):/root/utils2/hci/hciconfig.c:1075: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1cb6):/root/utils2/hci/hciconfig.c:1061: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1ce0):/root/utils2/hci/hciconfig.c:1059: undefined=20
reference to `hci_read_page_scan_activity'
hciconfig.o(.text+0x1da9): In function `cmd_iscantype':
/root/utils2/hci/hciconfig.c:1094: undefined reference to `hci_open'
hciconfig.o(.text+0x1df4):/root/utils2/hci/hciconfig.c:1107: undefined=20
reference to `hci_write_inquiry_scan_type'
hciconfig.o(.text+0x1e04):/root/utils2/hci/hciconfig.c:1126: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1e21):/root/utils2/hci/hciconfig.c:1117: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1e49):/root/utils2/hci/hciconfig.c:1115: undefined=20
reference to `hci_read_inquiry_scan_type'
hciconfig.o(.text+0x1eb9): In function `cmd_iscanact':
/root/utils2/hci/hciconfig.c:1133: undefined reference to `hci_open'
hciconfig.o(.text+0x1f19):/root/utils2/hci/hciconfig.c:1149: undefined=20
reference to `hci_write_inquiry_scan_activity'
hciconfig.o(.text+0x1f29):/root/utils2/hci/hciconfig.c:1175: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1f46):/root/utils2/hci/hciconfig.c:1161: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x1f70):/root/utils2/hci/hciconfig.c:1158: undefined=20
reference to `hci_read_inquiry_scan_activity'
hciconfig.o(.text+0x2039): In function `cmd_afhmode':
/root/utils2/hci/hciconfig.c:1194: undefined reference to `hci_open'
hciconfig.o(.text+0x2084):/root/utils2/hci/hciconfig.c:1207: undefined=20
reference to `hci_write_afh_channel_assessment_mode'
hciconfig.o(.text+0x2094):/root/utils2/hci/hciconfig.c:1226: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x20b1):/root/utils2/hci/hciconfig.c:1217: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x20d9):/root/utils2/hci/hciconfig.c:1215: undefined=20
reference to `hci_read_afh_channel_assessment_mode'
hciconfig.o(.text+0x2144): In function `cmd_newunitkey':
/root/utils2/hci/hciconfig.c:1233: undefined reference to `hci_open'
hciconfig.o(.text+0x2156):/root/utils2/hci/hciconfig.c:1238: undefined=20
reference to `hci_create_new_unit_key'
hciconfig.o(.text+0x2180):/root/utils2/hci/hciconfig.c:1240: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x21dd): In function `cmd_features':
/root/utils2/hci/hciconfig.c:1258: undefined reference to `hci_open'
hciconfig.o(.text+0x21fa):/root/utils2/hci/hciconfig.c:1263: undefined=20
reference to `hci_read_local_extended_features'
hciconfig.o(.text+0x2225):/root/utils2/hci/hciconfig.c:1279: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x227a):/root/utils2/hci/hciconfig.c:1266: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x22b6): In function `cmd_commands':
/root/utils2/hci/hciconfig.c:1287: undefined reference to `hci_open'
hciconfig.o(.text+0x22d3):/root/utils2/hci/hciconfig.c:1292: undefined=20
reference to `hci_read_local_supported_commands'
hciconfig.o(.text+0x2306):/root/utils2/hci/hciconfig.c:1311: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x2395):/root/utils2/hci/hciconfig.c:1294: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x23d5): In function `cmd_version':
/root/utils2/hci/hciconfig.c:1320: undefined reference to `hci_open'
hciconfig.o(.text+0x23fe):/root/utils2/hci/hciconfig.c:1325: undefined=20
reference to `hci_read_local_version_information'
hciconfig.o(.text+0x2422):/root/utils2/hci/hciconfig.c:1337: undefined=20
reference to `bt_compidtostr'
hciconfig.o(.text+0x243c):/root/utils2/hci/hciconfig.c:1337: undefined=20
reference to `hci_vertostr'
hciconfig.o(.text+0x2455):/root/utils2/hci/hciconfig.c:1337: undefined=20
reference to `hci_vertostr'
hciconfig.o(.text+0x246b):/root/utils2/hci/hciconfig.c:1343: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x2487):/root/utils2/hci/hciconfig.c:1328: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x24c8): In function `cmd_revision':
/root/utils2/hci/hciconfig.c:1353: undefined reference to `hci_open'
hciconfig.o(.text+0x24ed):/root/utils2/hci/hciconfig.c:1358: undefined=20
reference to `hci_read_local_version_information'
hciconfig.o(.text+0x2549):/root/utils2/hci/hciconfig.c:1426: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x2565):/root/utils2/hci/hciconfig.c:1376: undefined=20
reference to `hci_close'
hciconfig.o(.text+0x2990): In function `__print_dev_info':
/root/utils2/hci/hciconfig.c:1491: undefined reference to `hci_devinfo'
hciconfig.o(.text+0x29c2): In function `print_dev_list':
/root/utils2/hci/hciconfig.c:1499: undefined reference to `hci_foreach'
hciconfig.o(.text+0x2b37): In function `main':
/root/utils2/hci/hciconfig.c:1601: undefined reference to `hci_devinfo'
hciconfig.o(.text+0x216b): In function `cmd_newunitkey':
/root/utils2/hci/hciconfig.c:1244: undefined reference to `hci_close'
ericsson.o(.text+0x55): In function `ericsson_read_revision_information':
/root/utils2/hci/ericsson.c:59: undefined reference to `hci_send_request'
ericsson.o(.text+0xa8):/root/utils2/hci/ericsson.c:63: undefined reference =
to=20
`hci_errno'
csr.o(.text+0x1d0): In function `csr_read_varid_uint16':
/root/utils2/hci/csr.c:301: undefined reference to `hci_send_request'
csr.o(.text+0x340): In function `csr_read_pskey_uint16':
/root/utils2/hci/csr.c:341: undefined reference to `hci_send_request'
collect2: ld returned 1 exit status
make[2]: *** [hciconfig] Error 1
make[2]: Leaving directory `/root/utils2/hci'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/root/utils2'
make: *** [all] Error 2

What i need ?

S=E9rgio


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
