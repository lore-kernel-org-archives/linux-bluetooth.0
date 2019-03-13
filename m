Return-Path: <SRS0=EDUn=RQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BDCC43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Mar 2019 20:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFA42075C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Mar 2019 20:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfCMUC2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:02:28 -0400
Received: from mail-gw.thundercloud.uk ([149.255.60.84]:40051 "EHLO
        mail-gw.thundercloud.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfCMUC1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Mar 2019 16:02:27 -0400
Received: from mailbsf01.thundercloud.uk (mail-gw.thundercloud.uk [149.255.60.72])
        by mail-gw.thundercloud.uk (Postfix) with ESMTPS id 1F10060197F0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2019 20:02:26 +0000 (GMT)
X-ASG-Debug-ID: 1552507345-05541312671170150001-Y6scnF
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net [149.255.62.7]) by mailbsf01.thundercloud.uk with ESMTP id lCT9rzaFFsf53QaJ (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 13 Mar 2019 20:02:25 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
Received: from [81.174.179.112] (port=43874 helo=[192.168.2.187])
        by cloud706.unlimitedwebhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <beagleboard@davidjohnsummers.uk>)
        id 1h4A52-000Mhe-8j; Wed, 13 Mar 2019 20:02:24 +0000
Subject: Re: [PATCH v3 3/3] arm: dts: rk3288-tinker.dtsi: Add outline
 Bluetooth support
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190309153923.22806-1-beagleboard@davidjohnsummers.uk>
 <20190309153923.22806-3-beagleboard@davidjohnsummers.uk>
 <4537885.W6WcYDDAQ4@diego>
X-ASG-Orig-Subj: Re: [PATCH v3 3/3] arm: dts: rk3288-tinker.dtsi: Add outline
 Bluetooth support
Cc:     linux-bluetooth@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
From:   David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <f71f537d-f7d3-dda8-a960-13dd442d75c4@davidjohnsummers.uk>
Date:   Wed, 13 Mar 2019 20:02:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <4537885.W6WcYDDAQ4@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-PH
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud706.unlimitedwebhosting.co.uk
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - davidjohnsummers.uk
X-Get-Message-Sender-Via: cloud706.unlimitedwebhosting.co.uk: authenticated_id: davidjoh/from_h
X-Authenticated-Sender: cloud706.unlimitedwebhosting.co.uk: beagleboard@davidjohnsummers.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Barracuda-Connect: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Start-Time: 1552507345
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at thundercloud.uk
X-Barracuda-Scan-Msg-Size: 3380
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 1.21
X-Barracuda-Spam-Status: No, SCORE=1.21 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=MISSING_HEADERS
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.68563
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        1.21 MISSING_HEADERS        Missing To: header
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 13/03/2019 10:56, Heiko Stübner wrote:
> Hi David,
>
> Am Samstag, 9. März 2019, 16:39:23 CET schrieb David Summers:
>> This patch is an outline for bluetooth on the ASUS Tinker Board (S).
>>
>> Bluetooth is provided my RTL8723BS on these machine, and this is wired
>> into UART0.
>>
>> Here this is performed as a SerDev device.
>>
>> Now as presented, this does not give functioning bluetooth. The
>> updates needed to the device driver:
>>
>> https://www.spinics.net/lists/linux-bluetooth/msg78661.html
>>
>> Haven't yet been accepted. So this device tree hook doesn't yet have
>> "realtek,rtl8723bs-bt" compatible flag.
>>
>> It is however still submitted as a patch, as it sets the UART up
>> correctly. And so basic communciation can be had with the device. This
>> has been confirmed by Tony McKahan @ Armbian, in particular that the
>> CTS/RTS is needed.
>>
>> When Vasily patch is accepted, this will be added as a minor patch on
>> top of this patch; as this patch gives the pins needed.
>>
>> The one oddity, is the RESET pin, it is labeled this way on the
>> schematic. However the hci_h5.c driver calls this ENABLE. Here we have
>> stuck with the schematic name.
>>
>> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
>> ---
>>   arch/arm/boot/dts/rk3288-tinker.dtsi | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi
>> b/arch/arm/boot/dts/rk3288-tinker.dtsi index 0ffab1b7c940..d29f5b34d7e6
>> 100644
>> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
>> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
>> @@ -486,6 +486,17 @@
>>
>>   &uart0 {
>>   	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>, <&uart0_rts>;
>> +
>> +	bluetooth {
>> +		clocks = <&rk808 RK808_CLKOUT1>;
>> +		reset-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
>> +		device-wake-gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
>> +		host-wake-gpios = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
>> +		vcc-18-supply = <&vcc_18>;
>> +		vcc-io-supply = <&vcc_io>;
>> +	};
> As this is supposed to work as serial attached device it should follow a
> dt-binding, so first of all definitly needs a compatible and a binding
> specifying all the properties declared above.
>
> See for example Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> for a similar device.
>
> Heiko
>
>
Heiko,

Yes I understand. Means I'll need to take care not to loose these email, 
as getting all the pins right took some time ...

I'll probably follow 
https://www.spinics.net/lists/linux-bluetooth/msg78654.html if it gets 
accepted. That is the main problem here, at the moment there is no 
compatible that can be used, as none yet accepted.

Rob H, Question for you, before you said [1]:

> There's no interrupts, GPIO control lines, power supplies, etc. for
> these chips? The binding should be complete even if your platform
> doesn't need these.
Now its clear that so far the driver for bluetooth doesn't know about 
supply, and clocks etc.

So should these be included in the dts, as a correct description as how 
its wired; even if not used in the current driver, they may be used in 
future.

Am happy to do whatever best.

Regards,

David.

[1] https://www.spinics.net/lists/linux-bluetooth/msg78545.html


