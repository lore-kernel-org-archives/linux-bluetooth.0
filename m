Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2 3/7] Bluetooth: Update page scan when necessary for Add/Remove Device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140709094848.GB13302@t440s.P-661HNU-F1>
Date: Wed, 9 Jul 2014 11:50:42 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BB9EDC01-439D-4E2B-A340-FFBEAC6E2C8D@holtmann.org>
References: <1404895392-12588-1-git-send-email-johan.hedberg@gmail.com> <1404895392-12588-4-git-send-email-johan.hedberg@gmail.com> <3DF0F8C8-F681-40AB-AD14-81ECD2C897CA@holtmann.org> <20140709094848.GB13302@t440s.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> When we're removing the last item in the white list or adding the first
>>> one to it and HCI_CONNECTABLE is not set we need to update the current
>>> page scan. This patch adds a simple helper function for the purpose and
>>> calls it from the respective mgmt command handlers.
>>> 
>>> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
>>> ---
>>> net/bluetooth/mgmt.c | 31 +++++++++++++++++++++++++++++++
>>> 1 file changed, 31 insertions(+)
>>> 
>>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>>> index 431d5e4aa34b..f5f0763266e0 100644
>>> --- a/net/bluetooth/mgmt.c
>>> +++ b/net/bluetooth/mgmt.c
>>> @@ -5198,6 +5198,24 @@ unlock:
>>> 	return err;
>>> }
>>> 
>>> +/* Helper for Add/Remove Device commands */
>>> +static void update_page_scan(struct hci_dev *hdev, u8 scan)
>>> +{
>>> +	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
>>> +		return;
>>> +
>>> +	if (!hdev_is_powered(hdev))
>>> +		return;
>>> +
>>> +	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
>>> +		return;
>> 
>> wouldn't it be better to check the HCI_PSCAN flag here to see if page
>> scan is actually enabled on the controller?
> 
> Maybe I was a bit too smart here, but the code is actually correct. We
> also call update_page_scan() with SCAN_DISABLE (0x00) for the
> remove_device case and there if HCI_CONNECTABLE is set we should return
> from the function. Checking for HCI_PSCAN would do the wrong thing.
> 
> I can leave the patch as-is, or add a bit more complex logic there:
> 
> 	if (PSCAN && scan)
> 		return;
> 
> 	if (!PSCAN && !scan)
> 		return;
> 
> Let me know what you prefer.

maybe just add a comment explaining why checking HCI_CONNECTABLE is the right thing to do here.

Regards

Marcel

