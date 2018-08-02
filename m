Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 02 Aug 2018 23:24:52 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
 rtatiya@codeaurora.org, hemantg@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v12 1/7] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
In-Reply-To: <20180802172043.GN68975@google.com>
References: <20180802132518.8680-1-bgodavar@codeaurora.org>
 <20180802132518.8680-2-bgodavar@codeaurora.org>
 <20180802172043.GN68975@google.com>
Message-ID: <366e23679cabb332b1ecde8396570f66@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

On 2018-08-02 22:50, Matthias Kaehlcke wrote:
> On Thu, Aug 02, 2018 at 06:55:12PM +0530, Balakrishna Godavarthi wrote:
>> This patch enables regulators for the Qualcomm Bluetooth wcn3990
>> controller.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  .../bindings/net/qualcomm-bluetooth.txt       | 26 
>> +++++++++++++++++--
>>  1 file changed, 24 insertions(+), 2 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt 
>> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> index 0ea18a53cc29..2175174415ee 100644
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
> 
> Are these really optional? If I understand correctly the driver
> expects the regulators to be there. Even if it could do with only some
> regulators specified the devm_regulator_bulk_get() call would fail if
> not all requested regulators are available.

yes they are required along with compatible string "qcom,wcn3990-bt".
i have taken reference wrt compatible string "qcom,qca6174-bt".
In which clocks and enable-gpios are required for driver to work, but it 
was written as optional in doc.

below snippet from hci_qca.c for qcom,qca6174-bt.

  if (IS_ERR(qcadev->bt_en)) {
        dev_err(&serdev->dev, "failed to acquire enable gpio\n");
        return PTR_ERR(qcadev->bt_en);
     }

   qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
   if (IS_ERR(qcadev->susclk)) {
       dev_err(&serdev->dev, "failed to acquire clk\n");
        return PTR_ERR(qcadev->susclk);
      }


-- 
Regards
Balakrishna.
