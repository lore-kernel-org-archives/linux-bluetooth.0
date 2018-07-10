Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 10 Jul 2018 18:02:31 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Rob Herring <robh@kernel.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
 rtatiya@codeaurora.org, hemantg@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 1/7] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
In-Reply-To: <20180705204250.GA30484@rob-hp-laptop>
References: <20180705165515.13340-1-bgodavar@codeaurora.org>
 <20180705165515.13340-2-bgodavar@codeaurora.org>
 <20180705204250.GA30484@rob-hp-laptop>
Message-ID: <afafe6e8055477020376f65dd14cc346@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rob,

On 2018-07-06 02:12, Rob Herring wrote:
> On Thu, Jul 05, 2018 at 10:25:09PM +0530, Balakrishna Godavarthi wrote:
>> This patch enables regulators for the Qualcomm Bluetooth wcn3990
>> controller.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> Changes in v9:
>>     * updated with latest reg handle and names.
>>     * updated max-speed definition.
>> 
>> Changes in v8:
>>     * Separated the optional entries between two chips
>> 
>> Changes in v7:
>>     * no change.
>> 
>> Changes in v6:
>> 
>>     * Changed the oper-speed to max-speed.
>> 
>> Changes in v5:
>> 
>>     * Added entry for oper-speed and init-speed.
>> 
>> ---
>>  .../bindings/net/qualcomm-bluetooth.txt       | 28 
>> +++++++++++++++++--
>>  1 file changed, 26 insertions(+), 2 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt 
>> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> index 0ea18a53cc29..ced58575e2b8 100644
>> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> @@ -10,12 +10,22 @@ device the slave device is attached to.
>>  Required properties:
>>   - compatible: should contain one of the following:
>>     * "qcom,qca6174-bt"
>> +   * "qcom,wcn3990-bt"
>> +
>> +Optional properties for compatible string qcom,qca6174-bt:
>> 
>> -Optional properties:
>>   - enable-gpios: gpio specifier used to enable chip
>>   - clocks: clock provided to the controller (SUSCLK_32KHZ)
>> 
>> -Example:
>> +Optional properties for compatible string qcom,wcn3990-bt:
>> +
>> + - vddio-supply: Bluetooth wcn3990 VDD_IO supply regulator handle.
>> + - vddxo-supply: Bluetooth wcn3990 VDD_XO supply regulator handle.
>> + - vddrf-supply: Bluetooth wcn3990 VDD_RF supply regulator handle.
>> + - vddch0-supply: Bluetooth wcn3990 VDD_CH0 supply regulator handle.
>> + - max-speed: see 
>> Documentation/devicetree/bindings/serial/slave-device.txt
>> +
>> +Examples:
>> 
>>  serial@7570000 {
>>  	label = "BT-UART";
>> @@ -28,3 +38,17 @@ serial@7570000 {
>>  		clocks = <&divclk4>;
>>  	};
>>  };
>> +
>> +serial@898000 {
>> +	label = "BT-UART";
> 
> label is generally intended for when you need to identify the physical
> connector which wouldn't apply here.
> 
>> +	status = "okay";
> 
> Don't show status in examples.
> 
>> +
>> +	bluetooth {
>> +		compatible = "qcom,wcn3990-bt";
>> +		vddio-supply = <&vreg_s4a_1p8>;
>> +		vddxosupply = <&vreg_l7a_1p8>;
> 
> Typo.
> 
> With those fixed,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
>> +		vddrf-supply = <&vreg_l17a_1p3>;
>> +		vddch0-supply = <&vreg_l25a_3p3>;
>> +		max-speed = <3200000>;
>> +	};
>> +};
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" 
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks for reviewing patch. will update those.

-- 
Regards
Balakrishna.
