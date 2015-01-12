Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 3/5] Bluetooth: Read stored link key information when powering on controller
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150112090639.GA20805@t440s.lan>
Date: Mon, 12 Jan 2015 09:12:33 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6549B655-CD64-434E-947D-EA1E36F264F6@holtmann.org>
References: <1421012665-4842-3-git-send-email-marcel@holtmann.org> <20150112090639.GA20805@t440s.lan>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> The information about max stored link keys and current stored link keys
>> should be read at controller initialization. So issue HCI Read Stored
>> Link Key command with BDADDR_ANY and read_all flag set to 0x01 to
>> retrieve this information.
>> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> net/bluetooth/hci_core.c | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>> 
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index ba0d1fdccbd9..96572a48948e 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -731,6 +731,14 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
>> 
>> 	hci_setup_event_mask(req);
>> 
>> +	if (hdev->commands[6] & 0x20) {
>> +		struct hci_cp_read_stored_link_key cp;
>> +
>> +		bacpy(&cp.bdaddr, BDADDR_ANY);
>> +		cp.read_all = 0x01;
>> +		hci_req_add(req, HCI_OP_READ_STORED_LINK_KEY, sizeof(cp), &cp);
>> +	}
> 
> Since we're now reading the stored key count before deleting anything,
> wouldn't it also make sense to move the deleting into init4_req and only
> do it if hdev->stored_num_keys > 0?

most likely it would make sense. I left this for later to get first some test results on how this actually goes and see if we have stored keys in the controller.

Regards

Marcel

