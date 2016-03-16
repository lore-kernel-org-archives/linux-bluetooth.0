Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+4r+YTJByojL8QBCtWnUFeojqOoKkiOBycJFrfCdWz=g@mail.gmail.com>
References: <CAASrBQ=Wd1Jdp1GHEzjPrZ=-nZocAo9qx05pvsMsz0T6Btc95Q@mail.gmail.com>
	<CABBYNZ+4r+YTJByojL8QBCtWnUFeojqOoKkiOBycJFrfCdWz=g@mail.gmail.com>
Date: Wed, 16 Mar 2016 15:02:08 -0600
Message-ID: <CAASrBQmixu2USeLXSsR3vaSWUujra=Ky1TcXTyMUgsr4GR9_Jw@mail.gmail.com>
Subject: Re: setting indication on GattCharacteristic1 interface
From: Mark Rages <markrages@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It seems to work to treat indication as notify.

But sometimes bluetoothd is crashing:

Program received signal SIGSEGV, Segmentation fault.
register_notify_cb (att_ecode=0, user_data=0x7b1d60) at src/gatt-client.c:1114
1114        if (!chrc->notifying) {
(gdb) bt
#0  register_notify_cb (att_ecode=0, user_data=0x7b1d60)
    at src/gatt-client.c:1114
#1  0x000000000049c97d in complete_notify_request (data=0x719a60)
    at src/shared/gatt-client.c:1137
#2  enable_ccc_callback (opcode=<optimized out>, pdu=<optimized out>,
    length=<optimized out>, user_data=0x719a60)
    at src/shared/gatt-client.c:1219
#3  0x00000000004998da in handle_rsp (pdu_len=<optimized out>,
    pdu=0x7b1af1 "\022\020", opcode=19 '\023', att=0x7b1db0)
    at src/shared/att.c:697
#4  can_read_data (io=<optimized out>, user_data=0x7b1db0)
    at src/shared/att.c:869
#5  0x00000000004a2245 in watch_callback (channel=<optimized out>,
    cond=<optimized out>, user_data=<optimized out>)
    at src/shared/io-glib.c:170
#6  0x00007ffff7b1ace5 in g_main_context_dispatch ()
   from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#7  0x00007ffff7b1b048 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#8  0x00007ffff7b1b30a in g_main_loop_run ()
   from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#9  0x000000000040b674 in main (argc=1, argv=0x7fffffffe638) at src/main.c:687

On Wed, Mar 16, 2016 at 6:03 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mark,
>
> On Wed, Mar 16, 2016 at 12:59 AM, Mark Rages <markrages@gmail.com> wrote:
>> Hi,
>>
>> The GattCharacteristic1 d-bus interface has methods for StartNotify
>> and StopNotify.
>>
>> But I don't see corresponding methods for requesting Indications
>>
>> Is there a way to do this?  Should I write to the CCCD directly?  How
>> do the indications arrive on the d-bus?
>
> Indicate would probably need to be a method since it does require a
> reply, but for now you can just treat it as a notification whereas
> BlueZ will be responsible for confirming so nothing else need to be
> done by the application. The code can actually distinguished between
> the 2:
>
> /* Try to enable notifications and/or indications based on
> * whatever the characteristic supports.
> */
> if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_NOTIFY)
> pdu[2] = 0x01;
>
> if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_INDICATE)
> pdu[2] |= 0x02;
>
>
> --
> Luiz Augusto von Dentz



-- 
Regards,
Mark
markrages@gmail
