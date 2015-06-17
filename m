Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 2/2] Bluetooth: hci_uart: Fix dereferencing of ERR_PTR
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5580F9E7.1000902@samsung.com>
Date: Wed, 17 Jun 2015 11:37:58 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D18C0514-53EB-43A5-A41C-99A1610D9186@holtmann.org>
References: <1434459321-20281-1-git-send-email-chanyeol.park@samsung.com> <1434459321-20281-2-git-send-email-chanyeol.park@samsung.com> <98B3DE38-46E4-44F7-8AA5-774A96C521BE@holtmann.org> <5580F9E7.1000902@samsung.com>
To: Chan-yeol Park <chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

>>> If h4_recv() return ERR_PTR instead sk_buff pointer, it should be
>>> cleared once dereference is completed for the further reference such as
>>> h4_recv(), or h4_close().
>> 
>> I have no idea what the h4_close has to do with it? Can you explain.
> If h4->rx_skb has ERR_PTR , kfree_skb() would dereference of ERR_PTR. This is easily reproduced on my board when I turn off BT.

I see. kfree_skb is not smart enough.

>> 
>>> 
>>> Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
>>> ---
>>> drivers/bluetooth/hci_h4.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>> 
>>> diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
>>> index f7190f0..a8acd99 100644
>>> --- a/drivers/bluetooth/hci_h4.c
>>> +++ b/drivers/bluetooth/hci_h4.c
>>> @@ -133,6 +133,7 @@ static int h4_recv(struct hci_uart *hu, const void *data, int count)
>>> 	if (IS_ERR(h4->rx_skb)) {
>>> 		int err = PTR_ERR(h4->rx_skb);
>>> 		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
>>> +		h4->rx_skb = NULL;
>>> 		return err;
>>> 	}

actually lets go with this fix. It is cleaner since you do not need to touch the close functions. However this issue exists in all drivers. So we need to fix all of them.

Regards

Marcel

