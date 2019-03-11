Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE92C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 20:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4B92064A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 20:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfCKUs2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:48:28 -0400
Received: from mail-gw.thundercloud.uk ([149.255.60.87]:51667 "EHLO
        mail-gw.thundercloud.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfCKUs1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 16:48:27 -0400
Received: from mailbsf01.thundercloud.uk (mail-gw.thundercloud.uk [149.255.60.72])
        by mail-gw.thundercloud.uk (Postfix) with ESMTPS id 078696014D3A
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2019 20:48:22 +0000 (GMT)
X-ASG-Debug-ID: 1552337299-0554131268100d540001-Y6scnF
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net [149.255.62.7]) by mailbsf01.thundercloud.uk with ESMTP id XMDzCye5HGYX3hBR (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 11 Mar 2019 20:48:19 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
Received: from [87.113.244.251] (port=41718 helo=[192.168.2.187])
        by cloud706.unlimitedwebhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <beagleboard@davidjohnsummers.uk>)
        id 1h3RqM-00017S-Eg; Mon, 11 Mar 2019 20:48:18 +0000
Subject: Re: [PATCH v3 3/3] arm: dts: rk3288-tinker.dtsi: Add outline
 Bluetooth support
To:     Marcel Holtmann <marcel@holtmann.org>
X-ASG-Orig-Subj: Re: [PATCH v3 3/3] arm: dts: rk3288-tinker.dtsi: Add outline
 Bluetooth support
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        frowand.list@gmail.com, Johan Hedberg <johan.hedberg@gmail.com>,
        anarsoul@gmail.com, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190309153923.22806-1-beagleboard@davidjohnsummers.uk>
 <20190309153923.22806-3-beagleboard@davidjohnsummers.uk>
 <C67B8798-ACD1-470B-B69A-650A62AE7982@holtmann.org>
From:   David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <f4cee9a8-8ff5-52f8-7170-d78b6917ca74@davidjohnsummers.uk>
Date:   Mon, 11 Mar 2019 20:48:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <C67B8798-ACD1-470B-B69A-650A62AE7982@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Barracuda-Start-Time: 1552337299
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at thundercloud.uk
X-Barracuda-Scan-Msg-Size: 3859
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.68520
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On 11/03/2019 16:41, Marcel Holtmann wrote:
> Hi David,
>
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
>> arch/arm/boot/dts/rk3288-tinker.dtsi | 11 +++++++++++
>> 1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
>> index 0ffab1b7c940..d29f5b34d7e6 100644
>> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
>> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
>> @@ -486,6 +486,17 @@
>>
>> &uart0 {
>> 	status = "okay";
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
>> };
> I need an ACK from Rob for this and also you might want to send the whole series for me to review in full context.
>
> Regards
>
> Marcel
>
Yes happy to wait for ACK from Rob. Of the 3 patches done this is the 
least urgent, as Bluetooth is currently non functioning on these 
machines, so delay in this doesn't change the status quo. Patch 3 is 
self standing, e.g. not applying it doesn't affect the other two. 
However patch 3 probably has to be applied sequentially after patches 
1&2 as all are on the single file.

Following on from Robs comments on last patch sent adding bluetooth, 
I've made this one FAR more detailed. That said though the drivers for 
bluetooth in this case doesn't use clock or supply ASAIK. Most things 
are brought up by the wifi part of the device tree which was patch 2. 
However adding to the bluetooth device tree as well, at least leaves the 
option open to a user just loading bluetooth, and not wifi.

The one thing missing from this bluetooth device tree, is explaining 
which pins need to be pulled to bring up the card. This is part be 
design (the tinker board and rt8723bs both have bad public documentation 
- so exact operation is hard to guess ...); but also because I couldn't 
see a way of getting a SerDev device to pull pins on loading, unlike 
sdio (used for wifi).

Full series:

Part 1 - device tree changes for sd card
Part 2 - adding wifi to the device tree
Part 3 - adding outline bluetooth

So are each fairly self standing. However if interested in parts 1 and 2 
they can be found:

http://lists.infradead.org/pipermail/linux-rockchip/2019-March/023330.html
http://lists.infradead.org/pipermail/linux-rockchip/2019-March/023331.html

Regards, and yes happy to wait and see what Rob has to say.

David.


