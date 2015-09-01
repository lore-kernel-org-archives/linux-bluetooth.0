Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 3/3] Bluetooth: hci_intel: Add runtime PM support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55E5C4F4.6020305@intel.com>
Date: Tue, 1 Sep 2015 08:37:43 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F7752FAC-4ADD-4239-8BEE-72B28468ED46@holtmann.org>
References: <1441118530-18154-1-git-send-email-loic.poulain@intel.com> <1441118530-18154-3-git-send-email-loic.poulain@intel.com> <00A4FA75-DFA4-4890-A4A1-A4969FE5A313@holtmann.org> <55E5C4F4.6020305@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

>>> static int intel_recv_lpm(struct hci_dev *hdev, struct sk_buff *skb)
>>> @@ -895,9 +936,24 @@ static int intel_recv(struct hci_uart *hu, const void *data, int count)
>>> static int intel_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>>> {
>>> 	struct intel_data *intel = hu->priv;
>>> +	struct list_head *p;
>>> 
>>> 	BT_DBG("hu %p skb %p", hu, skb);
>>> 
>>> +	mutex_lock(&intel_device_list_lock);
>>> +	list_for_each(p, &intel_device_list) {
>>> +		struct intel_device *idev = list_entry(p, struct intel_device,
>>> +						      list);
>>> +
>>> +		if (hu->tty->dev->parent == idev->pdev->dev.parent) {
>>> +			pm_runtime_get_sync(&idev->pdev->dev);
>> 
>> just for my own clarification. Why this is get_sync and the other just get?
>> 
> 
> I want to be sure resume is completed before enqueuing any packet in order to be able to send the packet in dequeue.
> Moreover, since LPM and 'standard' packets share the same queue, we don't want to enqueue a 'standard' packet before our LPM one.
> 
> In the threaded IRQ , we are actually already LPM resumed since we have
> send a LPM resume ack to the controller, I just use get and put to notify the resume to the PM core and trigger autosuspend.
> 
> In the busy work, we don't need to be synced since we are already in a
> async work. It is more a keep alive to delay the auto suspend.

then please add some comment in front of the commands to make clear why we are doing it. When it comes to this level of details, comments help a lot.

Regards

Marcel

