Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABuKQij9z-JOH7cGrasTQ8ONKB6dT0-vK3k4ONY3PXaSnjyREA@mail.gmail.com>
References: <1479123009-7190-1-git-send-email-luiz.dentz@gmail.com>
 <20161114115118.GA5921@x1c> <CABuKQigFTmsni5cGhgMdneez_K78-cKTrg1LG6qHZjmK2tpj7g@mail.gmail.com>
 <CABBYNZK3B61f4gVuCGMM+7pSB3ik-jvAx+=6GWMwkS7mAecaKQ@mail.gmail.com> <CABuKQij9z-JOH7cGrasTQ8ONKB6dT0-vK3k4ONY3PXaSnjyREA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Nov 2016 14:06:57 +0200
Message-ID: <CABBYNZLZ=DPiGcEU51Nr3KdrB7TD5u1HFYi3XZUJursJc4d+fA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/adapter: Fix using wrong address type to
 listen ATT
To: Trump DD <wrxzzj@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Nov 15, 2016 at 2:45 AM, Trump DD <wrxzzj@gmail.com> wrote:
> Hi
>    compare the ok.log and failed.log generate by bluetoothd, I found
> that the first time startup bluetoothd, a error message was presented
> " Failed to set privacy: Rejected "
>
> bluetoothd[9988]: Failed to set privacy: Rejected (0x0b)
> bluetoothd[9988]: src/adapter.c:new_settings_callback() Settings: 0x00000ac5
> bluetoothd[9988]: src/adapter.c:settings_changed() Changed settings: 0x00000004
> bluetoothd[9988]: src/adapter.c:load_link_keys_complete() link keys
> loaded for hci0
> bluetoothd[9988]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
> bluetoothd[9988]: src/adapter.c:load_irks_complete() IRKs loaded for hci0
> bluetoothd[9988]: src/adapter.c:load_conn_params_complete() Connection
> Parameters loaded for hci0
> bluetoothd[9988]: src/adapter.c:add_device_complete()
> C0:11:5B:C6:55:DF (2) added to kernel connect list
> bluetoothd[9988]: src/adapter.c:get_connections_complete() Connection count: 0
>
> In /etc/bluetooth/main.conf I have set
> "
>  Privacy=device
> "
>
> Why the first time bluetoothd startup failed to set privacy, the
> second time bluetoothd startup all works right ?

Rejected is probably due to adapter being powered, perhaps hciconfig
or something is messing up the state during reboot, but this shouldn't
affect the address type thus Im not sure why it will cause the failure
loop. Also note that if privacy is used you may not be able to
reconnect using passive scanning, at least the 2 mouses I have here
seems to be using direct advertising to public address but with
privacy we are scanning using the random address the controller just
filter any advertisement to the public address.
