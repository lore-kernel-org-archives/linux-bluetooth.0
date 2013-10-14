Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/7] Bluetooth: Add connectable argument to enable_advertising()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131014113622.GE26222@x220.p-661hnu-f1>
Date: Mon, 14 Oct 2013 13:43:51 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4E952FA5-97BF-4712-996C-1AB7883A70C9@holtmann.org>
References: <1381747965-24599-1-git-send-email-johan.hedberg@gmail.com> <1381747965-24599-2-git-send-email-johan.hedberg@gmail.com> <9E7A5B1E-F415-4F2D-BDBF-B6C4ACB6B142@holtmann.org> <20131014113622.GE26222@x220.p-661hnu-f1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> We want to be able to control whether enable_advertising() enables
>>> connectable or non-connectable advertising based on the connectable
>>> setting of the adapter. We could have the function check directly for
>>> the HCI_CONNECTABLE flag, but since the flag may not be set or unset
>>> before we call the function it's necessary to pass an explicit parameter
>>> value to it.
>>> 
>>> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
>>> ---
>>> net/bluetooth/mgmt.c | 16 +++++++++++-----
>>> 1 file changed, 11 insertions(+), 5 deletions(-)
>>> 
>>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>>> index 020f95b..6f07523 100644
>>> --- a/net/bluetooth/mgmt.c
>>> +++ b/net/bluetooth/mgmt.c
>>> @@ -1418,7 +1418,7 @@ unlock:
>>> 	return err;
>>> }
>>> 
>>> -static void enable_advertising(struct hci_request *req)
>>> +static void enable_advertising(struct hci_request *req, bool connectable)
>>> {
>>> 	struct hci_dev *hdev = req->hdev;
>>> 	struct hci_cp_le_set_adv_param cp;
>>> @@ -1427,7 +1427,10 @@ static void enable_advertising(struct hci_request *req)
>>> 	memset(&cp, 0, sizeof(cp));
>>> 	cp.min_interval = __constant_cpu_to_le16(0x0800);
>>> 	cp.max_interval = __constant_cpu_to_le16(0x0800);
>>> -	cp.type = LE_ADV_IND;
>>> +	if (connectable)
>>> +		cp.type = LE_ADV_IND;
>>> +	else
>>> +		cp.type = LE_ADV_NONCONN_IND;
>> 
>> this is the part that I do not like. Having the extra parameter seems
>> rather pointless. We could check for the HCI_CONNECTABLE bit in
>> dev_flags right here.
> 
> This is what I tried to explain in the commit message. When we do
> set_connectable() we want to call enable_advertising() with an explicit
> value since the HCI_CONNECTABLE flag gets toggled only when the HCI
> commands have been successful.

I have a bad feeling with doing it like this. So I rather try to avoid this. We might need an internal difference between BR/EDR connectable and LE connectable. So that at least we can track this internally independent.

The whole feeding test_bit() as parameter is getting out of control quickly. So I would propose to have one extra flag that gets set.

Regards

Marcel

