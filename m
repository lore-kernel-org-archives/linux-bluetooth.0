Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGXr9JHMO5tdy1HH2wX0X4=kB2hE-_b_bwt5WJ6yL0DCNhZN4Q@mail.gmail.com>
References: <CAGXr9JHWb+Gg=Xnm-Nx5iQ3=DK_4fTtFCeR35WpVmcsYhj5=1g@mail.gmail.com>
	<CABBYNZLyJ_BB0z5+=GRYxqaLkTfkRV5C24sPbg4bmH+Ho0nD6g@mail.gmail.com>
	<CAGXr9JHMO5tdy1HH2wX0X4=kB2hE-_b_bwt5WJ6yL0DCNhZN4Q@mail.gmail.com>
Date: Wed, 25 Jun 2014 10:27:22 +0300
Message-ID: <CABBYNZKLRwTAFz3FiNB1LE0qVJT_nSTmP7+G03svkZoxuZ_SbA@mail.gmail.com>
Subject: Re: BlueZ 5.19: BLE HoG device reconnect issues
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Wed, Jun 25, 2014 at 3:44 AM, Petri Gynther <pgynther@google.com> wrote:
> Hi Luiz,
>
> On Tue, Jun 24, 2014 at 4:48 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Petri,
>>
>> On Tue, Jun 24, 2014 at 3:37 AM, Petri Gynther <pgynther@google.com> wrote:
>>> With BlueZ 5.19 stack and BLE HoG remote controls, I'm seeing 3
>>> different issues when trying to reconnect a previously paired BLE HoG
>>> remote control:
>>>
>>> Full log:
>>> [72241.012] bluez: bluetoothd[29263]:
>>> src/adapter.c:discovering_callback() hci0 type 6 discovering 1
>>> [72251.269] bluez: bluetoothd[29263]:
>>> src/adapter.c:device_found_callback() hci0 addr 88:33:14:E6:XX:XX,
>>> rssi -81 flags 0x0000 eir_len 16
>>> [72251.270] bluez: bluetoothd[29263]: src/device.c:device_set_legacy() legacy 0
>>> [72251.270] bluez: bluetoothd[29263]: src/adapter.c:stop_passive_scanning()
>>> [72251.270] bluez: bluetoothd[29263]:
>>> src/adapter.c:discovering_callback() hci0 type 6 discovering 0
>>> [72251.270] bluez: bluetoothd[29263]:
>>> src/adapter.c:trigger_passive_scanning()
>>> [72251.270] bluez: bluetoothd[29263]:
>>> src/adapter.c:stop_passive_scanning_complete() status 0x0b (Rejected)
>>> [72251.270] bluez: bluetoothd[29263]: Stopping passive scanning failed: Rejected
>>> [72255.015] bluez: bluetoothd[29263]:
>>> src/adapter.c:passive_scanning_complete() status 0x00
>>> [72255.015] bluez: bluetoothd[29263]:
>>> src/adapter.c:discovering_callback() hci0 type 6 discovering 1
>>> [72258.550] bluez: bluetoothd[29263]:
>>> src/adapter.c:device_found_callback() hci0 addr 88:33:14:E6:XX:XX,
>>> rssi -76 flags 0x0000 eir_len 16
>>> [72258.551] bluez: bluetoothd[29263]: src/device.c:device_set_legacy() legacy 0
>>> [72258.551] bluez: bluetoothd[29263]: src/adapter.c:stop_passive_scanning()
>>> [72258.551] bluez: bluetoothd[29263]:
>>> src/adapter.c:device_found_callback() hci0 addr CB:36:E5:F5:XX:XX,
>>> rssi -82 flags 0x0000 eir_len 36
>>> [72258.558] bluez: bluetoothd[29263]:
>>> src/adapter.c:stop_passive_scanning_complete() status 0x00 (Success)
>>> [72258.558] bluez: bluetoothd[29263]: src/device.c:device_connect_le()
>>> Connection attempt to: 88:33:14:E6:XX:XX
>>> [72258.558] bluez: bluetoothd[29263]:
>>> src/adapter.c:discovering_callback() hci0 type 6 discovering 0
>>> [72278.629] bluez: bluetoothd[29263]:
>>> src/adapter.c:connect_failed_callback() hci0 88:33:14:E6:XX:XX status
>>> 2
>>> [72278.629] bluez: bluetoothd[29263]: plugins/policy.c:conn_fail_cb() status 2
>>> [72278.629] bluez: bluetoothd[29263]:
>>> src/adapter.c:bonding_attempt_complete() hci0 bdaddr 88:33:14:E6:XX:XX
>>> type 1 status 0x2
>>> [72278.629] bluez: bluetoothd[29263]:
>>> src/device.c:device_bonding_complete() bonding (nil) status 0x02
>>> [72278.629] bluez: bluetoothd[29263]:
>>> src/device.c:device_bonding_failed() status 2
>>> [72278.629] bluez: bluetoothd[29263]: src/adapter.c:resume_discovery()
>>> [72278.629] bluez: bluetoothd[29263]: src/device.c:att_connect_cb()
>>> connect error: Transport endpoint is not connected (134)
>>> [72278.629] bluez: bluetoothd[29263]: src/device.c:att_error_cb()
>>> Enabling automatic connections
>>> [72278.630] bluez: bluetoothd[29263]:
>>> src/adapter.c:adapter_connect_list_add() ignoring already added device
>>> /org/bluez/hci0/dev_88_33_14_E6_XX_XX
>>>
>>> Issues 1 and 2:
>>> [72251.270] bluez: bluetoothd[29263]: src/adapter.c:stop_passive_scanning()
>>> [72251.270] bluez: bluetoothd[29263]:
>>> src/adapter.c:discovering_callback() hci0 type 6 discovering 0
>>> [72251.270] bluez: bluetoothd[29263]:
>>> src/adapter.c:trigger_passive_scanning()
>>> [72251.270] bluez: bluetoothd[29263]:
>>> src/adapter.c:stop_passive_scanning_complete() status 0x0b (Rejected)
>>> [72251.270] bluez: bluetoothd[29263]: Stopping passive scanning failed: Rejected
>>>
>>> 1) device_found_callback() -> update_found_devices() ->
>>> stop_passive_scanning() needs to stop passive scanning because BlueZ
>>> is about to connect to previously paired BLE device. But,
>>> discovering_callback() doesn't take the pending BLE connection into
>>> account and still calls trigger_passive_scanning() when it shouldn't.
>>>
>>> 2) stop_passive_scanning() can actually fail because passive scanning
>>> was already stopped in kernel due to passive scan timer expiring. But,
>>> stop_passive_scanning_complete() handles the Reject case as an error
>>> and never attempts the pending BLE connection in that case.
>>>
>>> Issue 3:
>>> [72278.629] bluez: bluetoothd[29263]: src/device.c:att_connect_cb()
>>> connect error: Transport endpoint is not connected (134)
>>> [72278.629] bluez: bluetoothd[29263]: src/device.c:att_error_cb()
>>> Enabling automatic connections
>>> [72278.630] bluez: bluetoothd[29263]:
>>> src/adapter.c:adapter_connect_list_add() ignoring already added device
>>> /org/bluez/hci0/dev_88_33_14_E6_XX_XX
>>>
>>> If there is an error connecting to BLE device, att_error_cb() adds the
>>> failed device back to adapter connect list, but if it is already
>>> there, no code actually calls trigger_passive_scanning(). So, from
>>> this point on, no BLE device is ever going to reconnect back to BlueZ,
>>> because the passive scanning is disabled and nothing will re-enable
>>> it.
>>>
>>>
>>> Here is my proposed diff for fixing these issues:
>>> @@ -1228,7 +1228,7 @@ static void
>>> stop_passive_scanning_complete(uint8_t status, uint16_t length,
>>>         dev = adapter->connect_le;
>>>         adapter->connect_le = NULL;
>>>
>>> -       if (status != MGMT_STATUS_SUCCESS) {
>>> +       if (status != MGMT_STATUS_SUCCESS && status != MGMT_STATUS_REJECTED) {
>>>                 error("Stopping passive scanning failed: %s",
>>>                                                         mgmt_errstr(status));
>>>                 return;
>>>
>>> @@ -1500,6 +1500,10 @@ static void discovering_callback(uint16_t
>>> index, uint16_t length,
>>>          * passive scanning attempt.
>>>          */
>>>         if (!adapter->discovery_list) {
>>> +               if (adapter->connect_le) {
>>> +                       DBG("LE connect pending, skip
>>> trigger_passive_scanning");
>>> +                       return;
>>> +               }
>>>                 trigger_passive_scanning(adapter);
>>>                 return;
>>>         }
>>>
>>> @@ -3675,6 +3676,7 @@ static void att_error_cb(const GError *gerr,
>>> gpointer user_data)
>>>         if (device_get_auto_connect(device)) {
>>>                 DBG("Enabling automatic connections");
>>>                 adapter_connect_list_add(device->adapter, device);
>>> +               trigger_passive_scanning(device->adapter);
>>>         }
>>>  }
>>>
>>>
>>> Let me know if this looks good. I'll then e-mail proper patch for review.
>>
>> Haven't tested it yet but has this code been changed recently? I
>> wonder how does 5.20 behave in this regard since I did change some
>> parts of uHID implementation but not the scanning logic. Anyway in
>> future we will be changing the scanning logic and let the kernel do
>> the scanning (real passive scanning and perhaps whitelist) for us but
>> in the meantime it is good to have this fixed if still reproducible
>> with 5.20.
>
> I just tested with BlueZ 5.20, and I'm seeing the same 3 issues. I'll
> e-mail patches shortly. I'll fix issue #3 inside
> adapter_connect_list_add(), instead of modifying att_error_cb().

I could not reproduce it, Ive turned the device off and then back to
on and it did reconnects, perhaps there is something else that you are
doing to trigger the problem. Btw someone reported that the microsoft
arc also doesn't reconnect but it seems to be after restarting
bluetoothd which I haven't tried.


-- 
Luiz Augusto von Dentz
