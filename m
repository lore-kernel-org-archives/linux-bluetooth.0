Return-Path: <cyrus@holtmann.org>
Message-id: <759EA0AE32CD4AFF8B2B6EC8A9F1EDAA@sisodomain.com>
From: Syam Sidhardhan <s.syam@samsung.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
References: <1350999140-7481-1-git-send-email-s.syam@samsung.com>
 <1350999140-7481-4-git-send-email-s.syam@samsung.com>
 <1351003568.1785.30.camel@aeonflux>
Subject: Re: [PATCH 4/5] Bluetooth: mgmt: Use __constant when dealing with
 constants
Date: Mon, 29 Oct 2012 20:35:09 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=utf-8; reply-type=original
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Syam Sidhardhan" <s.syam@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Sent: Tuesday, October 23, 2012 8:16 PM
Subject: Re: [PATCH 4/5] Bluetooth: mgmt: Use __constant when dealing with 
constants


> Hi Syam,
>
>> __constant_cpu_to_le*() is the right go here.
>>
>> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
>> ---
>>  net/bluetooth/mgmt.c |   12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index b127b88..e3bb2a7 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -222,7 +222,7 @@ static int cmd_status(struct sock *sk, u16 index, u16 
>> cmd, u8 status)
>>
>>  hdr = (void *) skb_put(skb, sizeof(*hdr));
>>
>> - hdr->opcode = cpu_to_le16(MGMT_EV_CMD_STATUS);
>> + hdr->opcode = __constant_cpu_to_le16(MGMT_EV_CMD_STATUS);
>>  hdr->index = cpu_to_le16(index);
>>  hdr->len = cpu_to_le16(sizeof(*ev));
>>
>> @@ -253,7 +253,7 @@ static int cmd_complete(struct sock *sk, u16 index, 
>> u16 cmd, u8 status,
>>
>>  hdr = (void *) skb_put(skb, sizeof(*hdr));
>>
>> - hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
>> + hdr->opcode = __constant_cpu_to_le16(MGMT_EV_CMD_COMPLETE);
>>  hdr->index = cpu_to_le16(index);
>>  hdr->len = cpu_to_le16(sizeof(*ev) + rp_len);
>>
>> @@ -832,7 +832,7 @@ static int mgmt_event(u16 event, struct hci_dev 
>> *hdev, void *data, u16 data_len,
>>  if (hdev)
>>  hdr->index = cpu_to_le16(hdev->id);
>>  else
>> - hdr->index = cpu_to_le16(MGMT_INDEX_NONE);
>> + hdr->index = __constant_cpu_to_le16(MGMT_INDEX_NONE);
>>  hdr->len = cpu_to_le16(data_len);
>>
>>  if (data)
>> @@ -3570,9 +3570,11 @@ int mgmt_device_found(struct hci_dev *hdev, 
>> bdaddr_t *bdaddr, u8 link_type,
>>  ev->addr.type = link_to_bdaddr(link_type, addr_type);
>>  ev->rssi = rssi;
>>  if (cfm_name)
>> - ev->flags |= cpu_to_le32(MGMT_DEV_FOUND_CONFIRM_NAME);
>> + ev->flags |=
>> + __constant_cpu_to_le32(MGMT_DEV_FOUND_CONFIRM_NAME);
>>  if (!ssp)
>> - ev->flags |= cpu_to_le32(MGMT_DEV_FOUND_LEGACY_PAIRING);
>> + ev->flags |=
>> + __constant_cpu_to_le32(MGMT_DEV_FOUND_LEGACY_PAIRING);
>
> for these ones, break the 80 chars rule. In this case that is
> acceptable.


I'll correct it and send another version.

Thanks,
Syam 
