Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: ConnectProfile continuously failing with InProgress error
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <563C3D4B.30102@netcommwireless.com>
 <CABBYNZKcgeVoFJcNEcSpp3Kn45qM1XXRncQocSR5PCSGX=e6xQ@mail.gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Alan Au <alan.au@netcommwireless.com>
Message-ID: <563FF930.2030102@netcommwireless.com>
Date: Mon, 9 Nov 2015 12:38:56 +1100
MIME-Version: 1.0
In-Reply-To: <CABBYNZKcgeVoFJcNEcSpp3Kn45qM1XXRncQocSR5PCSGX=e6xQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 06/11/15 21:22, Luiz Augusto von Dentz wrote:
> Hi Alan,
>
> On Fri, Nov 6, 2015 at 7:40 AM, Alan Au <alan.au@netcommwireless.com> wrote:
>> Hi,
>>
>> I've been writing an application that invokes Device1.ConnectProfile to
>> connect to a remote device. That works fine in the normal case. But during
>> development sometimes the app crashes after invoking ConnectProfile but
>> before the ConnectProfile async invocation returns. In this case bluetoothd
>> seems to sometimes get stuck in a bad state in which all subsequent calls to
>> ConnectProfile (or Connect) for the same device will continuously return a
>> org.bluez.Error.InProgress failure. I need to reboot the box to recover.
>>
>> This is reproducible with bluetoothctl. By running "connect" to a remote
>> device that is not there and then exiting bluetoothctl before the connect
>> result comes back. It may take a few tries but eventually bluetoothctl will
>> show that any connects to that same device will always fail with
>> org.bluez.Error.InProgress:
> Please add the bluetoothd logs, the important part is to check if
> there are services that don't transition to disconnected when that
> happen.

The log is pasted below. It shows a premature app exit - after 
ConnectProfile is invoked and before the async reply comes back.

I did a little analysis of the logs and the code and here is what I 
found. The summary is that the device fields are left in a bad state: 
device->connect is not correctly NULLed out. Below contains the detailed 
analysis.

In connect_profiles():

     if (dev->pending || dev->connect || dev->browse) {
             return btd_error_in_progress(msg);
     }

After the premature app exit, this error is being hit with 
"dev->connect" being non-NULL. So it seems that dev->connect was not 
properly cleaned up in the previous aborted connection.

This arises because of this code path:

     ext_exited -> remove_ext -> adapter_remove_profile -> 
device_remove_profile

device_remove_profile() clears out device->pending but not device->connect:

     device->pending = g_slist_remove(device->pending, service);

That happens before the connection is completed (abort in this case). On 
connection completion, device_profile_connected is called. Normally that 
would clear out device->connect but because device->pending has already 
been cleared out it returns early without doing the usual "done" 
cleanup. The result is a device->connect that is not NULL even though 
the connection attempt has finished. The early return in 
device_profile_connected that causes cleanup to be skipped:

     if (dev->pending == NULL) {
         return;
     }

So subsequent connect_profiles calls will always fail the 
device->connect check and hence always return an InProgress error.

Hope that helps.

# logread -f
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/profile.c:register_profile() sender :1.2
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/profile.c:create_ext() Created "Serial Port"
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/profile.c:ext_adapter_probe() "Serial Port" probed
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/profile.c:ext_start_servers() Serial Port listening on chan 3
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/adapter.c:adapter_service_add() /org/bluez/hci0
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10005
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/sdpd-service.c:add_record_to_server() Record pattern UUID 
00000003-0000-1000-8000-00805f9
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/sdpd-service.c:add_record_to_server() Record pattern UUID 
00000100-0000-1000-8000-00805f9
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/sdpd-service.c:add_record_to_server() Record pattern UUID 
00001002-0000-1000-8000-00805f9
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/sdpd-service.c:add_record_to_server() Record pattern UUID 
00001101-0000-1000-8000-00805f9
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/adapter.c:adapter_service_insert() /org/bluez/hci0
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/adapter.c:add_uuid() sending add uuid command for index 0
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/profile.c:ext_device_probe() Serial Port probed with UUID 
00001101-0000-1000-8000-00805f9b34fb
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/service.c:change_state() 0xca9a18: device 8C:DE:52:42:D9:3B profile 
Serial Port state changed: unavailable -> disconnected (0)
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/profile.c:ext_device_probe() Serial Port probed with UUID 
00001101-0000-1000-8000-00805f9b34fb
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/service.c:change_state() 0xc9aac0: device 00:07:80:31:CC:DD profile 
Serial Port state changed: unavailable -> disconnected (0)
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/device.c:connect_profiles() /org/bluez/hci0/dev_8C_DE_52_42_D9_3B 
00001101-0000-1000-8000-00805f9b34fb, client :1.2
Nov  9 10:12:54 ntc_20 user.notice hotplug: add, /module/rfcomm
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/service.c:btd_service_ref() 0xca9a18: ref=2
Nov  9 10:12:54 ntc_20 daemon.debug bluetoothd[2851]: 
src/service.c:change_state() 0xca9a18: device 8C:DE:52:42:D9:3B profile 
Serial Port state changed: disconnected -> connecting (0)
Nov  9 10:12:54 ntc_20 user.notice hotplug: add, /module/rfcomm
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/profile.c:ext_exited() "Serial Port" exited
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/service.c:change_state() 0xca9a18: device 8C:DE:52:42:D9:3B profile 
Serial Port state changed: connecting -> disconnected (-103)
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/device.c:device_profile_connected() Serial Port Software caused 
connection abort (103)
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/service.c:change_state() 0xca9a18: device 8C:DE:52:42:D9:3B profile 
Serial Port state changed: disconnected -> unavailable (0)
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/profile.c:ext_device_remove() Serial Port
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/service.c:btd_service_unref() 0xca9a18: ref=1
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/service.c:btd_service_unref() 0xca9a18: ref=0
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/service.c:change_state() 0xc9aac0: device 00:07:80:31:CC:DD profile 
Serial Port state changed: disconnected -> unavailable (0)
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/profile.c:ext_device_remove() Serial Port
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/service.c:btd_service_unref() 0xc9aac0: ref=0
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/profile.c:ext_adapter_remove() "Serial Port" removed
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/adapter.c:adapter_service_remove() /org/bluez/hci0
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/adapter.c:remove_uuid() sending remove uuid command for index 0
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/sdpd-service.c:remove_record_from_server() Removing record with 
handle 0x10005
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/profile.c:remove_ext() Removed "Serial Port"
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/adapter.c:connect_failed_callback() hci0 8C:DE:52:42:D9:3B status 2
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
plugins/policy.c:conn_fail_cb() status 2
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/adapter.c:bonding_attempt_complete() hci0 bdaddr 8C:DE:52:42:D9:3B 
type 0 status 0x2
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/device.c:device_bonding_complete() bonding (nil) status 0x02
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/device.c:device_bonding_failed() status 2
Nov  9 10:12:55 ntc_20 daemon.debug bluetoothd[2851]: 
src/adapter.c:resume_discovery()

Alan

>


______________________________________________________________________
This communication contains information which may be confidential or privileged. The information is intended solely for the use of the individual or entity named above.  If you are not the intended recipient, be aware that any disclosure, copying, distribution or use of the contents of this information is prohibited.  If you have received this communication in error, please notify me by telephone immediately.
______________________________________________________________________
