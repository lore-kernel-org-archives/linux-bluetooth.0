Return-Path: <cyrus@holtmann.org>
Message-ID: <4C446DA6.7070509@aircable.net>
Date: Mon, 19 Jul 2010 12:22:14 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: BlueZ segfault on sdp resolving
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

I had been tracing a BlueZ segfault for a few months all ready, the 
other day I got an idea, I added some trace to the code just printed 
which line got called (then I discover |-finstrument-functions from gcc)

Anyway, I run the test two times, and both times it died the same way, 
here's the trace I got:

bluetoothd[3551]: ../bluez-4.66/src/device.c:device_free()
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_free() 
device_free(0x2cf17e8)
bluetoothd[3551]: ../bluez-4.66/src/security.c:check_pending_hci_req()
bluetoothd[3551]: ../bluez-4.66/src/security.c:io_security_event()
bluetoothd[3551]: ../bluez-4.66/src/security.c:inquiry_complete()
bluetoothd[3551]: ../bluez-4.66/src/manager.c:manager_find_adapter()
bluetoothd[3551]: ../bluez-4.66/src/manager.c:adapter_cmp()
bluetoothd[3551]: ../bluez-4.66/src/security.c:check_pending_hci_req()
bluetoothd[3551]: ../bluez-4.66/src/security.c:io_security_event()
bluetoothd[3551]: ../bluez-4.66/src/security.c:cmd_status()
bluetoothd[3551]: ../bluez-4.66/src/security.c:check_pending_hci_req()
bluetoothd[3551]: ../bluez-4.66/src/adapter.c:session_unref() 
session_unref(0x2c99a68): ref=0
bluetoothd[3551]: ../bluez-4.66/src/adapter.c:session_free() Discovery 
session 0x2c99a68 with :1.247 deactivated
bluetoothd[3551]: ../bluez-4.66/src/adapter.c:session_remove() Stopping 
discovery
bluetoothd[3551]: Stopping discovery
bluetoothd[3551]: ../bluez-4.66/src/security.c:io_security_event()
bluetoothd[3551]: ../bluez-4.66/src/security.c:cmd_complete()
bluetoothd[3551]: ../bluez-4.66/src/security.c:inquiry_complete()
bluetoothd[3551]: ../bluez-4.66/src/manager.c:manager_find_adapter()
bluetoothd[3551]: ../bluez-4.66/src/manager.c:adapter_cmp()
bluetoothd[3551]: ../bluez-4.66/src/security.c:check_pending_hci_req()
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_address_cmp()
....
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_address_cmp()
bluetoothd[3551]: ../bluez-4.66/src/adapter.c:create_device() 
create_device(00:25:E7:98:AB:57)
bluetoothd[3551]: ../bluez-4.66/src/adapter.c:adapter_create_device() 
adapter_create_device(00:25:E7:98:AB:57)
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_create()
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_create() Creating 
device /org/bluez/3551/hci0/dev_00_25_E7_98_AB_57
bluetoothd[3551]: ../bluez-4.66/src/device.c:btd_device_ref() 
btd_device_ref(0x2cf3938): ref=1
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_get_path()
....
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_get_path()
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_browse()
bluetoothd[3551]: ../bluez-4.66/src/device.c:btd_device_ref() 
btd_device_ref(0x2cf3938): ref=2
bluetoothd[3551]: ../bluez-4.66/src/device.c:init_browse()
bluetoothd[3551]: ../bluez-4.66/src/glib-helper.c:bt_search_service()
bluetoothd[3551]: ../bluez-4.66/src/glib-helper.c:create_search_context()
bluetoothd[3551]: ../bluez-4.66/src/glib-helper.c:get_sdp_session() new 
(0x2ce2ce0)
bluetoothd[3551]: ../bluez-4.66/src/glib-helper.c:search_context_ref() 
(0x2cdd858) ref=1, src(0x2cdd858), dest(0x2cdd85e)
bluetoothd[3551]: 
../bluez-4.66/src/glib-helper.c:create_search_context() (0x2cdd858)
bluetoothd[3551]: ../bluez-4.66/src/device.c:get_properties()
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_is_paired()
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_is_trusted()
bluetoothd[3551]: ../bluez-4.66/src/device.c:get_properties()
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_is_paired()
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_is_trusted()
bluetoothd[3551]: ../bluez-4.66/src/device.c:get_properties()
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_is_paired()
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_is_trusted()
bluetoothd[3551]: ../bluez-4.66/src/security.c:io_security_event()
bluetoothd[3551]: ../bluez-4.66/src/security.c:conn_complete()
bluetoothd[3551]: ../bluez-4.66/src/manager.c:manager_find_adapter()
bluetoothd[3551]: ../bluez-4.66/src/manager.c:adapter_cmp()
bluetoothd[3551]: ../bluez-4.66/src/adapter.c:adapter_get_device() 
adapter_get_device(00:25:E7:98:AB:57)
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_address_cmp()
....
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_address_cmp()
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_add_connection()
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_set_connected()
bluetoothd[3551]: ../bluez-4.66/src/security.c:update_lastused()
bluetoothd[3551]: ../bluez-4.66/src/security.c:hci_req_data_new()
bluetoothd[3551]: ../bluez-4.66/src/security.c:hci_req_queue_append()
bluetoothd[3551]: ../bluez-4.66/src/security.c:hci_req_find_by_devid()
bluetoothd[3551]: ../bluez-4.66/src/security.c:hci_req_queue_process()
bluetoothd[3551]: ../bluez-4.66/src/security.c:hci_req_find_by_devid()
bluetoothd[3551]: ../bluez-4.66/src/security.c:check_pending_hci_req()
bluetoothd[3551]: ../bluez-4.66/src/security.c:hci_req_find_by_devid()
bluetoothd[3551]: ../bluez-4.66/src/security.c:io_security_event()
bluetoothd[3551]: ../bluez-4.66/src/security.c:cmd_status()
bluetoothd[3551]: ../bluez-4.66/src/security.c:check_pending_hci_req()
bluetoothd[3551]: ../bluez-4.66/src/security.c:hci_req_find_by_devid()
bluetoothd[3551]: ../bluez-4.66/src/security.c:io_security_event()
bluetoothd[3551]: ../bluez-4.66/src/security.c:cmd_status()
bluetoothd[3551]: ../bluez-4.66/src/security.c:check_pending_hci_req()
bluetoothd[3551]: ../bluez-4.66/src/security.c:hci_req_find_by_devid()
bluetoothd[3551]: ../bluez-4.66/src/security.c:io_security_event()
bluetoothd[3551]: ../bluez-4.66/src/security.c:cmd_status()
bluetoothd[3551]: ../bluez-4.66/src/security.c:check_pending_hci_req()
bluetoothd[3551]: ../bluez-4.66/src/security.c:hci_req_find_by_devid()
bluetoothd[3551]: ../bluez-4.66/src/security.c:io_security_event()
bluetoothd[3551]: 
../bluez-4.66/src/security.c:remote_features_information()
bluetoothd[3551]: ../bluez-4.66/src/security.c:get_bdaddr()
bluetoothd[3551]: ../bluez-4.66/src/security.c:check_pending_hci_req()
bluetoothd[3551]: ../bluez-4.66/src/security.c:hci_req_find_by_devid()
bluetoothd[3551]: Discovery session 0x2cd6958 with :1.247 activated
bluetoothd[3551]: ../bluez-4.66/src/adapter.c:session_ref() 
session_ref(0x2cd6958): ref=1
bluetoothd[3551]: ../bluez-4.66/src/security.c:io_security_event()
bluetoothd[3551]: ../bluez-4.66/src/security.c:remote_name_information()
bluetoothd[3551]: ../bluez-4.66/src/manager.c:manager_find_adapter()
bluetoothd[3551]: ../bluez-4.66/src/manager.c:adapter_cmp()
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_address_cmp()
....
bluetoothd[3551]: ../bluez-4.66/src/device.c:device_set_name()
bluetoothd[3551]: ../bluez-4.66/src/security.c:check_pending_hci_req()
bluetoothd[3551]: ../bluez-4.66/src/security.c:hci_req_find_by_devid()
bluetoothd[3551]: ../bluez-4.66/src/security.c:hci_req_queue_process()
bluetoothd[3551]: ../bluez-4.66/src/security.c:io_security_event()
bluetoothd[3551]: ../bluez-4.66/src/security.c:cmd_complete()
bluetoothd[3551]: ../bluez-4.66/src/security.c:start_inquiry()
bluetoothd[3551]: ../bluez-4.66/src/manager.c:manager_find_adapter()
bluetoothd[3551]: ../bluez-4.66/src/manager.c:adapter_cmp()
bluetoothd[3551]: ../bluez-4.66/src/security.c:check_pending_hci_req()
bluetoothd[3551]: ../bluez-4.66/src/glib-helper.c:connect_watch()
bluetoothd[3551]: ../bluez-4.66/src/device.c:browse_cb()
bluetoothd[3551]: ../bluez-4.66/src/device.c:search_cb()

Segmentation fault

If I read the code then I see device.c gets into search_cb directly from 
browse_cb in this piece
/* If we have a valid response and req->search_uuid == 2, then L2CAP
  * UUID & PNP searching was successful -- we are done */
  if (err < 0 || (req->search_uuid == 2 && req->records)) {
     if (err == -ECONNRESET && req->reconnect_attempt < 1) {
         req->search_uuid--;
         req->reconnect_attempt++;
     } else
         goto done;
     }

...
done:
         search_cb(recs, err, user_data);

Problem is that device has been released by when search_cb does:
if (err < 0) {
     error("%s: error updating services: %s (%d)",
           device->path, strerror(-err), -err);
     goto send_reply;
}

The solution we found a few months ago was to make a slight change in 
security.c, tell glib to do resources releasing with low priority:
chan = g_io_channel_unix_new(dev);
g_io_channel_set_close_on_unref(chan, TRUE);
io_data[hdev].watch_id = g_io_add_watch_full(chan, G_PRIORITY_LOW,
                         G_IO_IN | G_IO_NVAL | G_IO_HUP | G_IO_ERR,
                         io_security_event, di, (GDestroyNotify) g_free);


Still this is not enough. I think the problem is that the refcount is 
broken, we're forgeting to do btd_device_ref under some circustances?

I can mail the log if someone needs it.

Manuel
|
