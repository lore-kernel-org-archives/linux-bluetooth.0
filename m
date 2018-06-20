Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 20 Jun 2018 17:03:04 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Rob Herring <robh@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, Thierry
 Escande <thierry.escande@linaro.org>, "open list:BLUETOOTH DRIVERS"
 <linux-bluetooth@vger.kernel.org>, rtatiya@codeaurora.org,
 hemantg@codeaurora.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v7 1/8] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
In-Reply-To: <CAL_JsqL5K-4LBEwS0ag=7M8cOp2nF+mRC+M03BinSj-YR0+b=Q@mail.gmail.com>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
 <20180616062718.29844-2-bgodavar@codeaurora.org>
 <CAL_JsqL5K-4LBEwS0ag=7M8cOp2nF+mRC+M03BinSj-YR0+b=Q@mail.gmail.com>
Message-ID: <ec01ffb8cb16afef0e92d4355f5e839e@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rob,

please find my comments inline.

On 2018-06-18 18:59, Rob Herring wrote:
> On Sat, Jun 16, 2018 at 12:27 AM, Balakrishna Godavarthi
> <bgodavar@codeaurora.org> wrote:
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> 
> Commit messag missing.
> 
[Bala]: my bad, i some how missed. will update.

> Please use get_maintainers.pl and send patches to the right lists. DT
> list in this case.
> 
[Bala]: will find the correct POC.


>> ---
>> Changes in v7:
>>         * no change.
>> 
>> Changes in v6:
>> 
>>         * Changed the oper-speed to max-speed.
>> 
>> Changes in v5:
>> 
>>         * Added entry for oper-speed and init-speed.
>> 
>> ---
>>  .../bindings/net/qualcomm-bluetooth.txt       | 31 
>> +++++++++++++++++--
>>  1 file changed, 29 insertions(+), 2 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt 
>> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> index 0ea18a53cc29..c4590bc87390 100644
>> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> @@ -10,12 +10,24 @@ device the slave device is attached to.
>>  Required properties:
>>   - compatible: should contain one of the following:
>>     * "qcom,qca6174-bt"
>> +   * "qcom,wcn3990-bt"
>> 
>>  Optional properties:
>>   - enable-gpios: gpio specifier used to enable chip
>>   - clocks: clock provided to the controller (SUSCLK_32KHZ)
>> -
>> -Example:
>> + - vddpa-supply: Bluetooth VDD PA regulator handle
>> + - vddio-supply: Bluetooth VDD IO regulator handle
>> + - vddldo-supply: Bluetooth VDD LDO regulator handle. Kept under 
>> optional
>> +                 parameters as some of the chipsets doesn't require 
>> ldo or
>> +                 it may use from same vddio.
> 
> You need to be explicit as to which properties apply or don't apply to
> specific compatible strings.
> 

[Bala]: will update.

> Supplies should be based on inputs to the chip, so if 1 regulator
> supplies 2 inputs you still need both.
> 
[Bala]:  sorry i did't get you, all these regulators are single output 
line regulators.
          i.e. <supply-name>- supply, need single regulator input as a 
handle.
          and these line regulators generate fixed voltage output.
          please let me know, if i have cleared your query

>> + - vddxtal-supply: Bluetooth VDD XTAL regulator handle
>> + - vddcore-supply: Bluetooth VDD CORE regulator handle
>> + - vddpwd-supply: Chip power down gpio is required when bluetooth 
>> module
>> +                 and other modules like wifi co-exist in a singe chip 
>> and
>> +                 shares a common gpio to bring chip out of reset.
>> + - max-speed: operating speed of the chip.
>> +
>> +Examples:
>> 
>>  serial@7570000 {
>>         label = "BT-UART";
>> @@ -28,3 +40,18 @@ serial@7570000 {
>>                 clocks = <&divclk4>;
>>         };
>>  };
>> +
>> +serial@898000 {
>> +       label = "BT-UART";
>> +       status = "okay";
>> +
>> +       bluetooth: bt_wcn3990 {
> 
> Reverse these. The node name should be "bluetooth".
> 
>> +               compatible = "qcom,wcn3990-bt";
>> +               vddio-supply = <&pm8998_s3>;
>> +               vddxtal-supply = <&pm8998_s5>;
>> +               vddcore-supply = <&pm8998_l7>;
>> +               vddpa-supply = <&pm8998_l17>;
>> +               vddldo-supply = <&pm8998_l25>;
>> +               max-speed = <3200000>;
>> +       };
>> +};
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 

Thanks for reviewing, will send a incremental patch.

-- 
Regards
Balakrishna.
