Return-Path: <martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <01000162362879ce-d5906360-2001-4c67-b414-07e116a0ef93-000000@email.amazonses.com>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
 <20171117223543.32429-7-martin.blumenstingl@googlemail.com>
 <14831F71-B426-491A-A5B0-7F93533AE78C@holtmann.org> <01000162362879ce-d5906360-2001-4c67-b414-07e116a0ef93-000000@email.amazonses.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 18 Mar 2018 23:52:38 +0100
Message-ID: <CAFBinCCyG368zkAZ8WG8i0ZdNPpyN35vNXOmdEnS++6ppBohQA@mail.gmail.com>
Subject: Re: [RFC v1 6/8] Bluetooth: hci_h5: add support for Realtek UART
 Bluetooth modules
To: Jeremy Cline <jeremy@jcline.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh+dt@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, linux-sunxi@googlegroups.com,
	linux-amlogic@lists.infradead.org, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeremy,

On Sat, Mar 17, 2018 at 11:50 PM, Jeremy Cline <jeremy@jcline.org> wrote:
> Hi Marcel, Martin,
>
> On 03/16/2018 03:22 PM, Marcel Holtmann wrote:
>> Hi Martin,
>>
>>> Realtek RTL8723BS and RTL8723DS are SDIO wifi chips with an embedded
>>> Bluetooth controller which connects to the host via UART.
>>> The H5 protocol is used for communication between host and device.
>>>
>>> The Realtek "rtl8723bs_bt" and "rtl8723ds_bt" userspace Bluetooth UART
>>> initialization tools (rtk_hciattach) use the following sequence:
>>> 1) send H5 sync pattern (already supported by hci_h5)
>>> 2) get LMP version (already supported by btrtl)
>>> 3) get ROM version (already supported by btrtl)
>>> 4) load the firmware and config for the current chipset (already
>>>   supported by btrtl)
>>> 5) read UART settings from the config blob (already supported by btrtl)
>>> 6) send UART settings via a vendor command to the device (which changes
>>>   the baudrate of the device and enables or disables flow control
>>>   depending on the config)
>>> 7) change the baudrate and flow control settings on the host
>>> 8) send the firmware and config blob to the device (already supported by
>>>   btrtl)
>>>
>>> This uses the serdev library as well as the existing btrtl driver to
>>> initialize the Bluetooth functionality, which consists of:
>>> - identifying the device and loading the corresponding firmware and
>>>  config blobs (steps #2, #3 and #4)
>>> - configuring the baudrate and flow control (steps #6 and #7)
>>> - uploading the firmware to the device (step #8)
>>>
>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> ---
>>> drivers/bluetooth/Kconfig  |   1 +
>>> drivers/bluetooth/hci_h5.c | 195 ++++++++++++++++++++++++++++++++++++++++++++-
>>> 2 files changed, 195 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>>> index 60e1c7d6986d..3001f1200c72 100644
>>> --- a/drivers/bluetooth/Kconfig
>>> +++ b/drivers/bluetooth/Kconfig
>>> @@ -146,6 +146,7 @@ config BT_HCIUART_LL
>>> config BT_HCIUART_3WIRE
>>>      bool "Three-wire UART (H5) protocol support"
>>>      depends on BT_HCIUART
>>> +    select BT_RTL if SERIAL_DEV_BUS
>>>      help
>>>        The HCI Three-wire UART Transport Layer makes it possible to
>>>        user the Bluetooth HCI over a serial port interface. The HCI
>>
>> so I just posted a bt3wire.c driver that is serdev only and written from scratch. On a RPi3 Broadcom chip it kinda works. I think there is a lot of extra work to be done, but this might be a better starting point for Realtek UART devices.
>
> I picked up the v2 version of this RFC and rebased it to the latest
> bluetooth-next and added ACPI support. It also kinda works, but there's
> a few problems left to track down and I still haven't looked into
> getting rid of the config blobs.
>
> It sounded like Martin wasn't going to be able to get to this until
> at least the 4.18 cycle, so unless he objects I'm going to look at
> getting what I've got working with that bt3wire.c driver.
please go ahead - I am still busy with other things
thank you for taking this over!


Regards
Martin
