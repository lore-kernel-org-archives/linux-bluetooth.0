Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4C587AFF.7060402@aircable.net>
References: <4C46324D.5070800@aircable.net> <20100721101934.GA12188@jh-x301>
	<4C470E2D.7000607@aircable.net> <AANLkTi=8=BUThjVdc4EN_8uupGKmdgHQzGOe560Cv+pm@mail.gmail.com>
	<AANLkTi=jzZScnCK6rFpKjBJesnw=71y5hNG3kDBhxv1u@mail.gmail.com>
	<4C505806.3040508@aircable.net> <AANLkTikRQfhAKm-UW+on+ZeEp709z_ku_NDjeVD_US1b@mail.gmail.com>
	<AANLkTi=9Top+9kRwtZj-nZw8szQU4ff9CTSNSGuexmEL@mail.gmail.com>
	<4C518373.6000706@aircable.net> <AANLkTi=i8MhyC80qis9TjZBmtNUJDBMNw5g2rjKPQvdj@mail.gmail.com>
	<AANLkTinYN=KDban-WsF4wZw-ZZDU7fQ0SFnAWdofbokd@mail.gmail.com>
	<4C587AFF.7060402@aircable.net>
From: Manuel Naranjo <manuel@aircable.net>
Date: Thu, 5 Aug 2010 11:48:26 -0300
Message-ID: <AANLkTimLaDPPqwhr0jPaAQcOA+wkiFmj11bmp_d5EvHd@mail.gmail.com>
Subject: Re: [PATCH][RFC] Fix SDP resolving segfault
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Luiz,

>> This looks like a different issue, at least it doesn't seems to crash
>> in the same point, so I assume the patch does fix something but
>> uncover another problem. But we have to find out where exactly is this
>> other problem because btd_device_unref doesn't seems to be the place,
>> can't you get any core dumps from the tests you did?
>>
>
> I agree it looks like it triggered another issue, I will try to get logs
> tomorrow.
>

Here's the call trace, unfortunately I don't have bluetoothd debug
messages, just this
	+  0 0x804e4ea (from 0x7e0dab)  watch_func():
/home/manuel/bluez/gdbus/mainloop.c:94
	+  1 0x804ea3b (from 0x7140dd)   dispatch_status():
/home/manuel/bluez/gdbus/mainloop.c:244
	+  2 0x804e49b (from 0x804ea7d)    queue_dispatch():
/home/manuel/bluez/gdbus/mainloop.c:87
	+  0 0x804e436 (from 0x7aa53c)  message_dispatch():
/home/manuel/bluez/gdbus/mainloop.c:73
	+  1 0x8050fa1 (from 0x716c8d)   message_filter():
/home/manuel/bluez/gdbus/watch.c:408
	+  1 0x804f506 (from 0x723f13)   generic_message():
/home/manuel/bluez/gdbus/object.c:236
	+  2 0x804f483 (from 0x804f549)    find_interface():
/home/manuel/bluez/gdbus/object.c:219
	+  2 0x80a4d46 (from 0x804f5cb)    adapter_start_discovery():
/home/manuel/bluez/src/adapter.c:1215
	+  3 0x80a354c (from 0x80a4da5)     find_session():
/home/manuel/bluez/src/adapter.c:621
	+  3 0x80a4cce (from 0x80a4dfa)     adapter_start_inquiry():
/home/manuel/bluez/src/adapter.c:1203
	+  4 0x80a2744 (from 0x80a4d0c)      pending_remote_name_cancel():
/home/manuel/bluez/src/adapter.c:263
	+  5 0x80a208d (from 0x80a27aa)       bacpy():
/home/manuel/bluez/./lib/bluetooth/bluetooth.h:132
	+  5 0x80a8b8e (from 0x80a27c3)       adapter_search_found_devices():
/home/manuel/bluez/src/adapter.c:2667
	+  4 0x808831a (from 0x80a4d29)      hciops_start_discovery():
/home/manuel/bluez/plugins/hciops.c:570
	+  3 0x80a2de5 (from 0x80a4e45)     create_session():
/home/manuel/bluez/src/adapter.c:425
	+  4 0x80514c7 (from 0x80a2ea9)      g_dbus_add_disconnect_watch():
/home/manuel/bluez/gdbus/watch.c:572
	+  5 0x80513cc (from 0x8051510)       g_dbus_add_service_watch():
/home/manuel/bluez/gdbus/watch.c:544
	+  6 0x8050753 (from 0x8051430)        filter_data_get():
/home/manuel/bluez/gdbus/watch.c:177
	+  7 0x80502a8 (from 0x80507a0)         filter_data_find():
/home/manuel/bluez/gdbus/watch.c:69
	+  7 0x80502a8 (from 0x8050803)         filter_data_find():
/home/manuel/bluez/gdbus/watch.c:69
	+  7 0x8050572 (from 0x80508a4)         add_match():
/home/manuel/bluez/gdbus/watch.c:134
	+  8 0x8050402 (from 0x80505cc)          format_rule():
/home/manuel/bluez/gdbus/watch.c:111
	+  8 0x804e8bd (from 0x729783)          add_timeout():
/home/manuel/bluez/gdbus/mainloop.c:207
	+  8 0x804ea3b (from 0x7140dd)          dispatch_status():
/home/manuel/bluez/gdbus/mainloop.c:244
	+  9 0x804e49b (from 0x804ea7d)           queue_dispatch():
/home/manuel/bluez/gdbus/mainloop.c:87
	+  8 0x804e96c (from 0x7296ff)          remove_timeout():
/home/manuel/bluez/gdbus/mainloop.c:227
	+  8 0x804e85f (from 0x729469)          timeout_handler_free():
/home/manuel/bluez/gdbus/mainloop.c:195
	+  6 0x8050af5 (from 0x8051470)        filter_data_add_callback():
/home/manuel/bluez/gdbus/watch.c:272
	+  4 0x8089ea8 (from 0x80a2ee4)      info(): /home/manuel/bluez/src/log.c:36
	+  4 0x80a2d65 (from 0x80a2eef)      session_ref():
/home/manuel/bluez/src/adapter.c:416
	+  5 0x8089f44 (from 0x80a2dc7)       btd_debug():
/home/manuel/bluez/src/log.c:58
	+  0 0x808c945 (from 0x7e0dab)  io_security_event():
/home/manuel/bluez/src/security.c:967
	+  1 0x808a32d (from 0x808caa9)   hci_test_bit():
/home/manuel/bluez/./lib/bluetooth/hci_lib.h:167
	+  1 0x808bc97 (from 0x808cb24)   cmd_complete():
/home/manuel/bluez/src/security.c:690
	+  2 0x808b951 (from 0x808bd70)    start_inquiry():
/home/manuel/bluez/src/security.c:570
	+  3 0x80a1a5d (from 0x808b9a0)     manager_find_adapter():
/home/manuel/bluez/src/manager.c:343
	+  4 0x80a1955 (from 0x7c947e)      adapter_cmp():
/home/manuel/bluez/src/manager.c:319
	+  5 0x80a89ca (from 0x80a198d)       adapter_get_address():
/home/manuel/bluez/src/adapter.c:2625
	+  6 0x80a208d (from 0x80a89f8)        bacpy():
/home/manuel/bluez/./lib/bluetooth/bluetooth.h:132
	+  5 0x80a1000 (from 0x80a199f)       bacmp():
/home/manuel/bluez/./lib/bluetooth/bluetooth.h:128
	+  3 0x80a8b15 (from 0x808b9ca)     adapter_get_state():
/home/manuel/bluez/src/adapter.c:2657
	+  3 0x80a995b (from 0x808b9d8)     adapter_has_discov_sessions():
/home/manuel/bluez/src/adapter.c:3021
	+  3 0x80a8a0d (from 0x808b9fc)     adapter_set_state():
/home/manuel/bluez/src/adapter.c:2630
	+  4 0x80b0b44 (from 0x80a8aeb)      emit_property_changed():
/home/manuel/bluez/src/dbus-common.c:266
	+  5 0x80b086d (from 0x80b0be0)       append_variant():
/home/manuel/bluez/src/dbus-common.c:195
	+  5 0x805005d (from 0x80b0bf2)       g_dbus_send_message():
/home/manuel/bluez/gdbus/object.c:615
	+  1 0x808a82f (from 0x808cdb4)   check_pending_hci_req():
/home/manuel/bluez/src/security.c:186
	+  0 0x808c945 (from 0x7e0dab)  io_security_event():
/home/manuel/bluez/src/security.c:967
	+  1 0x808a32d (from 0x808caa9)   hci_test_bit():
/home/manuel/bluez/./lib/bluetooth/hci_lib.h:167
	+  1 0x808bc30 (from 0x808cafa)   cmd_status():
/home/manuel/bluez/src/security.c:681
	+  1 0x808a82f (from 0x808cdb4)   check_pending_hci_req():
/home/manuel/bluez/src/security.c:186
	+  0 0x808c945 (from 0x7e0dab)  io_security_event():
/home/manuel/bluez/src/security.c:967
	+  1 0x808a32d (from 0x808caa9)   hci_test_bit():
/home/manuel/bluez/./lib/bluetooth/hci_lib.h:167
	+  1 0x808c6e1 (from 0x808cd1b)   disconn_complete():
/home/manuel/bluez/src/security.c:916
	+  2 0x80b2947 (from 0x808c734)    hcid_dbus_disconn_complete():
/home/manuel/bluez/src/dbus-hci.c:779
	+  3 0x80a1a5d (from 0x80b29a3)     manager_find_adapter():
/home/manuel/bluez/src/manager.c:343
	+  4 0x80a1955 (from 0x7c947e)      adapter_cmp():
/home/manuel/bluez/src/manager.c:319
	+  5 0x80a89ca (from 0x80a198d)       adapter_get_address():
/home/manuel/bluez/src/adapter.c:2625
	+  6 0x80a208d (from 0x80a89f8)        bacpy():
/home/manuel/bluez/./lib/bluetooth/bluetooth.h:132
	+  5 0x80a1000 (from 0x80a199f)       bacmp():
/home/manuel/bluez/./lib/bluetooth/bluetooth.h:128
	+  3 0x80a45fd (from 0x80b29d2)     adapter_find_connection():
/home/manuel/bluez/src/adapter.c:1025
	+  4 0x80ac5b0 (from 0x80a4644)      device_has_connection():
/home/manuel/bluez/src/device.c:934
	+  3 0x80a97f0 (from 0x80b2a2c)     adapter_remove_connection():
/home/manuel/bluez/src/adapter.c:2992
	+  4 0x80ac472 (from 0x80a9864)      device_remove_connection():
/home/manuel/bluez/src/device.c:908
	+  5 0x80ac306 (from 0x80ac58f)       device_set_connected():
/home/manuel/bluez/src/device.c:875
	+  6 0x80b0b44 (from 0x80ac353)        emit_property_changed():
/home/manuel/bluez/src/dbus-common.c:266
	+  7 0x80b086d (from 0x80b0be0)         append_variant():
/home/manuel/bluez/src/dbus-common.c:195
	+  7 0x805005d (from 0x80b0bf2)         g_dbus_send_message():
/home/manuel/bluez/gdbus/object.c:615
	+  4 0x80ae44a (from 0x80a9891)      device_get_address():
/home/manuel/bluez/src/device.c:1654
	+  5 0x80aa3e0 (from 0x80ae475)       bacpy():
/home/manuel/bluez/./lib/bluetooth/bluetooth.h:132
	+  4 0x808a77f (from 0x80a98a9)      hci_req_queue_remove():
/home/manuel/bluez/src/security.c:169
	+  4 0x80afe26 (from 0x80a98b4)      device_is_authenticating():
/home/manuel/bluez/src/device.c:2339
	+  4 0x80ae585 (from 0x80a98d6)      device_is_temporary():
/home/manuel/bluez/src/device.c:1683
	+  1 0x808a82f (from 0x808cdb4)   check_pending_hci_req():
/home/manuel/bluez/src/security.c:186
	+  0 0x8099459 (from 0x7e0dab)  connect_watch():
/home/manuel/bluez/src/glib-helper.c:257
	+  1 0x80ae001 (from 0x809963a)   browse_cb():
/home/manuel/bluez/src/device.c:1540

I think it keeps crashing the same way, when browse_cb gets called
user_data points to non valid data.

Manuel
