Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFBinCBNro18Ak3h1fHFpAioDzimh5KcUeOE8PjQr_CCkAs7PA@mail.gmail.com>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
 <20180101204217.26165-3-martin.blumenstingl@googlemail.com>
 <2A1D60F1-F86F-4A2B-A43A-F3419506DE99@holtmann.org> <CAFBinCBNro18Ak3h1fHFpAioDzimh5KcUeOE8PjQr_CCkAs7PA@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 3 Jan 2018 13:07:28 -0600
Message-ID: <CAL_JsqLRkicv0p8ur==mq3bCp6Sn7b41M+CoFYx_qrhcdsY9Qg@mail.gmail.com>
Subject: Re: [RFC v2 2/9] dt-bindings: net: bluetooth: add support for Realtek
 Bluetooth chips
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, devicetree <devicetree@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, linux-amlogic@lists.infradead.org,
	Larry Finger <Larry.Finger@lwfinger.net>, Carlo Caione <carlo@endlessm.com>,
	Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jan 2, 2018 at 3:10 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> Hi Marcel,
>
> On Tue, Jan 2, 2018 at 12:16 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Martin,
>>
>>> This adds the documentation for Bluetooth functionality of the Realtek
>>> RTL8723BS and RTL8723DS.
>>> Both are SDIO wifi chips with an additional Bluetooth module which is
>>> connected via UART to the host.
>>>
>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> ---
>>> .../devicetree/bindings/net/realtek-bluetooth.txt  | 41 ++++++++++++++++++++++
>>> 1 file changed, 41 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
>>> new file mode 100644
>>> index 000000000000..1491329c4cd1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
>>> @@ -0,0 +1,41 @@
>>> +Realtek Bluetooth Chips
>>> +-----------------------
>>> +
>>> +This documents the binding structure and common properties for serial
>>> +attached Realtek devices.
>>> +
>>> +Serial attached Realtek devices shall be a child node of the host UART
>>> +device the slave device is attached to. See ../serial/slave-device.txt
>>> +for more information
>>> +
>>> +Required properties:
>>> +- compatible: should contain one of the following:
>>> +    * "realtek,rtl8723bs-bluetooth"
>>> +    * "realtek,rtl8723ds-bluetooth"
>>> +
>>> +Optional properties:
>>> +- realtek,config-data: Bluetooth chipset configuration data which is
>>> +                     needed for communication (it typically contains
>>> +                     board specific settings like the baudrate and
>>> +                     whether flow-control is used).
>>> +                     This is an array of u8 values.
>>
>> any chance we can at least include the basic format of these config blobs. And I prefer at least an ACK from Rob here.
> with including the basic format you mean a description that the config
> blob should start with 0x55 0xab 0x23 0x87 (which translates to:
> 0x8723ab55)?

That and the size if it is fixed (or fixed per compatible). Also,
would be useful to state what are the defaults if not present.

If it is all documented somewhere else, a pointer to that is fine.

> I think all non-trivial dt-binding patches should be ACKed by the DT
> maintainers, so waiting for Rob's ACK is perfectly fine for me
>
>>> +- enable-gpios: GPIO specifier, used to enable/disable the BT module
>>> +- reset-gpios: GPIO specifier, used to reset the BT module

These should state active high or low.

Rob
