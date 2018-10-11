Return-Path: <SRS0=Gi1c=MX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62666C32788
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Oct 2018 10:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC1E2085B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Oct 2018 10:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="xWhlUo7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC1E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeJKRnM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:43:12 -0400
Received: from mail-gw.unlimitedwebhosting.co.uk ([149.255.60.82]:35948 "EHLO
        mail-gw.unlimitedwebhosting.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbeJKRnM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Oct 2018 13:43:12 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2018 13:43:11 EDT
Received: from uwhbsf01.unlimitedwebhosting.co.uk (mail-gw.unlimitedwebhosting.co.uk [149.255.60.72])
        by mail-gw.unlimitedwebhosting.co.uk (Postfix) with ESMTPS id 04691608E999
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Oct 2018 11:09:53 +0100 (BST)
X-ASG-Debug-ID: 1539252592-055413120c1920310001-Y6scnF
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net [149.255.62.7]) by uwhbsf01.unlimitedwebhosting.co.uk with ESMTP id xwRtrkQ3VkWwvRwr (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO) for <linux-bluetooth@vger.kernel.org>; Thu, 11 Oct 2018 11:09:52 +0100 (BST)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i3mALwZdt6l0uBTpnjKHdLNZP3GYamKAmvwMZ8vgR0Q=; b=xWhlUo7zF6g1G17oq5fnEL7uc+
        exycS29KlRUCZVwgK+ZVFxe7vdzQS+ITBOat+mxjc3irhVxC+KK8Gx9vejYbHRAJHgBlJomnWKoUz
        kowUriHy/O2SPc06p4gjZV49K4dPo5n7duEYZjYhsj2FN6mLlQgEY83VZDYT72no6NaQuRsoDWAIc
        /Gvr6LKglIIZRuMz6sDYPzzO8TiqOh9oxB2Q27JEKMKljHzDVBUFwLOMXmL2Gl2YXeHrWWYI4Qn9v
        dGCLT7keqPAeDZq8HtnPUjyYjGgIOrgR7arVm0p93egsPRWFzJ29K4m4tErcQ4fgoXg4FROgDWBmq
        K2V6sBhw==;
Received: from 41.172.114.87.dyn.plus.net ([87.114.172.41]:58416 helo=[192.168.1.70])
        by cloud706.unlimitedwebhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <beagleboard@davidjohnsummers.uk>)
        id 1gAXuh-00B84j-Nq; Thu, 11 Oct 2018 11:09:51 +0100
Subject: Re: [PATCH 3/3] This patch adds wifi to asus tinker board S
To:     Heiko Stuebner <heiko@sntech.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
X-ASG-Orig-Subj: Re: [PATCH 3/3] This patch adds wifi to asus tinker board S
References: <20180922170236.8690-1-beagleboard@davidjohnsummers.uk>
 <20180922170236.8690-4-beagleboard@davidjohnsummers.uk>
 <5682345.Yzn33l6ONg@phil>
Cc:     linux-bluetooth@vger.kernel.org, linux-rockchip@lists.infradead.org
From:   David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <efb16675-0382-64b1-ceb5-acee3f95628d@davidjohnsummers.uk>
Date:   Thu, 11 Oct 2018 11:09:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <5682345.Yzn33l6ONg@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
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
X-Barracuda-Start-Time: 1539252592
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at unlimitedwebhosting.co.uk
X-Barracuda-Scan-Msg-Size: 2365
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=BSF_SC0_MISMATCH_TO
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.59479
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 BSF_SC0_MISMATCH_TO    Envelope rcpt doesn't match header
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 08/10/2018 10:30, Heiko Stuebner wrote:
> Hi David,
>
> Am Samstag, 22. September 2018, 19:02:36 CEST schrieb David Summers:
>> Now as fair as I understand. the asus tinker board contains a wifi
>> So should this patch be added to the tinker board dtsi ?
>>
>> It also far move complex - it adds far more things, so consider
>>
>> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
>> ---
>>   arch/arm/boot/dts/rk3288-tinker-s.dts | 93 +++++++++++++++++++++++++++
>>   1 file changed, 93 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rk3288-tinker-s.dts b/arch/arm/boot/dts/rk3288-tinker-s.dts
>> index bc691e3f9c07..3d91924fd8db 100644
>> --- a/arch/arm/boot/dts/rk3288-tinker-s.dts
>> +++ b/arch/arm/boot/dts/rk3288-tinker-s.dts
>> @@ -10,6 +10,95 @@
>>   / {
>>   	model = "Rockchip RK3288 Asus Tinker Board S";
>>   	compatible = "asus,rk3288-tinker-s", "rockchip,rk3288";
>> +
>> +	wireless-bluetooth {
>> +		compatible = "bluetooth-platdata";
>> +		uart_rts_gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
>> +		pinctrl-names = "default","rts_gpio";
>> +		pinctrl-0 = <&uart0_rts>;
>> +		pinctrl-1 = <&uart0_gpios>;
>> +		BT,reset_gpio    = <&gpio4 29 GPIO_ACTIVE_HIGH>;
>> +		BT,wake_gpio     = <&gpio4 26 GPIO_ACTIVE_HIGH>;
>> +		BT,wake_host_irq = <&gpio4 31 GPIO_ACTIVE_HIGH>;
>> +		status = "okay";
>> +	};
> the basic problem here is, that all these nodes stem from the so called
> soc-vendor-tree. Devicetree bindings normally go through a review process
> while soc vendors often invent their own shortcut that is not and will
> not be supported by the mainline kernel.
>
> Bluetooth-platdata and wlan-platdata are examples of that.
>
> Additionally, the kernel now has the somewhat new "serdev" to manage the
> needed connection between bluetooth and uart. See
> http://events17.linuxfoundation.org/sites/events/files/slides/serdev-elce-2017-2.pdf
> for an introduction.

Sigh - this just got difficult:

https://github.com/torvalds/linux/blob/master/drivers/bluetooth/btrtl.c

Which is the bluetooth driver for Realtek RTL8723BS neither contains the 
device tree tabs ("static const struct of_device_id") so it can't be 
referred to in the device tree, nor is it linked in with serdev, so it 
probably can't go as sub child of uart0.

I'll look at those changes first ...

David

