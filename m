Return-Path: <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add optional nvmem MAC address bindings
 to ti,wlink-st
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: David Lechner <david@lechnology.com>, devicetree@vger.kernel.org,
 linux-bluetooth@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1512357682-8911-1-git-send-email-david@lechnology.com>
 <1512357682-8911-2-git-send-email-david@lechnology.com>
 <2dfb7130-e229-7429-0f30-11d7df553fdf@cogentembedded.com>
Message-ID: <f50b5810-31ca-6ce8-ba1e-0484a3dd1d89@cogentembedded.com>
Date: Mon, 4 Dec 2017 13:09:43 +0300
MIME-Version: 1.0
In-Reply-To: <2dfb7130-e229-7429-0f30-11d7df553fdf@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 12/4/2017 12:54 PM, Sergei Shtylyov wrote:

>> This adds optional nvmem consumer properties to the ti,wlink-st device tree
>> bindings to allow specifying the Bluetooth MAC address.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   Documentation/devicetree/bindings/net/ti,wilink-st.txt | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/ti,wilink-st.txt 
>> b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
>> index 1649c1f..24eb897 100644
>> --- a/Documentation/devicetree/bindings/net/ti,wilink-st.txt
>> +++ b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
>> @@ -32,6 +32,8 @@ Optional properties:
>>      See ../clocks/clock-bindings.txt for details.
>>    - clock-names : Must include the following entry:
>>      "ext_clock" (External clock provided to the TI combo chip).
>> + - nvmem-cells: phandle to nvmem data cell that contains a MAC address
>> + - nvmem-cell-names: "mac-address" (required when nvmem-cells is specified)
>>   Example:
>> @@ -43,5 +45,7 @@ Example:
>>           enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
>>           clocks = <&clk32k_wl18xx>;
>>           clock-names = "ext_clock";
>> +        nvmem-cells: <&mac_address>
> 
>     s/:/ = /?
> 
>> +        nvmem-cell-names "mac-address"
> 
>     Where's =?

    And ;? :-)

[...]

MBR, Sergei
