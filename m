Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAASrBQnKW-zcVy=8ncXay9USaMT4czqqKp1Gp_PHkDAOQ2fWag@mail.gmail.com>
References: <CAASrBQ=Wd1Jdp1GHEzjPrZ=-nZocAo9qx05pvsMsz0T6Btc95Q@mail.gmail.com>
	<CABBYNZ+4r+YTJByojL8QBCtWnUFeojqOoKkiOBycJFrfCdWz=g@mail.gmail.com>
	<CAASrBQmixu2USeLXSsR3vaSWUujra=Ky1TcXTyMUgsr4GR9_Jw@mail.gmail.com>
	<CAASrBQnKW-zcVy=8ncXay9USaMT4czqqKp1Gp_PHkDAOQ2fWag@mail.gmail.com>
Date: Thu, 17 Mar 2016 09:51:40 +0200
Message-ID: <CABBYNZK94wg-AM=QVT4+R=hWCWGf81t877qPi+vSLv8tA2_0Xg@mail.gmail.com>
Subject: Re: setting indication on GattCharacteristic1 interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mark Rages <markrages@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

On Wed, Mar 16, 2016 at 11:16 PM, Mark Rages <markrages@gmail.com> wrote:
> Maybe this is more helpful. This time it failed on an assertion:

Those seems to be different issues.

> bluetoothd: src/shared/gatt-client.c:1593: disable_ccc_callback:
> Assertion `notify_data->chrc->ccc_write_id' failed.

Do you have the trace before this? btw, what version are you using?

> Program received signal SIGABRT, Aborted.
> 0x00007ffff70f2cc9 in __GI_raise (sig=sig@entry=6)
>     at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
> 56    ../nptl/sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> (gdb) bt
> #0  0x00007ffff70f2cc9 in __GI_raise (sig=sig@entry=6)
>     at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
> #1  0x00007ffff70f60d8 in __GI_abort () at abort.c:89
> #2  0x00007ffff70ebb86 in __assert_fail_base (
>     fmt=0x7ffff723c830 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n",
>     assertion=assertion@entry=0x4cb8f8 "notify_data->chrc->ccc_write_id",
>     file=file@entry=0x4cbb8e "src/shared/gatt-client.c", line=line@entry=1593,
>     function=function@entry=0x4cbbd0 <__PRETTY_FUNCTION__.5821>
> "disable_ccc_callback") at assert.c:92
> #3  0x00007ffff70ebc32 in __GI___assert_fail (
>     assertion=assertion@entry=0x4cb8f8 "notify_data->chrc->ccc_write_id",
>     file=file@entry=0x4cbb8e "src/shared/gatt-client.c", line=line@entry=1593,
>     function=function@entry=0x4cbbd0 <__PRETTY_FUNCTION__.5821>
> "disable_ccc_callback") at assert.c:101
> #4  0x000000000049ba8b in disable_ccc_callback (opcode=<optimized out>,
>     pdu=<optimized out>, length=<optimized out>, user_data=0x7213d0)
>     at src/shared/gatt-client.c:1593
> #5  0x00000000004998da in handle_rsp (pdu_len=<optimized out>,
>     pdu=0x71d8a1 "\022\020", opcode=19 '\023', att=0x71cb20)
>     at src/shared/att.c:697
> #6  can_read_data (io=<optimized out>, user_data=0x71cb20)
>     at src/shared/att.c:869
> #7  0x00000000004a2245 in watch_callback (channel=<optimized out>,
>     cond=<optimized out>, user_data=<optimized out>)
>     at src/shared/io-glib.c:170
> #8  0x00007ffff7b1ace5 in g_main_context_dispatch ()
>    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #9  0x00007ffff7b1b048 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #10 0x00007ffff7b1b30a in g_main_loop_run ()
>    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #11 0x000000000040b674 in main (argc=1, argv=0x7fffffffe638) at src/main.c:687
>
> On Wed, Mar 16, 2016 at 3:02 PM, Mark Rages <markrages@gmail.com> wrote:
>> It seems to work to treat indication as notify.
>>
>> But sometimes bluetoothd is crashing:
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> register_notify_cb (att_ecode=0, user_data=0x7b1d60) at src/gatt-client.c:1114
>> 1114        if (!chrc->notifying) {
>> (gdb) bt
>> #0  register_notify_cb (att_ecode=0, user_data=0x7b1d60)
>>     at src/gatt-client.c:1114
>> #1  0x000000000049c97d in complete_notify_request (data=0x719a60)
>>     at src/shared/gatt-client.c:1137
>> #2  enable_ccc_callback (opcode=<optimized out>, pdu=<optimized out>,
>>     length=<optimized out>, user_data=0x719a60)
>>     at src/shared/gatt-client.c:1219
>> #3  0x00000000004998da in handle_rsp (pdu_len=<optimized out>,
>>     pdu=0x7b1af1 "\022\020", opcode=19 '\023', att=0x7b1db0)
>>     at src/shared/att.c:697
>> #4  can_read_data (io=<optimized out>, user_data=0x7b1db0)
>>     at src/shared/att.c:869
>> #5  0x00000000004a2245 in watch_callback (channel=<optimized out>,
>>     cond=<optimized out>, user_data=<optimized out>)
>>     at src/shared/io-glib.c:170
>> #6  0x00007ffff7b1ace5 in g_main_context_dispatch ()
>>    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
>> #7  0x00007ffff7b1b048 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
>> #8  0x00007ffff7b1b30a in g_main_loop_run ()
>>    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
>> #9  0x000000000040b674 in main (argc=1, argv=0x7fffffffe638) at src/main.c:687
>>
>> On Wed, Mar 16, 2016 at 6:03 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Mark,
>>>
>>> On Wed, Mar 16, 2016 at 12:59 AM, Mark Rages <markrages@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> The GattCharacteristic1 d-bus interface has methods for StartNotify
>>>> and StopNotify.
>>>>
>>>> But I don't see corresponding methods for requesting Indications
>>>>
>>>> Is there a way to do this?  Should I write to the CCCD directly?  How
>>>> do the indications arrive on the d-bus?
>>>
>>> Indicate would probably need to be a method since it does require a
>>> reply, but for now you can just treat it as a notification whereas
>>> BlueZ will be responsible for confirming so nothing else need to be
>>> done by the application. The code can actually distinguished between
>>> the 2:
>>>
>>> /* Try to enable notifications and/or indications based on
>>> * whatever the characteristic supports.
>>> */
>>> if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_NOTIFY)
>>> pdu[2] = 0x01;
>>>
>>> if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_INDICATE)
>>> pdu[2] |= 0x02;
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>>
>>
>>
>> --
>> Regards,
>> Mark
>> markrages@gmail
>
>
>
> --
> Regards,
> Mark
> markrages@gmail



-- 
Luiz Augusto von Dentz
