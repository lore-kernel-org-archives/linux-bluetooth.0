Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140213124134.GA13866@x220.p-661hnu-f1>
References: <20140213014521.59803100423@puck.mtv.corp.google.com>
	<20140213124134.GA13866@x220.p-661hnu-f1>
Date: Thu, 13 Feb 2014 12:45:25 -0800
Message-ID: <CAGXr9JE_iee3UApMtm+Z_JzaMRWU7MgdHRCz-gGF-aQ7veH+jQ@mail.gmail.com>
Subject: Re: [PATCH] adapter: Handle MGMT_SETTING_LE change
From: Petri Gynther <pgynther@google.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Feb 13, 2014 at 4:41 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Petri,
>
> On Wed, Feb 12, 2014, Petri Gynther wrote:
>> On some BLE-capable adapters, BLE is not enabled by default. When BLE is
>> enabled after the adapter is already powered up, we need to call
>> trigger_passive_scanning() so that paired BLE devices (e.g. HoG devices)
>> are able to reconnect back to host.
>
> No dual-mode adapter should have LE enabled by default and we do have
> the following piece of code that gets run for any newly discovered
> adapter:
>
>         if ((adapter->supported_settings & MGMT_SETTING_LE) &&
>                         !(adapter->current_settings & MGMT_SETTING_LE))
>                 set_mode(adapter, MGMT_OP_SET_LE, 0x01);
>
> So the commit message is a bit confusing to me. How exactly do you end
> up reproducing this scenario? I could imagine this maybe happening if
> bluetoothd crashes and gets restarted when the adapter state is already
> powered on. Either way you should explain this in the commit message.
>

I have two boards with two different dual-mode adapters that exhibit
this behavior at every boot.

The init sequence is:
1. /etc/init.d/S09drivers
    modprobe all BlueZ kernel drivers

2. /etc/init.d/S31bluez
    hciconfig hci0 reset
    hciconfig hci0 up
    bdaddr -i hci0 <new BD address for adapter>
    hciconfig hci0 reset
    hciconfig hci0 up
    ...
    bluetoothd -n -d 2>&1 | <log-collector> &
    ...
    bluez-agent 2>&1 | <log-collector> &

So, bluetoothd starts with hci0 already up. With this init sequence,
bluetoothd log always shows BLE getting enabled (setting 0x200)
*after* the adapter is already powered up (setting 0x1). So, it is
necessary to call trigger_passive_scanning() at that point, since it
didn't get called at adapter_start() when BLE wasn't yet enabled.

bluetoothd[917]: src/adapter.c:adapter_register() Adapter
/org/bluez/hci0 registered
bluetoothd[917]: src/adapter.c:set_dev_class() sending set device
class command for index 0
bluetoothd[917]: src/adapter.c:set_name() sending set local name
command for index 0
bluetoothd[917]: src/adapter.c:set_mode() sending set mode command for index 0
bluetoothd[917]: src/adapter.c:set_mode() sending set mode command for index 0
bluetoothd[917]: src/adapter.c:set_mode() sending set mode command for index 0
bluetoothd[917]: src/adapter.c:set_mode() sending set mode command for index 0
bluetoothd[917]: src/adapter.c:adapter_start() adapter /org/bluez/hci0
has been enabled
bluetoothd[917]: src/adapter.c:load_link_keys_complete() link keys
loaded for hci0
bluetoothd[917]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
bluetoothd[917]: src/adapter.c:get_connections_complete() Connection count: 0
bluetoothd[917]: src/adapter.c:local_name_changed_callback() Name: system-name
bluetoothd[917]: src/adapter.c:local_name_changed_callback() Short name:
bluetoothd[917]: src/adapter.c:local_name_changed_callback() Current
alias: system-name
bluetoothd[917]: src/attrib-server.c:attrib_db_update() handle=0x0006
bluetoothd[917]: src/adapter.c:new_settings_callback() Settings: 0x000000c1
bluetoothd[917]: src/adapter.c:settings_changed() Changed settings: 0x00000040
bluetoothd[917]: src/adapter.c:new_settings_callback() Settings:
0x000002c1  <=== MGMT_SETTING_LE=1
bluetoothd[917]: src/adapter.c:settings_changed() Changed settings: 0x00000200
===> need to call trigger_passive_scanning() here
bluetoothd[917]: src/adapter.c:new_settings_callback() Settings: 0x000002d1
bluetoothd[917]: src/adapter.c:settings_changed() Changed settings: 0x00000010
bluetoothd[917]: src/adapter.c:new_settings_callback() Settings: 0x000002d3
bluetoothd[917]: src/adapter.c:settings_changed() Changed settings: 0x00000002


>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -405,6 +405,7 @@ static void store_adapter_info(struct btd_adapter *adapter)
>>  static void trigger_pairable_timeout(struct btd_adapter *adapter);
>>  static void adapter_start(struct btd_adapter *adapter);
>>  static void adapter_stop(struct btd_adapter *adapter);
>> +static void trigger_passive_scanning(struct btd_adapter *adapter);
>
> Since we try to avoid forward declarations like this whenever possible, did you
> investigate what would be needed to not need it here. I.e. is it really
> a lot of dependent functions that would need to be moved further up
> together with trigger_passive_scanning() or is there even a circular
> dependency somewhere that makes the forward declaration inevitable?
>

I'll investigate this.

>> +     if (changed_mask & MGMT_SETTING_LE) {
>> +             if ((adapter->current_settings & MGMT_SETTING_POWERED) &&
>> +                 (adapter->current_settings & MGMT_SETTING_LE)) {
>> +                     trigger_passive_scanning(adapter);
>> +             }
>> +     }
>
> The { } isn't needed for the internal if-statement.

I'll fix this.

>
> Johan
