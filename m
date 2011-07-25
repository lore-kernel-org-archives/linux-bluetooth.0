Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1309309092.2208.25.camel@aeonflux>
References: <1308737516-3303-1-git-send-email-antti.julku@nokia.com>
	<1309309092.2208.25.camel@aeonflux>
Date: Mon, 25 Jul 2011 14:34:50 +0300
Message-ID: <CAHMBquWSLjzKKyM2xuMUakHeBb-FMLUWXLj2_Tz4Ye1MWj37qw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add mgmt command for fast connectable mode
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Antti Julku <antti.julku@nokia.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jun 29, 2011 at 3:58 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Antti,
>
>> Add command to management interface for enabling/disabling the
>> fast connectable mode.
>>
>> Signed-off-by: Antti Julku <antti.julku@nokia.com>
>> ---
>> =A0include/net/bluetooth/hci.h =A0| =A0 10 +++++++
>> =A0include/net/bluetooth/mgmt.h | =A0 =A05 +++
>> =A0net/bluetooth/mgmt.c =A0 =A0 =A0 =A0 | =A0 60 +++++++++++++++++++++++=
+++++++++++++++++++
>> =A03 files changed, 75 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 65345cd..d7b9600 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -698,6 +698,16 @@ struct hci_rp_read_bd_addr {
>> =A0 =A0 =A0 bdaddr_t bdaddr;
>> =A0} __packed;
>>
>> +#define HCI_OP_WRITE_PAGE_SCAN_ACTIVITY =A0 =A0 =A00x0c1c
>> +struct hci_cp_write_page_scan_activity {
>> + =A0 =A0 __le16 =A0 interval;
>> + =A0 =A0 __le16 =A0 window;
>> +} __packed;
>> +
>> +#define HCI_OP_WRITE_PAGE_SCAN_TYPE =A00x0c47
>> + =A0 =A0 #define PAGE_SCAN_TYPE_STANDARD =A0 =A0 =A0 =A0 0x00
>> + =A0 =A0 #define PAGE_SCAN_TYPE_INTERLACED =A0 =A0 =A0 0x01
>> +
>> =A0#define HCI_OP_LE_SET_EVENT_MASK =A0 =A0 0x2001
>> =A0struct hci_cp_le_set_event_mask {
>> =A0 =A0 =A0 __u8 =A0 =A0 mask[8];
>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>> index 45bea25..7196d04 100644
>> --- a/include/net/bluetooth/mgmt.h
>> +++ b/include/net/bluetooth/mgmt.h
>> @@ -209,6 +209,11 @@ struct mgmt_cp_unblock_device {
>> =A0 =A0 =A0 bdaddr_t bdaddr;
>> =A0} __packed;
>>
>> +#define MGMT_OP_SET_FAST_CONNECTABLE 0x001F
>> +struct mgmt_cp_set_fast_connectable {
>> + =A0 =A0 __u8 enable;
>> +} __packed;
>> +
>
> so I am not 100% sure that doing it this way is the best way.
>
> What is the down side of just enabling interlaced page scan all the
> time? And then maybe allow tuning of the timeout via debugfs for testing
> purposes.

This mode changes two parameters: page scan type and page scan
interval. There two downsides to have those changed all the time:
1) power consumption
2) re-transmissions on eSCO channel (see BT Core v4.0, Vol. 2, p. 159)

In this configuration page scanning happening during all dedicated
slots and much more frequently. This is why probably it is not very
good idea to have it enabled all the time, but only during short time
interval when there are benefits out of such changes.

> If we really wanna differentiate between connectable and fast
> connectable, then we need to fix up also the controller information to
> export this kind of detail. That will get pretty messy right now. So I
> would really just prefer to go with interlaced page scan by default and
> see what downside this gives us.

This is the way how fast connectable implementation is done currently
for hci_ops. It is disabled by default and default values for page
scan type and page scan interval are used. If one wishes to enable it,
audio.conf is used for that purpose. In that case, fast connectable
configuration is enabled during incoming/outgoing call alerting only.
In this case, connection initiated from headset side can be performed
much faster during that specific time interval.

Hope this clarifies the questions. What do you think? Could you
elaborate more on 'then we need to fix up also the controller
information to export this kind of detail.'? Why that is needed?

BR,
Dmitriy
