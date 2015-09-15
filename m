Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth: ask for MWS transport config only if
 controller supports 4.1
To: Marcel Holtmann <marcel@holtmann.org>
References: <1442309091-1088-1-git-send-email-simon.fels@canonical.com>
 <6C5C6E24-A663-4A52-B38E-3AA2E8742779@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
From: Simon Fels <simon.fels@canonical.com>
Message-ID: <55F7EEA0.7030504@canonical.com>
Date: Tue, 15 Sep 2015 12:10:40 +0200
MIME-Version: 1.0
In-Reply-To: <6C5C6E24-A663-4A52-B38E-3AA2E8742779@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 15.09.2015 11:32, Marcel Holtmann wrote:
> Hi Simon,
>
>> Some controllers doesn't seem to clear the bitfield to indicate which
>> HCI commands are supported correctly. This leads to wrong conclusions
>> which HCI commands we can send at initialization time. In this case
>> the problem appeared with the command to retrieve the MWS transport
>> configuration which is only available since version 4.1
>
> provide btmon of the failing case and information about the controller that has this bug.
>
>> Signed-off-by: Simon Fels <simon.fels@canonical.com>
>> ---
>> include/net/bluetooth/bluetooth.h | 2 +-
>> net/bluetooth/hci_core.c          | 9 +++++++--
>> 2 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>> index fcf2ae7..0861477 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -37,7 +37,7 @@
>> /* Bluetooth versions */
>> #define BLUETOOTH_VER_1_1	1
>> #define BLUETOOTH_VER_1_2	2
>> -#define BLUETOOTH_VER_2_0	3
>> +#define BLUETOOTH_VER_4_1	7
>>
>> /* Reserv for core and drivers use */
>> #define BT_SKB_RESERVE	8
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index a7cdd99..f376ab6 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -824,8 +824,13 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
>> 	if (hdev->commands[29] & 0x20)
>> 		hci_req_add(req, HCI_OP_READ_LOCAL_CODECS, 0, NULL);
>>
>> -	/* Get MWS transport configuration if the HCI command is supported */
>> -	if (hdev->commands[30] & 0x08)
>> +	/* Get MWS transport configuration if the HCI command is supported
>> +	 * but only when reported HCI version is at minimum 4.1. Some
>> +	 * controllers doesn't seem to clear the bit field they transmit
>> +	 * correctly so all resevered fields are invalid and let to
>> +	 * failing commands */
>> +	if (hdev->hci_ver >= BLUETOOTH_VER_4_1 &&
>> +		hdev->commands[30] & 0x08)
>> 		hci_req_add(req, HCI_OP_GET_MWS_TRANSPORT_CONFIG, 0, NULL);
>
> We are not doing it this way. The version checks we have in the core are for really old controllers and times when the Bluetooth Core specification was unclear in certain behaviors.
>
> Any new broken behavior of a controller will not be hidden behind a version check. It will be hidden behind a quirk and we will call out the manufacturer for not doing this right in the driver by setting needed quirks.

That is fine for me. Was just sending this out to get the discussion 
started and a bit unsure which patterns you use for such things.

btmon log is at http://paste.ubuntu.com/12416578/

The failure case is simply that the HCI is never getting up. It fails 
during a

$ hciconfig hci0 up

within the kernel side initialization phase.

regards,
Simon
