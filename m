Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+yMwgGN4+pv7dyog0P8LyME5zVz=RuD=sqXs6csYQBAQ@mail.gmail.com>
References: <CAGXr9JFjURuq0brgMGYYU+r_5XedXm4WgS_B-vKLZiWS4WKbrA@mail.gmail.com>
 <CABBYNZ+yMwgGN4+pv7dyog0P8LyME5zVz=RuD=sqXs6csYQBAQ@mail.gmail.com>
From: Petri Gynther <pgynther@google.com>
Date: Thu, 10 Nov 2016 18:42:10 -0800
Message-ID: <CAGXr9JHSmQs-wZenHAVCPqpe+jL8b5awywBQ-XtZtqYSVtmcpQ@mail.gmail.com>
Subject: Re: BlueZ 5.43: HoG peripheral services re-discovered again and again
 on every reconnect
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Nov 10, 2016 at 6:17 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Petri,
>
> On Wed, Nov 9, 2016 at 9:39 PM, Petri Gynther <pgynther@google.com> wrote:
>> Hi linux-bluetooth:
>>
>> I'm seeing the following issue with BlueZ 5.43 and Linux 4.4.30.
>>
>> When a previously bonded HoG remote control reconnects to BlueZ 5.43
>> host, BlueZ goes ahead and re-discovers the primary services of the
>> bonded remote again and again on every reconnect.
>>
>> Why is this necessary? Shouldn't this information be cached on the
>> initial pairing/bonding, and a reconnect can get this information from
>> the relevant persistent file, rather than wasting BLE airtime and
>> delaying the reconnect?
>>
>
> IF, and only if, the cache is restored properly then yes it will work
> as you said, but bt_hog is not yet using the gatt_db so it might
> rediscover the handles anyway, this happens only once though.
>
>>
>>
>> In the above log, I see that MTU exchange takes place:
>> 15,148467,14484676000,-;bluez: bluetoothd[1985]:
>> src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
>>
>> Looking at the relevant code in src/shared/gatt-client.c, function
>> exchange_mtu_cb():
>>
>>         util_debug(client->debug_callback, client->debug_data,
>>                                         "MTU exchange complete, with MTU: %u",
>>                                         bt_att_get_mtu(client->att));
>>
>> discover:
>>         client->discovery_req = bt_gatt_discover_all_primary_services(
>>                                                         client->att, NULL,
>>                                                         discover_primary_cb,
>>                                                         discovery_op_ref(op),
>>                                                         discovery_op_unref);
>>
>>
>> The call to bt_gatt_discover_all_primary_services() is unconditional,
>> whether the device was previously bonded or not.
>
> This does range validation in case service changed is not properly
> implemented this will attempt to figure out if there are any changes
> in the database, but note that it will stop in here:
>
> attr = gatt_db_insert_service(client->db, start, &uuid, true,
> end - start + 1);
> if (!attr) {
>
> So if the database already contain all the services it will no do more
> than one Read By Group Type.
>
> --
> Luiz Augusto von Dentz

I'm observing primary services re-discovery on every reconnect, even
on the first reconnect after the initial pairing.
Multiple Read By Group Type messages are sent to the remote, until all
primary services have been re-discovered.
The files D4:F5:13:xx:xx:xx/attributes and cache/D4:F5:13:xx:xx:xx
exist and contain valid data.

Here is the log for the initial pairing:
15,15255,744664000,-;bluez: bluetoothd[2346]:
src/device.c:bonding_request_new() Requesting bonding for
D4:F5:13:xx:xx:xx
15,15256,744664000,-;bluez: bluetoothd[2346]: src/agent.c:agent_ref()
0x51c600: ref=3
15,15257,744664000,-;bluez: bluetoothd[2346]:
src/agent.c:agent_unref() 0x51c600: ref=2
15,15258,744664000,-;bluez: bluetoothd[2346]: src/adapter.c:suspend_discovery()
15,15259,744667000,-;bluez: bluetoothd[2346]:
src/adapter.c:adapter_bonding_attempt() hci0 bdaddr D4:F5:13:xx:xx:xx
type 1 io_cap 0x03
15,15306,744819000,-;bluez: bluetoothd[2346]:
src/adapter.c:connected_callback() hci0 device D4:F5:13:xx:xx:xx
connected eir_len 30
15,15313,744822000,-;bluez: bluetoothd[2346]:
src/adapter.c:connected_callback() device 0x518440 paired 0 bonded 0
bonding 1
15,15314,744822000,-;bluez: bluetoothd[2346]:
src/device.c:device_set_class() /org/bluez/hci0/dev_D4_F5_13_xx_xx_xx
0x20050C
15,15387,744928000,-;bluez: bluetoothd[2346]:
src/gatt-database.c:connect_cb() New incoming LE ATT connection
15,15388,744947000,-;bluez: bluetoothd[2346]:
attrib/gattrib.c:g_attrib_ref() 0x5159d8: g_attrib_ref=1
15,15389,744947000,-;bluez: bluetoothd[2346]:
src/device.c:load_gatt_db() Restoring D4:F5:13:xx:xx:xx gatt database
from file
15,15390,744948000,-;bluez: bluetoothd[2346]: No cache for D4:F5:13:xx:xx:xx
15,15394,744951000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:btd_gatt_client_connected() Device connected.
15,15413,745068000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
15,15442,745101000,-;bluez: bluetoothd[2346]:
src/adapter.c:new_irk_callback() hci0 new IRK for D4:F5:13:xx:xx:xx
RPA 00:00:00:00:00:00
15,15466,745120000,-;bluez: bluetoothd[2346]:
src/adapter.c:new_csrk_callback() hci0 new CSRK for D4:F5:13:xx:xx:xx
type 1
15,15489,745161000,-;bluez: bluetoothd[2346]:
src/adapter.c:new_csrk_callback() hci0 new CSRK for D4:F5:13:xx:xx:xx
type 0
15,15490,745177000,-;bluez: bluetoothd[2346]:
src/adapter.c:new_long_term_key_callback() hci0 new LTK for
D4:F5:13:xx:xx:xx type 0 enc_size 16
15,15491,745193000,-;bluez: bluetoothd[2346]: src/device.c:device_set_bonded()
15,15492,745193000,-;bluez: bluetoothd[2346]:
src/device.c:device_bonding_complete() bonding 0x51a458 status 0x00
15,15493,745194000,-;bluez: bluetoothd[2346]:
src/device.c:device_bonding_complete() Proceeding with service
discovery
15,15494,745194000,-;bluez: bluetoothd[2346]:
src/agent.c:agent_unref() 0x51c600: ref=1
15,15496,745196000,-;bluez: bluetoothd[2346]: src/adapter.c:resume_discovery()
15,15500,745198000,-;bluez: bluetoothd[2346]:
src/adapter.c:new_long_term_key_callback() hci0 new LTK for
D4:F5:13:xx:xx:xx type 0 enc_size 16
15,15505,745216000,-;bluez: bluetoothd[2346]: src/device.c:device_set_bonded()
15,15506,745216000,-;bluez: bluetoothd[2346]:
src/device.c:device_bonding_complete() bonding (nil) status 0x00
15,15507,745217000,-;bluez: bluetoothd[2346]: src/adapter.c:resume_discovery()
15,15514,745230000,-;bluez: bluetoothd[2346]:
src/adapter.c:pair_device_complete() Success (0x00)
15,15515,745230000,-;bluez: bluetoothd[2346]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr D4:F5:13:xx:xx:xx
type 1 status 0x0
15,15516,745233000,-;bluez: bluetoothd[2346]:
src/device.c:device_bonding_complete() bonding (nil) status 0x00
15,15517,745233000,-;bluez: bluetoothd[2346]: src/adapter.c:resume_discovery()
15,15548,745375000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Primary services found: 9
15,15549,745375000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0001, end: 0x000b, uuid:
00001800-0000-1000-8000-00805f9b34fb
15,15550,745376000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x000c, end: 0x000f, uuid:
00001801-0000-1000-8000-00805f9b34fb
15,15551,745377000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0010, end: 0x0022, uuid:
0000180a-0000-1000-8000-00805f9b34fb
15,15552,745380000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0023, end: 0x0028, uuid:
0000180f-0000-1000-8000-00805f9b34fb
15,15553,745380000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0029, end: 0x002e, uuid:
00001813-0000-1000-8000-00805f9b34fb
15,15554,745381000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x002f, end: 0x0037, uuid:
0000fff0-0000-1000-8000-00805f9b34fb
15,15555,745384000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0038, end: 0x005c, uuid:
00001812-0000-1000-8000-00805f9b34fb
15,15556,745384000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x005d, end: 0x0070, uuid:
f000fef0-0451-4000-b000-000000000000
15,15557,745384000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0071, end: 0xffff, uuid:
f000ffc0-0451-4000-b000-000000000000
15,15571,745472000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Secondary service discovery failed. ATT
ECODE: 0x10
15,15672,745685000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Included services found: 1
15,15673,745685000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0039, start: 0x0023, end:
0x0028,uuid: 0000180f-0000-1000-8000-0080
15,15753,745903000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Characteristics found: 5
15,15754,745904000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0002, end: 0x0003, value: 0x0003,
props: 0x02, uuid: 00002a00-0000-1
15,15755,745905000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0004, end: 0x0005, value: 0x0005,
props: 0x02, uuid: 00002a01-0000-1
15,15756,745906000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0006, end: 0x0007, value: 0x0007,
props: 0x0a, uuid: 00002a02-0000-1
15,15757,745907000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0008, end: 0x0009, value: 0x0009,
props: 0x08, uuid: 00002a03-0000-1
15,15758,745912000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x000a, end: 0x000b, value: 0x000b,
props: 0x02, uuid: 00002a04-0000-1
15,15789,746112000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Characteristics found: 1
15,15790,746113000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x000d, end: 0x000f, value: 0x000e,
props: 0x20, uuid: 00002a05-0000-1
15,15798,746134000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 1
15,15804,746134000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x000f, uuid:
00002902-0000-1000-8000-00805f9b34fb
15,15875,746292000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Characteristics found: 9
15,15876,746294000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0011, end: 0x0012, value: 0x0012,
props: 0x02, uuid: 00002a23-0000-1
15,15877,746294000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0013, end: 0x0014, value: 0x0014,
props: 0x02, uuid: 00002a24-0000-1
15,15878,746296000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0015, end: 0x0016, value: 0x0016,
props: 0x02, uuid: 00002a25-0000-1
15,15879,746296000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0017, end: 0x0018, value: 0x0018,
props: 0x02, uuid: 00002a26-0000-1
15,15880,746300000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0019, end: 0x001a, value: 0x001a,
props: 0x02, uuid: 00002a27-0000-1
15,15883,746304000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x001b, end: 0x001c, value: 0x001c,
props: 0x02, uuid: 00002a28-0000-1
15,15884,746307000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x001d, end: 0x001e, value: 0x001e,
props: 0x02, uuid: 00002a29-0000-1
15,15885,746307000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x001f, end: 0x0020, value: 0x0020,
props: 0x02, uuid: 00002a2a-0000-1
15,15886,746308000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0021, end: 0x0022, value: 0x0022,
props: 0x02, uuid: 00002a50-0000-1
15,15914,746423000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Characteristics found: 1
15,15915,746424000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0024, end: 0x0028, value: 0x0025,
props: 0x12, uuid: 00002a19-0000-1
15,15932,746453000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 3
15,15933,746453000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0026, uuid:
00002902-0000-1000-8000-00805f9b34fb
15,15934,746453000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0027, uuid:
00002908-0000-1000-8000-00805f9b34fb
15,15935,746455000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0028, uuid:
00002904-0000-1000-8000-00805f9b34fb
15,15960,746513000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Characteristics found: 2
15,15962,746514000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x002a, end: 0x002b, value: 0x002b,
props: 0x04, uuid: 00002a4f-0000-1
15,15964,746515000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x002c, end: 0x002e, value: 0x002d,
props: 0x10, uuid: 00002a31-0000-1
15,15980,746535000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 1
15,15981,746536000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x002e, uuid:
00002902-0000-1000-8000-00805f9b34fb
15,16014,746904000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Characteristics found: 3
15,16015,746904000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0030, end: 0x0032, value: 0x0031,
props: 0x1e, uuid: 0000fff1-0000-1
15,16016,746905000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0033, end: 0x0034, value: 0x0034,
props: 0x0a, uuid: 0000fff2-0000-1
15,16017,746909000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0035, end: 0x0037, value: 0x0036,
props: 0x12, uuid: 0000fff4-0000-1
15,16029,747004000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 1
15,16031,747005000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0032, uuid:
00002902-0000-1000-8000-00805f9b34fb
15,16044,747124000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 1
15,16045,747124000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0037, uuid:
00002902-0000-1000-8000-00805f9b34fb
15,16128,747343000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Characteristics found: 12
15,16130,747343000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x003a, end: 0x003b, value: 0x003b,
props: 0x02, uuid: 00002a4a-0000-1
15,16132,747344000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x003c, end: 0x003d, value: 0x003d,
props: 0x04, uuid: 00002a4c-0000-1
15,16135,747345000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x003e, end: 0x003f, value: 0x003f,
props: 0x06, uuid: 00002a4e-0000-1
15,16137,747346000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0040, end: 0x0042, value: 0x0041,
props: 0x02, uuid: 00002a4b-0000-1
15,16139,747347000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0043, end: 0x0046, value: 0x0044,
props: 0x12, uuid: 00002a4d-0000-1
15,16141,747350000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0047, end: 0x004a, value: 0x0048,
props: 0x12, uuid: 00002a4d-0000-1
15,16142,747351000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x004b, end: 0x004e, value: 0x004c,
props: 0x12, uuid: 00002a4d-0000-1
15,16143,747355000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x004f, end: 0x0051, value: 0x0050,
props: 0x0e, uuid: 00002a4d-0000-1
15,16144,747356000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0052, end: 0x0054, value: 0x0053,
props: 0x12, uuid: 00002a22-0000-1
15,16145,747359000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0055, end: 0x0056, value: 0x0056,
props: 0x0e, uuid: 00002a32-0000-1
15,16146,747361000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0057, end: 0x0059, value: 0x0058,
props: 0x12, uuid: 00002a33-0000-1
15,16147,747363000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x005a, end: 0x005c, value: 0x005b,
props: 0x0a, uuid: 00002a4d-0000-1
15,16156,747526000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 1
15,16157,747526000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0042, uuid:
00002907-0000-1000-8000-00805f9b34fb
15,16177,747635000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 2
15,16178,747638000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0045, uuid:
00002902-0000-1000-8000-00805f9b34fb
15,16179,747638000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0046, uuid:
00002908-0000-1000-8000-00805f9b34fb
15,16195,747744000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 2
15,16196,747744000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0049, uuid:
00002902-0000-1000-8000-00805f9b34fb
15,16197,747744000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x004a, uuid:
00002908-0000-1000-8000-00805f9b34fb
15,16213,747776000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 2
15,16214,747776000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x004d, uuid:
00002902-0000-1000-8000-00805f9b34fb
15,16215,747776000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x004e, uuid:
00002908-0000-1000-8000-00805f9b34fb
15,16225,747873000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 1
15,16231,747874000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0051, uuid:
00002908-0000-1000-8000-00805f9b34fb
15,16244,747894000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 1
15,16245,747894000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0054, uuid:
00002902-0000-1000-8000-00805f9b34fb
15,16258,747913000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 1
15,16259,747913000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0059, uuid:
00002902-0000-1000-8000-00805f9b34fb
15,16272,747936000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 1
15,16273,747936000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x005c, uuid:
00002908-0000-1000-8000-00805f9b34fb
15,16416,748556000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Characteristics found: 9
15,16422,748563000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x005e, end: 0x005f, value: 0x005f,
props: 0x0a, uuid: f000fef1-0451-4
15,16423,748563000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0060, end: 0x0061, value: 0x0061,
props: 0x0a, uuid: f000fef2-0451-4
15,16424,748563000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0062, end: 0x0063, value: 0x0063,
props: 0x0a, uuid: f000fef3-0451-4
15,16425,748563000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0064, end: 0x0065, value: 0x0065,
props: 0x0a, uuid: f000fef4-0451-4
15,16426,748563000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0066, end: 0x0068, value: 0x0067,
props: 0x08, uuid: f000fef5-0451-4
15,16427,748565000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0069, end: 0x006a, value: 0x006a,
props: 0x0a, uuid: f000fef6-0451-4
15,16428,748565000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x006b, end: 0x006c, value: 0x006c,
props: 0x0a, uuid: f000fef7-0451-4
15,16429,748567000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x006d, end: 0x006e, value: 0x006e,
props: 0x0a, uuid: f000fef8-0451-4
15,16430,748572000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x006f, end: 0x0070, value: 0x0070,
props: 0x08, uuid: f000fef9-0451-4
15,16443,748665000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 1
15,16444,748665000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0068, uuid:
00002902-0000-1000-8000-00805f9b34fb
15,16488,748827000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Characteristics found: 2
15,16489,748827000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0072, end: 0x0074, value: 0x0073,
props: 0x1c, uuid: f000ffc1-0451-4
15,16490,748827000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0075, end: 0xffff, value: 0x0076,
props: 0x1c, uuid: f000ffc2-0451-4
15,16505,748849000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 1
15,16506,748849000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0074, uuid:
00002902-0000-1000-8000-00805f9b34fb
15,16534,748968000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Descriptors found: 1
15,16535,748968000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() handle: 0x0077, uuid:
00002902-0000-1000-8000-00805f9b34fb
15,16536,748968000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_client_ready_cb() status: success, error: 10
15,16537,748973000,-;bluez: bluetoothd[2346]:
src/device.c:update_gatt_uuids() UUID Added:
00001800-0000-1000-8000-00805f9b34fb
15,16538,748975000,-;bluez: bluetoothd[2346]:
src/device.c:update_gatt_uuids() UUID Added:
00001801-0000-1000-8000-00805f9b34fb
15,16539,748975000,-;bluez: bluetoothd[2346]:
src/device.c:update_gatt_uuids() UUID Added:
0000180a-0000-1000-8000-00805f9b34fb
15,16540,748978000,-;bluez: bluetoothd[2346]:
src/device.c:update_gatt_uuids() UUID Added:
0000180f-0000-1000-8000-00805f9b34fb
15,16541,748978000,-;bluez: bluetoothd[2346]:
src/device.c:update_gatt_uuids() UUID Added:
00001813-0000-1000-8000-00805f9b34fb
15,16542,748979000,-;bluez: bluetoothd[2346]:
src/device.c:update_gatt_uuids() UUID Added:
0000fff0-0000-1000-8000-00805f9b34fb
15,16543,748981000,-;bluez: bluetoothd[2346]:
src/device.c:update_gatt_uuids() UUID Added:
00001812-0000-1000-8000-00805f9b34fb
15,16544,748981000,-;bluez: bluetoothd[2346]:
src/device.c:update_gatt_uuids() UUID Added:
f000fef0-0451-4000-b000-000000000000
15,16545,748983000,-;bluez: bluetoothd[2346]:
src/device.c:update_gatt_uuids() UUID Added:
f000ffc0-0451-4000-b000-000000000000
15,16546,748987000,-;bluez: bluetoothd[2346]:
src/device.c:device_probe_profiles() Probing profiles for device
D4:F5:13:xx:xx:xx
15,16554,748989000,-;bluez: bluetoothd[2346]:
profiles/gap/gas.c:gap_probe() GAP profile probe (D4:F5:13:xx:xx:xx)
15,16555,748991000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x563210: device D4:F5:13:xx:xx:xx
profile gap-profile state changed: unavailable -> disconnected (0)
15,16556,748993000,-;bluez: bluetoothd[2346]:
profiles/gap/gas.c:gap_accept() GAP profile accept (D4:F5:13:xx:xx:xx)
15,16558,748998000,-;bluez: bluetoothd[2346]:
profiles/gap/gas.c:handle_characteristic() Unsupported characteristic:
00002a02-0000-1000-8000-00805f9b34fb
15,16559,749000000,-;bluez: bluetoothd[2346]:
profiles/gap/gas.c:handle_characteristic() Unsupported characteristic:
00002a03-0000-1000-8000-00805f9b34fb
15,16560,749000000,-;bluez: bluetoothd[2346]:
profiles/gap/gas.c:handle_characteristic() Unsupported characteristic:
00002a04-0000-1000-8000-00805f9b34fb
15,16561,749002000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x563210: device D4:F5:13:xx:xx:xx
profile gap-profile state changed: disconnected -> connected (0)
15,16563,749003000,-;bluez: bluetoothd[2346]:
src/device.c:device_probe_profiles() Probing profiles for device
D4:F5:13:xx:xx:xx
15,16564,749006000,-;bluez: bluetoothd[2346]:
src/device.c:device_probe_profiles() Probing profiles for device
D4:F5:13:xx:xx:xx
15,16567,749011000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564370: device D4:F5:13:xx:xx:xx
profile deviceinfo state changed: unavailable -> disconnected (0)
15,16568,749015000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:deviceinfo_accept() deviceinfo
profile accept (D4:F5:13:xx:xx:xx)
15,16569,749018000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a23-0000-1000-8000-00805f9b34fb
15,16570,749019000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a24-0000-1000-8000-00805f9b34fb
15,16571,749021000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a25-0000-1000-8000-00805f9b34fb
15,16572,749023000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a26-0000-1000-8000-00805f9b34fb
15,16573,749024000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a27-0000-1000-8000-00805f9b34fb
15,16574,749024000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a28-0000-1000-8000-00805f9b34fb
15,16575,749026000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a29-0000-1000-8000-00805f9b34fb
15,16576,749027000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a2a-0000-1000-8000-00805f9b34fb
15,16577,749028000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564370: device D4:F5:13:xx:xx:xx
profile deviceinfo state changed: disconnected -> connected (0)
15,16578,749030000,-;bluez: bluetoothd[2346]:
src/device.c:device_probe_profiles() Probing profiles for device
D4:F5:13:xx:xx:xx
15,16579,749031000,-;bluez: bluetoothd[2346]:
profiles/battery/battery.c:batt_probe() BATT path
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx
15,16580,749032000,-;bluez: bluetoothd[2346]:
profiles/battery/battery.c:batt_probe() BATT matched BATT_UUID
0000180f-0000-1000-8000-00805f9b34fb
15,16581,749037000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564408: device D4:F5:13:xx:xx:xx
profile Battery state changed: unavailable -> disconnected (0)
15,16582,749038000,-;bluez: bluetoothd[2346]:
src/device.c:device_set_auto_connect() D4:F5:13:xx:xx:xx auto connect:
1
15,16583,749041000,-;bluez: bluetoothd[2346]:
src/device.c:device_set_auto_connect() Already connected
15,16584,749043000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564408: device D4:F5:13:xx:xx:xx
profile Battery state changed: disconnected -> connected (0)
15,16585,749045000,-;bluez: bluetoothd[2346]:
src/service.c:btd_service_ref() 0x564408: ref=2
15,16586,749047000,-;bluez: bluetoothd[2346]:
plugins/policy.c:service_cb() Added Battery reconnect 0
15,16591,749062000,-;bluez: bluetoothd[2346]:
profiles/battery/battery.c:batt_accept() BATT discovering
characteristics
15,16593,749066000,-;bluez: bluetoothd[2346]:
src/device.c:device_probe_profiles() Probing profiles for device
D4:F5:13:xx:xx:xx
15,16595,749068000,-;bluez: bluetoothd[2346]:
profiles/scanparam/scan.c:scan_param_probe() Scan Parameters Client
Driver profile probe (D4:F5:13:xx:xx:xx)
15,16596,749068000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564808: device D4:F5:13:xx:xx:xx
profile Scan Parameters Client Driver state changed: unavailable ->
disconnected (0)
15,16598,749075000,-;bluez: bluetoothd[2346]:
profiles/scanparam/scan.c:scan_param_accept() Scan Parameters Client
Driver profile accept (D4:F5:13:xx:xx:xx)
15,16600,749077000,-;bluez: bluetoothd[2346]:
profiles/scanparam/scan.c:handle_iwin() Scan Interval Window handle:
0x002b
15,16601,749079000,-;bluez: bluetoothd[2346]:
profiles/scanparam/scan.c:handle_refresh() Scan Refresh handle: 0x002d
15,16602,749081000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564808: device D4:F5:13:xx:xx:xx
profile Scan Parameters Client Driver state changed: disconnected ->
connected (0)
15,16610,749141000,-;bluez: bluetoothd[2346]:
src/device.c:device_probe_profiles() Probing profiles for device
D4:F5:13:xx:xx:xx
15,16612,749148000,-;bluez: bluetoothd[2346]:
profiles/input/hog.c:hog_probe() path
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx
15,16613,749149000,-;bluez: bluetoothd[2346]:
profiles/input/hog.c:hog_device_new() name=xxxxxx vendor=0x471,
product=0x2210, version=0x0
15,16614,749167000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564ba0: device D4:F5:13:xx:xx:xx
profile input-hog state changed: unavailable -> disconnected (0)
15,16615,749167000,-;bluez: bluetoothd[2346]:
src/device.c:device_set_auto_connect() D4:F5:13:xx:xx:xx auto connect:
1
15,16616,749171000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:bt_hog_attach() HoG discovering
characteristics
15,16617,749173000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564ba0: device D4:F5:13:xx:xx:xx
profile input-hog state changed: disconnected -> connected (0)
15,16618,749180000,-;bluez: bluetoothd[2346]:
src/service.c:btd_service_ref() 0x564ba0: ref=2
15,16619,749181000,-;bluez: bluetoothd[2346]:
plugins/policy.c:service_cb() Added input-hog reconnect 0
15,16620,749183000,-;bluez: bluetoothd[2346]:
src/device.c:device_probe_profiles() Probing profiles for device
D4:F5:13:xx:xx:xx
15,16621,749189000,-;bluez: bluetoothd[2346]:
src/device.c:device_probe_profiles() Probing profiles for device
D4:F5:13:xx:xx:xx
15,16622,749196000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_probe() OAD path
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx
15,16623,749198000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_probe() OAD matched OAD_UUID
f000ffc0-0451-4000-b000-000000000000
15,16624,749198000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564f60: device D4:F5:13:xx:xx:xx
profile OAD state changed: unavailable -> disconnected (0)
15,16625,749199000,-;bluez: bluetoothd[2346]:
src/device.c:device_set_auto_connect() D4:F5:13:xx:xx:xx auto connect:
1
15,16626,749201000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564f60: device D4:F5:13:xx:xx:xx
profile OAD state changed: disconnected -> connected (0)
15,16627,749202000,-;bluez: bluetoothd[2346]:
src/service.c:btd_service_ref() 0x564f60: ref=2
15,16628,749206000,-;bluez: bluetoothd[2346]:
plugins/policy.c:service_cb() Added OAD reconnect 0
15,16629,749208000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_accept() OAD discovering characteristics
15,16630,749210000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:btd_gatt_client_ready() GATT client ready
15,16631,749212000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:create_services() Exporting objects for GATT
services: D4:F5:13:xx:xx:xx
15,16632,749212000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:service_create() Exported GATT service:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service000c
15,16633,749214000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service000c/char000d
15,16635,749221000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:descriptor_create() Exported GATT characteristic
descriptor: /org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service000c/char000d/desc000f
15,16636,749225000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:service_create() Exported GATT service:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service0010
15,16637,749226000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service0010/char0011
15,16638,749227000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service0010/char0013
15,16639,749228000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service0010/char0015
15,16640,749229000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service0010/char0017
15,16641,749233000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service0010/char0019
15,16642,749237000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service0010/char001b
15,16643,749240000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service0010/char001d
15,16644,749247000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service0010/char001f
15,16645,749249000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service0010/char0021
15,16646,749250000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:service_create() Exported GATT service:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service005d
15,16647,749252000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service005d/char005e
15,16648,749257000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service005d/char0060
15,16649,749259000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service005d/char0062
15,16650,749262000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service005d/char0064
15,16651,749265000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service005d/char0066
15,16652,749268000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:descriptor_create() Exported GATT characteristic
descriptor: /org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service005d/char0066/desc0068
15,16653,749273000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service005d/char0069
15,16654,749275000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service005d/char006b
15,16655,749277000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service005d/char006d
15,16656,749281000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:characteristic_create() Exported GATT
characteristic:
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx/service005d/char006f
15,16657,749283000,-;bluez: bluetoothd[2346]:
src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx err 0
15,16669,749406000,-;bluez: bluetoothd[2346]:
src/adapter.c:add_device_complete() D4:F5:13:xx:xx:xx (1) added to
kernel connect list
15,16685,749474000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Registered handler for "Service Changed": 1
15,16697,749493000,-;bluez: bluetoothd[2346]:
profiles/gap/gas.c:read_device_name_cb() GAP Device Name: xxxxxx
15,16698,749494000,-;bluez: bluetoothd[2346]:
src/device.c:btd_device_device_set_name()
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx xxxxxx
15,16709,749512000,-;bluez: bluetoothd[2346]:
profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x03c0
15,16726,749565000,-;bluez: bluetoothd[2346]:
src/device.c:btd_device_set_trusted() trusted 1
15,16750,749663000,-;bluez: bluetoothd[2346]:
profiles/scanparam/scan.c:refresh_ccc_written_cb() Scan Refresh:
notification enabled
15,16817,749945000,-;bluez: bluetoothd[2346]:
profiles/battery/battery.c:char_discovered_cb() BATT inspecting
characteristics
15,16818,749945000,-;bluez: bluetoothd[2346]:
profiles/battery/battery.c:char_discovered_cb() BATT found
BATT_LEVEL_UUID value_handle=0x0025
15,16872,750055000,-;bluez: bluetoothd[2346]:
profiles/battery/battery.c:level_read_char_cb() BATT level=100
15,16932,750307000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_char_discovered_cb() OAD inspecting
characteristics
15,16933,750307000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_char_discovered_cb() OAD found
OAD_IMG_IDENTITY_UUID value_handle=0x0073
15,16934,750309000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_discover_desc() OAD discovering descriptors
start=0x0074 end=0x0074
15,16935,750310000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_char_discovered_cb() OAD found
OAD_IMG_BLOCK_UUID value_handle=0x0076
15,16936,750312000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_discover_desc() OAD discovering descriptors
start=0x0077 end=0xffff
15,16972,750473000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_desc_discovered_cb() OAD found
OAD_IMG_IDENTITY_UUID ccc_handle=0x0074
15,16999,750524000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:char_discovered_cb() HoG inspecting
characteristics
15,17000,750524000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:char_discovered_cb() 0x003a UUID:
00002a4a-0000-1000-8000-00805f9b34fb properties: 02
15,17001,750527000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:char_discovered_cb() 0x003c UUID:
00002a4c-0000-1000-8000-00805f9b34fb properties: 04
15,17002,750527000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:char_discovered_cb() 0x003e UUID:
00002a4e-0000-1000-8000-00805f9b34fb properties: 06
15,17003,750527000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:char_discovered_cb() 0x0040 UUID:
00002a4b-0000-1000-8000-00805f9b34fb properties: 02
15,17009,750529000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:char_discovered_cb() HoG discovering report
map
15,17010,750530000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:char_discovered_cb() 0x0043 UUID:
00002a4d-0000-1000-8000-00805f9b34fb properties: 12
15,17011,750531000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:char_discovered_cb() 0x0047 UUID:
00002a4d-0000-1000-8000-00805f9b34fb properties: 12
15,17012,750532000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:char_discovered_cb() 0x004b UUID:
00002a4d-0000-1000-8000-00805f9b34fb properties: 12
15,17013,750533000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:char_discovered_cb() 0x004f UUID:
00002a4d-0000-1000-8000-00805f9b34fb properties: 0e
15,17014,750534000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:char_discovered_cb() 0x0052 UUID:
00002a22-0000-1000-8000-00805f9b34fb properties: 12
15,17015,750535000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:char_discovered_cb() 0x0055 UUID:
00002a32-0000-1000-8000-00805f9b34fb properties: 0e
15,17016,750536000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:char_discovered_cb() 0x0057 UUID:
00002a33-0000-1000-8000-00805f9b34fb properties: 12
15,17017,750537000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:char_discovered_cb() 0x005a UUID:
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
15,17018,750542000,-;bluez: bluetoothd[2346]:
attrib/gattrib.c:g_attrib_ref() 0x5159d8: g_attrib_ref=21
15,17030,750633000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_desc_discovered_cb() OAD found
OAD_IMG_BLOCK_UUID ccc_handle=0x0077
15,17181,751092000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:proto_mode_read_cb() HoG is operating in
Report Protocol Mode
15,17195,751113000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:info_read_cb() bcdHID: 0x0111 bCountryCode:
0x00 Flags: 0x01
15,17216,751164000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:external_report_reference_cb() External
report reference read, external report characteristic UUID: 0x2a19
15,17226,751184000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_reference_cb() Report 0x0044: id 0x01
type input
15,17237,751204000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_reference_cb() Report 0x0048: id 0x02
type input
15,17251,751224000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_reference_cb() Report 0x004c: id 0x03
type input
15,17262,751244000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_reference_cb() Report 0x0050: id 0x00
type output
15,17270,751262000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_reference_cb() Report 0x005b: id 0x00
type feature
15,17338,751382000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_ccc_written_cb() Report characteristic
descriptor written: notifications enabled
15,17349,751404000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_ccc_written_cb() Report characteristic
descriptor written: notifications enabled
15,17360,751423000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_ccc_written_cb() Report characteristic
descriptor written: notifications enabled
15,17386,751547000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb() HoG inspecting report
map
15,17387,751547000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb() Report MAP:
15,17388,751547000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          05 01
15,17389,751547000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          09 06
15,17390,751548000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          a1 01
15,17391,751549000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          85 02
15,17392,751549000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          05 07
15,17393,751550000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          19 e0
15,17394,751551000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          29 e7
15,17395,751554000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          15 00
15,17396,751554000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          25 01
15,17397,751558000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          75 01
15,17398,751560000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          95 08
15,17399,751561000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          81 02
15,17400,751566000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          95 01
15,17401,751566000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          75 08
15,17402,751567000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          81 01
15,17403,751568000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          95 05
15,17404,751569000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          75 01
15,17405,751570000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          05 08
15,17406,751571000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          19 01
15,17408,751574000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          29 05
15,17409,751578000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          91 02
15,17410,751579000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          95 01
15,17411,751581000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          75 03
15,17412,751585000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          91 01
15,17413,751586000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          95 06
15,17414,751589000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          75 08
15,17415,751590000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          15 00
15,17416,751591000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          25 73
15,17417,751596000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          05 07
15,17418,751596000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          19 00
15,17419,751598000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          29 73
15,17420,751600000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          81 00
15,17421,751602000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          c0
15,17422,751603000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          05 0c
15,17423,751607000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          09 01
15,17424,751609000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          a1 01
15,17425,751613000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          85 03
15,17426,751613000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          05 0c
15,17427,751615000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          a1 02
15,17428,751615000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          19 00
15,17429,751617000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          2a 3c 02
15,17430,751617000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          15 00
15,17431,751620000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          26 3c 02
15,17432,751620000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          95 01
15,17433,751622000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          75 10
15,17434,751623000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          81 00
15,17435,751625000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          c0
15,17436,751626000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          c0
15,17437,751628000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          06 00 ff
15,17438,751629000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          09 07
15,17439,751631000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          a1 01
15,17440,751633000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          85 81
15,17441,751635000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          19 00
15,17442,751638000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          2a ff 00
15,17443,751647000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          15 00
15,17444,751647000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          26 ff 00
15,17445,751649000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          75 08
15,17446,751651000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          95 01
15,17447,751652000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          81 02
15,17448,751652000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb()          c0
15,17451,751664000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_map_read_cb() HoG created uHID device
15,17465,752003000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_upgrade_timer() OAD timer fired
15,17466,752003000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_enable_notify() OAD enabling notify for
OAD_IMG_IDENTITY_UUID
15,17467,752003000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_enable_notify() OAD enabling notify for
OAD_IMG_BLOCK_UUID
15,17488,752062000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_check_fwversion() OAD sending fw version
request
15,17509,752104000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_check_for_upgrade() OAD TI firmware is up to
date
15,17510,752107000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_check_for_upgrade() OAD GP firmware is up to
date
15,17511,752109000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_check_for_upgrade() OAD next check is in 28800
seconds
15,17548,755028000,-;bluez: bluetoothd[2346]:
src/adapter.c:new_conn_param() hci0 D4:F5:13:xx:xx:xx (1) min 0x0008
max 0x0008 latency 0x0032 timeout 0x01f4
15,17565,755036000,-;bluez: bluetoothd[2346]: src/adapter.c:store_conn_param()
15,17581,755058000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_value_cb() HoG report (3 bytes)
15,17594,755145000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_value_cb() HoG report (3 bytes)
15,17610,755375000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_value_cb() HoG report (3 bytes)
15,17619,755483000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_value_cb() HoG report (3 bytes)

Then, the remote disconnects to save battery:
15,18130,815801000,-;bluez: bluetoothd[2346]:
src/adapter.c:dev_disconnected() Device D4:F5:13:xx:xx:xx
disconnected, reason 3
15,18131,815801000,-;bluez: bluetoothd[2346]:
src/adapter.c:dev_disconnected() device 0x518440 paired 1 bonded 1
bonding 0
15,18132,815802000,-;bluez: bluetoothd[2346]:
src/adapter.c:adapter_remove_connection()
15,18133,815802000,-;bluez: bluetoothd[2346]:
plugins/policy.c:disconnect_cb() reason 3
15,18134,815804000,-;bluez: bluetoothd[2346]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr D4:F5:13:xx:xx:xx
type 1 status 0xe
15,18135,815804000,-;bluez: bluetoothd[2346]:
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
15,18136,815804000,-;bluez: bluetoothd[2346]:
src/device.c:device_bonding_failed() status 14
15,18137,815805000,-;bluez: bluetoothd[2346]: src/adapter.c:resume_discovery()
15,18138,815807000,-;bluez: bluetoothd[2346]: src/device.c:att_disconnected_cb()
15,18139,815808000,-;bluez: bluetoothd[2346]:
src/device.c:att_disconnected_cb() Connection reset by peer (131)
15,18140,815808000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x563210: device D4:F5:13:xx:xx:xx
profile gap-profile state changed: connected -> disconnecting (0)
15,18141,815810000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x563210: device D4:F5:13:xx:xx:xx
profile gap-profile state changed: disconnecting -> disconnected (0)
15,18142,815810000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564370: device D4:F5:13:xx:xx:xx
profile deviceinfo state changed: connected -> disconnecting (0)
15,18149,815810000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564370: device D4:F5:13:xx:xx:xx
profile deviceinfo state changed: disconnecting -> disconnected (0)
15,18150,815811000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564408: device D4:F5:13:xx:xx:xx
profile Battery state changed: connected -> disconnecting (0)
15,18151,815811000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564408: device D4:F5:13:xx:xx:xx
profile Battery state changed: disconnecting -> disconnected (0)
15,18152,815813000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564808: device D4:F5:13:xx:xx:xx
profile Scan Parameters Client Driver state changed: connected ->
disconnecting (0)
15,18153,815814000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564808: device D4:F5:13:xx:xx:xx
profile Scan Parameters Client Driver state changed: disconnecting ->
disconnected (0)
15,18156,815816000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564ba0: device D4:F5:13:xx:xx:xx
profile input-hog state changed: connected -> disconnecting (0)
15,18157,815817000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564ba0: device D4:F5:13:xx:xx:xx
profile input-hog state changed: disconnecting -> disconnected (0)
15,18158,815818000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564f60: device D4:F5:13:xx:xx:xx
profile OAD state changed: connected -> disconnecting (0)
15,18159,815819000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564f60: device D4:F5:13:xx:xx:xx
profile OAD state changed: disconnecting -> disconnected (0)
15,18169,815827000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected.
Cleaning up.
15,18170,815828000,-;bluez: bluetoothd[2346]:
attrib/gattrib.c:g_attrib_unref() 0x5159d8: g_attrib_unref=0

And here is the first reconnect:
15,18345,832482000,-;bluez: bluetoothd[2346]:
src/adapter.c:connected_callback() hci0 device D4:F5:13:xx:xx:xx
connected eir_len 0
15,18352,832483000,-;bluez: bluetoothd[2346]:
src/adapter.c:connected_callback() device 0x518440 paired 1 bonded 1
bonding 0
15,18369,832511000,-;bluez: bluetoothd[2346]:
src/gatt-database.c:connect_cb() New incoming LE ATT connection
15,18370,832511000,-;bluez: bluetoothd[2346]:
src/device.c:device_attach_att() Elevating security level since LTK is
available
15,18384,832524000,-;bluez: bluetoothd[2346]:
attrib/gattrib.c:g_attrib_ref() 0x5159d8: g_attrib_ref=1
15,18385,832525000,-;bluez: bluetoothd[2346]:
profiles/gap/gas.c:gap_accept() GAP profile accept (D4:F5:13:xx:xx:xx)
15,18386,832526000,-;bluez: bluetoothd[2346]:
profiles/gap/gas.c:handle_characteristic() Unsupported characteristic:
00002a02-0000-1000-8000-00805f9b34fb
15,18387,832527000,-;bluez: bluetoothd[2346]:
profiles/gap/gas.c:handle_characteristic() Unsupported characteristic:
00002a03-0000-1000-8000-00805f9b34fb
15,18388,832527000,-;bluez: bluetoothd[2346]:
profiles/gap/gas.c:handle_characteristic() Unsupported characteristic:
00002a04-0000-1000-8000-00805f9b34fb
15,18389,832528000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x563210: device D4:F5:13:xx:xx:xx
profile gap-profile state changed: disconnected -> connected (0)
15,18391,832543000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:deviceinfo_accept() deviceinfo
profile accept (D4:F5:13:xx:xx:xx)
15,18392,832544000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a23-0000-1000-8000-00805f9b34fb
15,18393,832545000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a24-0000-1000-8000-00805f9b34fb
15,18394,832546000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a25-0000-1000-8000-00805f9b34fb
15,18395,832546000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a26-0000-1000-8000-00805f9b34fb
15,18396,832547000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a27-0000-1000-8000-00805f9b34fb
15,18397,832549000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a28-0000-1000-8000-00805f9b34fb
15,18398,832549000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a29-0000-1000-8000-00805f9b34fb
15,18399,832552000,-;bluez: bluetoothd[2346]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a2a-0000-1000-8000-00805f9b34fb
15,18400,832557000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564370: device D4:F5:13:xx:xx:xx
profile deviceinfo state changed: disconnected -> connected (0)
15,18401,832558000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564408: device D4:F5:13:xx:xx:xx
profile Battery state changed: disconnected -> connected (0)
15,18402,832559000,-;bluez: bluetoothd[2346]:
plugins/policy.c:service_cb() Added Battery reconnect 0
15,18403,832563000,-;bluez: bluetoothd[2346]:
profiles/scanparam/scan.c:scan_param_accept() Scan Parameters Client
Driver profile accept (D4:F5:13:xx:xx:xx)
15,18404,832563000,-;bluez: bluetoothd[2346]:
profiles/scanparam/scan.c:handle_iwin() Scan Interval Window handle:
0x002b
15,18405,832565000,-;bluez: bluetoothd[2346]:
profiles/scanparam/scan.c:handle_refresh() Scan Refresh handle: 0x002d
15,18406,832567000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564808: device D4:F5:13:xx:xx:xx
profile Scan Parameters Client Driver state changed: disconnected ->
connected (0)
15,18413,832579000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564ba0: device D4:F5:13:xx:xx:xx
profile input-hog state changed: disconnected -> connected (0)
15,18414,832579000,-;bluez: bluetoothd[2346]:
plugins/policy.c:service_cb() Added input-hog reconnect 0
15,18415,832579000,-;bluez: bluetoothd[2346]:
src/service.c:change_state() 0x564f60: device D4:F5:13:xx:xx:xx
profile OAD state changed: disconnected -> connected (0)
15,18416,832579000,-;bluez: bluetoothd[2346]:
plugins/policy.c:service_cb() Added OAD reconnect 0
15,18417,832579000,-;bluez: bluetoothd[2346]:
profiles/oad/oad.c:oad_is_time_for_upgrade_check() OAD not time for
upgrade check yet (28720 seconds left)
15,18418,832579000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:btd_gatt_client_connected() Device connected.
15,18441,832622000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
15,18447,832642000,-;bluez: bluetoothd[2346]:
profiles/gap/gas.c:read_device_name_cb() GAP Device Name: xxxxxxxx
15,18463,832664000,-;bluez: bluetoothd[2346]:
profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x03c0
15,18481,832702000,-;bluez: bluetoothd[2346]:
profiles/battery/battery.c:level_read_char_cb() BATT level=100
====
15,18491,832722000,-;bluez: bluetoothd[2346]:
profiles/scanparam/scan.c:refresh_ccc_written_cb() Scan Refresh:
notification enabled
15,18649,834042000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Primary services found: 9
15,18650,834043000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0001, end: 0x000b, uuid:
00001800-0000-1000-8000-00805f9b34fb
15,18651,834043000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x000c, end: 0x000f, uuid:
00001801-0000-1000-8000-00805f9b34fb
15,18652,834043000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0010, end: 0x0022, uuid:
0000180a-0000-1000-8000-00805f9b34fb
15,18653,834045000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0023, end: 0x0028, uuid:
0000180f-0000-1000-8000-00805f9b34fb
15,18654,834046000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0029, end: 0x002e, uuid:
00001813-0000-1000-8000-00805f9b34fb
15,18655,834046000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x002f, end: 0x0037, uuid:
0000fff0-0000-1000-8000-00805f9b34fb
15,18656,834047000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0038, end: 0x005c, uuid:
00001812-0000-1000-8000-00805f9b34fb
15,18657,834049000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x005d, end: 0x0070, uuid:
f000fef0-0451-4000-b000-000000000000
15,18658,834050000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0071, end: 0xffff, uuid:
f000ffc0-0451-4000-b000-000000000000
15,18659,834053000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_client_ready_cb() status: success, error: 0
15,18660,834064000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:btd_gatt_client_ready() GATT client ready
15,18661,834066000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:create_services() Exporting objects for GATT
services: D4:F5:13:xx:xx:xx
15,18662,834066000,-;bluez: bluetoothd[2346]:
src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx err 0
15,18673,834571000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Registered handler for "Service Changed": 2
15,18702,837932000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_value_cb() HoG report (3 bytes)
15,18721,838033000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_value_cb() HoG report (3 bytes)
15,18737,838262000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_value_cb() HoG report (3 bytes)
15,18753,838353000,-;bluez: bluetoothd[2346]:
profiles/input/hog-lib.c:report_value_cb() HoG report (3 bytes)


Looking into btmon details after the line marked ====:
15,18491,832722000,-;bluez: bluetoothd[2346]:
profiles/scanparam/scan.c:refresh_ccc_written_cb() Scan Refresh:
notification enabled

We can see that BlueZ issues a bunch of ATT: Read By Group Type
Requests to re-discover all primary services (0x2800):

15,18491,832722000,-;bluez: bluetoothd[2346]:
profiles/scanparam/scan.c:refresh_ccc_written_cb() Scan Refresh:
notification enabled
15,18492,832723000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
11             [hci0] 17:26:51.730522
15,18493,832725000,-;btmon:       ATT: Read By Type Request (0x08) len 6
15,18494,832725000,-;btmon:         Handle range: 0x002f-0x0037
15,18495,832725000,-;btmon:         Attribute type: Characteristic (0x2803)
15,18496,832725000,-;btmon: > HCI Event: Number of Completed Packets
(0x13) plen 5   [hci0] 17:26:51.731128
15,18497,832726000,-;btmon:         Num handles: 1
15,18498,832726000,-;btmon:         Handle: 128
15,18499,832726000,-;btmon:         Count: 1
15,18500,832733000,-;btmon: > HCI Event: Number of Completed Packets
(0x13) plen 5   [hci0] 17:26:51.739362
15,18501,832733000,-;btmon:         Num handles: 1
15,18502,832733000,-;btmon:         Handle: 128
15,18503,832733000,-;btmon:         Count: 1
15,18504,832752000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
27             [hci0] 17:26:51.759357
15,18505,832753000,-;btmon:       ATT: Read By Type Response (0x09) len 22
15,18506,832753000,-;btmon:         Attribute data length: 7
15,18507,832753000,-;btmon:         Attribute data list: 3 entries
15,18508,832753000,-;btmon:         Handle: 0x0030
15,18509,832753000,-;btmon:         Value: 1e3100f1ff
15,18510,832753000,-;btmon:         Handle: 0x0033
15,18511,832753000,-;btmon:         Value: 0a3400f2ff
15,18512,832753000,-;btmon:         Handle: 0x0035
15,18513,832753000,-;btmon:         Value: 123600f4ff
15,18514,832754000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
11             [hci0] 17:26:51.760043
15,18515,832754000,-;btmon:       ATT: Read By Group Type Request (0x10) len 6
15,18516,832754000,-;btmon:         Handle range: 0x0001-0xffff
15,18517,832754000,-;btmon:         Attribute group type: Primary
Service (0x2800)
15,18518,832762000,-;btmon: > HCI Event: Number of Completed Packets
(0x13) plen 5   [hci0] 17:26:51.769346
15,18519,832762000,-;btmon:         Num handles: 1
15,18520,832762000,-;btmon:         Handle: 128
15,18521,832762000,-;btmon:         Count: 1
15,18522,832782000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
24             [hci0] 17:26:51.789303
15,18523,832782000,-;btmon:       ATT: Read By Group Type Response (0x11) len 19
15,18524,832782000,-;btmon:         Attribute data length: 6
15,18525,832782000,-;btmon:         Attribute group list: 3 entries
15,18526,832784000,-;btmon:         Handle range: 0x0001-0x000b
15,18527,832784000,-;btmon:         UUID: Generic Access Profile (0x1800)
15,18528,832784000,-;btmon:         Handle range: 0x000c-0x000f
15,18529,832784000,-;btmon:         UUID: Generic Attribute Profile (0x1801)
15,18530,832784000,-;btmon:         Handle range: 0x0010-0x0022
15,18531,832784000,-;btmon:         UUID: Device Information (0x180a)
15,18532,832784000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
11             [hci0] 17:26:51.790028
15,18533,832784000,-;btmon:       ATT: Read By Type Request (0x08) len 6
15,18534,832784000,-;btmon:         Handle range: 0x0036-0x0037
15,18535,832784000,-;btmon:         Attribute type: Characteristic (0x2803)
15,18536,832792000,-;btmon: > HCI Event: Number of Completed Packets
(0x13) plen 5   [hci0] 17:26:51.799354
15,18537,832792000,-;btmon:         Num handles: 1
15,18538,832792000,-;btmon:         Handle: 128
15,18539,832792000,-;btmon:         Count: 1
15,18540,832809000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
9              [hci0] 17:26:51.808179
15,18541,832809000,-;btmon:       ATT: Error Response (0x01) len 4
15,18542,832809000,-;btmon:         Read By Type Request (0x08)
15,18543,832809000,-;btmon:         Handle: 0x0036
15,18544,832809000,-;btmon:         Error: Attribute Not Found (0x0a)
15,18546,832811000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
11             [hci0] 17:26:51.810774
15,18547,832812000,-;btmon:       ATT: Read By Group Type Request (0x10) len 6
15,18548,832812000,-;btmon:         Handle range: 0x0023-0xffff
15,18549,832812000,-;btmon:         Attribute group type: Primary
Service (0x2800)
15,18553,833321000,-;btmon: > HCI Event: Number of Completed Packets
(0x13) plen 5   [hci0] 17:26:52.328191
15,18554,833321000,-;btmon:         Num handles: 1
15,18555,833321000,-;btmon:         Handle: 128
15,18556,833321000,-;btmon:         Count: 1
15,18558,833334000,-;btmon: > HCI Event: Vendor (0xff) plen 5
              [hci0] 17:26:52.339515
15,18559,833334000,-;btmon:         05 80 00 09 00
              .....
15,18560,833362000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
24             [hci0] 17:26:52.369478
15,18561,833363000,-;btmon:       ATT: Read By Group Type Response (0x11) len 19
15,18562,833363000,-;btmon:         Attribute data length: 6
15,18563,833363000,-;btmon:         Attribute group list: 3 entries
15,18564,833364000,-;btmon:         Handle range: 0x0023-0x0028
15,18565,833364000,-;btmon:         UUID: Battery Service (0x180f)
15,18566,833364000,-;btmon:         Handle range: 0x0029-0x002e
15,18567,833364000,-;btmon:         UUID: Scan Parameters (0x1813)
15,18568,833364000,-;btmon:         Handle range: 0x002f-0x0037
15,18569,833364000,-;btmon:         UUID: Unknown (0xfff0)
15,18570,833364000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
9              [hci0] 17:26:52.370138
15,18571,833364000,-;btmon:       ATT: Find Information Request (0x04) len 4
15,18572,833364000,-;btmon:         Handle range: 0x0036-0x0037
15,18574,833371000,-;btmon: > HCI Event: Number of Completed Packets
(0x13) plen 5   [hci0] 17:26:52.378203
15,18575,833371000,-;btmon:         Num handles: 1
15,18576,833371000,-;btmon:         Handle: 128
15,18577,833371000,-;btmon:         Count: 1
15,18578,833391000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
14             [hci0] 17:26:52.398166
15,18579,833391000,-;btmon:       ATT: Find Information Response (0x05) len 9
15,18580,833392000,-;btmon:         Format: UUID-16 (0x01)
15,18582,833394000,-;btmon:         Handle: 0x0036
15,18583,833394000,-;btmon:         UUID: Unknown (0xfff4)
15,18584,833394000,-;btmon:         Handle: 0x0037
15,18585,833394000,-;btmon:         UUID: Client Characteristic
Configuration (0x2902)
15,18586,833394000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
10             [hci0] 17:26:52.400735
15,18587,833394000,-;btmon:       ATT: Write Request (0x12) len 5
15,18588,833394000,-;btmon:         Handle: 0x0034
15,18589,833394000,-;btmon:           Data: 030000
15,18591,833912000,-;btmon: > HCI Event: Number of Completed Packets
(0x13) plen 5   [hci0] 17:26:52.919397
15,18592,833912000,-;btmon:         Num handles: 1
15,18593,833912000,-;btmon:         Handle: 128
15,18594,833912000,-;btmon:         Count: 1
15,18595,833931000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
5              [hci0] 17:26:52.938157
15,18596,833931000,-;btmon:       ATT: Write Response (0x13) len 0
15,18597,833932000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
11             [hci0] 17:26:52.939032
15,18598,833932000,-;btmon:       ATT: Read By Group Type Request (0x10) len 6
15,18599,833932000,-;btmon:         Handle range: 0x0038-0xffff
15,18600,833932000,-;btmon:         Attribute group type: Primary
Service (0x2800)
15,18601,833944000,-;btmon: > HCI Event: Number of Completed Packets
(0x13) plen 5   [hci0] 17:26:52.951628
15,18602,833944000,-;btmon:         Num handles: 1
15,18603,833944000,-;btmon:         Handle: 128
15,18604,833944000,-;btmon:         Count: 1
15,18605,833959000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
12             [hci0] 17:26:52.966479
15,18606,833959000,-;btmon:       ATT: Read By Group Type Response (0x11) len 7
15,18607,833960000,-;btmon:         Attribute data length: 6
15,18608,833960000,-;btmon:         Attribute group list: 1 entry
15,18609,833960000,-;btmon:         Handle range: 0x0038-0x005c
15,18610,833960000,-;btmon:         UUID: Human Interface Device (0x1812)
15,18611,833960000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
9              [hci0] 17:26:52.967113
15,18612,833960000,-;btmon:       ATT: Write Request (0x12) len 4
15,18613,833960000,-;btmon:         Handle: 0x0037
15,18614,833960000,-;btmon:           Data: 0100
15,18615,833971000,-;btmon: > HCI Event: Number of Completed Packets
(0x13) plen 5   [hci0] 17:26:52.976999
15,18616,833971000,-;btmon:         Num handles: 1
15,18617,833972000,-;btmon:         Handle: 128
15,18618,833972000,-;btmon:         Count: 1
15,18619,833979000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
5              [hci0] 17:26:52.986355
15,18620,833980000,-;btmon:       ATT: Write Response (0x13) len 0
15,18621,833980000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
11             [hci0] 17:26:52.986894
15,18622,833980000,-;btmon:       ATT: Read By Group Type Request (0x10) len 6
15,18623,833980000,-;btmon:         Handle range: 0x005d-0xffff
15,18624,833980000,-;btmon:         Attribute group type: Primary
Service (0x2800)
15,18625,833990000,-;btmon: > HCI Event: Number of Completed Packets
(0x13) plen 5   [hci0] 17:26:52.996610
15,18626,833990000,-;btmon:         Num handles: 1
15,18627,833991000,-;btmon:         Handle: 128
15,18628,833991000,-;btmon:         Count: 1
15,18629,834013000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
26             [hci0] 17:26:53.019401
15,18630,834013000,-;btmon:       ATT: Read By Group Type Response (0x11) len 21
15,18631,834013000,-;btmon:         Attribute data length: 20
15,18632,834013000,-;btmon:         Attribute group list: 1 entry
15,18633,834013000,-;btmon:         Handle range: 0x005d-0x0070
15,18634,834013000,-;btmon:         UUID: Vendor specific
(f000fef0-0451-4000-b000-000000000000)
15,18635,834013000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
11             [hci0] 17:26:53.020026
15,18636,834013000,-;btmon:       ATT: Read By Group Type Request (0x10) len 6
15,18637,834013000,-;btmon:         Handle range: 0x0071-0xffff
15,18638,834013000,-;btmon:         Attribute group type: Primary
Service (0x2800)
15,18639,834022000,-;btmon: > HCI Event: Number of Completed Packets
(0x13) plen 5   [hci0] 17:26:53.029922
15,18640,834022000,-;btmon:         Num handles: 1
15,18641,834022000,-;btmon:         Handle: 128
15,18642,834023000,-;btmon:         Count: 1
15,18643,834042000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
26             [hci0] 17:26:53.049348
15,18644,834042000,-;btmon:       ATT: Read By Group Type Response (0x11) len 21
15,18645,834042000,-;btmon:         Attribute data length: 20
15,18646,834042000,-;btmon:         Attribute group list: 1 entry
15,18647,834042000,-;btmon:         Handle range: 0x0071-0xffff
15,18648,834042000,-;btmon:         UUID: Vendor specific
(f000ffc0-0451-4000-b000-000000000000)
15,18649,834042000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() Primary services found: 9
15,18650,834043000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0001, end: 0x000b, uuid:
00001800-0000-1000-8000-00805f9b34fb
15,18651,834043000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x000c, end: 0x000f, uuid:
00001801-0000-1000-8000-00805f9b34fb
15,18652,834043000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0010, end: 0x0022, uuid:
0000180a-0000-1000-8000-00805f9b34fb
15,18653,834045000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0023, end: 0x0028, uuid:
0000180f-0000-1000-8000-00805f9b34fb
15,18654,834046000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0029, end: 0x002e, uuid:
00001813-0000-1000-8000-00805f9b34fb
15,18655,834046000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x002f, end: 0x0037, uuid:
0000fff0-0000-1000-8000-00805f9b34fb
15,18656,834047000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0038, end: 0x005c, uuid:
00001812-0000-1000-8000-00805f9b34fb
15,18657,834049000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x005d, end: 0x0070, uuid:
f000fef0-0451-4000-b000-000000000000
15,18658,834050000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_debug() start: 0x0071, end: 0xffff, uuid:
f000ffc0-0451-4000-b000-000000000000
15,18659,834053000,-;bluez: bluetoothd[2346]:
src/device.c:gatt_client_ready_cb() status: success, error: 0
15,18660,834064000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:btd_gatt_client_ready() GATT client ready
15,18661,834066000,-;bluez: bluetoothd[2346]:
src/gatt-client.c:create_services() Exporting objects for GATT
services: D4:F5:13:xx:xx:xx
15,18662,834066000,-;bluez: bluetoothd[2346]:
src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx err 0


The file "D4:F5:13:xx:xx:xx/attributes" exists and contains:
[1]
UUID=00002800-0000-1000-8000-00805f9b34fb
Value=1800
EndGroupHandle=11

[12]
UUID=00002800-0000-1000-8000-00805f9b34fb
Value=1801
EndGroupHandle=15

[16]
UUID=00002800-0000-1000-8000-00805f9b34fb
Value=180A
EndGroupHandle=34

[35]
UUID=00002800-0000-1000-8000-00805f9b34fb
Value=180F
EndGroupHandle=40

[41]
UUID=00002800-0000-1000-8000-00805f9b34fb
Value=1813
EndGroupHandle=46

[47]
UUID=00002800-0000-1000-8000-00805f9b34fb
Value=FFF0
EndGroupHandle=55

[56]
UUID=00002800-0000-1000-8000-00805f9b34fb
Value=1812
EndGroupHandle=92

[93]
UUID=00002800-0000-1000-8000-00805f9b34fb
Value=F000FEF004514000B000000000000000
EndGroupHandle=112

[113]
UUID=00002800-0000-1000-8000-00805f9b34fb
Value=F000FFC004514000B000000000000000
EndGroupHandle=65535


And, the file "cache/D4:F5:13:xx:xx:xx" exists and contains:
[Attributes]
0001=2800:000b:00001800-0000-1000-8000-00805f9b34fb
0002=2803:0003:02:00002a00-0000-1000-8000-00805f9b34fb
0004=2803:0005:02:00002a01-0000-1000-8000-00805f9b34fb
0006=2803:0007:0a:00002a02-0000-1000-8000-00805f9b34fb
0008=2803:0009:08:00002a03-0000-1000-8000-00805f9b34fb
000a=2803:000b:02:00002a04-0000-1000-8000-00805f9b34fb
000c=2800:000f:00001801-0000-1000-8000-00805f9b34fb
000d=2803:000e:20:00002a05-0000-1000-8000-00805f9b34fb
000f=00002902-0000-1000-8000-00805f9b34fb
0010=2800:0022:0000180a-0000-1000-8000-00805f9b34fb
0011=2803:0012:02:00002a23-0000-1000-8000-00805f9b34fb
0013=2803:0014:02:00002a24-0000-1000-8000-00805f9b34fb
0015=2803:0016:02:00002a25-0000-1000-8000-00805f9b34fb
0017=2803:0018:02:00002a26-0000-1000-8000-00805f9b34fb
0019=2803:001a:02:00002a27-0000-1000-8000-00805f9b34fb
001b=2803:001c:02:00002a28-0000-1000-8000-00805f9b34fb
001d=2803:001e:02:00002a29-0000-1000-8000-00805f9b34fb
001f=2803:0020:02:00002a2a-0000-1000-8000-00805f9b34fb
0021=2803:0022:02:00002a50-0000-1000-8000-00805f9b34fb
0023=2800:0028:0000180f-0000-1000-8000-00805f9b34fb
0024=2803:0025:12:00002a19-0000-1000-8000-00805f9b34fb
0026=00002902-0000-1000-8000-00805f9b34fb
0027=00002908-0000-1000-8000-00805f9b34fb
0028=00002904-0000-1000-8000-00805f9b34fb
0029=2800:002e:00001813-0000-1000-8000-00805f9b34fb
002a=2803:002b:04:00002a4f-0000-1000-8000-00805f9b34fb
002c=2803:002d:10:00002a31-0000-1000-8000-00805f9b34fb
002e=00002902-0000-1000-8000-00805f9b34fb
002f=2800:0037:0000fff0-0000-1000-8000-00805f9b34fb
0030=2803:0031:1e:0000fff1-0000-1000-8000-00805f9b34fb
0032=00002902-0000-1000-8000-00805f9b34fb
0033=2803:0034:0a:0000fff2-0000-1000-8000-00805f9b34fb
0035=2803:0036:12:0000fff4-0000-1000-8000-00805f9b34fb
0037=00002902-0000-1000-8000-00805f9b34fb
0038=2800:005c:00001812-0000-1000-8000-00805f9b34fb
0039=2802:0023:0028:0000180f-0000-1000-8000-00805f9b34fb
003a=2803:003b:02:00002a4a-0000-1000-8000-00805f9b34fb
003c=2803:003d:04:00002a4c-0000-1000-8000-00805f9b34fb
003e=2803:003f:06:00002a4e-0000-1000-8000-00805f9b34fb
0040=2803:0041:02:00002a4b-0000-1000-8000-00805f9b34fb
0042=00002907-0000-1000-8000-00805f9b34fb
0043=2803:0044:12:00002a4d-0000-1000-8000-00805f9b34fb
0045=00002902-0000-1000-8000-00805f9b34fb
0046=00002908-0000-1000-8000-00805f9b34fb
0047=2803:0048:12:00002a4d-0000-1000-8000-00805f9b34fb
0049=00002902-0000-1000-8000-00805f9b34fb
004a=00002908-0000-1000-8000-00805f9b34fb
004b=2803:004c:12:00002a4d-0000-1000-8000-00805f9b34fb
004d=00002902-0000-1000-8000-00805f9b34fb
004e=00002908-0000-1000-8000-00805f9b34fb
004f=2803:0050:0e:00002a4d-0000-1000-8000-00805f9b34fb
0051=00002908-0000-1000-8000-00805f9b34fb
0052=2803:0053:12:00002a22-0000-1000-8000-00805f9b34fb
0054=00002902-0000-1000-8000-00805f9b34fb
0055=2803:0056:0e:00002a32-0000-1000-8000-00805f9b34fb
0057=2803:0058:12:00002a33-0000-1000-8000-00805f9b34fb
0059=00002902-0000-1000-8000-00805f9b34fb
005a=2803:005b:0a:00002a4d-0000-1000-8000-00805f9b34fb
005c=00002908-0000-1000-8000-00805f9b34fb
005d=2800:0070:f000fef0-0451-4000-b000-000000000000
005e=2803:005f:0a:f000fef1-0451-4000-b000-000000000000
0060=2803:0061:0a:f000fef2-0451-4000-b000-000000000000
0062=2803:0063:0a:f000fef3-0451-4000-b000-000000000000
0064=2803:0065:0a:f000fef4-0451-4000-b000-000000000000
0066=2803:0067:08:f000fef5-0451-4000-b000-000000000000
0068=00002902-0000-1000-8000-00805f9b34fb
0069=2803:006a:0a:f000fef6-0451-4000-b000-000000000000
006b=2803:006c:0a:f000fef7-0451-4000-b000-000000000000
006d=2803:006e:0a:f000fef8-0451-4000-b000-000000000000
006f=2803:0070:08:f000fef9-0451-4000-b000-000000000000
0071=2800:ffff:f000ffc0-0451-4000-b000-000000000000
0072=2803:0073:1c:f000ffc1-0451-4000-b000-000000000000
0074=00002902-0000-1000-8000-00805f9b34fb
0075=2803:0076:1c:f000ffc2-0451-4000-b000-000000000000
0077=00002902-0000-1000-8000-00805f9b34fb
