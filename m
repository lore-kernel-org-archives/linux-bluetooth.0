Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Expose inquiry_cache debugfs only on BR/EDR controllers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131016152018.GA18754@x220.p-661hnu-f1>
Date: Wed, 16 Oct 2013 18:07:44 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CBF90906-B2DB-4BD5-A6A6-1760E0CBF36B@holtmann.org>
References: <1381919335-59602-1-git-send-email-marcel@holtmann.org> <20131016152018.GA18754@x220.p-661hnu-f1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
>> @@ -734,7 +772,22 @@ static int __hci_init(struct hci_dev *hdev)
>> 	if (err < 0)
>> 		return err;
>> 
>> -	return __hci_req_sync(hdev, hci_init4_req, 0, HCI_INIT_TIMEOUT);
>> +	err = __hci_req_sync(hdev, hci_init4_req, 0, HCI_INIT_TIMEOUT);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	/* Only create debugfs entries during the initial setup
>> +	 * phase and not every time the controller gets powered on.
>> +	 */
>> +	if (!test_bit(HCI_SETUP, &hdev->dev_flags))
>> +		return 0;
>> +
>> +	if (lmp_bredr_capable(hdev)) {
>> +		debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
>> +				    hdev, &inquiry_cache_fops);
>> +	}
> 
> The patch looks good but just a minor nit-pick here: do you really want
> to have the curly braces for this one? Even though the function call is
> split across two lines it doesn't make it any harder to read without the
> braces, for me at least.

that is because I am planning to add more in future patches.

Regards

Marcel

