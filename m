Return-Path: <SRS0=2QA5=RH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF03C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Mar 2019 02:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9710E20842
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Mar 2019 02:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfCDCM3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:12:29 -0500
Received: from mail-gw.thundercloud.uk ([149.255.60.82]:56202 "EHLO
        mail-gw.thundercloud.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfCDCM2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 3 Mar 2019 21:12:28 -0500
Received: from mailbsf01.thundercloud.uk (mail-gw.thundercloud.uk [149.255.60.72])
        by mail-gw.thundercloud.uk (Postfix) with ESMTPS id EA01C6045E5D
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2019 02:12:26 +0000 (GMT)
X-ASG-Debug-ID: 1551665545-0554131266b67b20001-Y6scnF
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net [149.255.62.7]) by mailbsf01.thundercloud.uk with ESMTP id SuoISRvmkPIIKAMB (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 04 Mar 2019 02:12:25 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
Received: from [87.114.170.31] (port=51082 helo=[192.168.2.187])
        by cloud706.unlimitedwebhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <beagleboard@davidjohnsummers.uk>)
        id 1h0XWI-00072R-6k; Sun, 03 Mar 2019 20:15:34 +0000
Subject: Re: [PATCH 3/3] ARM: dts: rk3288 Tinker Board (S) add bluetooth
To:     heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
X-ASG-Orig-Subj: Re: [PATCH 3/3] ARM: dts: rk3288 Tinker Board (S) add bluetooth
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tony McKahan <tonymckahan@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-4-beagleboard@davidjohnsummers.uk>
From:   David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <4de2979b-0553-300c-fea5-49d68e2b3580@davidjohnsummers.uk>
Date:   Sun, 3 Mar 2019 20:15:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190217121513.22965-4-beagleboard@davidjohnsummers.uk>
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
X-Barracuda-Start-Time: 1551665545
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at thundercloud.uk
X-Barracuda-Scan-Msg-Size: 4797
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.68164
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Finally on the patch to give an outline description to Bluetooth on the 
Tinker Boards.

Synthesis here is harder.

On the one hand, it is non functioning - because although it describes 
the hardware, it has no compatible flag, and there is no current driver 
in the kernel.

It should be said though there is a patch for a proposed driver:

https://www.spinics.net/lists/linux-bluetooth/msg78661.html

And if accepted this would give the compatible flag. So should this 
change wait until that is added?

An alternative approach though arises from what Tony McKahan of Armbian 
writes

"For the Bluetooth I can confirm _RTS is required"

So this device tree segment is useful - it correctly describes the uart 
portion of the interface, and that is hard to determine from the ASUS 
dts. So this is useful information to capture.

On the pinout information of the rtl8723. Two points:

1) information like clock, and voltage supplies, are formally hardware 
correct, but practically will probably never be applied via bluetooth. 
Instead its the wifi that brings this hardware up. So should these be 
supplied if unlikly to be used? I think they should as they formally 
describe the hardware.

2) Confusion over enable-gpios vs reset-gpios

The second appeared on the bluetooth thread:

https://www.spinics.net/lists/linux-bluetooth/msg78654.html

should this be written:

enable-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_LOW>;

or

reset-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;

The datasheet (as available as it is): 
http://cit.odessa.ua/media/pdf/Intel-Compute-Stick/FN-Link_F23BDSM25-W1.pdf

Says it is BT_RST - BT Reset IN

but the current kernel driver hci_h5 says:

https://github.com/torvalds/linux/blob/master/drivers/bluetooth/hci_h5.c#L989

     { "enable-gpios", &btrtl_enable_gpios, 1 },

And RobH clearly has a view:

https://www.spinics.net/lists/linux-bluetooth/msg79138.html

So there is still some confusion.

Guess its a question of it a partial hardware description, with possible 
faults, is better than no device tree description of the hardware?

Any views?



On 17/02/2019 12:15, David Summers wrote:
> This patch is to add Bluetooth to the ASUS Tinker Board (S) device
> tree.
>
> This patch is more contraversal - so probably view it as a request for
> comments.
>
> The reason behind this, is this patch does not currently set Bluetooth
> working on the these boards. The problem is that the
> bluetooth/hci_h5.c driver, that is used for Realtek serial devices,
> depends on ACPI. Unfortantly ACPI can not be enabled on armv7 machines
> such as the TB(S). And so the kernel module for the RTL8723BS
> Bluetooth can not be loaded.
>
> However this patch is believed to be an accurate description of the
> Tinker Board (S) wiring. It is strongly based on the ASUS patch:
>
> https://github.com/TinkerBoard/debian_kernel/commit/6a3128ade33f758887048578ada61a4b7ab8e678
>
> As the Bluetooth is connected via a UART and this is wired into uart0,
> this has been described as a SerDev.
>
> The ASUS patch mentions the UART_CTS, but not the _RTS. Now as the
> RTL8723BS has both CTS and RTS on the uart, it has been assumed both
> are wired into uart0 on the cpu.
>
> The Bluetooth connection has several wake up pins both device and host
> and a reset pin. The wiring of these has been described; however how
> the kernel driver will use these isn't clear. E.g. should HOST_WAKE be
> an interupt?
>
> The main reason for asking for comments, is that when it comes time to
> make the changes to the bluetooth uart code, and add compatible flags,
> robh has indicated that this will only be accepted with a valid
> example. So the code below is that example. So I would like comments
> that this approach is valid, which can be used when the later
> submission comes.
>
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> ---
>   arch/arm/boot/dts/rk3288-tinker.dtsi | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
> index e1796f340eef..931b4c652fdc 100644
> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
> @@ -481,6 +481,17 @@
>   
>   &uart0 {
>   	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>, <&uart0_rts>;
> +
> +	bluetooth {
> +		clocks = <&rk808 RK808_CLKOUT1>;
> +		reset-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_LOW>;
> +		device-wake-gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
> +		host-wake-gpios = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
> +		vcc-18-supply = <&vcc_18>;
> +		vcc-io-supply = <&vcc_io>;
> +	};
>   };
>   
>   &uart1 {


