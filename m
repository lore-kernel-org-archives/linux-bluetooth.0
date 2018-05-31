Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 01/13] dt-bindings: net: bluetooth: add support for
 Realtek Bluetooth chips
To: Rob Herring <robh@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jeremy Cline <jeremy@jcline.org>, linux-bluetooth@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20180527190457.2632-1-hdegoede@redhat.com>
 <20180527190457.2632-2-hdegoede@redhat.com>
 <7A22F14E-9F45-4779-B7E5-CEB330A5601E@holtmann.org>
 <16b7e10b-6816-f441-00e5-9e86d1df33a7@redhat.com>
 <20180531164214.GA12210@rob-hp-laptop>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <0d99e890-b93c-df55-ae43-8fc910778243@redhat.com>
Date: Thu, 31 May 2018 22:50:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180531164214.GA12210@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 31-05-18 18:42, Rob Herring wrote:
> On Wed, May 30, 2018 at 10:04:37AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 30-05-18 08:42, Marcel Holtmann wrote:
>>> Hi Hans,
>>>
>>>> This adds the documentation for Bluetooth functionality of the Realtek
>>>> RTL8723BS and RTL8723DS.
>>>> Both are SDIO wifi chips with an additional Bluetooth module which is
>>>> connected via UART to the host.
>>>>
>>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>>> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>> .../bindings/net/realtek-bluetooth.txt        | 41 +++++++++++++++++++
>>>> 1 file changed, 41 insertions(+)
>>>> create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
>>>> new file mode 100644
>>>> index 000000000000..1491329c4cd1
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
>>>> @@ -0,0 +1,41 @@
>>>> +Realtek Bluetooth Chips
>>>> +-----------------------
>>>> +
>>>> +This documents the binding structure and common properties for serial
>>>> +attached Realtek devices.
>>>> +
>>>> +Serial attached Realtek devices shall be a child node of the host UART
>>>> +device the slave device is attached to. See ../serial/slave-device.txt
>>>> +for more information
>>>> +
>>>> +Required properties:
>>>> +- compatible: should contain one of the following:
>>>> +    * "realtek,rtl8723bs-bluetooth"
>>>> +    * "realtek,rtl8723ds-bluetooth"
>>>> +
>>>> +Optional properties:
>>>> +- realtek,config-data: Bluetooth chipset configuration data which is
>>>> +			needed for communication (it typically contains
>>>> +			board specific settings like the baudrate and
>>>> +			whether flow-control is used).
>>>> +			This is an array of u8 values.
>>>> +- enable-gpios: GPIO specifier, used to enable/disable the BT module
>>>> +- reset-gpios: GPIO specifier, used to reset the BT module
>>>> +
>>>> +
>>>> +Example:
>>>> +
>>>> +&uart {
>>>> +	...
>>>> +
>>>> +	bluetooth {
>>>> +		compatible = "realtek,rtl8723bs-bluetooth";
>>>> +		enable-gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
>>>> +		reset-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
>>>> +		realtek,config-data = /bits/ 8 <
>>>> +			0x55 0xab 0x23 0x87 0x29 0x00 0xf4 0x00 0x01 0x01 0xf6 0x00
>>>> +			0x02 0x81 0x00 0xfa 0x00 0x02 0x12 0x80 0x0c 0x00 0x10 0x02
>>>> +			0x80 0x92 0x04 0x50 0xc5 0xea 0x19 0xe1 0x1b 0xfd 0xaf 0x5f
>>>> +			0x01 0xa4 0x0b 0xd9 0x00 0x01 0x0f 0xe4 0x00 0x01 0x08>;
>>>> +	};
>>>> +};
>>>
>>> we actually need to agree on this config-data. As I wrote in an earlier email some time ago, the actual config-data files are just memory portions that will overload the default config area. I wrote tools/rtlfw.c to parse these.
>>>
>>> So now I wonder if we can just read the current configuration and run with that when no extra blob is provided. That way it would always work and we might just give the config-data filename here. Mostly this is the for PCM and UART settings anyway.
>>
>> I've been thinking about this too and 2 different solutions come to mind.
>>
>> Note this is all x86 specific, I think it best to solve this for x86 first
>> and then we can apply the lessons learned there to ARM/devicetree when
>> someone comes along who wants to hook-up things on ARM.
>>
>> My first idea was to stick with a config blob using the firmware_load
>> mechanism, but to add a postfix to the filename based on the ACPI
>> HID (hardware-id) of the serdev device, so in practice this means
>> we would try to load:
>>
>> /lib/firmware/rtl_bt/rtl8723bs_config-OBDA8723.bin
>>
>> On most x86 devices, so far all my testing on a bunch of different
>> devices has shown that the same config works for all x86 devices
>> (I took the config from a Chuwi Vi8 tablet which uses 3000000bps
>> + hardware flowcontrol).
>>
>> This way we can put the config in linux-firmware, without it
>> getting loaded on ARM boards where it might very well be wrong.
>>
>>
>> My second idea is to include a default config inside the driver,
>> which can be optionally overridden by a file in
>> /lib/firmware/rtl_bt and/or dt. Combined with module-options to
>> override the baudrate and flowcontrol setting (and patch the
>> builtin config accordingly).
>>
>>
>> Your idea to read back the config from the device is also
>> interesting, but I don't think that will gain us anything because
>> AFAIK the whole purpose of the board specific config file
>> bits is that the chip lack eeprom space to store this info,
>> so we will just always get some generic defaults.
>>
>>
>> I've run your rtlfw tool on a bunch of different config files and
>> there are a lot of unknown fields, and even of the known fields
>> I don't think we understand all the bits. So all in all the
>> config file is a bit of a black box and as such I believe it
>> would be best to just treat it as such and I personally
>> prefer my first idea, which is to add a postfix to the
>> firmware filename request, so on x86 load:
>>
>> /lib/firmware/rtl_bt/rtl8723bs_config-OBDA8723.bin
>>
>> And on devicetree we could postfix things with the machine
>> model string (as returned by  of_flat_dt_get_machine_name())
> 
> If the firmware file is going to depend on the DT, then you might as
> well just put the data into the DT.

Ok, note we don't need the entire firmware in DT, just a (binary
format) config file for the firmware. The question is if we are
going to try and break up the info from the config-file and then
regenerate it inside the kernel driver. Or if we are just going
to put the say 60 bytes in DT as an u8 array as the original
binding proposed by Martin Blumenstingl suggests.

Since we only know the meaning for a couple of the bytes in
the file, which is typically 40 - 60 bytes big, I think it
is probably best to just treat it as a blob.

> There's a similar issue on QCom Dragonboards. The WiFi (and BT?)
> firmware files are supposedly board specific, so folks don't want to put
> them into linux-firmware. But it also seems to be unknown as to which
> parts are board specific are not.

In my experience with broadcom and now the rtl8723bs the
actual firmware and the needed config data are separate.

Hmm that is actually no entirely true, for broadcom the
bluetooth patchram file depends on the clockcrystal freq
used on the board, so there are 2 versions of it for a
single chip, 1 for each of the 2 different freqs used.

Regards,

Hans
