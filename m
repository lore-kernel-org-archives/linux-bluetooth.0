Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <db972f430708302356x1bcdbd6bn31369092d8ad7f58@mail.gmail.com>
Date: Fri, 31 Aug 2007 14:56:05 +0800
From: "Ricky Soh" <rickysoh@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] newbie questions on Bluez installation
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1701062669=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1701062669==
Content-Type: multipart/alternative;
	boundary="----=_Part_9009_7845635.1188543365181"

------=_Part_9009_7845635.1188543365181
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I have just downloaded bluez-lib and bluez-utils-3.16 and ported to FC6
linux 2.6.18-1.2798.

After i did the ./configure, i did the usual "make" for both. This is the
error for blue-utils-3.16:

Entering the directory '/root/bluez-utils-3.16/hci'
/bin/sh ../libtool --tag=CC   --mode=link gcc
-I/usr/include/dbus-1.0-I/usr/lib/dbus-
1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2
-D_FORTIFY_SOURCE=2   -o hcid main.o libhciserver.a ../sdpd/libsdpserver.a
../common/libhelper.a ../eglib/libeglib.la -L/lib -ldbus-1   -lbluetooth
-lexpat
gcc -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
-DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2 -o
hcid main.o  libhciserver.a ../sdpd/libsdpserver.a ../common/libhelper.a
../eglib/.libs/libeglib.a -L/lib -ldbus-1 /usr/lib/libbluetooth.so
/usr/lib/libexpat.so
libhciserver.a(device.o): In function `start_adapter':
device.c:(.text+0x10c1): undefined reference to
`hci_read_simple_pairing_mode'
libhciserver.a(dbus-common.o): In function `unregister_sdp_record':
dbus-common.c:(.text+0x90): undefined reference to
`sdp_device_record_unregister_binary'
libhciserver.a(dbus-common.o): In function `register_sdp_binary':
dbus-common.c:(.text+0x9d7): undefined reference to
`sdp_device_record_register_binary'
libhciserver.a(dbus-service.o): In function `remove_trust':
dbus-service.c:(.text+0x160b): undefined reference to `bachk'
libhciserver.a(dbus-service.o): In function `is_trusted':
dbus-service.c:(.text+0x1724): undefined reference to `bachk'
libhciserver.a(dbus-service.o): In function `set_trusted':
dbus-service.c:(.text+0x193b): undefined reference to `bachk'
libhciserver.a(dbus-hci.o): In function
`hcid_dbus_write_simple_pairing_mode_complete':
dbus-hci.c:(.text+0x1b4): undefined reference to
`hci_read_simple_pairing_mode'
libhciserver.a(dbus-sdp.o): In function `get_rec_with_uuid_conn_cb':
dbus-sdp.c:(.text+0x57d): undefined reference to `sdp_set_notify'
dbus-sdp.c:(.text+0x5af): undefined reference to `sdp_service_search_async'
dbus-sdp.c:(.text+0x604): undefined reference to `sdp_get_error'
libhciserver.a(dbus-sdp.o): In function `get_rec_with_handle_conn_cb':
dbus-sdp.c:(.text+0x63c): undefined reference to `sdp_set_notify'
dbus-sdp.c:(.text+0x67c): undefined reference to `sdp_service_attr_async'
libhciserver.a(dbus-sdp.o): In function `remote_svc_rec_conn_xml_cb':
dbus-sdp.c:(.text+0x725): undefined reference to `sdp_set_notify'
dbus-sdp.c:(.text+0x79e): undefined reference to `sdp_service_attr_async'
dbus-sdp.c:(.text+0x7d8): undefined reference to `sdp_get_error'
libhciserver.a(dbus-sdp.o): In function `remote_svc_rec_conn_cb':
dbus-sdp.c:(.text+0x815): undefined reference to `sdp_set_notify'
dbus-sdp.c:(.text+0x88e): undefined reference to `sdp_service_attr_async'
dbus-sdp.c:(.text+0x8c8): undefined reference to `sdp_get_error'
libhciserver.a(dbus-sdp.o): In function `service_search_attr':
dbus-sdp.c:(.text+0x94e): undefined reference to
`sdp_service_search_attr_async'
dbus-sdp.c:(.text+0x98f): undefined reference to `sdp_get_error'
libhciserver.a(dbus-sdp.o): In function `remote_svc_identifiers_conn_cb':
dbus-sdp.c:(.text+0x9bd): undefined reference to `sdp_set_notify'
libhciserver.a(dbus-sdp.o): In function `remote_svc_handles_conn_cb':
dbus-sdp.c:(.text+0xb6f): undefined reference to `sdp_set_notify'
dbus-sdp.c:(.text+0xbf5): undefined reference to `sdp_service_search_async'
dbus-sdp.c:(.text+0xc6f): undefined reference to `sdp_get_error'
libhciserver.a(dbus-sdp.o): In function `remote_svc_rec_completed_xml_cb':
dbus-sdp.c:(.text+0xe37): undefined reference to `sdp_get_error'
libhciserver.a(dbus-sdp.o): In function `search_process_cb':
dbus-sdp.c:(.text+0xff8): undefined reference to `sdp_process'
libhciserver.a(dbus-sdp.o): In function `get_rec_with_uuid_comp_cb':
dbus-sdp.c:(.text+0x1147): undefined reference to `sdp_get_error'
libhciserver.a(dbus-sdp.o): In function `get_rec_with_handle_comp_cb':
dbus-sdp.c:(.text+0x1257): undefined reference to `sdp_get_error'
libhciserver.a(dbus-sdp.o): In function `remote_svc_rec_completed_cb':
dbus-sdp.c:(.text+0x1467): undefined reference to `sdp_get_error'
libhciserver.a(dbus-sdp.o): In function `get_cached_session':
dbus-sdp.c:(.text+0x1580): undefined reference to `sdp_get_socket'
libhciserver.a(dbus-sdp.o): In function `connect_request':
dbus-sdp.c:(.text+0x1719): undefined reference to `sdp_get_socket'
libhciserver.a(dbus-sdp.o): In function
`remote_svc_identifiers_completed_cb':
dbus-sdp.c:(.text+0x2144): undefined reference to `sdp_get_error'
libhciserver.a(dbus-sdp.o): In function `remote_svc_handles_completed_cb':
dbus-sdp.c:(.text+0x23fe): undefined reference to `sdp_get_error'
libhciserver.a(adapter.o): In function `adapter_dc_remote_device':
adapter.c:(.text+0x5f2): undefined reference to `bachk'
libhciserver.a(adapter.o): In function `get_remote_class':
adapter.c:(.text+0x7a9): undefined reference to `bachk'
libhciserver.a(adapter.o): In function `adapter_create_bonding':
adapter.c:(.text+0xdb4): undefined reference to `bachk'
libhciserver.a(adapter.o): In function `create_device':
adapter.c:(.text+0x10b6): undefined reference to `bachk'
libhciserver.a(adapter.o): In function `adapter_remove_trust':
adapter.c:(.text+0x13a7): undefined reference to `bachk'
libhciserver.a(adapter.o):adapter.c:(.text+0x14cb): more undefined
references to `bachk' follow
../common/libhelper.a(sdp-xml.o): In function `sdp_xml_parse_text':
sdp-xml.c:(.text+0x2a3): undefined reference to `sdp_data_alloc_with_length'
../common/libhelper.a(sdp-xml.o): In function `sdp_xml_parse_url':
sdp-xml.c:(.text+0x311): undefined reference to `sdp_data_alloc_with_length'
collect2: ld returned 1 exit status
make[3]: *** [hcid] Error 1

I really do not understand these messages.

Please help. Thanks.

------=_Part_9009_7845635.1188543365181
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br><br>I have just downloaded bluez-lib and bluez-utils-3.16 and ported to FC6 linux 2.6.18-1.2798.<br><br>After i did the ./configure, i did the usual &quot;make&quot; for both. This is the error for blue-utils-3.16
:<br><br>Entering the directory &#39;/root/bluez-utils-3.16/hci&#39;<br>/bin/sh ../libtool --tag=CC&nbsp;&nbsp; --mode=link gcc -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2&nbsp;&nbsp; -o hcid 
main.o libhciserver.a ../sdpd/libsdpserver.a ../common/libhelper.a ../eglib/libeglib.la -L/lib -ldbus-1&nbsp;&nbsp; -lbluetooth&nbsp;&nbsp; -lexpat <br>gcc -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2 -o hcid 
main.o&nbsp; libhciserver.a ../sdpd/libsdpserver.a ../common/libhelper.a ../eglib/.libs/libeglib.a -L/lib -ldbus-1 /usr/lib/libbluetooth.so /usr/lib/libexpat.so&nbsp; <br>libhciserver.a(device.o): In function `start_adapter&#39;:<br>
device.c:(.text+0x10c1): undefined reference to `hci_read_simple_pairing_mode&#39;<br>libhciserver.a(dbus-common.o): In function `unregister_sdp_record&#39;:<br>dbus-common.c:(.text+0x90): undefined reference to `sdp_device_record_unregister_binary&#39;
<br>libhciserver.a(dbus-common.o): In function `register_sdp_binary&#39;:<br>dbus-common.c:(.text+0x9d7): undefined reference to `sdp_device_record_register_binary&#39;<br>libhciserver.a(dbus-service.o): In function `remove_trust&#39;:
<br>dbus-service.c:(.text+0x160b): undefined reference to `bachk&#39;<br>libhciserver.a(dbus-service.o): In function `is_trusted&#39;:<br>dbus-service.c:(.text+0x1724): undefined reference to `bachk&#39;<br>libhciserver.a
(dbus-service.o): In function `set_trusted&#39;:<br>dbus-service.c:(.text+0x193b): undefined reference to `bachk&#39;<br>libhciserver.a(dbus-hci.o): In function `hcid_dbus_write_simple_pairing_mode_complete&#39;:<br>dbus-hci.c:
(.text+0x1b4): undefined reference to `hci_read_simple_pairing_mode&#39;<br>libhciserver.a(dbus-sdp.o): In function `get_rec_with_uuid_conn_cb&#39;:<br>dbus-sdp.c:(.text+0x57d): undefined reference to `sdp_set_notify&#39;
<br>dbus-sdp.c:(.text+0x5af): undefined reference to `sdp_service_search_async&#39;<br>dbus-sdp.c:(.text+0x604): undefined reference to `sdp_get_error&#39;<br>libhciserver.a(dbus-sdp.o): In function `get_rec_with_handle_conn_cb&#39;:
<br>dbus-sdp.c:(.text+0x63c): undefined reference to `sdp_set_notify&#39;<br>dbus-sdp.c:(.text+0x67c): undefined reference to `sdp_service_attr_async&#39;<br>libhciserver.a(dbus-sdp.o): In function `remote_svc_rec_conn_xml_cb&#39;:
<br>dbus-sdp.c:(.text+0x725): undefined reference to `sdp_set_notify&#39;<br>dbus-sdp.c:(.text+0x79e): undefined reference to `sdp_service_attr_async&#39;<br>dbus-sdp.c:(.text+0x7d8): undefined reference to `sdp_get_error&#39;
<br>libhciserver.a(dbus-sdp.o): In function `remote_svc_rec_conn_cb&#39;:<br>dbus-sdp.c:(.text+0x815): undefined reference to `sdp_set_notify&#39;<br>dbus-sdp.c:(.text+0x88e): undefined reference to `sdp_service_attr_async&#39;
<br>dbus-sdp.c:(.text+0x8c8): undefined reference to `sdp_get_error&#39;<br>libhciserver.a(dbus-sdp.o): In function `service_search_attr&#39;:<br>dbus-sdp.c:(.text+0x94e): undefined reference to `sdp_service_search_attr_async&#39;
<br>dbus-sdp.c:(.text+0x98f): undefined reference to `sdp_get_error&#39;<br>libhciserver.a(dbus-sdp.o): In function `remote_svc_identifiers_conn_cb&#39;:<br>dbus-sdp.c:(.text+0x9bd): undefined reference to `sdp_set_notify&#39;
<br>libhciserver.a(dbus-sdp.o): In function `remote_svc_handles_conn_cb&#39;:<br>dbus-sdp.c:(.text+0xb6f): undefined reference to `sdp_set_notify&#39;<br>dbus-sdp.c:(.text+0xbf5): undefined reference to `sdp_service_search_async&#39;
<br>dbus-sdp.c:(.text+0xc6f): undefined reference to `sdp_get_error&#39;<br>libhciserver.a(dbus-sdp.o): In function `remote_svc_rec_completed_xml_cb&#39;:<br>dbus-sdp.c:(.text+0xe37): undefined reference to `sdp_get_error&#39;
<br>libhciserver.a(dbus-sdp.o): In function `search_process_cb&#39;:<br>dbus-sdp.c:(.text+0xff8): undefined reference to `sdp_process&#39;<br>libhciserver.a(dbus-sdp.o): In function `get_rec_with_uuid_comp_cb&#39;:<br>dbus-sdp.c:
(.text+0x1147): undefined reference to `sdp_get_error&#39;<br>libhciserver.a(dbus-sdp.o): In function `get_rec_with_handle_comp_cb&#39;:<br>dbus-sdp.c:(.text+0x1257): undefined reference to `sdp_get_error&#39;<br>libhciserver.a
(dbus-sdp.o): In function `remote_svc_rec_completed_cb&#39;:<br>dbus-sdp.c:(.text+0x1467): undefined reference to `sdp_get_error&#39;<br>libhciserver.a(dbus-sdp.o): In function `get_cached_session&#39;:<br>dbus-sdp.c:(.text+0x1580): undefined reference to `sdp_get_socket&#39;
<br>libhciserver.a(dbus-sdp.o): In function `connect_request&#39;:<br>dbus-sdp.c:(.text+0x1719): undefined reference to `sdp_get_socket&#39;<br>libhciserver.a(dbus-sdp.o): In function `remote_svc_identifiers_completed_cb&#39;:
<br>dbus-sdp.c:(.text+0x2144): undefined reference to `sdp_get_error&#39;<br>libhciserver.a(dbus-sdp.o): In function `remote_svc_handles_completed_cb&#39;:<br>dbus-sdp.c:(.text+0x23fe): undefined reference to `sdp_get_error&#39;
<br>libhciserver.a(adapter.o): In function `adapter_dc_remote_device&#39;:<br>adapter.c:(.text+0x5f2): undefined reference to `bachk&#39;<br>libhciserver.a(adapter.o): In function `get_remote_class&#39;:<br>adapter.c:(.text+0x7a9): undefined reference to `bachk&#39;
<br>libhciserver.a(adapter.o): In function `adapter_create_bonding&#39;:<br>adapter.c:(.text+0xdb4): undefined reference to `bachk&#39;<br>libhciserver.a(adapter.o): In function `create_device&#39;:<br>adapter.c:(.text+0x10b6): undefined reference to `bachk&#39;
<br>libhciserver.a(adapter.o): In function `adapter_remove_trust&#39;:<br>adapter.c:(.text+0x13a7): undefined reference to `bachk&#39;<br>libhciserver.a(adapter.o):adapter.c:(.text+0x14cb): more undefined references to `bachk&#39; follow
<br>../common/libhelper.a(sdp-xml.o): In function `sdp_xml_parse_text&#39;:<br>sdp-xml.c:(.text+0x2a3): undefined reference to `sdp_data_alloc_with_length&#39;<br>../common/libhelper.a(sdp-xml.o): In function `sdp_xml_parse_url&#39;:
<br>sdp-xml.c:(.text+0x311): undefined reference to `sdp_data_alloc_with_length&#39;<br>collect2: ld returned 1 exit status<br>make[3]: *** [hcid] Error 1<br><br>I really do not understand these messages.<br><br>Please help. Thanks.
<br>

------=_Part_9009_7845635.1188543365181--


--===============1701062669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1701062669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1701062669==--
