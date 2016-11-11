Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGXr9JHSmQs-wZenHAVCPqpe+jL8b5awywBQ-XtZtqYSVtmcpQ@mail.gmail.com>
References: <CAGXr9JFjURuq0brgMGYYU+r_5XedXm4WgS_B-vKLZiWS4WKbrA@mail.gmail.com>
 <CABBYNZ+yMwgGN4+pv7dyog0P8LyME5zVz=RuD=sqXs6csYQBAQ@mail.gmail.com> <CAGXr9JHSmQs-wZenHAVCPqpe+jL8b5awywBQ-XtZtqYSVtmcpQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Nov 2016 11:07:17 +0200
Message-ID: <CABBYNZ+cGzQcspVM0B3wbimsE5sjZS6t9Kk-TZ_qc324aO1Q2Q@mail.gmail.com>
Subject: Re: BlueZ 5.43: HoG peripheral services re-discovered again and again
 on every reconnect
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Fri, Nov 11, 2016 at 4:42 AM, Petri Gynther <pgynther@google.com> wrote:
> Hi Luiz,
>
> On Thu, Nov 10, 2016 at 6:17 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Petri,
>>
>> On Wed, Nov 9, 2016 at 9:39 PM, Petri Gynther <pgynther@google.com> wrote:
>>> Hi linux-bluetooth:
>>>
>>> I'm seeing the following issue with BlueZ 5.43 and Linux 4.4.30.
>>>
>>> When a previously bonded HoG remote control reconnects to BlueZ 5.43
>>> host, BlueZ goes ahead and re-discovers the primary services of the
>>> bonded remote again and again on every reconnect.
>>>
>>> Why is this necessary? Shouldn't this information be cached on the
>>> initial pairing/bonding, and a reconnect can get this information from
>>> the relevant persistent file, rather than wasting BLE airtime and
>>> delaying the reconnect?
>>>
>>
>> IF, and only if, the cache is restored properly then yes it will work
>> as you said, but bt_hog is not yet using the gatt_db so it might
>> rediscover the handles anyway, this happens only once though.
>>
>>>
>>>
>>> In the above log, I see that MTU exchange takes place:
>>> 15,148467,14484676000,-;bluez: bluetoothd[1985]:
>>> src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
>>>
>>> Looking at the relevant code in src/shared/gatt-client.c, function
>>> exchange_mtu_cb():
>>>
>>>         util_debug(client->debug_callback, client->debug_data,
>>>                                         "MTU exchange complete, with MTU: %u",
>>>                                         bt_att_get_mtu(client->att));
>>>
>>> discover:
>>>         client->discovery_req = bt_gatt_discover_all_primary_services(
>>>                                                         client->att, NULL,
>>>                                                         discover_primary_cb,
>>>                                                         discovery_op_ref(op),
>>>                                                         discovery_op_unref);
>>>
>>>
>>> The call to bt_gatt_discover_all_primary_services() is unconditional,
>>> whether the device was previously bonded or not.
>>
>> This does range validation in case service changed is not properly
>> implemented this will attempt to figure out if there are any changes
>> in the database, but note that it will stop in here:
>>
>> attr = gatt_db_insert_service(client->db, start, &uuid, true,
>> end - start + 1);
>> if (!attr) {
>>
>> So if the database already contain all the services it will no do more
>> than one Read By Group Type.
 Looking into btmon details after the line marked ====:
> 15,18491,832722000,-;bluez: bluetoothd[2346]:
> profiles/scanparam/scan.c:refresh_ccc_written_cb() Scan Refresh:
> notification enabled
>
> We can see that BlueZ issues a bunch of ATT: Read By Group Type
> Requests to re-discover all primary services (0x2800):


This is what I said, we will issue Read By Group Type to validate the
cached data since service changed is not mandatory and way too many
devices don't implement it correctly.

> 15,18491,832722000,-;bluez: bluetoothd[2346]:
> profiles/scanparam/scan.c:refresh_ccc_written_cb() Scan Refresh:
> notification enabled
> 15,18492,832723000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
> 11             [hci0] 17:26:51.730522
> 15,18493,832725000,-;btmon:       ATT: Read By Type Request (0x08) len 6
> 15,18494,832725000,-;btmon:         Handle range: 0x002f-0x0037
> 15,18495,832725000,-;btmon:         Attribute type: Characteristic (0x2803)
> 15,18496,832725000,-;btmon: > HCI Event: Number of Completed Packets
> (0x13) plen 5   [hci0] 17:26:51.731128
> 15,18497,832726000,-;btmon:         Num handles: 1
> 15,18498,832726000,-;btmon:         Handle: 128
> 15,18499,832726000,-;btmon:         Count: 1
> 15,18500,832733000,-;btmon: > HCI Event: Number of Completed Packets
> (0x13) plen 5   [hci0] 17:26:51.739362
> 15,18501,832733000,-;btmon:         Num handles: 1
> 15,18502,832733000,-;btmon:         Handle: 128
> 15,18503,832733000,-;btmon:         Count: 1
> 15,18504,832752000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
> 27             [hci0] 17:26:51.759357
> 15,18505,832753000,-;btmon:       ATT: Read By Type Response (0x09) len 22
> 15,18506,832753000,-;btmon:         Attribute data length: 7
> 15,18507,832753000,-;btmon:         Attribute data list: 3 entries
> 15,18508,832753000,-;btmon:         Handle: 0x0030
> 15,18509,832753000,-;btmon:         Value: 1e3100f1ff
> 15,18510,832753000,-;btmon:         Handle: 0x0033
> 15,18511,832753000,-;btmon:         Value: 0a3400f2ff
> 15,18512,832753000,-;btmon:         Handle: 0x0035
> 15,18513,832753000,-;btmon:         Value: 123600f4ff
> 15,18514,832754000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
> 11             [hci0] 17:26:51.760043
> 15,18515,832754000,-;btmon:       ATT: Read By Group Type Request (0x10) len 6
> 15,18516,832754000,-;btmon:         Handle range: 0x0001-0xffff
> 15,18517,832754000,-;btmon:         Attribute group type: Primary
> Service (0x2800)
> 15,18518,832762000,-;btmon: > HCI Event: Number of Completed Packets
> (0x13) plen 5   [hci0] 17:26:51.769346
> 15,18519,832762000,-;btmon:         Num handles: 1
> 15,18520,832762000,-;btmon:         Handle: 128
> 15,18521,832762000,-;btmon:         Count: 1
> 15,18522,832782000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
> 24             [hci0] 17:26:51.789303
> 15,18523,832782000,-;btmon:       ATT: Read By Group Type Response (0x11) len 19
> 15,18524,832782000,-;btmon:         Attribute data length: 6
> 15,18525,832782000,-;btmon:         Attribute group list: 3 entries
> 15,18526,832784000,-;btmon:         Handle range: 0x0001-0x000b
> 15,18527,832784000,-;btmon:         UUID: Generic Access Profile (0x1800)
> 15,18528,832784000,-;btmon:         Handle range: 0x000c-0x000f
> 15,18529,832784000,-;btmon:         UUID: Generic Attribute Profile (0x1801)
> 15,18530,832784000,-;btmon:         Handle range: 0x0010-0x0022
> 15,18531,832784000,-;btmon:         UUID: Device Information (0x180a)
> 15,18532,832784000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
> 11             [hci0] 17:26:51.790028
> 15,18533,832784000,-;btmon:       ATT: Read By Type Request (0x08) len 6
> 15,18534,832784000,-;btmon:         Handle range: 0x0036-0x0037
> 15,18535,832784000,-;btmon:         Attribute type: Characteristic (0x2803)
> 15,18536,832792000,-;btmon: > HCI Event: Number of Completed Packets
> (0x13) plen 5   [hci0] 17:26:51.799354
> 15,18537,832792000,-;btmon:         Num handles: 1
> 15,18538,832792000,-;btmon:         Handle: 128
> 15,18539,832792000,-;btmon:         Count: 1
> 15,18540,832809000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
> 9              [hci0] 17:26:51.808179
> 15,18541,832809000,-;btmon:       ATT: Error Response (0x01) len 4
> 15,18542,832809000,-;btmon:         Read By Type Request (0x08)
> 15,18543,832809000,-;btmon:         Handle: 0x0036
> 15,18544,832809000,-;btmon:         Error: Attribute Not Found (0x0a)
> 15,18546,832811000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
> 11             [hci0] 17:26:51.810774
> 15,18547,832812000,-;btmon:       ATT: Read By Group Type Request (0x10) len 6
> 15,18548,832812000,-;btmon:         Handle range: 0x0023-0xffff
> 15,18549,832812000,-;btmon:         Attribute group type: Primary
> Service (0x2800)
> 15,18553,833321000,-;btmon: > HCI Event: Number of Completed Packets
> (0x13) plen 5   [hci0] 17:26:52.328191
> 15,18554,833321000,-;btmon:         Num handles: 1
> 15,18555,833321000,-;btmon:         Handle: 128
> 15,18556,833321000,-;btmon:         Count: 1
> 15,18558,833334000,-;btmon: > HCI Event: Vendor (0xff) plen 5
>               [hci0] 17:26:52.339515
> 15,18559,833334000,-;btmon:         05 80 00 09 00
>               .....
> 15,18560,833362000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
> 24             [hci0] 17:26:52.369478
> 15,18561,833363000,-;btmon:       ATT: Read By Group Type Response (0x11) len 19
> 15,18562,833363000,-;btmon:         Attribute data length: 6
> 15,18563,833363000,-;btmon:         Attribute group list: 3 entries
> 15,18564,833364000,-;btmon:         Handle range: 0x0023-0x0028
> 15,18565,833364000,-;btmon:         UUID: Battery Service (0x180f)
> 15,18566,833364000,-;btmon:         Handle range: 0x0029-0x002e
> 15,18567,833364000,-;btmon:         UUID: Scan Parameters (0x1813)
> 15,18568,833364000,-;btmon:         Handle range: 0x002f-0x0037
> 15,18569,833364000,-;btmon:         UUID: Unknown (0xfff0)
> 15,18570,833364000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
> 9              [hci0] 17:26:52.370138

I have to check but these command bellow seems to be unrelated to the discover.

> 15,18571,833364000,-;btmon:       ATT: Find Information Request (0x04) len 4
> 15,18572,833364000,-;btmon:         Handle range: 0x0036-0x0037
> 15,18574,833371000,-;btmon: > HCI Event: Number of Completed Packets
> (0x13) plen 5   [hci0] 17:26:52.378203
> 15,18575,833371000,-;btmon:         Num handles: 1
> 15,18576,833371000,-;btmon:         Handle: 128
> 15,18577,833371000,-;btmon:         Count: 1
> 15,18578,833391000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
> 14             [hci0] 17:26:52.398166
> 15,18579,833391000,-;btmon:       ATT: Find Information Response (0x05) len 9
> 15,18580,833392000,-;btmon:         Format: UUID-16 (0x01)
> 15,18582,833394000,-;btmon:         Handle: 0x0036
> 15,18583,833394000,-;btmon:         UUID: Unknown (0xfff4)
> 15,18584,833394000,-;btmon:         Handle: 0x0037
> 15,18585,833394000,-;btmon:         UUID: Client Characteristic
> Configuration (0x2902)
> 15,18586,833394000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
> 10             [hci0] 17:26:52.400735
> 15,18587,833394000,-;btmon:       ATT: Write Request (0x12) len 5
> 15,18588,833394000,-;btmon:         Handle: 0x0034
> 15,18589,833394000,-;btmon:           Data: 030000
> 15,18591,833912000,-;btmon: > HCI Event: Number of Completed Packets
> (0x13) plen 5   [hci0] 17:26:52.919397
> 15,18592,833912000,-;btmon:         Num handles: 1
> 15,18593,833912000,-;btmon:         Handle: 128
> 15,18594,833912000,-;btmon:         Count: 1
> 15,18595,833931000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
> 5              [hci0] 17:26:52.938157
> 15,18596,833931000,-;btmon:       ATT: Write Response (0x13) len 0
> 15,18597,833932000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
> 11             [hci0] 17:26:52.939032


Were we just continue with the primary discovery.

> 15,18598,833932000,-;btmon:       ATT: Read By Group Type Request (0x10) len 6
> 15,18599,833932000,-;btmon:         Handle range: 0x0038-0xffff
> 15,18600,833932000,-;btmon:         Attribute group type: Primary
> Service (0x2800)
> 15,18601,833944000,-;btmon: > HCI Event: Number of Completed Packets
> (0x13) plen 5   [hci0] 17:26:52.951628
> 15,18602,833944000,-;btmon:         Num handles: 1
> 15,18603,833944000,-;btmon:         Handle: 128
> 15,18604,833944000,-;btmon:         Count: 1
> 15,18605,833959000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
> 12             [hci0] 17:26:52.966479
> 15,18606,833959000,-;btmon:       ATT: Read By Group Type Response (0x11) len 7
> 15,18607,833960000,-;btmon:         Attribute data length: 6
> 15,18608,833960000,-;btmon:         Attribute group list: 1 entry
> 15,18609,833960000,-;btmon:         Handle range: 0x0038-0x005c
> 15,18610,833960000,-;btmon:         UUID: Human Interface Device (0x1812)
> 15,18611,833960000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
> 9              [hci0] 17:26:52.967113
> 15,18612,833960000,-;btmon:       ATT: Write Request (0x12) len 4
> 15,18613,833960000,-;btmon:         Handle: 0x0037
> 15,18614,833960000,-;btmon:           Data: 0100
> 15,18615,833971000,-;btmon: > HCI Event: Number of Completed Packets
> (0x13) plen 5   [hci0] 17:26:52.976999
> 15,18616,833971000,-;btmon:         Num handles: 1
> 15,18617,833972000,-;btmon:         Handle: 128
> 15,18618,833972000,-;btmon:         Count: 1
> 15,18619,833979000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
> 5              [hci0] 17:26:52.986355
> 15,18620,833980000,-;btmon:       ATT: Write Response (0x13) len 0
> 15,18621,833980000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
> 11             [hci0] 17:26:52.986894
> 15,18622,833980000,-;btmon:       ATT: Read By Group Type Request (0x10) len 6
> 15,18623,833980000,-;btmon:         Handle range: 0x005d-0xffff
> 15,18624,833980000,-;btmon:         Attribute group type: Primary
> Service (0x2800)
> 15,18625,833990000,-;btmon: > HCI Event: Number of Completed Packets
> (0x13) plen 5   [hci0] 17:26:52.996610
> 15,18626,833990000,-;btmon:         Num handles: 1
> 15,18627,833991000,-;btmon:         Handle: 128
> 15,18628,833991000,-;btmon:         Count: 1
> 15,18629,834013000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
> 26             [hci0] 17:26:53.019401
> 15,18630,834013000,-;btmon:       ATT: Read By Group Type Response (0x11) len 21
> 15,18631,834013000,-;btmon:         Attribute data length: 20
> 15,18632,834013000,-;btmon:         Attribute group list: 1 entry
> 15,18633,834013000,-;btmon:         Handle range: 0x005d-0x0070
> 15,18634,834013000,-;btmon:         UUID: Vendor specific
> (f000fef0-0451-4000-b000-000000000000)
> 15,18635,834013000,-;btmon: < ACL Data TX: Handle 128 flags 0x00 dlen
> 11             [hci0] 17:26:53.020026
> 15,18636,834013000,-;btmon:       ATT: Read By Group Type Request (0x10) len 6
> 15,18637,834013000,-;btmon:         Handle range: 0x0071-0xffff
> 15,18638,834013000,-;btmon:         Attribute group type: Primary
> Service (0x2800)
> 15,18639,834022000,-;btmon: > HCI Event: Number of Completed Packets
> (0x13) plen 5   [hci0] 17:26:53.029922
> 15,18640,834022000,-;btmon:         Num handles: 1
> 15,18641,834022000,-;btmon:         Handle: 128
> 15,18642,834023000,-;btmon:         Count: 1
> 15,18643,834042000,-;btmon: > ACL Data RX: Handle 128 flags 0x02 dlen
> 26             [hci0] 17:26:53.049348
> 15,18644,834042000,-;btmon:       ATT: Read By Group Type Response (0x11) len 21
> 15,18645,834042000,-;btmon:         Attribute data length: 20
> 15,18646,834042000,-;btmon:         Attribute group list: 1 entry
> 15,18647,834042000,-;btmon:         Handle range: 0x0071-0xffff
> 15,18648,834042000,-;btmon:         UUID: Vendor specific

So there is nothing new in the behavior, it does recheck the if the
services are in place but it doesn't check if anything about
characteristics and descriptors, also in the meantime you can issue
command as we see above, so it doesn't introduce extra delays so I
wonder why this is bothering you?

-- 
Luiz Augusto von Dentz
