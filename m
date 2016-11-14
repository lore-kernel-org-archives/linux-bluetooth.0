Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161114115118.GA5921@x1c>
References: <1479123009-7190-1-git-send-email-luiz.dentz@gmail.com> <20161114115118.GA5921@x1c>
From: Trump DD <wrxzzj@gmail.com>
Date: Mon, 14 Nov 2016 21:53:25 +0800
Message-ID: <CABuKQigFTmsni5cGhgMdneez_K78-cKTrg1LG6qHZjmK2tpj7g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/adapter: Fix using wrong address type to
 listen ATT
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

this patch look like fix part bug of BLE devices reconnect

when I restart bluetoothd , all works fine.
such as:
systemctl stop bluetooth
systemctl start bluetooth
click BLE mouse button, reconnect success.

but this issue existed after apply this patch
1.  reboot computer, bluetoothd the first time startup, BLE mouse
reconnect failed with loop
Connected: yes
Connected: no
...
...

with log
bluetoothd[471]: src/adapter.c:connected_callback() hci0 device
C0:11:5B:C6:55:DF connected eir_len 27
bluetoothd[471]: src/adapter.c:dev_disconnected() Device
C0:11:5B:C6:55:DF disconnected, reason 0
bluetoothd[471]: src/adapter.c:adapter_remove_connection()
bluetoothd[471]: plugins/policy.c:disconnect_cb() reason 0
bluetoothd[471]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
C0:11:5B:C6:55:DF type 2 status 0xe
bluetoothd[471]: src/device.c:device_bonding_complete() bonding (nil)
status 0x0e
bluetoothd[471]: src/device.c:device_bonding_failed() status 14
bluetoothd[471]: src/adapter.c:resume_discovery()
bluetoothd[471]: src/adapter.c:connected_callback() hci0 device
C0:11:5B:C6:55:DF connected eir_len 27
bluetoothd[471]: src/adapter.c:dev_disconnected() Device
C0:11:5B:C6:55:DF disconnected, reason 0
bluetoothd[471]: src/adapter.c:adapter_remove_connection()
bluetoothd[471]: plugins/policy.c:disconnect_cb() reason 0
bluetoothd[471]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
C0:11:5B:C6:55:DF type 2 status 0xe
bluetoothd[471]: src/device.c:device_bonding_complete() bonding (nil)
status 0x0e
bluetoothd[471]: src/device.c:device_bonding_failed() status 14
bluetoothd[471]: src/adapter.c:resume_discovery()
bluetoothd[471]: src/adapter.c:connected_callback() hci0 device
C0:11:5B:C6:55:DF connected eir_len 27
bluetoothd[471]: src/adapter.c:dev_disconnected() Device
C0:11:5B:C6:55:DF disconnected, reason 0
bluetoothd[471]: src/adapter.c:adapter_remove_connection()
bluetoothd[471]: plugins/policy.c:disconnect_cb() reason 0
bluetoothd[471]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
C0:11:5B:C6:55:DF type 2 status 0xe
bluetoothd[471]: src/device.c:device_bonding_complete() bonding (nil)
status 0x0e
bluetoothd[471]: src/device.c:device_bonding_failed() status 14
bluetoothd[471]: src/adapter.c:resume_discovery()
bluetoothd[471]: src/adapter.c:connected_callback() hci0 device
C0:11:5B:C6:55:DF connected eir_len 27
bluetoothd[471]: src/adapter.c:dev_disconnected() Device
C0:11:5B:C6:55:DF disconnected, reason 0
bluetoothd[471]: src/adapter.c:adapter_remove_connection()
bluetoothd[471]: plugins/policy.c:disconnect_cb() reason 0
bluetoothd[471]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
C0:11:5B:C6:55:DF type 2 status 0xe
bluetoothd[471]: src/device.c:device_bonding_complete() bonding (nil)
status 0x0e
bluetoothd[471]: src/device.c:device_bonding_failed() status 14
bluetoothd[471]: src/adapter.c:resume_discovery()

On Mon, Nov 14, 2016 at 7:51 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Mon, Nov 14, 2016, Luiz Augusto von Dentz wrote:
>> bdaddr_type shall only matter for controllers supporting LE otherwise
>> it may cause BDADDR_BREDR to be used for things like LE ATT socket
>> listen breaking reconnections.
>> ---
>>  src/adapter.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Applied. Thanks.
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
