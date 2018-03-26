Return-Path: <thierry.escande@linaro.org>
Subject: Re: [PATCH v5 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, David Brown
 <david.brown@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Loic Poulain <loic.poulain@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20180320032331.29865-1-thierry.escande@linaro.org>
 <20180320032331.29865-3-thierry.escande@linaro.org>
 <FAC61078-6298-47A7-A51C-73D72BEF6E4A@holtmann.org>
From: Thierry Escande <thierry.escande@linaro.org>
Message-ID: <a1105b78-c871-df4a-c277-355d20d79d87@linaro.org>
Date: Mon, 26 Mar 2018 18:45:10 +0200
MIME-Version: 1.0
In-Reply-To: <FAC61078-6298-47A7-A51C-73D72BEF6E4A@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 20/03/2018 16:58, Marcel Holtmann wrote:
> Hi Thierry,
> 
>> Add binding document for serial bluetooth chips using Qualcomm protocol.
>>
>> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
>> ---
>>
>> v5:
>> - Rename 'bt-disable-n' gpio as 'enable'
>>
>> v4:
>> - Move bt-disable-n-gpios to required properties section
>> - Add clocks and pinctrl-0 as required properties
>>
>> v3: no change
>> v2: no change
>>
>> .../devicetree/bindings/net/qualcomm-bluetooth.txt | 34 ++++++++++++++++++++++
>> 1 file changed, 34 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> new file mode 100644
>> index 000000000000..bbc2973634b2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> @@ -0,0 +1,34 @@
>> +Qualcomm Bluetooth Chips
>> +---------------------
>> +
>> +This documents the binding structure and common properties for serial
>> +attached Qualcomm devices.
>> +
>> +Serial attached Qualcomm devices shall be a child node of the host UART
>> +device the slave device is attached to.
>> +
>> +Required properties:
>> + - compatible: should contain one of the following:
>> +   * "qcom,qca6174-bt"
>> + - enable-gpios: gpio specifier used to enable chip
>> + - pinctrl-0: pin phandle for bt_en gpio
>> + - clocks: clock phandle for SUSCLK_32KHZ
> 
> if I compare this with broadcom-bluetooth.txt or ti-bluetooth.txt then besides compatible, everything else is optional. The nokia-bluetooth.txt has everything required, but that is also a really specific platform.
> 
> Can we be less restrictive for a QCA general purpose chip?
Ok. To me, at least the enable gpio seems required.

> 
>> +
>> +Example:
>> +
>> +serial@7570000 {
>> +	pinctrl-names = "default", "sleep";
>> +	pinctrl-0 = <&blsp1_uart1_default>;
>> +	pinctrl-1 = <&blsp1_uart1_sleep>;
>> +
>> +	bluetooth {
>> +		compatible = "qcom,qca6174-bt";
>> +
>> +		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&bt_en_pin_a>;
> 
> This one I do not understand and you might want to shed some light into why this is done that way.
Sure. It reclaims this gpio pin for this device. Will add it to the 
documentation.

> 
>> +
>> +		clocks = <&divclk4>;
> 
> No clock-names?
No need for a name as there is only one clk obtained by passing a NULL 
id to devm_gpiod_get().

Regards,
Thierry

> 
> Regards
> 
> Marcel
> 
