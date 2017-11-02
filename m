Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALvjcs84PCsT0upCdp7H0QKfaK8KUbHEP5W6C3Dk65uhPZbLPg@mail.gmail.com>
References: <20171023111723.20729-1-luiz.dentz@gmail.com> <20171023111723.20729-2-luiz.dentz@gmail.com>
 <CALvjcs9i_J5H2jbVWToQbc4xNo9+N3jxrHh3FTo7LKjRN1E=Wg@mail.gmail.com>
 <CABBYNZKgHAUTipjRzxN=_sWH=ooRs3PHnhKaotc33epHQ7efhA@mail.gmail.com>
 <CALvjcs-SbR8JXDEvKRxD1Eq08PyN9D5zEDjc9P8puDMJDwJr=w@mail.gmail.com>
 <CABBYNZJuyZOEzLV0fkU8xTpPWuzc76CeYBLUR9DNq2c4pVPN5w@mail.gmail.com>
 <CALvjcs-HuvDjGo3ynvnxx47yXX4DJF1SFzdYkE1BY8VKcQD5Ng@mail.gmail.com>
 <CABBYNZ+WCNvJHgzM2JU2NxeNvUsDmThxw_Ly1uX83S7=tcNN4g@mail.gmail.com>
 <CALvjcs8Nzske0yzYQKEX6MNd_DQo05SExFqsVAgsM7_e65TR3w@mail.gmail.com> <CALvjcs84PCsT0upCdp7H0QKfaK8KUbHEP5W6C3Dk65uhPZbLPg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 Nov 2017 20:07:39 +0200
Message-ID: <CABBYNZ+WejgDWjpszASFE5xRgPNVL174Sa92nEFLkKFYyCxNCg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] gatt: Clear subscriptions for device not paired
To: Yunhan Wang <yunhanw@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

On Thu, Nov 2, 2017 at 7:45 PM, Yunhan Wang <yunhanw@google.com> wrote:
> Hi Luiz
>
> It is working now with your latest fix.

Great, hopefully this will settle things for server notifications.

> Thanks
> Best wishes
> Yunhan
>
> On Mon, Oct 30, 2017 at 2:44 PM, Yunhan Wang <yunhanw@google.com> wrote:
>> Hi, Luiz
>>
>> I am still consistently seeing multiple segmentation faults happening
>> on this feature via bluetoothctl. I am using latest bluez master.
>>
>> Here are the full reproduced details using bluetoothctl
>> Terminal 1(Bluetoothd):
>> sudo gdb --args ./src/bluetoothd --experimental --debug
>> run
>>
>> Terminal 2(btvirt 2 interface):
>> sudo ./emulator/btvirt -L -l2
>>
>> Terminal 3(Peripheral):
>> select 00:AA:01:00:00:23
>> power on
>> register-service 00001820-0000-1000-8000-00805f9b34fb
>> register-characteristic 00002a06-0000-1000-8000-00805f9b34fb read,indicate
>> register-application
>> advertise on
>>
>> Terminal 4(Central):
>> select 00:AA:01:01:00:24
>> power on
>> scan on
>> scan off
>> connect 00:AA:01:00:00:23
>> select-attribute /org/bluez/hci1/dev_00_AA_01_00_00_23/service000a/char000b
>> notify on
>> disconnect
>>
>> Then one of segmentation faults happen
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> queue_remove (queue=0x30, data=data@entry=0x70b6c0) at src/shared/queue.c:256
>> 256 for (entry = queue->head, prev = NULL; entry;
>> (gdb) bt
>> #0  queue_remove (queue=0x30, data=data@entry=0x70b6c0)
>>     at src/shared/queue.c:256
>> #1  0x00000000004437bb in att_disconnected (err=<optimized out>,
>>     user_data=0x70b6c0) at src/gatt-database.c:310
>> #2  0x0000000000481d6d in queue_foreach (queue=0x6f1d50,
>>     function=function@entry=0x4854a0 <disconn_handler>, user_data=0x68)
>>     at src/shared/queue.c:220
>> #3  0x0000000000486852 in disconnect_cb (io=<optimized out>,
>>     user_data=0x704ce0) at src/shared/att.c:590
>> #4  0x000000000048fde5 in watch_callback (channel=<optimized out>,
>>     cond=<optimized out>, user_data=<optimized out>)
>>     at src/shared/io-glib.c:170
>> #5  0x00007ffff7b1ace5 in g_main_context_dispatch ()
>>    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
>> #6  0x00007ffff7b1b048 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
>> #7  0x00007ffff7b1b30a in g_main_loop_run ()
>>    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
>> #8  0x000000000040b56b in main (argc=1, argv=0x7fffffffe618) at src/main.c:770
>>
>> some of other faults:
>> 1.
>> Program received signal SIGSEGV, Segmentation fault.
>> att_disconnected (err=<optimized out>, user_data=0x703270)
>>     at src/gatt-database.c:300
>> 300 if (!state->db->adapter)
>> (gdb)
>> (gdb) bt
>> #0  att_disconnected (err=<optimized out>, user_data=0x703270)
>>     at src/gatt-database.c:300
>> #1  0x0000000000481ccd in queue_foreach (queue=0x6fd7e0,
>>     function=function@entry=0x485400 <disconn_handler>, user_data=0x68)
>>     at src/shared/queue.c:220
>> #2  0x00000000004867b2 in disconnect_cb (io=<optimized out>,
>>     user_data=0x6ee310) at src/shared/att.c:590
>> #3  0x000000000048fd45 in watch_callback (channel=<optimized out>,
>>     cond=<optimized out>, user_data=<optimized out>)
>>     at src/shared/io-glib.c:170
>> #4  0x00007ffff7b1ace5 in g_main_context_dispatch ()
>>    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
>> #5  0x00007ffff7b1b048 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
>> #6  0x00007ffff7b1b30a in g_main_loop_run ()
>>    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
>> #7  0x000000000040b56b in main (argc=1, argv=0x7fffffffe618) at src/main.c:770
>> (gdb) print state
>> $1 = (struct device_state *) 0x703270
>> (gdb) print state->db
>> $2 = (struct btd_gatt_database *) 0x0
>>
>> 2.
>> Program received signal SIGSEGV, Segmentation fault.
>> btd_adapter_find_device (adapter=0x2a, dst=dst@entry=0x70a2e8,
>>     bdaddr_type=0 '\000') at src/adapter.c:821
>> 821 list = g_slist_find_custom(adapter->devices, &addr,
>> (gdb) quit
>>
>>
>> Thanks
>> Best wishes
>> Yunhan
>>
>> On Wed, Oct 25, 2017 at 6:27 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Yunhan,
>>>
>>> On Wed, Oct 25, 2017 at 10:58 AM, Yunhan Wang <yunhanw@nestlabs.com> wrote:
>>>> Hi, Luiz
>>>>
>>>> On Tue, Oct 24, 2017 at 1:10 AM, Luiz Augusto von Dentz
>>>> <luiz.dentz@gmail.com> wrote:
>>>>> Hi Yunhan,
>>>>>
>>>>> On Mon, Oct 23, 2017 at 11:59 PM, Yunhan Wang <yunhanw@nestlabs.com> wrote:
>>>>>> Hi, Luiz
>>>>>>
>>>>>> I have tried this, I think the issue is still there with your patch.
>>>>>
>>>>> I don't see any problem:
>>>>>
>>>>> bluetoothd[13968]: src/device.c:att_disconnected_cb() Software caused
>>>>> connection abort (103)
>>>>> bluetoothd[13968]: src/gatt-client.c:btd_gatt_client_disconnected()
>>>>> Device disconnected. Cleaning up.
>>>>> bluetoothd[13968]: src/device.c:att_disconnected_cb() Automatic
>>>>> connection disabled
>>>>> bluetoothd[13968]: attrib/gattrib.c:g_attrib_unref() 0x8897600: g_attrib_unref=0
>>>>> bluetoothd[13968]: src/gatt-database.c:att_disconnected()
>>>>> bluetoothd[13968]: src/gatt-database.c:ccc_write_cb() External CCC
>>>>> write received with value: 0x0000
>>>>>
>>>>> Could you try running under valgrind?
>>>>>
>>>> Yes, just tried under valgrind, the issue is constantly reprodcued.
>>>> Btw, I am currently using btvirt -L -l2, one client, one server, then
>>>> bluetoothd crash after client issue ble disconnect. I am using bluez
>>>> lateset master.
>>>>
>>>> sudo valgrind ./src/bluetoothd --experimental --debug
>>>> ==31609== Jump to the invalid address stated on the next line
>>>> ==31609==    at 0x0: ???
>>>> ==31609==    by 0x481B4C: queue_foreach (queue.c:220)
>>>> ==31609==    by 0x4436C8: att_disconnected (gatt-database.c:310)
>>>> ==31609==    by 0x481B4C: queue_foreach (queue.c:220)
>>>> ==31609==    by 0x486631: disconnect_cb (att.c:590)
>>>> ==31609==    by 0x48FBC4: watch_callback (io-glib.c:170)
>>>> ==31609==    by 0x4E7FCE4: g_main_context_dispatch (in
>>>> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
>>>> ==31609==    by 0x4E80047: ??? (in
>>>> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
>>>> ==31609==    by 0x4E80309: g_main_loop_run (in
>>>> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
>>>> ==31609==    by 0x40B51A: main (main.c:770)
>>>> ==31609==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
>>>
>>> It turns out the ccc_cb->callback could be NULL in case of
>>> svc_changed, though I not sure why in our case it did not have the
>>> last call pointing to clear_ccc_state:
>>>
>>>       at 0x0: ???
>>>       by 0x475C7C: clear_ccc_state (gatt-database.c:287)
>>>       by 0x4D28CF: queue_foreach (queue.c:220)
>>>       by 0x475FE7: att_disconnected (gatt-database.c:310)
>>>       by 0x4D7255: disconn_handler (att.c:538)
>>>       by 0x4D28CF: queue_foreach (queue.c:220)
>>>       by 0x4D8F39: disconnect_cb (att.c:590)
>>>       by 0x4E6B3A: watch_callback (io-glib.c:170)
>>>       by 0x50CD246: g_main_context_dispatch (in
>>> /usr/lib64/libglib-2.0.so.0.5200.3)
>>>       by 0x50CD5E7: ??? (in /usr/lib64/libglib-2.0.so.0.5200.3)
>>>       by 0x50CD901: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5200.3)
>>>       by 0x40CD90: main (main.c:770)
>>>     Address 0x0 is not stack'd, malloc'd or (recently) free'd
>>>
>>> Anyway now this should fixed upstream, thanks for the report.
>>>
>>> --
>>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
