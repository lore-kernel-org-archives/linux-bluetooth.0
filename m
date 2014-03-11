Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] bluetooth: Fix aborting eSCO connection in case of error 0x20
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1394447464-29164-2-git-send-email-andrewx.earl@intel.com>
Date: Tue, 11 Mar 2014 08:17:54 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BBE97863-5D8F-4565-B7E9-79087B616138@holtmann.org>
References: <1394447464-29164-1-git-send-email-andrewx.earl@intel.com> <1394447464-29164-2-git-send-email-andrewx.earl@intel.com>
To: Andrew Earl <andrewx.earl@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrew,

> Add additional error case to attempt alternative configuration for SCO. Error
> occurs with Intel BT controller where fallback is not attempted as the error
> 0x20 Unsupported LMP Parameter value is not included in the list of errors
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
> 
> See btmon log for further details:
>> HCI Event (0x0f) plen 4 [hci0] 44.888063
>      Setup Synchronous Connection (0x01|0x0028) ncmd 1
>        Status: Success (0x00)
>> HCI Event (0x1b) plen 3 [hci0] 44.893064
>        Handle: 256
>        Max slots: 1
>> HCI Event (0x2c) plen 17 [hci0] 44.942080
>        Status: Unsupported LMP Parameter Value (0x20)
>        Handle: 0
>        Address: 00:1B:DC:06:04:B0 (OUI 00-1B-DC)
>        Link type: eSCO (0x02)
>        Transmission interval: 0x00
>        Retransmission window: 0x01
>        RX packet length: 0
>        TX packet length: 0
>        Air mode: CVSD (0x02)
>> HCI Event (0x1b) plen 3 [hci0] 44.948054
>        Handle: 256
>        Max slots: 5
> 
> Signed-off-by: Andrew Earl <andrewx.earl@intel.com>
> ---
> net/bluetooth/hci_event.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

