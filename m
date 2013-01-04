Return-Path: <cyrus@holtmann.org>
Message-id: <6D3FC6505D984C0CB54FCD7FAB7D9D47@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1357218329-21399-1-git-send-email-jaganath.k@samsung.com>
 <1357218329-21399-2-git-send-email-jaganath.k@samsung.com>
 <20130103140026.GB18154@x220.ger.corp.intel.com>
In-reply-to: <20130103140026.GB18154@x220.ger.corp.intel.com>
Subject: Re: [PATCH 2/2] Bluetooth: Fix authentication if acl data comes before
 remote feature evt
Date: Fri, 04 Jan 2013 11:27:35 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

--------------------------------------------------
From: "Johan Hedberg" <johan.hedberg@gmail.com>
Sent: Thursday, January 03, 2013 7:30 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/2] Bluetooth: Fix authentication if acl data comes 
before remote feature evt

> Hi Jaganath,
>
> On Thu, Jan 03, 2013, Jaganath Kanakkassery wrote:
>> If remote device sends l2cap info request before read_remote_ext_feature
>> completes then mgmt_connected will be sent in hci_acldata_packet() and
>> remote name request wont be sent and eventually authentication wont 
>> happen
>>
>> Hcidump log of the issue
>>
>> < HCI Command: Create Connection (0x01|0x0005) plen 13
>>     bdaddr BC:85:1F:74:7F:29 ptype 0xcc18 rswitch 0x01 clkoffset 0x4bf7 
>> (valid)
>>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>> > HCI Event: Command Status (0x0f) plen 4
>>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
>> > HCI Event: Connect Complete (0x03) plen 11
>>     status 0x00 handle 12 bdaddr BC:85:1F:74:7F:29 type ACL encrypt 0x00
>> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>>     handle 12
>> > HCI Event: Command Status (0x0f) plen 4
>>     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
>> > HCI Event: Read Remote Supported Features (0x0b) plen 11
>>     status 0x00 handle 12
>>     Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
>> > HCI Event: Max Slots Change (0x1b) plen 3
>>     handle 12 slots 5
>> < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
>>     handle 12 page 1
>> > HCI Event: Command Status (0x0f) plen 4
>>     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
>> > ACL data: handle 12 flags 0x02 dlen 10
>>     L2CAP(s): Info req: type 2
>> < ACL data: handle 12 flags 0x00 dlen 16
>>     L2CAP(s): Info rsp: type 2 result 0
>>       Extended feature mask 0x00b8
>>         Enhanced Retransmission mode
>>         Streaming mode
>>         FCS Option
>>         Fixed Channels
>> > HCI Event: Read Remote Extended Features (0x23) plen 13
>>     status 0x00 handle 12 page 1 max 1
>>     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>> > ACL data: handle 12 flags 0x02 dlen 10
>>     L2CAP(s): Info req: type 3
>> < ACL data: handle 12 flags 0x00 dlen 20
>>     L2CAP(s): Info rsp: type 3 result 0
>>       Fixed channel list 0x00000002
>>         L2CAP Signalling Channel
>> > HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 12 packets 2
>>
>> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
>> ---
>>  net/bluetooth/hci_core.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 596660d..c14def9 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -2812,6 +2812,7 @@ static void hci_acldata_packet(struct hci_dev 
>> *hdev, struct sk_buff *skb)
>>
>>  hci_dev_lock(hdev);
>>  if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
>> +     !hci_outgoing_auth_needed(hdev, conn) &&
>>      !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
>>  mgmt_device_connected(hdev, &conn->dst, conn->type,
>>        conn->dst_type, 0, NULL, 0,
>
> I'm not completely sure if this is the right way or even the right place
> to fix the issue. The reason why this if-clause is here is so that we
> don't get a too late mgmt_connected event in case the remote device is
> fast in sending an L2CAP Connect Request. Maybe if-clause needs to be
> made L2CAP Connect request specific (and moved to an L2CAP specific
> location) or then something added to the code path taken for the info
> request?

If the reason for mgmt_connected in acl_data() is to handle early l2cap
connect request from remote then I think it is better to move it to
l2cap connect request as you said.

So I will add mgmt_connected in l2cap_connect_req() before sending
l2cap connect response?

This will solve the authentication issue as well.

Thanks,
Jaganath 

