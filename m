Return-Path: <cyrus@holtmann.org>
Subject: Corruption in bluetoothd if started when adapter was rfkilled
From: Valmantas =?UTF-8?Q?Palik=C5=A1a?= <walmis@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-y5HlYO0KtkkuqcL49BEE"
Date: Fri, 16 Oct 2009 15:41:48 +0300
Message-Id: <1255696908.12027.15.camel@walmis-laptop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-y5HlYO0KtkkuqcL49BEE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Steps to reproduce:
1. rfkill block bluetooth
2. start bluetoothd
3. kill bluetoothd



--=-y5HlYO0KtkkuqcL49BEE
Content-Disposition: attachment; filename="bluetoothd.log"
Content-Type: text/x-log; name="bluetoothd.log"; charset="UTF-8"
Content-Transfer-Encoding: 8bit

bluetoothd[11044]: Bluetooth daemon 4.56
bluetoothd[11044]: Enabling debug information
bluetoothd[11044]: parsing main.conf
bluetoothd[11044]: discovto=0
bluetoothd[11044]: pairto=0
bluetoothd[11044]: pageto=8192
bluetoothd[11044]: name=%h-%d
bluetoothd[11044]: class=0x000100
bluetoothd[11044]: discov_interval=0
bluetoothd[11044]: Key file does not have key 'DeviceID'
bluetoothd[11044]: Starting SDP server
bluetoothd[11044]: Loading builtin plugins
bluetoothd[11044]: Loading audio plugin
bluetoothd[11044]: Loading input plugin
bluetoothd[11044]: Loading serial plugin
bluetoothd[11044]: Loading network plugin
bluetoothd[11044]: Loading service plugin
bluetoothd[11044]: Loading hciops plugin
bluetoothd[11044]: Loading hal plugin
bluetoothd[11044]: Loading storage plugin
bluetoothd[11044]: Loading plugins /usr/lib/bluetooth/plugins
bluetoothd[11044]: Can't load plugin /usr/lib/bluetooth/plugins/netlink.so: /usr/lib/bluetooth/plugins/netlink.so: undefined symbol: debug
bluetoothd[11044]: register_interface: path /org/bluez/11044/any
bluetoothd[11044]: Registered interface org.bluez.Service on path /org/bluez/11044/any
bluetoothd[11044]: /etc/bluetooth/network.conf: Key file does not have key 'Disable'
bluetoothd[11044]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[11044]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[11044]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[11044]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=false
bluetoothd[11044]: bridge pan0 created
bluetoothd[11044]: input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[11044]: Unix socket created: 9
bluetoothd[11044]: audio.conf: Key file does not have key 'AutoConnect'
bluetoothd[11044]: audio.conf: Key file does not have key 'MaxConnected'
bluetoothd[11044]: Telephony plugin initialized
bluetoothd[11044]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[11044]: HCI dev 0 registered
bluetoothd[11044]: child 11049 forked
bluetoothd[11044]: btd_adapter_ref(0x7ff60fe4cd00): ref=1
bluetoothd[11044]: Entering main loop
bluetoothd[11049]: Can't init device hci0: Unknown error 132 (132)
bluetoothd[11044]: RFKILL event idx 1 type 1 op 0 soft 0 hard 0
bluetoothd[11044]: child 11049 exited
bluetoothd[11044]: RFKILL event idx 2 type 2 op 0 soft 1 hard 0
^Cbluetoothd[11044]: Removing adapter /org/bluez/11044/hci0
bluetoothd[11044]: unregister_interface: path /org/bluez/11044/hci0
bluetoothd[11044]: network_server_remove: path /org/bluez/11044/hci0
bluetoothd[11044]: network_server_remove: path /org/bluez/11044/hci0
bluetoothd[11044]: network_server_remove: path /org/bluez/11044/hci0
bluetoothd[11044]: proxy_remove: path /org/bluez/11044/hci0
bluetoothd[11044]: btd_adapter_unref(0x7ff60fe4cd00): ref=0
bluetoothd[11044]: adapter_free(0x7ff60fe4cd00)
bluetoothd[11044]: headset_server_remove: path 8p1�
bluetoothd[11044]: a2dp_server_remove: path �p1�
bluetoothd[11044]: avrcp_server_remove: path �p1�
process 11044: arguments to dbus_connection_unref() were incorrect, assertion "connection != NULL" failed in file dbus-connection.c line 2697.
This is normally a bug in some application using the D-Bus library.
bluetoothd[11044]: btd_adapter_unref(0x7ff60fe4cd00): ref=-1
bluetoothd[11044]: Cleanup plugins
bluetoothd[11044]: unregister_interface: path /org/bluez/11044/any
bluetoothd[11044]: bridge pan0 removed
bluetoothd[11044]: Stopping SDP server
bluetoothd[11044]: Exit


--=-y5HlYO0KtkkuqcL49BEE
Content-Disposition: attachment; filename="valgrind.log"
Content-Type: text/x-log; name="valgrind.log"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

==4146== Memcheck, a memory error detector
==4146== Copyright (C) 2002-2009, and GNU GPL'd, by Julian Seward et al.
==4146== Using Valgrind-3.5.0-Debian and LibVEX; rerun with -h for copyright info
==4146== Command: ./lt-bluetoothd -nd
==4146== 
bluetoothd[4146]: Bluetooth daemon 4.56
bluetoothd[4146]: Enabling debug information
bluetoothd[4146]: parsing main.conf
bluetoothd[4146]: discovto=0
bluetoothd[4146]: pairto=0
bluetoothd[4146]: pageto=8192
bluetoothd[4146]: name=%h-%d
bluetoothd[4146]: class=0x000100
bluetoothd[4146]: discov_interval=0
bluetoothd[4146]: Key file does not have key 'DeviceID'
bluetoothd[4146]: Starting SDP server
bluetoothd[4146]: Loading builtin plugins
bluetoothd[4146]: Loading audio plugin
bluetoothd[4146]: Loading input plugin
bluetoothd[4146]: Loading serial plugin
bluetoothd[4146]: Loading network plugin
bluetoothd[4146]: Loading service plugin
bluetoothd[4146]: Loading hciops plugin
bluetoothd[4146]: Loading hal plugin
bluetoothd[4146]: Loading storage plugin
bluetoothd[4146]: Loading plugins /usr/local/lib/bluetooth/plugins
bluetoothd[4146]: register_interface: path /org/bluez/4146/any
bluetoothd[4146]: Registered interface org.bluez.Service on path /org/bluez/4146/any
bluetoothd[4146]: /etc/bluetooth/network.conf: Key file does not have key 'Disable'
bluetoothd[4146]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[4146]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[4146]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[4146]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=false
==4146== Warning: noted but unhandled ioctl 0x89a0 with no size/direction hints
==4146==    This could cause spurious value errors to appear.
==4146==    See README_MISSING_SYSCALL_OR_IOCTL for guidance on writing a proper wrapper.
bluetoothd[4146]: bridge pan0 created
bluetoothd[4146]: input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[4146]: Unix socket created: 9
bluetoothd[4146]: audio.conf: Key file does not have key 'AutoConnect'
bluetoothd[4146]: audio.conf: Key file does not have key 'MaxConnected'
bluetoothd[4146]: Telephony plugin initialized
bluetoothd[4146]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[4146]: HCI dev 0 registered
bluetoothd[4146]: child 4150 forked
bluetoothd[4146]: btd_adapter_ref(0x617af50): ref=1
==4146== Syscall param ioctl(generic) points to unaddressable byte(s)
==4146==    at 0x5C48537: ioctl (in /lib/libc-2.10.1.so)
==4146==    by 0x13BAA6: device_event (hciops.c:170)
==4146==    by 0x13BF25: hciops_setup (hciops.c:273)
==4146==    by 0x13CC19: main (main.c:442)
==4146==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
==4146== 
bluetoothd[4150]: Can't init device hci0: Unknown error 132 (132)
bluetoothd[4146]: Entering main loop
==4146== 
==4146== HEAP SUMMARY:
==4146==     in use at exit: 36,229 bytes in 356 blocks
==4146==   total heap usage: 768 allocs, 412 frees, 388,354 bytes allocated
==4146== 
==4146== LEAK SUMMARY:
==4146==    definitely lost: 0 bytes in 0 blocks
==4146==    indirectly lost: 0 bytes in 0 blocks
==4146==      possibly lost: 7,645 bytes in 81 blocks
==4146==    still reachable: 28,584 bytes in 275 blocks
==4146==         suppressed: 0 bytes in 0 blocks
==4146== Rerun with --leak-check=full to see details of leaked memory
==4146== 
==4146== For counts of detected and suppressed errors, rerun with: -v
==4146== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 4 from 4)
bluetoothd[4146]: child 4150 exited
bluetoothd[4146]: RFKILL event idx 1 type 1 op 0 soft 0 hard 0
bluetoothd[4146]: RFKILL event idx 2 type 2 op 0 soft 1 hard 0
^Cbluetoothd[4146]: Removing adapter /org/bluez/4146/hci0
bluetoothd[4146]: unregister_interface: path /org/bluez/4146/hci0
bluetoothd[4146]: network_server_remove: path /org/bluez/4146/hci0
bluetoothd[4146]: network_server_remove: path /org/bluez/4146/hci0
bluetoothd[4146]: network_server_remove: path /org/bluez/4146/hci0
bluetoothd[4146]: proxy_remove: path /org/bluez/4146/hci0
bluetoothd[4146]: btd_adapter_unref(0x617af50): ref=0
bluetoothd[4146]: adapter_free(0x617af50)
==4146== Invalid read of size 8
==4146==    at 0x14D7D7: adapter_get_path (adapter.c:2494)
==4146==    by 0x11784D: headset_server_remove (manager.c:872)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617af58 is 8 bytes inside a block of size 440 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid read of size 1
==4146==    at 0x5BB9A87: vfprintf (vfprintf.c:1601)
==4146==    by 0x5C67266: __vfprintf_chk (vfprintf_chk.c:35)
==4146==    by 0x5C4C530: __vsyslog_chk (syslog.c:224)
==4146==    by 0x13D1F3: debug (syslog.h:48)
==4146==    by 0x117865: headset_server_remove (manager.c:874)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b150 is 0 bytes inside a block of size 21 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x14EB2C: adapter_free (adapter.c:2399)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid read of size 1
==4146==    at 0x5BE5410: _IO_default_xsputn (genops.c:480)
==4146==    by 0x5BB9711: vfprintf (vfprintf.c:1601)
==4146==    by 0x5C67266: __vfprintf_chk (vfprintf_chk.c:35)
==4146==    by 0x5C4C530: __vsyslog_chk (syslog.c:224)
==4146==    by 0x13D1F3: debug (syslog.h:48)
==4146==    by 0x117865: headset_server_remove (manager.c:874)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b150 is 0 bytes inside a block of size 21 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x14EB2C: adapter_free (adapter.c:2399)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid read of size 1
==4146==    at 0x5BE5422: _IO_default_xsputn (genops.c:479)
==4146==    by 0x5BB9711: vfprintf (vfprintf.c:1601)
==4146==    by 0x5C67266: __vfprintf_chk (vfprintf_chk.c:35)
==4146==    by 0x5C4C530: __vsyslog_chk (syslog.c:224)
==4146==    by 0x13D1F3: debug (syslog.h:48)
==4146==    by 0x117865: headset_server_remove (manager.c:874)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b152 is 2 bytes inside a block of size 21 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x14EB2C: adapter_free (adapter.c:2399)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
bluetoothd[4146]: headset_server_remove: path /org/bluez/4146/hci0
==4146== Invalid read of size 8
==4146==    at 0x14D7D7: adapter_get_path (adapter.c:2494)
==4146==    by 0x11767F: a2dp_server_remove (manager.c:977)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617af58 is 8 bytes inside a block of size 440 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
bluetoothd[4146]: a2dp_server_remove: path /org/bluez/4146/hci0
==4146== Invalid read of size 8
==4146==    at 0x14D7D7: adapter_get_path (adapter.c:2494)
==4146==    by 0x1174DF: avrcp_server_remove (manager.c:1011)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617af58 is 8 bytes inside a block of size 440 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid read of size 8
==4146==    at 0x5BE54A8: _IO_default_xsputn (genops.c:480)
==4146==    by 0x5BB9711: vfprintf (vfprintf.c:1601)
==4146==    by 0x5C67266: __vfprintf_chk (vfprintf_chk.c:35)
==4146==    by 0x5C4C530: __vsyslog_chk (syslog.c:224)
==4146==    by 0x13D1F3: debug (syslog.h:48)
==4146==    by 0x1174F7: avrcp_server_remove (manager.c:1014)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b150 is 0 bytes inside a block of size 21 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x14EB2C: adapter_free (adapter.c:2399)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid read of size 1
==4146==    at 0x5BE54C8: _IO_default_xsputn (genops.c:480)
==4146==    by 0x5BB9711: vfprintf (vfprintf.c:1601)
==4146==    by 0x5C67266: __vfprintf_chk (vfprintf_chk.c:35)
==4146==    by 0x5C4C530: __vsyslog_chk (syslog.c:224)
==4146==    by 0x13D1F3: debug (syslog.h:48)
==4146==    by 0x1174F7: avrcp_server_remove (manager.c:1014)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b160 is 16 bytes inside a block of size 21 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x14EB2C: adapter_free (adapter.c:2399)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid read of size 1
==4146==    at 0x5BE54DA: _IO_default_xsputn (genops.c:479)
==4146==    by 0x5BB9711: vfprintf (vfprintf.c:1601)
==4146==    by 0x5C67266: __vfprintf_chk (vfprintf_chk.c:35)
==4146==    by 0x5C4C530: __vsyslog_chk (syslog.c:224)
==4146==    by 0x13D1F3: debug (syslog.h:48)
==4146==    by 0x1174F7: avrcp_server_remove (manager.c:1014)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b162 is 18 bytes inside a block of size 21 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x14EB2C: adapter_free (adapter.c:2399)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
bluetoothd[4146]: avrcp_server_remove: path /org/bluez/4146/hci0
process 4146: arguments to dbus_connection_unref() were incorrect, assertion "connection != NULL" failed in file dbus-connection.c line 2697.
This is normally a bug in some application using the D-Bus library.
==4146== Invalid read of size 4
==4146==    at 0x14F37B: adapter_remove (adapter.c:2478)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617af54 is 4 bytes inside a block of size 440 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid read of size 4
==4146==    at 0x14F2A1: btd_adapter_unref (adapter.c:2416)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b104 is 436 bytes inside a block of size 440 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid write of size 4
==4146==    at 0x14F2B2: btd_adapter_unref (adapter.c:2416)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b104 is 436 bytes inside a block of size 440 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
bluetoothd[4146]: btd_adapter_unref(0x617af50): ref=-1
==4146== Invalid read of size 4
==4146==    at 0x14F2C4: btd_adapter_unref (adapter.c:2420)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b104 is 436 bytes inside a block of size 440 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid read of size 8
==4146==    at 0x14F2D0: btd_adapter_unref (adapter.c:2423)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617af58 is 8 bytes inside a block of size 440 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid read of size 1
==4146==    at 0x4C261D2: strlen (mc_replace_strmem.c:275)
==4146==    by 0x509EB81: g_strdup (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14F2D8: btd_adapter_unref (adapter.c:2423)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b150 is 0 bytes inside a block of size 21 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x14EB2C: adapter_free (adapter.c:2399)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid read of size 1
==4146==    at 0x4C261E4: strlen (mc_replace_strmem.c:275)
==4146==    by 0x509EB81: g_strdup (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14F2D8: btd_adapter_unref (adapter.c:2423)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b151 is 1 bytes inside a block of size 21 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x14EB2C: adapter_free (adapter.c:2399)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid read of size 1
==4146==    at 0x4C26678: memcpy (mc_replace_strmem.c:482)
==4146==    by 0x509EB9E: g_strdup (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14F2D8: btd_adapter_unref (adapter.c:2423)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b164 is 20 bytes inside a block of size 21 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x14EB2C: adapter_free (adapter.c:2399)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid read of size 1
==4146==    at 0x4C26681: memcpy (mc_replace_strmem.c:482)
==4146==    by 0x509EB9E: g_strdup (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14F2D8: btd_adapter_unref (adapter.c:2423)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b163 is 19 bytes inside a block of size 21 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x14EB2C: adapter_free (adapter.c:2399)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid read of size 1
==4146==    at 0x4C2668C: memcpy (mc_replace_strmem.c:482)
==4146==    by 0x509EB9E: g_strdup (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14F2D8: btd_adapter_unref (adapter.c:2423)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b162 is 18 bytes inside a block of size 21 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x14EB2C: adapter_free (adapter.c:2399)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid read of size 1
==4146==    at 0x4C26697: memcpy (mc_replace_strmem.c:482)
==4146==    by 0x509EB9E: g_strdup (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14F2D8: btd_adapter_unref (adapter.c:2423)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b161 is 17 bytes inside a block of size 21 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x14EB2C: adapter_free (adapter.c:2399)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
==4146== Invalid read of size 1
==4146==    at 0x4C266D8: memcpy (mc_replace_strmem.c:482)
==4146==    by 0x509EB9E: g_strdup (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14F2D8: btd_adapter_unref (adapter.c:2423)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146==  Address 0x617b150 is 0 bytes inside a block of size 21 free'd
==4146==    at 0x4C24D68: free (vg_replace_malloc.c:325)
==4146==    by 0x14EB2C: adapter_free (adapter.c:2399)
==4146==    by 0x11593A: remove_interface (object.c:394)
==4146==    by 0x115A49: g_dbus_unregister_interface (object.c:544)
==4146==    by 0x14F2F1: btd_adapter_unref (adapter.c:2425)
==4146==    by 0x12FE5E: hid_server_remove (manager.c:151)
==4146==    by 0x14F371: adapter_remove (adapter.c:2298)
==4146==    by 0x14CEF5: manager_remove_adapter (manager.c:298)
==4146==    by 0x509D53B: g_slist_foreach (in /lib/libglib-2.0.so.0.2200.2)
==4146==    by 0x14D208: manager_cleanup (manager.c:306)
==4146==    by 0x15693E: hcid_dbus_exit (dbus-common.c:158)
==4146==    by 0x13CC4A: main (main.c:455)
==4146== 
bluetoothd[4146]: Cleanup plugins
bluetoothd[4146]: unregister_interface: path /org/bluez/4146/any
==4146== Warning: noted but unhandled ioctl 0x89a1 with no size/direction hints
==4146==    This could cause spurious value errors to appear.
==4146==    See README_MISSING_SYSCALL_OR_IOCTL for guidance on writing a proper wrapper.
bluetoothd[4146]: bridge pan0 removed
bluetoothd[4146]: Stopping SDP server
bluetoothd[4146]: Exit
==4146== 
==4146== HEAP SUMMARY:
==4146==     in use at exit: 32,013 bytes in 251 blocks
==4146==   total heap usage: 938 allocs, 687 frees, 585,117 bytes allocated
==4146== 
==4146== LEAK SUMMARY:
==4146==    definitely lost: 0 bytes in 0 blocks
==4146==    indirectly lost: 0 bytes in 0 blocks
==4146==      possibly lost: 7,188 bytes in 55 blocks
==4146==    still reachable: 24,825 bytes in 196 blocks
==4146==         suppressed: 0 bytes in 0 blocks
==4146== Rerun with --leak-check=full to see details of leaked memory
==4146== 
==4146== For counts of detected and suppressed errors, rerun with: -v
==4146== ERROR SUMMARY: 159 errors from 21 contexts (suppressed: 4 from 4)


--=-y5HlYO0KtkkuqcL49BEE--

