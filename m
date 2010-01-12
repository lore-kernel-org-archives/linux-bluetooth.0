Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1263295337.12466.22.camel@localhost.localdomain>
References: <6aeb672b1001120157x18b2fee0n2e47078214e0f239@mail.gmail.com>
	 <1263295337.12466.22.camel@localhost.localdomain>
Date: Tue, 12 Jan 2010 21:39:16 +0800
Message-ID: <6aeb672b1001120539u1285b7ccr2558d804e965782b@mail.gmail.com>
Subject: Re: can we disable/enable eSCO by using setsockopt of sco socket?
From: Liang Bao <tim.bao@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

I revisited every message regarding this thread and found I'm a little
out-of-date. Thanks a lot for pointing out this.Some inline replies
below.

2010/1/12 Marcel Holtmann <marcel@holtmann.org>:
> Hi Liang,
>
>> We resumed the work of troubleshooting some problematic carkits
>> recently. While we agree with that eSCO/SCO is handled by the stuff
>> below HCI and bluez is absoultely right handling this, we still need
>> to face the fact that there're bunch of carkits and headsets with
>> hidden issues which only get exposed in certain combination like the
>> HF850 and our phones. Bluez can still be even better.
>>
>> In our case, the HF850 claims eSCO but when you're trying to connect
>> with it, it will timeout. So to have the stack works with those
>> on-market products, it's better if the developers sitting above the
>> HCI layer have some tweaking method on bluez behavior in ununsal
>> cases.
>>
>> Regarding the particular eSCO timeout failure, we add the following
>> delta into the net/bluetooth/hci_event.c
>>
>> =A0 =A0 =A0 =A0 hci_proto_connect_cfm(conn, ev->status);
>> +
>> + =A0 =A0if (conn->out && (ev->status =3D=3D 0x1a || ev->status =3D=3D 0=
x1c ||
>> + =A0 =A0 =A0 =A0 =A0 =A0ev->status =3D=3D 0x1f || ev->status =3D=3D 0x1=
0) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0conn->attempt < 2) {
>> + =A0 =A0 =A0 =A0conn->pkt_type =3D (hdev->esco_type & SCO_ESCO_MASK) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(hdev->esco_type & EDR_ESCO_MAS=
K);
>> + =A0 =A0 =A0 =A0hci_setup_sync(conn, conn->link->handle);
>> + =A0 =A0 =A0 =A0goto unlock;
>> + =A0 =A0}
>> +
>> =A0 =A0 =A0 if (ev->status)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_conn_del(conn);
>>
>> With this code change, we can successfully retry a SCO link after eSCO
>> attempt timeout. Still, a setsockopt interface will be better for
>> tweaking. Or is there any better idea on how to allow bluez work with
>> those on-market problematic devices?
>
> no you can NOT. It is race condition hazard. You can not call
> hci_proto_connect_cfm() and then just hci_setup_sync(). That confuses
> upper layers and just works by pure luck.
>
> The upstream code actually handles already the 0x1c and 0x1f error codes
> and retries the setup without eSCO packets types. So you snippet is
> against an old kernel (older than 2.6.30 at least).
>
Yeah, you're right, we're using version 2.6.29. I put the retry code betwee=
n

    hci_proto_connect_cfm(conn, ev->status)

and

    if (ev->status)
         hci_conn_del(conn);

because the kernel log is showing a warning complaining duplicate
device files is being added( log put at the end to make reading easy).
It seems the device file is created twice. I noticed a call to
hci_conn_hold_device(conn) is added to kernel 2.6.30 and onwards. I'll
try the new way tomorrow.

>> The hcidump log is copied again here for your convenience:
>> > 2009-09-03 17:26:29.093601 < HCI Command: Setup Synchronous Connection=
 (0x01|0x0
>> > 028) plen 17
>> > =A0 =A0handle 1 voice setting 0x0060
>> > 2009-09-03 17:26:29.094608 > HCI Event: Command Status (0x0f) plen 4
>> > =A0 =A0Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
>> > 2009-09-03 17:26:34.190952 > HCI Event: Synchronous Connect Complete (=
0x2c) plen
>> > =A017
>> > =A0 =A0status 0x10 handle 257 bdaddr 00:50:CD:20:BA:E6 type eSCO
>> > =A0 =A0Error: Connection Accept Timeout Exceeded
>
> The accept timeout has a pretty clear definition and while we could
> retry, I am having some concerns here. This also does not explain why
> 0x1a is in your code snippet.
We conduct a retry for the code 0x1a because there's also some devices
claim eSCO capability but respond with "Unsupported Remote Feature /
Unsupported LMP Feature (0X1A)".
We can understand your concern for 0x10 as it's a timeout by
definition, therefore, if a retry will be done, probably the same set
of parameters shall be used. However, the reality is that devices came
to market around eSCO was introduced could be troubles - eSCO was
added but not fully tested or failed to pass test and finally device
manufacturer had to turn off them but inconsistency was kept - like
what the Motorola HF850 does. Anyway, it's your call to determine the
behavior for the 0x10(Connection Accept Timeout Exceeded) and
personally I'll respect that.
>
> Regards
>
> Marcel
>
>
>

<4>[ 3753.172760] ------------[ cut here ]------------
<4>[ 3753.178649] WARNING: at fs/sysfs/dir.c:462 sysfs_add_one+0x34/0x44()
<4>[ 3753.226074] sysfs: duplicate filename 'hci0:257' can not be created
<4>[ 3753.239959] Modules linked in:
<4>[ 3753.243469] [<c037ce14>] (dump_stack+0x0/0x14) from [<c0062098>]
(warn_slowpath+0x70/0x8c)
<4>[ 3753.268310] [<c0062028>] (warn_slowpath+0x0/0x8c) from
[<c010d594>] (sysfs_add_one+0x34/0x44)
<4>[ 3753.298309]  r3:c9bf0280 r2:c041ec0a
<4>[ 3753.303161]  r7:00000001 r6:ced6dd58<3>kobject (c7c9f6dc): tried
to init an initialized object, something is seriously wrong.
<4>[ 3753.319458] [<c037ce14>] (dump_stack+0x0/0x14) from [<c0153940>]
(kobject_init+0x40/0x94)
<4>[ 3753.328826] [<c0153900>] (kobject_init+0x0/0x94) from
[<c01baa98>] (device_initialize+0x28/0x8c)
<4>[ 3753.338653]  r5:c057c430 r4:c7c9f698
<4>[ 3753.342987] [<c01baa70>] (device_initialize+0x0/0x8c) from
[<c0366bc4>] (hci_conn_add_sysfs+0x54/0x90)
<4>[ 3753.353363]  r5:c057c430 r4:c7c9f600
<4>[ 3753.357666] [<c0366b70>] (hci_conn_add_sysfs+0x0/0x90) from
[<c03651cc>] (hci_event_packet+0x3254/0x367c)
<4>[ 3753.368438]  r7:c963f00a r6:c7c9f600 r5:cec58140 r4:c9dd3c00
<4>[ 3753.375091] [<c0361f78>] (hci_event_packet+0x0/0x367c) from
[<c035fc3c>] (hci_rx_task+0xb8/0x2c4)
<4>[ 3753.385162] [<c035fb84>] (hci_rx_task+0x0/0x2c4) from
[<c00671b8>] (tasklet_action+0x74/0xb0)
<4>[ 3753.394836] [<c0067144>] (tasklet_action+0x0/0xb0) from
[<c00677a4>] (__do_softirq+0x60/0xf8)
<4>[ 3753.404388]  r7:c04f8e40 r6:cec52000 r5:00000009 r4:00000014
<4>[ 3753.411193] [<c0067744>] (__do_softirq+0x0/0xf8) from
[<c0067888>] (irq_exit+0x4c/0xac)
<4>[ 3753.420349] [<c006783c>] (irq_exit+0x0/0xac) from [<c0036058>]
(__exception_text_start+0x58/0x6c)
<4>[ 3753.430297] [<c0036000>] (__exception_text_start+0x0/0x6c) from
[<c0036a04>] (__irq_svc+0x44/0xa4)
<4>[ 3753.440399] Exception stack(0xcec53c68 to 0xcec53cb0)
<4>[ 3753.445983] 3c60:                   c048ddcc 00000013 c048ddb0
00000000 00000000 0000000c
<4>[ 3753.456115] 3c80: cec53d60 c014f8fc 00000004 00000013 cec53ce0
cec53d40 cec53c84 cec53cb4
<4>[ 3753.466369] 3ca0: c0062764 c0062dc0 60000013 ffffffff
<4>[ 3753.476623]  r5:d8200000 r4:ffffffff
<4>[ 3753.480804] [<c0062ad8>] (vprintk+0x0/0x340) from [<c037cf80>]
(printk+0x28/0x30)
<4>[ 3753.489379] [<c037cf58>] (printk+0x0/0x30) from [<c014f8e4>]
(no_frame+0x48/0xa8)
<4>[ 3753.497833]  r3:ced6dd58 r2:00000006 r1:00000020 r0:c014f8fc
<4>[ 3753.504608] [<c037ce14>] (dump_stack+0x0/0x14) from [<c0062098>]
(warn_slowpath+0x70/0x8c)
<4>[ 3753.514007] [<c0062028>] (warn_slowpath+0x0/0x8c) from
[<c010d594>] (sysfs_add_one+0x34/0x44)
<4>[ 3753.523559]  r3:c9bf0280 r2:c041ec0a
<4>[ 3753.527862]  r7:00000001 r6:ced6dd58 r5:cd9f8608 r4:ffffffef
<4>[ 3753.534515] [<c010d560>] (sysfs_add_one+0x0/0x44) from
[<c010e518>] (sysfs_do_create_link+0x104/0x19c)
<4>[ 3753.545013]  r5:cd9f8698 r4:cd9f8608
<4>[ 3753.549194] [<c010e414>] (sysfs_do_create_link+0x0/0x19c) from
[<c010e5dc>] (sysfs_create_link+0x14/0x18)
<4>[ 3753.559967]  r8:c7c9f700 r7:00000000 r6:00000000 r5:c7c9f6dc r4:c7c9f=
698
<4>[ 3753.567871] [<c010e5c8>] (sysfs_create_link+0x0/0x18) from
[<c01baf74>] (device_add+0x160/0x478)
<4>[ 3753.577819] [<c01bae14>] (device_add+0x0/0x478) from
[<c0366c24>] (add_conn+0x24/0x48)
<4>[ 3753.586730] [<c0366c00>] (add_conn+0x0/0x48) from [<c00737a8>]
(run_workqueue+0xe0/0x19c)
<4>[ 3753.596038]  r5:cec52000 r4:ced53700
<4>[ 3753.600219] [<c00736c8>] (run_workqueue+0x0/0x19c) from
[<c0073fb8>] (worker_thread+0x104/0x118)
<4>[ 3753.610168] [<c0073eb4>] (worker_thread+0x0/0x118) from
[<c0077c5c>] (kthread+0x5c/0x98)
<4>[ 3753.619415]  r7:00000000 r6:ced53700 r5:c0073eb4 r4:cec52000
<4>[ 3753.626068] [<c0077c00>] (kthread+0x0/0x98) from [<c0065600>]
(do_exit+0x0/0x784)
<4>[ 3753.634643]  r7:00000000 r6:00000000 r5:00000000 r4:00000000
<4>[ 3753.791687]  r5:cd9f8608 r4:ffffffef
<4>[ 3753.796752] [<c010d560>] (sysfs_add_one+0x0/0x44) from
[<c010e518>] (sysfs_do_create_link+0x104/0x19c)
<4>[ 3753.807281]  r5:cd9f8698 r4:cd9f8608
<4>[ 3753.811523] [<c010e414>] (sysfs_do_create_link+0x0/0x19c) from
[<c010e5dc>] (sysfs_create_link+0x14/0x18)
<4>[ 3753.822265]  r8:c7c9f700 r7:00000000 r6:00000000 r5:c7c9f6dc r4:c7c9f=
698
<4>[ 3753.830200] [<c010e5c8>] (sysfs_create_link+0x0/0x18) from
[<c01baf74>] (device_add+0x160/0x478)
<4>[ 3753.840179] [<c01bae14>] (device_add+0x0/0x478) from
[<c0366c24>] (add_conn+0x24/0x48)
<4>[ 3753.849304] [<c0366c00>] (add_conn+0x0/0x48) from [<c00737a8>]
(run_workqueue+0xe0/0x19c)
<4>[ 3753.858703]  r5:cec52000 r4:ced53700
<4>[ 3753.863525] [<c00736c8>] (run_workqueue+0x0/0x19c) from
[<c0073fb8>] (worker_thread+0x104/0x118)
<4>[ 3753.873504] [<c0073eb4>] (worker_thread+0x0/0x118) from
[<c0077c5c>] (kthread+0x5c/0x98)
<4>[ 3753.882659]  r7:00000000 r6:ced53700 r5:c0073eb4 r4:cec52000
<4>[ 3753.889465] [<c0077c00>] (kthread+0x0/0x98) from [<c0065600>]
(do_exit+0x0/0x784)
<4>[ 3753.898162]  r7:00000000 r6:00000000 r5:00000000 r4:00000000
