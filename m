Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC71C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 17:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0631613C0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 17:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbhEFRYr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 May 2021 13:24:47 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:29361 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbhEFRYp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 May 2021 13:24:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620321826; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=PkvnuSL03SDpw2bV221k6yrIiH+aU95lV8M60p0fhZU=;
 b=SdWpd/Re1NYnNeLTwnbI9XZChIhJrqJenTLxjfvH++H55hfI51i62rkd7Qh96gtR1P64JdxS
 TUo8lfmEyqWbv/95DHZpI4PjCicB9zfVqggRgFGUopgp+w5QoNt8xrzrxeBLIodYNsQqRQDp
 q9zyp8gT3uJLmF9nsfe1vvt+y1E=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6094260e853c0a2c468082ec (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 May 2021 17:23:26
 GMT
Sender: gubbaven=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8B216C43145; Thu,  6 May 2021 17:23:25 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: gubbaven)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32BF1C4338A;
        Thu,  6 May 2021 17:23:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 May 2021 22:53:22 +0530
From:   gubbaven@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        rjliao@codeaurora.org, hbandi@codeaurora.org,
        abhishekpandit@chromium.org
Subject: Re: [PATCH v2 2/3] dt-bindings: net: bluetooth: Convert to DT schema
In-Reply-To: <YH924M62b7PDd/r6@google.com>
References: <1618936010-16579-1-git-send-email-gubbaven@codeaurora.org>
 <1618936010-16579-3-git-send-email-gubbaven@codeaurora.org>
 <YH924M62b7PDd/r6@google.com>
Message-ID: <6eb5084aa89b7d2c26e41642b4fe56e1@codeaurora.org>
X-Sender: gubbaven@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Matthias,
On 2021-04-21 06:20, Matthias Kaehlcke wrote:
> On Tue, Apr 20, 2021 at 09:56:49PM +0530, Venkata Lakshmi Narayana 
> Gubba wrote:
> 
>> Subject: dt-bindings: net: bluetooth: Convert to DT schema
> 
> This doesn't convert the generic binding or all bindings to DT schema
> as the subject suggests, but the Qualcomm BT binding.
> 
[Venkata]:
I will update in next patchset.
>> 
>> Converted Qualcomm Bluetooth binidings to DT schema.
>> 
>> Signed-off-by: Venkata Lakshmi Narayana Gubba 
>> <gubbaven@codeaurora.org>
>> ---
>>  .../devicetree/bindings/net/qualcomm-bluetooth.txt | 69 
>> -----------------
>>  .../bindings/net/qualcomm-bluetooth.yaml           | 87 
>> ++++++++++++++++++++++
>>  2 files changed, 87 insertions(+), 69 deletions(-)
>>  delete mode 100644 
>> Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>>  create mode 100644 
>> Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt 
>> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> deleted file mode 100644
>> index 709ca6d..0000000
>> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> +++ /dev/null
>> @@ -1,69 +0,0 @@
>> -Qualcomm Bluetooth Chips
>> ----------------------
>> -
>> -This documents the binding structure and common properties for serial
>> -attached Qualcomm devices.
>> -
>> -Serial attached Qualcomm devices shall be a child node of the host 
>> UART
>> -device the slave device is attached to.
>> -
>> -Required properties:
>> - - compatible: should contain one of the following:
>> -   * "qcom,qca6174-bt"
>> -   * "qcom,qca9377-bt"
>> -   * "qcom,wcn3990-bt"
>> -   * "qcom,wcn3991-bt"
>> -   * "qcom,wcn3998-bt"
>> -   * "qcom,qca6390-bt"
>> -
>> -Optional properties for compatible string qcom,qca6174-bt:
>> -
>> - - enable-gpios: gpio specifier used to enable chip
>> - - clocks: clock provided to the controller (SUSCLK_32KHZ)
>> - - firmware-name: specify the name of nvm firmware to load
>> -
>> -Optional properties for compatible string qcom,qca9377-bt:
>> -
>> - - max-speed: see 
>> Documentation/devicetree/bindings/serial/serial.yaml
>> -
>> -Required properties for compatible string qcom,wcn399x-bt:
>> -
>> - - vddio-supply: VDD_IO supply regulator handle.
>> - - vddxo-supply: VDD_XO supply regulator handle.
>> - - vddrf-supply: VDD_RF supply regulator handle.
>> - - vddch0-supply: VDD_CH0 supply regulator handle.
>> -
>> -Optional properties for compatible string qcom,wcn399x-bt:
>> -
>> - - max-speed: see 
>> Documentation/devicetree/bindings/serial/serial.yaml
>> - - firmware-name: specify the name of nvm firmware to load
>> - - clocks: clock provided to the controller
>> -
>> -Examples:
>> -
>> -serial@7570000 {
>> -	label = "BT-UART";
>> -	status = "okay";
>> -
>> -	bluetooth {
>> -		compatible = "qcom,qca6174-bt";
>> -
>> -		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
>> -		clocks = <&divclk4>;
>> -		firmware-name = "nvm_00440302.bin";
>> -	};
>> -};
>> -
>> -serial@898000 {
>> -	bluetooth {
>> -		compatible = "qcom,wcn3990-bt";
>> -
>> -		vddio-supply = <&vreg_s4a_1p8>;
>> -		vddxo-supply = <&vreg_l7a_1p8>;
>> -		vddrf-supply = <&vreg_l17a_1p3>;
>> -		vddch0-supply = <&vreg_l25a_3p3>;
>> -		max-speed = <3200000>;
>> -		firmware-name = "crnv21.bin";
>> -		clocks = <&rpmhcc RPMH_RF_CLK2>;
>> -	};
>> -};
>> diff --git 
>> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml 
>> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
>> new file mode 100644
>> index 0000000..55cd995
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
>> @@ -0,0 +1,87 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/qualcomm-bluetooth.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Bluetooth Chips
>> +
>> +maintainers:
>> +  - Rob Herring <robh@kernel.org>
>> +  - Marcel Holtmann <marcel@holtmann.org>
>> +
>> +description:
>> +  This binding describes Qualcomm UART-attached bluetooth chips.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,qca6174-bt
>> +      - qcom,qca9377-bt
>> +      - qcom,wcn3990-bt
>> +      - qcom,wcn3991-bt
>> +      - qcom,wcn3998-bt
>> +      - qcom,qca6390-bt
> 
> delete trailing blanks
> 
[Venkata]:
I will update in next patchset.
>> +
>> +  enable-gpios:
>> +    maxItems: 1
>> +    description: gpio specifier used to enable chip
>> +
> 
> delete blanks
> 
[Venkata]:
I will update in next patchset.
>> +  clocks:
>> +    maxItems: 1
>> +    description: clock provided to the controller (SUSCLK_32KHZ)
>> +
>> +  vddio-supply:
>> +    description: VDD_IO supply regulator handle
>> +
>> +  vddxo-supply:
>> +    description: VDD_XO supply regulator handle
>> +
>> +  vddrf-supply:
>> +    description: VDD_RF supply regulator handle
>> +
>> +  vddch0-supply:
>> +    description: VDD_CH0 supply regulator handle
>> +
>> +  max-speed:
> 
> delete trailing blank
> 
[Venkata]:
I will update in next patchset.
>> +    description: see 
>> Documentation/devicetree/bindings/serial/serial.yaml
>> +
>> +  firmware-name:
>> +    description: specify the name of nvm firmware to load
>> +
>> +  local-bd-address:
>> +    description: see 
>> Documentation/devicetree/bindings/net/bluetooth.txt
>> +
>> +
>> +required:
>> +  - compatible
> 
> it seems you could make the supplies conditionally required based on 
> the
> compatible string. See
> Documentation/devicetree/bindings/connector/usb-connector.yaml
> for an example
> 
[Venkata]:
I will update in next patchset
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    uart {
>> +        label = "BT-UART";
>> +        status = "okay";
>> +
>> +        bluetooth {
>> +            compatible = "qcom,qca6174-bt";
>> +            enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
>> +            clocks = <&divclk4>;
>> +            firmware-name = "nvm_00440302.bin";
>> +        };
>> +    };
>> +  - |
>> +    uart {
>> +
>> +        bluetooth {
>> +            compatible = "qcom,wcn3990-bt";
>> +            vddio-supply = <&vreg_s4a_1p8>;
>> +            vddxo-supply = <&vreg_l7a_1p8>;
>> +            vddrf-supply = <&vreg_l17a_1p3>;
>> +            vddch0-supply = <&vreg_l25a_3p3>;
>> +            max-speed = <3200000>;
>> +            firmware-name = "crnv21.bin";
> 
> delete trailing blanks
[Venkata]:
I will update in next patchset.

Regards,
Venkata.
