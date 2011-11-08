Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] Bluetooth: Create hci_do_inquiry()
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1320710040.15441.309.camel@aeonflux>
Date: Tue, 8 Nov 2011 14:40:31 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <166092C5-5F89-49DD-866D-6397E4B9C05A@openbossa.org>
References: <1320427013-5684-1-git-send-email-andre.guedes@openbossa.org> <1320674372-5128-1-git-send-email-andre.guedes@openbossa.org> <1320710040.15441.309.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Nov 7, 2011, at 8:53 PM, Marcel Holtmann wrote:

> Hi Andre,
> 
>> This patch adds a function to hci_core to carry out inquiry.
>> 
>> All inquiry code from start_discovery() were replaced by a
>> hci_do_inquiry() call.
>> 
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/hci_core.h |    2 ++
>> net/bluetooth/hci_core.c         |   17 +++++++++++++++++
>> net/bluetooth/mgmt.c             |   11 +++--------
>> 3 files changed, 22 insertions(+), 8 deletions(-)
> 
> in general I am fine with this patch, besides some tiny nitpicks.
> 
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index f97792c..ae36ac0 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -970,4 +970,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
>> void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
>> void hci_le_ltk_neg_reply(struct hci_conn *conn);
>> 
>> +int hci_do_inquiry(struct hci_dev *hdev, u8 length);
>> +
> 
> I think the name hci_send_inquiry would be better. Since you are just
> sending the command and not handling the whole inquiry.

In LE scan patch (which I'll send to ML soon), we define a function called
hci_do_le_scan() which checks the current state, send some commands and
setup a timer to disable le scan after a given timeout. In this case the "do"
makes more sense. So, in order to keep things lined up, I chose a similar
name to inquiry function. This way hci_core provides the following helper
functions to carry out device discovery:

hci_do_inquiry();
hci_do_le_scan();
hci_cancel_inquiry();
hci_cancel_le_scan();

We may rename hci_do_inquiry to hci_send_inquiry but we won't keep theses
names lined up. So, can we keep this way or you still think we should
rename it?

>> #endif /* __HCI_CORE_H */
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index b7f6b5b..5b861c7 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -2560,3 +2560,20 @@ static void hci_cmd_task(unsigned long arg)
>> 		}
>> 	}
>> }
>> +
>> +int hci_do_inquiry(struct hci_dev *hdev, u8 length)
>> +{
>> +	u8 lap[3] = { 0x33, 0x8b, 0x9e };
>> +	struct hci_cp_inquiry cp;
>> +
>> +	BT_DBG("%s", hdev->name);
>> +
>> +	if (test_bit(HCI_INQUIRY, &hdev->flags))
>> +		return -EINPROGRESS;
>> +
>> +	memset(&cp, 0, sizeof(cp));
>> +	memcpy(&cp.lap, lap, sizeof(cp.lap));
>> +	cp.length  = length;
>> +
>> +	return hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
>> +}
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 747366a..17c7fbb 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -32,6 +32,8 @@
>> #define MGMT_VERSION	0
>> #define MGMT_REVISION	1
>> 
>> +#define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
>> +
> 
> Please add an extra tab between the comment and the define. It is too
> easy to get confused otherwise.

Ok, I'll fix it.

> 
>> struct pending_cmd {
>> 	struct list_head list;
>> 	__u16 opcode;
>> @@ -1598,8 +1600,6 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
>> 
>> static int start_discovery(struct sock *sk, u16 index)
>> {
>> -	u8 lap[3] = { 0x33, 0x8b, 0x9e };
>> -	struct hci_cp_inquiry cp;
>> 	struct pending_cmd *cmd;
>> 	struct hci_dev *hdev;
>> 	int err;
>> @@ -1618,12 +1618,7 @@ static int start_discovery(struct sock *sk, u16 index)
>> 		goto failed;
>> 	}
>> 
>> -	memset(&cp, 0, sizeof(cp));
>> -	memcpy(&cp.lap, lap, 3);
>> -	cp.length  = 0x08;
>> -	cp.num_rsp = 0x00;
>> -
>> -	err = hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
>> +	err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
>> 	if (err < 0)
>> 		mgmt_pending_remove(cmd);
>> 
> 
> Otherwise.
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> 
> Regards
> 
> Marcel
> 
> 

BR,

Andre