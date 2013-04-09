Return-Path: <cyrus@holtmann.org>
Message-id: <955A07EE3A29415FA1DD430AC80A0077@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1365423007-23159-1-git-send-email-jaganath.k@samsung.com>
 <20130408155900.GA28576@joana>
In-reply-to: <20130408155900.GA28576@joana>
Subject: Re: [PATCH] Bluetooth: Fix incorrect ssp mode bit for non ssp devices
Date: Tue, 09 Apr 2013 10:00:00 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

--------------------------------------------------
From: "Gustavo Padovan" <gustavo@padovan.org>
Sent: Monday, April 08, 2013 9:29 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Fix incorrect ssp mode bit for non ssp 
devices

> Hi Jaganath,
>
> * Jaganath Kanakkassery <jaganath.k@samsung.com> [2013-04-08 17:40:07 
> +0530]:
>
>> Some devices send extended inquiry response where as it wont
>> support ssp in remote extended features. So when we recieve eir,
>> we set ssp bit in conn flag which we are not clearing in
>> remote ext features event. So eventually ssp in conn flag will be
>> incorrectly set.
>>
>> In hci_remote_ext_features_evt(), if ssp is not supported then
>> we should clear HCI_CONN_SSP_ENABLED in conn flag since it might
>> have set while initiating acl connection using eir.
>>
>> hcidump log
>> ----------
>>
>> < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
>>     type 0x01 (active)
>>     interval 11.250ms window 11.250ms
>>     own address: 0x00 (Public) policy: All
>> > HCI Event: Command Complete (0x0e) plen 4
>>     LE Set Scan Parameters (0x08|0x000b) ncmd 1
>>     status 0x00
>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>     value 0x01 (scanning enabled)
>>     filter duplicates 0x01 (enabled)
>> > HCI Event: Command Complete (0x0e) plen 4
>>     LE Set Scan Enable (0x08|0x000c) ncmd 1
>>     status 0x00
>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>     value 0x00 (scanning disabled)
>>     filter duplicates 0x00 (disabled)
>> > HCI Event: Command Complete (0x0e) plen 4
>>     LE Set Scan Enable (0x08|0x000c) ncmd 1
>>     status 0x00
>> < HCI Command: Inquiry (0x01|0x0001) plen 5
>>     lap 0x9e8b33 len 4 num 0
>> > HCI Event: Command Status (0x0f) plen 4
>>     Inquiry (0x01|0x0001) status 0x00 ncmd 1
>> > HCI Event: Extended Inquiry Result (0x2f) plen 255
>>     bdaddr 00:1B:DC:05:B5:25 mode 1 clkoffset 0x3263 class 0x3c0000 
>> rssi -77
>>     Unknown type 0x42 with 8 bytes data
>>     Unknown type 0x1e with 2 bytes data
>> > HCI Event: Inquiry Complete (0x01) plen 1
>>     status 0x00
>>
>> < HCI Command: Create Connection (0x01|0x0005) plen 13
>>     bdaddr 00:1B:DC:05:B5:25 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>> > HCI Event: Command Status (0x0f) plen 4
>>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
>> > HCI Event: Connect Complete (0x03) plen 11
>>     status 0x00 handle 12 bdaddr 00:1B:DC:05:B5:25 type ACL encrypt 0x00
>> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>>     handle 12
>> > HCI Event: Command Status (0x0f) plen 4
>>     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
>> > HCI Event: Read Remote Supported Features (0x0b) plen 11
>>     status 0x00 handle 12
>>     Features: 0xff 0xff 0x8f 0x7e 0xd8 0x1f 0x5b 0x87
>> < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
>>     handle 12 page 1
>> > HCI Event: Command Status (0x0f) plen 4
>>     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
>> > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>>     bdaddr 00:1B:DC:05:B5:25 mode 1
>> > HCI Event: Max Slots Change (0x1b) plen 3
>>     handle 12 slots 5
>> > HCI Event: Read Remote Extended Features (0x23) plen 13
>>     status 0x00 handle 12 page 1 max 0
>>     Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>>     bdaddr 00:1B:DC:05:B5:25 mode 2 clkoffset 0x0000
>> > HCI Event: Command Status (0x0f) plen 4
>>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>> > HCI Event: Remote Name Req Complete (0x07) plen 255
>>     status 0x00 bdaddr 00:1B:DC:05:B5:25 name 'Bluetooth PTS Radio v4'
>> < HCI Command: Authentication Requested (0x01|0x0011) plen 2
>>     handle 12
>> > HCI Event: Command Status (0x0f) plen 4
>>     Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
>> > HCI Event: Link Key Request (0x17) plen 6
>>     bdaddr 00:1B:DC:05:B5:25
>> < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
>>     bdaddr 00:1B:DC:05:B5:25
>> > HCI Event: Command Complete (0x0e) plen 10
>>     Link Key Request Negative Reply (0x01|0x000c) ncmd 1
>>     status 0x00 bdaddr 00:1B:DC:05:B5:25
>> > HCI Event: PIN Code Request (0x16) plen 6
>>     bdaddr 00:1B:DC:05:B5:25
>>
>> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
>> ---
>>  net/bluetooth/hci_event.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 0a2b128..ef2353e 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -2935,6 +2935,8 @@ static void hci_remote_ext_features_evt(struct 
>> hci_dev *hdev,
>>
>>  if (ev->features[0] & LMP_HOST_SSP)
>>  set_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
>> + else
>> + test_and_clear_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
>
> Why not use clear_bit() only? I don't see why you need to test it first.
>

I used test_and_clear_bit() since it will be set only in certain conditions 
and I saw similar
code in other places also. I will use clear_bit() and raise the patch

Thanks,
Jaganath 

