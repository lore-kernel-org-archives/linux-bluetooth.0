Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] Bluetooth: remove btusb_work related workqueue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <088CC8BACB3382439E91D9919CE3502436568BA4@IRSMSX107.ger.corp.intel.com>
Date: Mon, 26 Oct 2015 04:56:54 +0900
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <F4DF561E-1F0B-44A1-8275-93180F23B34D@holtmann.org>
References: <1444316120-22893-1-git-send-email-kubax.t.pawlak@intel.com> <7D38034D-BDC6-4FD9-931E-7518FA2D20A4@holtmann.org> <088CC8BACB3382439E91D9919CE3502436568B42@IRSMSX107.ger.corp.intel.com> <6D48126C-1328-4466-9415-D48367F574C9@holtmann.org> <F79E09E1-497A-46AE-879B-F4AF321285AC@holtmann.org> <088CC8BACB3382439E91D9919CE3502436568BA4@IRSMSX107.ger.corp.intel.com>
To: "Pawlak, KubaX T" <kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kuba,

>>>>>> Workqueue handling btusb_work is no longer needed as btusb_notify
>>>>>> can sleep.
>>>>>> 
>>>>>> Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
>>>>>> ---
>>>>>> drivers/bluetooth/btusb.c | 14 +++++---------
>>>>>> 1 file changed, 5 insertions(+), 9 deletions(-)
>>>>>> 
>>>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>>>> index
>>>>> 
>> 247b1062cb9affc67d9e7f7a0234c167f90f4b79..98c616ddd7bac53b2d5d5f8b3dcc
>>>>> 2dca2b201e63 100644
>>>>>> --- a/drivers/bluetooth/btusb.c
>>>>>> +++ b/drivers/bluetooth/btusb.c
>>>>>> @@ -350,7 +350,6 @@ struct btusb_data {
>>>>>> 
>>>>>> 	unsigned long flags;
>>>>>> 
>>>>>> -	struct work_struct work;
>>>>>> 	struct work_struct waker;
>>>>>> 
>>>>>> 	struct usb_anchor deferred;
>>>>>> @@ -980,7 +979,6 @@ static int btusb_close(struct hci_dev *hdev)
>>>>>> 
>>>>>> 	BT_DBG("%s", hdev->name);
>>>>>> 
>>>>>> -	cancel_work_sync(&data->work);
>>>>>> 	cancel_work_sync(&data->waker);
>>>>>> 
>>>>>> 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
>>>>>> @@ -1181,6 +1179,8 @@ static int btusb_send_frame(struct hci_dev
>> *hdev,
>>>>> struct sk_buff *skb)
>>>>>> 	return -EILSEQ;
>>>>>> }
>>>>>> 
>>>>>> +static void btusb_sco_change(struct btusb_data *data);
>>>>>> +
>>>>> 
>>>>> do we need this forward declaration or can we just move code around to
>> avoid
>>>>> it?
>>>>> 
>>>>>> static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
>>>>>> {
>>>>>> 	struct btusb_data *data = hci_get_drvdata(hdev);
>>>>>> @@ -1189,7 +1189,7 @@ static void btusb_notify(struct hci_dev *hdev,
>>>>> unsigned int evt)
>>>>>> 
>>>>>> 	if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
>>>>>> 		data->sco_num = hci_conn_num(hdev, SCO_LINK);
>>>>>> -		schedule_work(&data->work);
>>>>>> +		btusb_sco_change(data);
>>>>>> 	}
>>>>>> }
>>>>>> 
>>>>>> @@ -1236,9 +1236,8 @@ static inline int __set_isoc_interface(struct
>> hci_dev
>>>>> *hdev, int altsetting)
>>>>>> 	return 0;
>>>>>> }
>>>>>> 
>>>>>> -static void btusb_work(struct work_struct *work)
>>>>>> +static void btusb_sco_change(struct btusb_data *data)
>>>>>> {
>>>>>> -	struct btusb_data *data = container_of(work, struct btusb_data,
>>>>> work);
>>>>>> 	struct hci_dev *hdev = data->hdev;
>>>>>> 	int new_alts;
>>>>>> 	int err;
>>>>>> @@ -2618,7 +2617,6 @@ static int btusb_probe(struct usb_interface
>> *intf,
>>>>>> 	data->udev = interface_to_usbdev(intf);
>>>>>> 	data->intf = intf;
>>>>>> 
>>>>>> -	INIT_WORK(&data->work, btusb_work);
>>>>>> 	INIT_WORK(&data->waker, btusb_waker);
>>>>>> 	init_usb_anchor(&data->deferred);
>>>>>> 	init_usb_anchor(&data->tx_anchor);
>>>>>> @@ -2848,8 +2846,6 @@ static int btusb_suspend(struct usb_interface
>> *intf,
>>>>> pm_message_t message)
>>>>>> 		return -EBUSY;
>>>>>> 	}
>>>>>> 
>>>>>> -	cancel_work_sync(&data->work);
>>>>>> -
>>>>>> 	btusb_stop_traffic(data);
>>>>>> 	usb_kill_anchored_urbs(&data->tx_anchor);
>>>>>> 
>>>>>> @@ -2922,7 +2918,7 @@ static int btusb_resume(struct usb_interface
>> *intf)
>>>>>> 	play_deferred(data);
>>>>>> 	clear_bit(BTUSB_SUSPENDING, &data->flags);
>>>>>> 	spin_unlock_irq(&data->txlock);
>>>>>> -	schedule_work(&data->work);
>>>>>> +	btusb_sco_change(data);
>>>>> 
>>>>> Can we actually sleep in the resume callbacks? I think so, but I have not
>> testing
>>>>> runtime power management in a while.
>>>> 
>>>> Apparently we can't, so workqueue needs to stay and this patch is invalid.
>>> 
>>> I think that removing the usage of the workqueue in btusb_notify is still a
>> good thing since it reduces the latency when establishing SCO connections.
>> 
>> actually I wonder if the call to usb_set_interface is needed on resume in the
>> first place. Maybe this is actually not needed and we just need to restart the
>> URBs.
>> 
>> Do you have the chance to test and see if the alternate setting actually changed
>> over resume?
> 
> Our platform does not support suspend/resume. I have an Ellisys analyser with external WP module connected through it over USB, so I can trace what altsettings are set and when. I will look into a possibility of testing this using a laptop, but I don’t know how to easily make phone open SCO channel, so I don't need to port our PulseAudio.

any update here? I would really get of this workqueue usage in btusb driver.

Regards

Marcel

