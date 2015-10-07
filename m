Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH] Bluetoot: Fix USB endpoint selection for wideband speech
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <088CC8BACB3382439E91D9919CE350243655F344@IRSMSX107.ger.corp.intel.com>
Date: Wed, 7 Oct 2015 20:15:01 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <089EE5F6-F949-4C9D-AB82-F18043D8FF64@holtmann.org>
References: <1444230347-1593-1-git-send-email-kubax.t.pawlak@intel.com> <747D67C0-738A-44E0-B489-D176C2290174@holtmann.org> <088CC8BACB3382439E91D9919CE350243655F344@IRSMSX107.ger.corp.intel.com>
To: "Pawlak, KubaX T" <kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kuba,

>>> For SCO connections, btusb driver sets alternate endpoint
>>> setting to 2 by default (17 bytes per USB packet).
>>> When connection is completed and airmode transparent has been
>> negotiated,
>>> alternate setting are not changed to 1 (9 bytes per USB packet).
>>> This results in wrong packets being sent and "robotic" audio.
>>> 
>>> Notify the driver that endpoint settings must change.
>>> 
>>> Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
>>> ---
>>> drivers/bluetooth/btusb.c | 12 +++++++++++-
>>> net/bluetooth/hci_event.c |  5 +++++
>>> 2 files changed, 16 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index
>> 247b1062cb9affc67d9e7f7a0234c167f90f4b79..65ce054d0755db9078a0f0813828
>> dbb278ea8f1c 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -1191,6 +1191,9 @@ static void btusb_notify(struct hci_dev *hdev,
>> unsigned int evt)
>>> 		data->sco_num = hci_conn_num(hdev, SCO_LINK);
>>> 		schedule_work(&data->work);
>>> 	}
>>> +
>>> +	if (evt == HCI_NOTIFY_VOICE_SETTING)
>>> +		schedule_work(&data->work);
>>> }
>> 
>> actually can you try to take the schedule_work out here. Since hdev->notify is
>> no longer called from bottom half, it is perfectly fine to sleep in this callback.
>> This is a leftover from a long time ago where all the packet processing was done
>> in the bottom half.
>> 
>> Once that has been removed, I think you can just switch the alternate setting
>> right in btusb_notify.
> 
> Pardon my ignorance, but I need to make sure that this would involve removing 'work' workqueue and calling btusb_work (renamed to not contain _work) everywhere, where schedule_work(&data->work); is called?

yep. That is exactly what this means. Remove data->work from everywhere.

>>> static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
>>> @@ -1255,7 +1258,11 @@ static void btusb_work(struct work_struct *work)
>>> 			set_bit(BTUSB_DID_ISO_RESUME, &data->flags);
>>> 		}
>>> 
>>> -		if (hdev->voice_setting & 0x0020) {
>>> +		if (hdev->voice_setting & BT_VOICE_TRANSPARENT) {
>>> +			static const int alts[3] = { 1, 2, 3 };
>>> +
>>> +			new_alts = alts[data->sco_num - 1];
>>> +		} else if (hdev->voice_setting & 0x0020) {
>>> 			static const int alts[3] = { 2, 4, 5 };
>>> 
>>> 			new_alts = alts[data->sco_num - 1];
>>> @@ -1267,6 +1274,9 @@ static void btusb_work(struct work_struct *work)
>>> 			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
>>> 			usb_kill_anchored_urbs(&data->isoc_anchor);
>>> 
>>> +			if (hdev->voice_setting & BT_VOICE_TRANSPARENT)
>>> +				hdev->voice_setting &=
>> ~BT_VOICE_TRANSPARENT;
>>> +
>>> 			/* When isochronous alternate setting needs to be
>>> 			 * changed, because SCO connection has been added
>>> 			 * or removed, a packet fragment may be left in the
>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>> index
>> 8acec932123ade906192ebbfd2daecee9b51f697..08e77537c6eb69c9727cb41a2ca
>> 8429f4d7a4941 100644
>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -3770,6 +3770,11 @@ static void hci_sync_conn_complete_evt(struct
>> hci_dev *hdev,
>>> 		break;
>>> 	}
>>> 
>>> +	if (ev->air_mode == SCO_AIRMODE_TRANSP) {
>>> +		hdev->voice_setting |= BT_VOICE_TRANSPARENT;
>>> +		hdev->notify(hdev, HCI_NOTIFY_VOICE_SETTING);
>>> +	}
>>> +
>> 
>> This is actually something that is not fully correct. The hdev->voice_setting is
>> suppose to represent the value of the setting. It should not be affected by the
>> connections. Especially since this gets tricky when you have two eSCO
>> connections. One using transparent and another using CVSD.
>> 
>> What we might need to do here is actually track the number of transparent vs
>> non-transparent eSCO connections separately.
> 
> Is it possible to have transparent and CVSD connections at the same time? Core spec 4.0, Vol 4, part B, 2.1.1 specifies endpoint configuration for multiples of 8bit or 16 bit connections only but not a mix of these. Also, second example provided only shows two connections of the same, 8bit type. I think this example forbids a mix of channels. Two SCO channels need to share USB endpoint, but a rule of having each SCO data packet divided into 3 fragments, each sent every 1ms needs to be preserved. That means that when two connections are carried over USB, packet frequency per channel is halved but packet size doubles. This can only be achieved if both connection have the same packet size. In case of 16 and 8 bit coexistence, 8bit channel would be required to increase its packets to 48 bit, which translates to 3 fragment 17 bytes each every 1ms, but 16bit channel would require 96 byte packets, which means 33 byte fragments every 1ms. One endpoint cannot support it. So when we have a transparent SCO link, we can only add more transparent SCO links and this device is BT_VOICE_TRANSPARENT only. Or am I fundamentally wrong?

We do not support multiple SCO links to the same device. However we do support multi SCO links to two different devices at the same time.

There is something that is specific to the Intel controllers with the 3 fragments. That is not necessarily the same for all controllers.

Also for Intel controllers we could look into SCO over bulk endpoints. I know that we do support that and it is actually more power efficient. However first we might try to get this fixed with using isochronous endpoints. Then we can try to enable it for bulk endpoints. You have a good test setup and it might be worth while for you to take a stab at it.

> I have no way of testing multiple SCO links.

I would try to just open a second HFP connection. In theory that should just work. Pair two phones and oFono + BlueZ should do the right thing. The controller might have a resource issue with this, but theoretical this should work.

Regards

Marcel

