Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK3B61f4gVuCGMM+7pSB3ik-jvAx+=6GWMwkS7mAecaKQ@mail.gmail.com>
References: <1479123009-7190-1-git-send-email-luiz.dentz@gmail.com>
 <20161114115118.GA5921@x1c> <CABuKQigFTmsni5cGhgMdneez_K78-cKTrg1LG6qHZjmK2tpj7g@mail.gmail.com>
 <CABBYNZK3B61f4gVuCGMM+7pSB3ik-jvAx+=6GWMwkS7mAecaKQ@mail.gmail.com>
From: Trump DD <wrxzzj@gmail.com>
Date: Tue, 15 Nov 2016 08:45:57 +0800
Message-ID: <CABuKQij9z-JOH7cGrasTQ8ONKB6dT0-vK3k4ONY3PXaSnjyREA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/adapter: Fix using wrong address type to
 listen ATT
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi
   compare the ok.log and failed.log generate by bluetoothd, I found
that the first time startup bluetoothd, a error message was presented
" Failed to set privacy: Rejected "

bluetoothd[9988]: Failed to set privacy: Rejected (0x0b)
bluetoothd[9988]: src/adapter.c:new_settings_callback() Settings: 0x00000ac5
bluetoothd[9988]: src/adapter.c:settings_changed() Changed settings: 0x00000004
bluetoothd[9988]: src/adapter.c:load_link_keys_complete() link keys
loaded for hci0
bluetoothd[9988]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
bluetoothd[9988]: src/adapter.c:load_irks_complete() IRKs loaded for hci0
bluetoothd[9988]: src/adapter.c:load_conn_params_complete() Connection
Parameters loaded for hci0
bluetoothd[9988]: src/adapter.c:add_device_complete()
C0:11:5B:C6:55:DF (2) added to kernel connect list
bluetoothd[9988]: src/adapter.c:get_connections_complete() Connection count: 0

In /etc/bluetooth/main.conf I have set
"
 Privacy=device
"

Why the first time bluetoothd startup failed to set privacy, the
second time bluetoothd startup all works right ?


On Mon, Nov 14, 2016 at 10:12 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Mon, Nov 14, 2016 at 3:53 PM, Trump DD <wrxzzj@gmail.com> wrote:
>> this patch look like fix part bug of BLE devices reconnect
>>
>> when I restart bluetoothd , all works fine.
>> such as:
>> systemctl stop bluetooth
>> systemctl start bluetooth
>> click BLE mouse button, reconnect success.
>>
>> but this issue existed after apply this patch
>> 1.  reboot computer, bluetoothd the first time startup, BLE mouse
>> reconnect failed with loop
>> Connected: yes
>> Connected: no
>> ...
>> ...
>
> Are you sure this is exact the same version after you reboot? Because
> from the logs it looks like the exact same problem so perhaps you have
> the older version being restored or something else is loading the old
> binary, for me this works all the time even after rebooting, or
> actually running a vm, but Im running it from source directly.



-- 
Thanks
