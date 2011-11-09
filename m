Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] Bluetooth: mgmt_stop_discovery_failed()
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1320824379.15441.321.camel@aeonflux>
Date: Wed, 9 Nov 2011 09:20:34 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <886E85F3-3878-4F83-B457-5C9EDA1597CF@openbossa.org>
References: <1320792002-31151-1-git-send-email-andre.guedes@openbossa.org> <1320792002-31151-2-git-send-email-andre.guedes@openbossa.org> <1320824379.15441.321.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Nov 9, 2011, at 4:39 AM, Marcel Holtmann wrote:

> Hi Andre,
> 
>> This patches creates mgmt_stop_discovery_failed() which removes
>> pending MGMT_OP_STOP_DISCOVERY commands and sends proper command
>> status events.
>> 
>> This patch also fixes the MGMT_OP_STOP_DISCOVERY command leak in
>> case cancel inquiry fails.
>> 
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/hci_core.h |    1 +
>> net/bluetooth/hci_event.c        |    4 +++-
>> net/bluetooth/mgmt.c             |   15 +++++++++++++++
>> 3 files changed, 19 insertions(+), 1 deletions(-)
>> 
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 4e00ae0..dba10c6 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -932,6 +932,7 @@ int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 type, u8 *dev_class,
>> 							s8 rssi, u8 *eir);
>> int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
>> int mgmt_start_discovery_failed(u16 index, u8 status);
>> +int mgmt_stop_discovery_failed(u16 index, u8 status);
>> int mgmt_discovering(u16 index, u8 discovering);
>> int mgmt_device_blocked(u16 index, bdaddr_t *bdaddr);
>> int mgmt_device_unblocked(u16 index, bdaddr_t *bdaddr);
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index e29a3b1..78ba9c8 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -55,8 +55,10 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
>> 
>> 	BT_DBG("%s status 0x%x", hdev->name, status);
>> 
>> -	if (status)
>> +	if (status) {
>> +		mgmt_stop_discovery_failed(hdev->id, status);
>> 		return;
>> +	}
>> 
>> 	clear_bit(HCI_INQUIRY, &hdev->flags);
>> 
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index dc938dc..d840600 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -2394,6 +2394,21 @@ int mgmt_start_discovery_failed(u16 index, u8 status)
>> 	return err;
>> }
>> 
>> +int mgmt_stop_discovery_failed(u16 index, u8 status)
>> +{
>> +	struct pending_cmd *cmd;
>> +	int err;
>> +
>> +	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index);
>> +	if (!cmd)
>> +		return -ENOENT;
>> +
>> +	err = cmd_status(cmd->sk, index, cmd->opcode, status);
>> +	mgmt_pending_remove(cmd);
>> +
>> +	return err;
>> +}
>> +
> 
> this looks like something that we might repeat over and over again.
> Would it not make sense to have a proper helper for this?

Yes, it seems we have three mgmt_*_failed functions that do the
same thing: find command, send cmd_status and remove command.
They are:

mgmt_disconnect_failed()
mgmt_start_discovery_failed()
mgmt_stop_discovery_failed()

We can create a helper function like mgmt_cmd_failed() that would
remove the command and would send the command status event. Then
we can do some refactoring in those three functions so they use
the mgmt_cmd_failed() function.

Since this patch fixes a mgmt command leak in the pending list
and the refactoring is not critical, IMO, we should apply it and
do the refactoring thing later.

BR,

Andre