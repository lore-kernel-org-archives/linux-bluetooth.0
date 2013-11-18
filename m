Return-Path: <cyrus@holtmann.org>
Message-ID: <528A5F29.1080902@openbossa.org>
Date: Mon, 18 Nov 2013 15:40:41 -0300
From: Andre Guedes <andre.guedes@openbossa.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC v2 10/15] Bluetooth: Temporarily stop background scanning
 on discovery
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org> <1383053160-10175-11-git-send-email-andre.guedes@openbossa.org> <8E33B37F-71D9-4516-8883-080DDEC81132@holtmann.org>
In-Reply-To: <8E33B37F-71D9-4516-8883-080DDEC81132@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 10/29/2013 08:19 PM, Marcel Holtmann wrote:
> Hi Andre,
>
>> If the user send a mgmt start discovery command while the background
>> scanning is running, we should temporarily stop it. Once the discovery
>> finishes, we start the background scanning again.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> net/bluetooth/hci_core.c |  5 +++++
>> net/bluetooth/mgmt.c     | 12 ++++++++----
>> 2 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 79debc3..44d3f99 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1496,6 +1496,11 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
>>
>> 	switch (state) {
>> 	case DISCOVERY_STOPPED:
>> +		/* Check the background scanning since it may have been
>> +		 * temporarily stopped by the start discovery command.
>> +		 */
>> +		hci_check_background_scan(hdev);
>> +
>
> I do not know what check here means. For me this is reenable_background_scan or trigger_background_scan or start_background_scan, but not some magic check.
>
>> 		if (hdev->discovery.state != DISCOVERY_STARTING)
>> 			mgmt_discovering(hdev, 0);
>> 		break;
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 22cf547..0e329e5 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -3280,11 +3280,15 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
>> 			goto failed;
>> 		}
>>
>> +		/* If controller is scanning, it means the background scanning
>> +		 * is running. Thus, we should temporarily stop it in order to
>> +		 * set the discovery scanning parameters.
>> +		 */
>> 		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
>> -			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
>> -					 MGMT_STATUS_BUSY);
>> -			mgmt_pending_remove(cmd);
>> -			goto failed;
>> +			memset(&enable_cp, 0, sizeof(enable_cp));
>> +			enable_cp.enable = LE_SCAN_DISABLE;
>> +			hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE,
>> +				    sizeof(enable_cp), &enable_cp);
>> 		}
>
> I think we need a new hdev->dev_flags for HCI_LE_BG_SCAN. Magically assuming that it is a background scan is dangerous.

A few lines above (the diff doesn't show it), we check if discovery is 
running. Since discovery is not running and controller is scanning, we 
assume that it is the background scanning. So, we might not want to 
create the HCI_LE_BG_SCAN flag since it is not really necessary by now.

Regards,

Andre
