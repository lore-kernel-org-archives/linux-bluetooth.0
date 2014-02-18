Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Feb 2014 21:49:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] adapter: Handle MGMT_SETTING_LE change
Message-ID: <20140218194954.GB9146@x220.p-661hnu-f1>
References: <20140218185506.C44B81005C1@puck.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140218185506.C44B81005C1@puck.mtv.corp.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Tue, Feb 18, 2014, Petri Gynther wrote:
> On dual-mode Bluetooth adapters, BLE is not enabled by default. When bluetoothd
> starts, BLE is enabled in read_info_complete(), but this management action does
> not always complete before adapter_start() is called. Therefore, bluetoothd
> needs to handle the MGMT_SETTING_LE change correctly in settings_changed().
> Specifically, trigger_passive_scanning() needs to be called so that paired BLE
> devices (e.g. HoG devices) are able to reconnect back to host.
> 
> The trace below shows this case:
> bluetoothd[1087]: src/adapter.c:adapter_start() adapter /org/bluez/hci0 has been enabled
>  => adapter_start() is called, but BLE is not yet enabled
> bluetoothd[1087]: src/adapter.c:load_link_keys_complete() link keys loaded for hci0
> bluetoothd[1087]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
> bluetoothd[1087]: src/adapter.c:get_connections_complete() Connection count: 0
> bluetoothd[1087]: src/adapter.c:new_settings_callback() Settings: 0x000000c1
> bluetoothd[1087]: src/adapter.c:settings_changed() Changed settings: 0x00000040
> bluetoothd[1087]: src/adapter.c:new_settings_callback() Settings: 0x000002c1
> bluetoothd[1087]: src/adapter.c:settings_changed() Changed settings: 0x00000200
>  => BLE got enabled, so need to call trigger_passive_scanning()
> bluetoothd[1087]: src/adapter.c:new_settings_callback() Settings: 0x000002d1
> bluetoothd[1087]: src/adapter.c:settings_changed() Changed settings: 0x00000010
> bluetoothd[1087]: src/adapter.c:new_settings_callback() Settings: 0x000002d3
> bluetoothd[1087]: src/adapter.c:settings_changed() Changed settings: 0x00000002
> 
> The issue is easily reproducible with this init sequence:
> hciconfig hci0 up
> bluetoothd -n -d
> ---
>  src/adapter.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied (after reformatting the commit message a bit to follow the "less
than 76 chars wide" rule). Thanks.

Johan
