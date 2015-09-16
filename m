Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] bluetooth: ask for MWS transport config only if controller supports 4.1
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55F7EEA0.7030504@canonical.com>
Date: Wed, 16 Sep 2015 04:36:46 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D76DBD6B-2DDD-4B96-B5F9-59A93B65D78E@holtmann.org>
References: <1442309091-1088-1-git-send-email-simon.fels@canonical.com> <6C5C6E24-A663-4A52-B38E-3AA2E8742779@holtmann.org> <55F7EEA0.7030504@canonical.com>
To: Simon Fels <simon.fels@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

>>> Some controllers doesn't seem to clear the bitfield to indicate which
>>> HCI commands are supported correctly. This leads to wrong conclusions
>>> which HCI commands we can send at initialization time. In this case
>>> the problem appeared with the command to retrieve the MWS transport
>>> configuration which is only available since version 4.1
>> 
>> provide btmon of the failing case and information about the controller that has this bug.
>> 
>>> Signed-off-by: Simon Fels <simon.fels@canonical.com>
>>> ---
>>> include/net/bluetooth/bluetooth.h | 2 +-
>>> net/bluetooth/hci_core.c          | 9 +++++++--
>>> 2 files changed, 8 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>>> index fcf2ae7..0861477 100644
>>> --- a/include/net/bluetooth/bluetooth.h
>>> +++ b/include/net/bluetooth/bluetooth.h
>>> @@ -37,7 +37,7 @@
>>> /* Bluetooth versions */
>>> #define BLUETOOTH_VER_1_1	1
>>> #define BLUETOOTH_VER_1_2	2
>>> -#define BLUETOOTH_VER_2_0	3
>>> +#define BLUETOOTH_VER_4_1	7
>>> 
>>> /* Reserv for core and drivers use */
>>> #define BT_SKB_RESERVE	8
>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>> index a7cdd99..f376ab6 100644
>>> --- a/net/bluetooth/hci_core.c
>>> +++ b/net/bluetooth/hci_core.c
>>> @@ -824,8 +824,13 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
>>> 	if (hdev->commands[29] & 0x20)
>>> 		hci_req_add(req, HCI_OP_READ_LOCAL_CODECS, 0, NULL);
>>> 
>>> -	/* Get MWS transport configuration if the HCI command is supported */
>>> -	if (hdev->commands[30] & 0x08)
>>> +	/* Get MWS transport configuration if the HCI command is supported
>>> +	 * but only when reported HCI version is at minimum 4.1. Some
>>> +	 * controllers doesn't seem to clear the bit field they transmit
>>> +	 * correctly so all resevered fields are invalid and let to
>>> +	 * failing commands */
>>> +	if (hdev->hci_ver >= BLUETOOTH_VER_4_1 &&
>>> +		hdev->commands[30] & 0x08)
>>> 		hci_req_add(req, HCI_OP_GET_MWS_TRANSPORT_CONFIG, 0, NULL);
>> 
>> We are not doing it this way. The version checks we have in the core are for really old controllers and times when the Bluetooth Core specification was unclear in certain behaviors.
>> 
>> Any new broken behavior of a controller will not be hidden behind a version check. It will be hidden behind a quirk and we will call out the manufacturer for not doing this right in the driver by setting needed quirks.
> 
> That is fine for me. Was just sending this out to get the discussion started and a bit unsure which patterns you use for such things.
> 
> btmon log is at http://paste.ubuntu.com/12416578/
> 
> The failure case is simply that the HCI is never getting up. It fails during a
> 
> $ hciconfig hci0 up
> 
> within the kernel side initialization phase.

so it is actually not that this chip does not understand this command, it is that it is being stupid.

< HCI Command: Get MWS Transport Layer.. (0x05|0x000c) plen 0
> HCI Event: Command Complete (0x0e) plen 5
      Get MWS Transport Layer Configuration (0x05|0x000c) ncmd 1
        Status: Unknown Connection Identifier (0x02)
        Number of transports: 0
        Baud rate list: 0 entries

The command is properly supported. I just don't know why it needs to return with an error. And especially error 0x02 which makes no sense in this case since the command is not even taking a connection handle in the first place.

< HCI Command: Read Local Version Info.. (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.0 (0x06) - Revision 0 (0x0000)
        LMP version: Bluetooth 4.0 (0x06) - Subversion 0 (0x0000)
        Manufacturer: MediaTek, Inc. (70)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
> HCI Event: Command Complete (0x0e) plen 10
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 38:BC:1A:1F:7E:96 (Meizu technology co.,ltd)

So it seems that MediaTek needs to work a bit on their HCI command support. Which module is this anyway? Who builds it and where can it be found? Is this USB or UART? If it is USB, please provide /sys/kernel/debug/usb/devices entry for this one.

I have the feeling we are missing some sort of firmware update here that would allow to fix this controller.

And I forgot to note that MWS actually was a CSA. So it is valid for Bluetooth 4.0 controllers. It is just that Bluetooth 4.1 included all previous CSA.

Regards

Marcel

