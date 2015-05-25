Return-Path: <cyrus@holtmann.org>
Message-ID: <5562D736.9050709@gmail.com>
Date: Mon, 25 May 2015 10:03:02 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 12/16] Bluetooth: mgmt: multi adv for set_advertising_complete()
References: <1432507154-22925-1-git-send-email-fgrandel@gmail.com> <1430408000-17785-1-git-send-email-fgrandel@gmail.com> <1432507154-22925-13-git-send-email-fgrandel@gmail.com> <4263A067-4FCF-4D44-8BB7-685D6C3AC1E4@holtmann.org>
In-Reply-To: <4263A067-4FCF-4D44-8BB7-685D6C3AC1E4@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 05/25/2015 02:25 AM, Marcel Holtmann wrote:
> Hi Florian,
>
>> The set_advertising_complete() method relied on the now obsolete
>> hci_dev->adv_instance structure. We replace this reference by an
>> equivalent access to the newly introduced dynamic advertising instance
>> list.
>>
>> This solution still relies on the fact that we only allow a single
>> advertising instance for now. It needs to be further refactored once we
>> allow more than one advertising instance. A corresponding TODO has been
>> inserted in the code to make this clear.
>>
>> Signed-off-by: Florian Grandel <fgrandel@gmail.com>
>> ---
>> net/bluetooth/mgmt.c | 19 ++++++++++++++++---
>> 1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 3d09cb9..1bdf005 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -4673,6 +4673,7 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
>> {
>> 	struct cmd_lookup match = { NULL, hdev };
>> 	struct hci_request req;
>> +	struct adv_info *adv_instance;
>>
>> 	hci_dev_lock(hdev);
>>
>> @@ -4698,14 +4699,26 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
>> 		sock_put(match.sk);
>>
>> 	/* If "Set Advertising" was just disabled and instance advertising was
>> -	 * set up earlier, then enable the advertising instance.
>> +	 * set up earlier, then re-enable multi-instance advertising.
>> 	 */
>> 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
>> -	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
>> +	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) ||
>> +	    &hdev->adv_instance_cnt == 0)
>
> this gives me an error on make C=2 net/bluetooth/
>
>    CHECK   net/bluetooth/mgmt.c
> net/bluetooth/mgmt.c:4717:40: warning: Using plain integer as NULL pointer

Oups! Beginner's error. I just did git rebase -i -exec make. I'll use 
the C=2 option from now on for all my contributions. Thanks for pointing 
me to it.

Florian
