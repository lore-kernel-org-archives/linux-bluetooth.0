Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8FFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 23:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242264AbhLVXIV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 18:08:21 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:52497 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhLVXIV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 18:08:21 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1BE1CCED17;
        Thu, 23 Dec 2021 00:08:19 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC PATCH v2] Bluetooth: btintel: Fix broken LED quirk for
 legacy ROM devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <39a9b9c68cdb9fbf32f3c6023c0272b53d37d668.camel@intel.com>
Date:   Thu, 23 Dec 2021 00:08:18 +0100
Cc:     "hj.tedd.an@gmail.com" <hj.tedd.an@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <768826DA-51CF-4EA2-B582-89BFE843EBAE@holtmann.org>
References: <20211216210958.62129-1-hj.tedd.an@gmail.com>
 <B5187291-3173-4BFB-8465-25AB75BA328E@holtmann.org>
 <39a9b9c68cdb9fbf32f3c6023c0272b53d37d668.camel@intel.com>
To:     "An, Tedd" <tedd.an@intel.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

>>> This patch fixes the broken LED quirk for Intel legacy ROM devices.
>>> To fix the LED issue that doesn't turn off immediately, the host sends
>>> the SW RFKILL command while shutting down the interface and it puts the
>>> devices in an asserted state.
>>> 
>>> Once the device is in SW RFKILL state, it can only accept HCI_Reset to
>>> exit from the SW RFKILL state. This patch checks the quirk and sends the
>>> HCI_Reset before sending the HCI_Intel_Read_Version command.
>>> 
>>> The affected legacy ROM devices are
>>> - 8087:0a2a
>>> - 8087:0aa7
>>> 
>>> fixes: ffcba827c0a1d ("Bluetooth: btintel: Fix the LED is not turning off
>>> immediately")
>>> 
>>> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
>>> ---
>>> drivers/bluetooth/btintel.c | 13 ++++++-------
>>> drivers/bluetooth/btusb.c   | 10 ++++++++--
>>> 2 files changed, 14 insertions(+), 9 deletions(-)
>>> 
>>> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
>>> index e1f96df847b8..75f8d7aceb35 100644
>>> --- a/drivers/bluetooth/btintel.c
>>> +++ b/drivers/bluetooth/btintel.c
>>> @@ -2355,8 +2355,13 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>>>          * As a workaround, send HCI Reset command first which will reset the
>>>          * number of completed commands and allow normal command processing
>>>          * from now on.
>>> +        *
>>> +        * For INTEL_BROKEN_LED, these devices have an issue with LED which
>>> +        * doesn't go off immediately during shutdown. Set the flag here to
>>> send
>>> +        * the LED OFF command during shutdown.
>>>          */
>>> -       if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD)) {
>>> +       if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD) ||
>>> +                               btintel_test_flag(hdev, INTEL_BROKEN_LED)) {
>>>                 skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
>>>                                      HCI_INIT_TIMEOUT);
>>>                 if (IS_ERR(skb)) {
>>> @@ -2428,12 +2433,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>>>                                 set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
>>>                                         &hdev->quirks);
>>> 
>>> -                       /* These devices have an issue with LED which doesn't
>>> -                        * go off immediately during shutdown. Set the flag
>>> -                        * here to send the LED OFF command during shutdown.
>>> -                        */
>>> -                       btintel_set_flag(hdev, INTEL_BROKEN_LED);
>>> -
>>>                         err = btintel_legacy_rom_setup(hdev, &ver);
>>>                         break;
>>>                 case 0x0b:      /* SfP */
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index d1bd9ee0a6ab..c6a070d5284f 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -60,6 +60,7 @@ static struct usb_driver btusb_driver;
>>> #define BTUSB_WIDEBAND_SPEECH   0x400000
>>> #define BTUSB_VALID_LE_STATES   0x800000
>>> #define BTUSB_QCA_WCN6855       0x1000000
>>> +#define BTUSB_INTEL_BROKEN_LED 0x2000000
>>> #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
>>> 
>>> static const struct usb_device_id btusb_table[] = {
>>> @@ -382,9 +383,11 @@ static const struct usb_device_id blacklist_table[] = {
>>>         { USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
>>>         { USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
>>>                                                     
>>> BTUSB_INTEL_BROKEN_INITIAL_NCMD },
>>> -       { USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
>>> +       { USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
>>> +                                                    BTUSB_INTEL_BROKEN_LED },
>>>         { USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
>>> -       { USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED },
>>> +       { USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
>>> +                                                    BTUSB_INTEL_BROKEN_LED },
>>>         { USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED },
>> 
>> this is the part that I tried to avoid.
> 
> I remembered it but I couldn't find any other way. 
> 
> I already tried the method below but it didn't work especially for the reboot
> (warm boot) case becase the platform keeps the USB power while rebooting the
> system and BT device is still in the SW RFKILL state. 
> The flag sets in the btintel_shutdown_combined() doesn't stay because the HDEV
> and the driver data are freed and allocated again while rebooting. So the
> intel_flag_test_and_clear(INTEL_SHUTDOWN_EXECUTED) is never TRUE.

this is the part that I don’t grok. So how do we reset the USB power while still keeping it. Does this mean we see a USB Disconnect and USB Reconnect happening, but the second time around we enter btusb_probe() we come from a total different state?

And how does it make sense that calling hdev->shutdown() ends up in btusb_remove() + btusb_probe(). I am confused.

Regards

Marcel

