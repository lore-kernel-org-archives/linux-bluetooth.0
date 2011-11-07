Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] Bluetooth: Create hci_do_inquiry()
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <20111107090343.GA10810@aemeltch-MOBL1>
Date: Mon, 7 Nov 2011 10:58:29 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6FA63277-5FDE-44FE-B4CC-17DACEDE7A18@openbossa.org>
References: <1320427013-5684-1-git-send-email-andre.guedes@openbossa.org> <20111107090343.GA10810@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Nov 7, 2011, at 6:03 AM, Andrei Emeltchenko wrote:

> Hi Andre,
> 
> On Fri, Nov 04, 2011 at 02:16:51PM -0300, Andre Guedes wrote:
>> This patch adds a function to hci_core to carry out inquiry.
>> 
>> All inquiry code from start_discovery() were replaced by a
>> hci_do_inquiry() call.
>> 
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/hci_core.h |    2 ++
>> net/bluetooth/hci_core.c         |   17 +++++++++++++++++
>> net/bluetooth/mgmt.c             |    9 +--------
>> 3 files changed, 20 insertions(+), 8 deletions(-)
>> 
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
>> #endif /* __HCI_CORE_H */
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index b7f6b5b..098f26c 100644
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
> 
> what are those numbers above?

This is the general inquiry LAP value defined in page 314 of
Core spec.

> 
>> +	struct hci_cp_inquiry cp;
>> +
>> +	BT_DBG("%s", hdev->name);
>> +
>> +	if (test_bit(HCI_INQUIRY, &hdev->flags))
>> +		return -EINPROGRESS;
>> +
>> +	memset(&cp, 0, sizeof(cp));
>> +	memcpy(&cp.lap, lap, 3);
> 
> sizeof(lap) looks better

Ok, I'll change this.

BR,

Andre