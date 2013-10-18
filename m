Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 07/15] Bluetooth: Refactor hci_disconn_complete_evt
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <FDFC9B6A-260D-4A54-83B7-ACCA36DF7B42@holtmann.org>
Date: Fri, 18 Oct 2013 11:08:26 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <98B46A35-D817-42B3-ACD1-106C2F0519C5@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org> <1381965485-9159-8-git-send-email-andre.guedes@openbossa.org> <FDFC9B6A-260D-4A54-83B7-ACCA36DF7B42@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Oct 17, 2013, at 6:33 AM, Marcel Holtmann wrote:

> Hi Andrei,
> 
>> hci_disconn_complete_evt() logic is more complicated than what it
>> should be, making it hard to follow and add new features. This patch
>> does some code refactoring by letting the main flow of the function
>> in first level of function scope.
>> 
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> net/bluetooth/hci_event.c | 62 +++++++++++++++++++++++++----------------------
>> 1 file changed, 33 insertions(+), 29 deletions(-)
> 
> why this is patch 7/15 is beyond me. These things should go first and with a clear commit message why they are are needed. Since if that is clear and easily to review, then you do not have to re-base them all the time.

I'll move this patch to the beginning of the patch set.

> 
>> 
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 6c3b193..edb2342 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -1781,6 +1781,8 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>> {
>> 	struct hci_ev_disconn_complete *ev = (void *) skb->data;
>> 	struct hci_conn *conn;
>> +	u8 type;
>> +	bool send_mgmt_event = false;
>> 
>> 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
>> 
>> @@ -1790,44 +1792,46 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>> 	if (!conn)
>> 		goto unlock;
>> 
>> -	if (ev->status == 0)
>> -		conn->state = BT_CLOSED;
>> -
>> 	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags) &&
>> -	    (conn->type == ACL_LINK || conn->type == LE_LINK)) {
>> -		if (ev->status) {
>> +	    (conn->type == ACL_LINK || conn->type == LE_LINK))
>> +		send_mgmt_event = true;
>> +
>> +	if (ev->status) {
>> +		if (send_mgmt_event)
>> 			mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
>> 					       conn->dst_type, ev->status);
>> -		} else {
>> -			u8 reason = hci_to_mgmt_reason(ev->reason);
>> -
>> -			mgmt_device_disconnected(hdev, &conn->dst, conn->type,
>> -						 conn->dst_type, reason);
>> -		}
>> +		return;
>> 	}
> 
> Unfortunately this diff is hard to read. So you need to explain to me in plain English why we are doing this and how it is the same.

Yes, this diff is not good. I'll be more verbose in the commit message.

Regards,

Andre

