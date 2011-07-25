Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHMBquWSLjzKKyM2xuMUakHeBb-FMLUWXLj2_Tz4Ye1MWj37qw@mail.gmail.com>
References: <1308737516-3303-1-git-send-email-antti.julku@nokia.com>
	<1309309092.2208.25.camel@aeonflux>
	<CAHMBquWSLjzKKyM2xuMUakHeBb-FMLUWXLj2_Tz4Ye1MWj37qw@mail.gmail.com>
Date: Mon, 25 Jul 2011 09:46:46 -0300
Message-ID: <CAKT1EBfQaTSjQe6sZnC5Wx52iPmyo6SSfYD0Ci+_qb1Dbq32+g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add mgmt command for fast connectable mode
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Dmitriy Paliy <dmitriy.paliy@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Antti Julku <antti.julku@nokia.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel/Antti/Dmitriy,

On Mon, Jul 25, 2011 at 8:34 AM, Dmitriy Paliy <dmitriy.paliy@gmail.com> wr=
ote:
> Hi Marcel,
>
> On Wed, Jun 29, 2011 at 3:58 AM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
>> Hi Antti,
>>
>>> Add command to management interface for enabling/disabling the
>>> fast connectable mode.
>>>
>>> Signed-off-by: Antti Julku <antti.julku@nokia.com>
>>> ---
>>> =C2=A0include/net/bluetooth/hci.h =C2=A0| =C2=A0 10 +++++++
>>> =C2=A0include/net/bluetooth/mgmt.h | =C2=A0 =C2=A05 +++
>>> =C2=A0net/bluetooth/mgmt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 60 ++++=
++++++++++++++++++++++++++++++++++++++
>>> =C2=A03 files changed, 75 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>> index 65345cd..d7b9600 100644
>>> --- a/include/net/bluetooth/hci.h
>>> +++ b/include/net/bluetooth/hci.h
>>> @@ -698,6 +698,16 @@ struct hci_rp_read_bd_addr {
>>> =C2=A0 =C2=A0 =C2=A0 bdaddr_t bdaddr;
>>> =C2=A0} __packed;
>>>
>>> +#define HCI_OP_WRITE_PAGE_SCAN_ACTIVITY =C2=A0 =C2=A0 =C2=A00x0c1c
>>> +struct hci_cp_write_page_scan_activity {
>>> + =C2=A0 =C2=A0 __le16 =C2=A0 interval;
>>> + =C2=A0 =C2=A0 __le16 =C2=A0 window;
>>> +} __packed;
>>> +
>>> +#define HCI_OP_WRITE_PAGE_SCAN_TYPE =C2=A00x0c47
>>> + =C2=A0 =C2=A0 #define PAGE_SCAN_TYPE_STANDARD =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x00
>>> + =C2=A0 =C2=A0 #define PAGE_SCAN_TYPE_INTERLACED =C2=A0 =C2=A0 =C2=A0 =
0x01
>>> +
>>> =C2=A0#define HCI_OP_LE_SET_EVENT_MASK =C2=A0 =C2=A0 0x2001
>>> =C2=A0struct hci_cp_le_set_event_mask {
>>> =C2=A0 =C2=A0 =C2=A0 __u8 =C2=A0 =C2=A0 mask[8];
>>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.=
h
>>> index 45bea25..7196d04 100644
>>> --- a/include/net/bluetooth/mgmt.h
>>> +++ b/include/net/bluetooth/mgmt.h
>>> @@ -209,6 +209,11 @@ struct mgmt_cp_unblock_device {
>>> =C2=A0 =C2=A0 =C2=A0 bdaddr_t bdaddr;
>>> =C2=A0} __packed;
>>>
>>> +#define MGMT_OP_SET_FAST_CONNECTABLE 0x001F
>>> +struct mgmt_cp_set_fast_connectable {
>>> + =C2=A0 =C2=A0 __u8 enable;
>>> +} __packed;
>>> +
>>
>> so I am not 100% sure that doing it this way is the best way.
>>
>> What is the down side of just enabling interlaced page scan all the
>> time? And then maybe allow tuning of the timeout via debugfs for testing
>> purposes.
>
> This mode changes two parameters: page scan type and page scan
> interval. There two downsides to have those changed all the time:
> 1) power consumption
> 2) re-transmissions on eSCO channel (see BT Core v4.0, Vol. 2, p. 159)
>
> In this configuration page scanning happening during all dedicated
> slots and much more frequently. This is why probably it is not very
> good idea to have it enabled all the time, but only during short time
> interval when there are benefits out of such changes.
>
>> If we really wanna differentiate between connectable and fast
>> connectable, then we need to fix up also the controller information to
>> export this kind of detail. That will get pretty messy right now. So I
>> would really just prefer to go with interlaced page scan by default and
>> see what downside this gives us.
>
> This is the way how fast connectable implementation is done currently
> for hci_ops. It is disabled by default and default values for page
> scan type and page scan interval are used. If one wishes to enable it,
> audio.conf is used for that purpose. In that case, fast connectable
> configuration is enabled during incoming/outgoing call alerting only.
> In this case, connection initiated from headset side can be performed
> much faster during that specific time interval.
>
> Hope this clarifies the questions. What do you think? Could you
> elaborate more on 'then we need to fix up also the controller
> information to export this kind of detail.'? Why that is needed?
>
> BR,
> Dmitriy

BTW, I think we need to align BR and LE. Proximity and Thermometer
Profiles also have recommended parameters for fast connection(first
30sec) and 2 reduced power options. Both profiles use the same
configuration. If we add a new command to control page/connection
parameters it needs to be aligned with BR and LE and if possible
avoiding transport specific parameters.

BR,
Claudio
