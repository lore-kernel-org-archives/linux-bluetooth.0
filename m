Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 18 May 2018 20:06:03 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Matthias Kaehlcke
 <mka@chromium.org>, BlueZ development <linux-bluetooth@vger.kernel.org>,
 rtatiya@codeaurora.org, hemantg@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
In-Reply-To: <F3C64EA5-D660-41E2-8233-0522D7019CB2@holtmann.org>
References: <1526041263-18795-1-git-send-email-bgodavar@codeaurora.org>
 <1526041263-18795-2-git-send-email-bgodavar@codeaurora.org>
 <F3C64EA5-D660-41E2-8233-0522D7019CB2@holtmann.org>
Message-ID: <4f2dc145c8d1c3a6ab1f94f3180cf058@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 2018-05-11 23:58, Marcel Holtmann wrote:
> Hi Balakrishna,
> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> .../devicetree/bindings/net/qualcomm-bluetooth.txt | 31 
>> ++++++++++++++++++++--
>> 1 file changed, 29 insertions(+), 2 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt 
>> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> index 0ea18a5..63cae49 100644
>> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> @@ -10,12 +10,24 @@ device the slave device is attached to.
>> Required properties:
>>  - compatible: should contain one of the following:
>>    * "qcom,qca6174-bt"
>> +   * "qcom,wcn3990-bt"
>> 
>> Optional properties:
>>  - enable-gpios: gpio specifier used to enable chip
>>  - clocks: clock provided to the controller (SUSCLK_32KHZ)
>> -
>> -Example:
>> + - vddpa-supply: Bluetooth VDD PA regulator handle
>> + - vddio-supply: Bluetooth VDD IO regulator handle
>> + - vddldo-supply: Bluetooth VDD LDO regulator handle. Kept under 
>> optional
>> +		  parameters as some of the chipsets doesn't require ldo or
>> +		  it may use from same vddio.
>> + - vddxtal-supply: Bluetooth VDD XTAL regulator handle
>> + - vddcore-supply: Bluetooth VDD CORE regulator handle
>> + - vddpwd-supply: Chip power down gpio is required when bluetooth 
>> module
>> +		  and other modules like wifi co-exist in a singe chip and
>> +		  shares a common gpio to bring chip out of reset.
>> + - oper-speed: operating speed of the chip.
> 
> we actually agreed on using max-speed for these. And it should
> optional to limit speed for “broken” devices or that have some limit
> because of the platform.
> 
> Regards
> 
> Marcel

will update the same in incremental patch.

-- 
Regards
Balakrishna.
