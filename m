Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] bluetooth: Fix aborting eSCO connection in case of error 0x20
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1394199005-28369-1-git-send-email-andrewx.earl@intel.com>
Date: Fri, 7 Mar 2014 09:53:50 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AF985C9B-3C8D-40BD-96F2-42EF32F28EF6@holtmann.org>
References: <1394199005-28369-1-git-send-email-andrewx.earl@intel.com>
To: Andrew Earl <andrewx.earl@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> Add additional error case to attempt alternative configuration for SCO. Error
> occurs with Intel BT controller where fallback is not attempted as the error
> 0x020 Unsupported LMP Parameter value is not included in the list of errors

status is only 1 octet and not 1.5 octets ;)

> where a retry should be attempted.
> The problem also affects PTS test case TC_HF_ACS_BV_05_I.
> 
> See the HCI log below for details:
> < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
>    handle 256 voice setting 0x0060 ptype 0x0380
>> HCI Event: Command Status (0x0f) plen 4
>    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
>> HCI Event: Max Slots Change (0x1b) plen 3
>    handle 256 slots 1
>> HCI Event: Synchronous Connect Complete (0x2c) plen 17
>    status 0x20 handle 0 bdaddr 00:80:98:09:0B:19 type eSCO
>    Error: Unsupported LMP Parameter Value
> < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
>    handle 256 voice setting 0x0060 ptype 0x0380
>> HCI Event: Command Status (0x0f) plen 4
>    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
>> HCI Event: Max Slots Change (0x1b) plen 3
>    handle 256 slots 5
>> HCI Event: Synchronous Connect Complete (0x2c) plen 17
>    status 0x20 handle 0 bdaddr 00:80:98:09:0B:19 type eSCO
>    Error: Unsupported LMP Parameter Value
> < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
>    handle 256 voice setting 0x0060 ptype 0x03c8
>> HCI Event: Command Status (0x0f) plen 4
>    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
>> HCI Event: Max Slots Change (0x1b) plen 3
>    handle 256 slots 1
>> HCI Event: Synchronous Connect Complete (0x2c) plen 17
>    status 0x00 handle 257 bdaddr 00:80:98:09:0B:19 type eSCO
>    Air mode: CVSD

You need to sign off your patches. Do you mind actually including the btmon trace since that is a bit more verbose.

> ---
> net/bluetooth/hci_event.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 5f81245..59e1b45 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2905,6 +2905,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
> 	case 0x1c:	/* SCO interval rejected */
> 	case 0x1a:	/* Unsupported Remote Feature */
> 	case 0x1f:	/* Unspecified error */
> +	case 0x20:	/* Unsupported LMP Parameter value */
> 		if (conn->out) {
> 			conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
> 					(hdev->esco_type & EDR_ESCO_MASK);

Regards

Marcel

