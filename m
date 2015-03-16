Return-Path: <cyrus@holtmann.org>
Message-ID: <5506D8AB.1040903@ubnt.com>
Date: Mon, 16 Mar 2015 15:20:43 +0200
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>,
	Arman Uguray <armansito@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcin Kraglak <marcin.kraglak@tieto.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: Re: Non-consecutive handle values in GATT
References: <54F752D8.1000605@ubnt.com>	<CAHrH25RVKCL9RQCeFBJAsUsNV1umOR92VWV1JQgkwy-RNh-GAg@mail.gmail.com>	<CAN_7+Yagp-R+H+nhCtmdqWyAJm4jO_VsB5c343A=39zurwqpPw@mail.gmail.com>	<007858C7-D538-407D-8212-D3B0CB880165@ubnt.com>	<CABBYNZLKfh7xPufAMfjG6P--Q-NkOVq4oYUdXEpqc5WsvQpu2g@mail.gmail.com> <CABBYNZLHtCJCoUp_4miapZJOReh=FP4_sJVFkyh5uE+NHV2x=A@mail.gmail.com>
In-Reply-To: <CABBYNZLHtCJCoUp_4miapZJOReh=FP4_sJVFkyh5uE+NHV2x=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 2015.03.16. 13:05, Luiz Augusto von Dentz wrote:
> Hi Andrejs,
> 
> On Thu, Mar 5, 2015 at 10:39 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Andrejs,
>>
>> On Thu, Mar 5, 2015 at 12:34 AM, Andrejs Hanins <andrejs.hanins@ubnt.com> wrote:
>>>
>>>
>>>> On 05 Mar 2015, at 00:21, Lukasz Rymanowski <lukasz.rymanowski@gmail.com> wrote:
>>>>
>>>> Hi Andrejs,
>>>>
>>>>> On Wed, Mar 4, 2015 at 10:39 PM, Arman Uguray <armansito@chromium.org> wrote:
>>>>> Hi Andrejs,
>>>>>
>>>>>> On Wed, Mar 4, 2015 at 10:45 AM, Andrejs Hanins <andrejs.hanins@ubnt.com> wrote:
>>>>>> Hello,
>>>>>>
>>>>>>    I'm experimenting with an LE peripheral device which provides GATT
>>>>>> services described by attributes with non-consecutive handle values, i.e.
>>>>>> there are "gaps" between handle values. According to the Bluetooth Core
>>>>>> specification 4.0 (Volume 3, Part G, "2.5.1 Overview") it is allowed:
>>>>>>
>>>>>>     Although the Attribute Handle values are in increasing order, following
>>>>>> Attribute Handle values may differ by more than one.
>>>>>>
>>>>>>    Based on my experiments, BlueZ 5.28 and also git-master as of today does
>>>>>> not support non-consecutive handle values GATT table. As a result, I can't
>>>>>> connect to my device because gatt-client fails to initialize properly. The
>>>>>> failing place is in discover_descs():
>>>>>>
>>>>>>      if (gatt_db_attribute_get_handle(attr) !=
>>>>>>                            chrc_data->value_handle)
>>>>>>            goto failed;
>>>>>>
>>>>>>    The value of chrc_data->value_handle is correct and matches GATT table
>>>>>> one the device, but the attr->handle has the value of previous attribute
>>>>>> (Primary Service UUID in my case) +2. This handle value calculation happens
>>>>>> in gatt_db_service_add_characteristic() which has strange code:
>>>>>>
>>>>>>    /* We set handle of characteristic value, which will be added next */
>>>>>>    put_le16(get_handle_at_index(service, i - 1) + 2, &value[1]);
>>>>>>
>>>>>>    Before trying to fix the problem by myself it would be great to hear
>>>>>> some comments about this issue. Does it seem like a bug or I missed
>>>>>> something?
>>>>>>
>>>>>>    As a note, I can successfully connect to my LE peripheral from an iPhone
>>>>>> LightBlue app, which does not posses any issues during GATT discovery and
>>>>>> can read/write the characteristic on the device.
>>>>
>>>> Can you share what device are you using? Is it on the market already?
>>>> I'm just curious as I haven't seen any device doing it on last couple UPFs
>>>>
>>>> But indeed, it looks like this is something we need to fix.
>>> It's a Broadcom dev kit for LE development. I'm running one of Broadcom examples which has non-consecutive handle values within single service. Of course, there is a full control over GATT and we can change handle values to be on +1 basis, no big deal, but in general BT core specs do not require it, so fix is nice to have to be on a safe side in case there will be such device in a wild. I spent a day to understand it digging the code :)
>>>
>>
>> I guess because it is a low level API you can basically use whatever
>> handles you want, probably OS API would not allow that but as you said
>> we may encounter devices out in the market that do that already.
>>
>>>> \Lukasz
>>>>>
>>>>> This is interesting. The gatt-db was initially designed for the
>>>>> server-role, with the assumption being that the handles of a service
>>>>> will be contiguous. So, it allows gaps between separate service ranges
>>>>> but not between individual attributes between the handles of a
>>>>> service. This assumption is OK for server-role but now that we also
>>>>> use gatt-db for the client role, then maybe this assumption is
>>>>> incorrect in some cases.
>>>>>
>>>>> So I guess we need a way to enter individual attributes with arbitrary
>>>>> handles directly into the database, since it currently creates a
>>>>> contiguous array to store the attributes of a service. I remember Luiz
>>>>> was talking about changing the way the gatt-db addition/removal works
>>>>> on IRC so maybe he can provide more input here. Fwiw, we never
>>>>> encountered this issue because in practice I've never seen a database
>>>>> implementation that skips attribute handles within a service.
>>
>> Well that was not exactly the problem I was discussing, but anyway it
>> is a problem that we need to fix. Id probably start by adding a unit
>> test where a service skips handles and then fix the gatt_db
>> implementation to handle that, speaking about implementation we could
>> either go with list but the entries would then need to store the
>> handles separately or we keep the current array and leave the gaps
>> with NULL pointers, I guess the later is still more efficient since we
>> are talking about a special case and storing the handles per list
>> entry might increase our memory consumption.
> 
> I just posted a patch-set that attempts to fix this, at least with
> unit test Ive created it seems to work but I would appreciate if you
> could try with your setup as well.
Tried on 0d468ec37cf42915f5873a40185b5f3a588c28ba and it still fails for my device. FYI - iOS and Android can successfully connect to this device and discover characteristics. Here is some analysis I made which might help you:

< HCI Command: LE Create Connection (0x08|0x000d) plen 25
    bdaddr 20:73:6A:17:69:31 type 0
    interval 96 window 48 initiator_filter 0
    own_bdaddr_type 0 min_interval 40 max_interval 56
    latency 0 supervision_to 42 min_ce 0 max_ce 0
> HCI Event: Command Status (0x0f) plen 4
    LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
> HCI Event: LE Meta Event (0x3e) plen 19
    LE Connection Complete
      status 0x00 handle 64, role master
      bdaddr 20:73:6A:17:69:31 (Public)
< ACL data: handle 64 flags 0x00 dlen 7
    ATT: MTU req (0x02)
      client rx mtu 517
> ACL data: handle 64 flags 0x02 dlen 7
    ATT: MTU resp (0x03)
      server rx mtu 23
< ACL data: handle 64 flags 0x00 dlen 11
    ATT: Read By Group req (0x10)
      start 0x0001, end 0xffff
      type-uuid 0x2800
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 64 packets 1
> ACL data: handle 64 flags 0x02 dlen 18
    ATT: Read By Group resp (0x11)
      attr handle 0x0100, end group handle 0x0121
      value 0x00 0x18
      attr handle 0x0200, end group handle 0x0200
      value 0x01 0x18
< ACL data: handle 64 flags 0x00 dlen 11
    ATT: Read By Group req (0x10)
      start 0x0201, end 0xffff
      type-uuid 0x2800
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 64 packets 2
> ACL data: handle 64 flags 0x02 dlen 26
    ATT: Read By Group resp (0x11)
      attr handle 0x0300, end group handle 0x0320
      value 0xbf 0x90 0x21 0x8e 0xc0 0x68 0x4c 0x00 0x84 0x01 0x2d 0xba 0x08 0xab 0x32 0x88
< ACL data: handle 64 flags 0x00 dlen 11
    ATT: Read By Group req (0x10)
      start 0x0321, end 0xffff
      type-uuid 0x2800
> ACL data: handle 64 flags 0x02 dlen 9
    ATT: Error (0x01)
      Error: Attribute not found (10)
      Read By Group req (0x10) on handle 0x0321
< ACL data: handle 64 flags 0x00 dlen 11
    ATT: Read By Group req (0x10)
      start 0x0001, end 0xffff
      type-uuid 0x2801
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 64 packets 2
> ACL data: handle 64 flags 0x02 dlen 9
    ATT: Error (0x01)
      Error: Attribute not found (10)
      Read By Group req (0x10) on handle 0x0001
< ACL data: handle 64 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0100, end 0x0121
      type-uuid 0x2802
> ACL data: handle 64 flags 0x02 dlen 9
    ATT: Error (0x01)
      Error: Attribute not found (10)
      Read By Type req (0x08) on handle 0x0100
< ACL data: handle 64 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0300, end 0x0320
      type-uuid 0x2802
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 64 packets 2
> ACL data: handle 64 flags 0x02 dlen 9
    ATT: Error (0x01)
      Error: Attribute not found (10)
      Read By Type req (0x08) on handle 0x0300
< ACL data: handle 64 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0100, end 0x0121
      type-uuid 0x2803                    <---- Characteristics in range 0x0100-0x0121 are requested.


> ACL data: handle 64 flags 0x02 dlen 20
    ATT: Read By Type resp (0x09)
      length: 7
        handle 0x0110, value 0x02 0x11 0x01 0x00 0x2a 
        handle 0x0120, value 0x02 0x21 0x01 0x01 0x2a  <---- Rsp: Chrc with descriptor handle 0x0120, value handle 0x0121 and standard 16bit UUID=0x2a01 ("Characteristic appearance")


< ACL data: handle 64 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0121, end 0x0121
      type-uuid 0x2803     <--- Here request is made for a single attribute with handle 0x0121 which is supposed to have UUID 0x2a01, as per previous response, but the request suggests that type should be UUID 0x2803 (Characteristic descriptor), which is wrong.


> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 64 packets 2
> ACL data: handle 64 flags 0x02 dlen 9
    ATT: Error (0x01)
      Error: Attribute not found (10)
      Read By Type req (0x08) on handle 0x0121  <---- As expected, there is no such attribute with handle 0x0121 and UUID 0x2803. A valid att request is for handle 0x0121 and UUID 0x2a01.



< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 64 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 64 reason 0x16
    Reason: Connection Terminated by Local Host

