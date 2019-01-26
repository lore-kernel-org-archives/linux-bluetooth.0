Return-Path: <SRS0=qwpb=QC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F3CC282C7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 14:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DD521908
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 14:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="oeerU8RW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfAZO0r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jan 2019 09:26:47 -0500
Received: from mail-gw.unlimitedwebhosting.co.uk ([149.255.60.84]:47840 "EHLO
        mail-gw.unlimitedwebhosting.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726052AbfAZO0q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jan 2019 09:26:46 -0500
Received: from uwhbsf01.unlimitedwebhosting.co.uk (mail-gw.unlimitedwebhosting.co.uk [149.255.60.72])
        by mail-gw.unlimitedwebhosting.co.uk (Postfix) with ESMTPS id A5067602D3F0
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jan 2019 14:26:44 +0000 (GMT)
X-ASG-Debug-ID: 1548512803-05541359746d5330001-Y6scnF
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net [149.255.62.7]) by uwhbsf01.unlimitedwebhosting.co.uk with ESMTP id bpHdA2UVU1B2Yryg (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 26 Jan 2019 14:26:43 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MKZIkyDMt8D9hlQ5bTlP9xPzKYmuaNxJDJgJ8EsS4Ps=; b=oeerU8RWDm1K+8mMY//8Yqw4nc
        caD5aRf3CanjDlnO3hKcwD5d/exfqahb1PSp7d070HbvBpcM10hg+ioLKOU+jQcjD7UvdXwHzqSHJ
        7ERMvsWG5/wGCa8odjIrygTbvj8oO4LlHaahtU4qAfUk/kTgClHL5h0r7jLzKqnzGaDn1+q/NkX+H
        QWYsVUNjTB7aX2nBQy2/p06E7ZK14wl9XAJfotqnK40B5VWS14QwfmOD6s+uT8JlzDL7HZ1wBgD9x
        CWV/7VfuUGVVt6zGdiYlSMjDjPseWQ1Tz/YbCCSpDEgeQa7UB4fibzR5zwi/yg05C4mVwS+9aIf6o
        x9QRwUFg==;
Received: from [87.113.131.230] (port=39480 helo=[192.168.2.187])
        by cloud706.unlimitedwebhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <beagleboard@davidjohnsummers.uk>)
        id 1gnOuw-000CJ7-K6; Sat, 26 Jan 2019 14:26:42 +0000
Subject: Re: [PATCH v4 2/2] dt-bindings: Create the file for Realtek Bluetooth
 serial devices
To:     Rob Herring <robh+dt@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v4 2/2] dt-bindings: Create the file for Realtek Bluetooth
 serial devices
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <20190121203928.32723-1-beagleboard@davidjohnsummers.uk>
 <20190121203928.32723-2-beagleboard@davidjohnsummers.uk>
 <CAL_Jsq+9zjPaDiJ0Uynp9p7WpH-NK-sT91vUm-+R7D_me8a9Mw@mail.gmail.com>
From:   David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <712d0ad2-0003-881c-b066-9462d3d8fa11@davidjohnsummers.uk>
Date:   Sat, 26 Jan 2019 14:26:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+9zjPaDiJ0Uynp9p7WpH-NK-sT91vUm-+R7D_me8a9Mw@mail.gmail.com>
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
X-Barracuda-Start-Time: 1548512803
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at unlimitedwebhosting.co.uk
X-Barracuda-Scan-Msg-Size: 5549
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.66440
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear All,

OK - spent some time last night and today reading 
/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt and 
/Documentation/devicetree/bindings/serial/serial.txt; reviewing the Asus 
Tinker Board device tree, and the comments. What is clear:

 1. I do not have the time available to learn in detail the preferred
    linux style of device tree
 2. The example I gave was for the ASUS Tinker Board, taken from the
    rk3288-miniarm.dts
 3. The current ASUS Tinker Board device tree is a patch done by ASUS
    for debian:
    https://github.com/TinkerBoard/debian_kernel/blob/develop/arch/arm/boot/dts/rk3288-miniarm.dts
 4. This device tree is non standard, and not suitable for inclusion in
    mainline
 5. This device tree is the only really device tree available for the
    ASUS Tinker Board (S)
 6. The schematic for the ASUS Tinker Board is available on:
    https://www.asus.com/uk/Single-Board-Computer/Tinker-Board/
 7. The schematic is not detailed, it for example does not show how
    Bluetooth and Wi-Fi are wired
 8. The only hints on wiring are in the ASUS developed patches to the
    debian device tree
 9. The documentation for realtek Bluetooth will only be accepted with
    an example that is complete:
    https://www.spinics.net/lists/linux-bluetooth/msg78545.html
10. Marcel has only had major problem with the first version of the
    patch. Since changes made to hci_h5.c his only problem has the
    naming of the compatible names, where he needs an Ack from Rob:
    https://www.spinics.net/lists/linux-bluetooth/msg78637.html
11. Marcel needs the device tree compatible hooks documented:
    https://www.spinics.net/lists/linux-bluetooth/msg78445.html
12. Now it is clear that I don't have time to do documentation, of the
    required standard, that is applicable to the ASUS Tinker Board (S)
13. So it is with regret that on reflection I have decided to withdraw
    this patchset

This to my mind is a pity, ASUS Tinker Board (S) uses currently don't 
have good mainline support, most use the debian/ASUS rk3288-miniarm.dts 
device tree. Without mainlining, it is very hard to support this board 
in distributions like Arm Arch. But its also clear that I am not the 
person to mainline the support. I neither have the knowledge of the 
device tree. Access to proper schematics for the device. Nor the time 
available to do this.

Hopefully someone else will take up mainlining these boards. I hope the 
bits I've done will at least give someone else ideas on how to proceed, 
and that they will be more successful than I. I'll probably keep 
learning the preferred device tree vocabulary and grammar - but at a 
slow pace as time allows.

Thank you all for your time and help,

David Summers

On 25/01/2019 19:46, Rob Herring wrote:
> On Mon, Jan 21, 2019 at 2:39 PM David Summers
> <beagleboard@davidjohnsummers.uk> wrote:
>> With the changes requested by Marcel Holtmann and Rob Herring.
>>
>> Capitalisation as requested.
> Write something that makes sense for the git history. The above 2
> lines are not useful information.
>
>> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
>> ---
>>   .../bindings/net/realtek-bluetooth-serial.txt | 32 +++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
>> new file mode 100644
>> index 000000000000..2eddde1a0cf1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
>> @@ -0,0 +1,32 @@
>> +Realtek Bluetooth devices connected via a UART.
>> +These devices typically also have a WI-FI connected via SDIO - the
>> +compatible described here is used just for referencing the Bluetooth.
>> +
>> +- compatible: should be "realtek,<name>-bt"
>> +  except for "realtek,trl8761atv" - which only has a serial Bluetooth connection
>> +       "realtek,rtl8723as-bt"
>> +       "realtek,rtl8723bs-bt"
>> +       "realtek,rtl8723ds-bt"
>> +       "realtek,rtl8761atv"
>> +       "realtek,rtl8821as-bt"
>> +       "realtek,rtl8821cs-bt"
>> +       "realtek,rtl8822bs-bt"
>> +
>> +Example:
>> +
>> +&uart0 {
>> +       status = "okay";
> Don't show 'status' in examples.
>
>> +       pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
>> +       bluetooth {
>> +               compatible = "realtek,rtl8723bs-bt";
>> +               uart_rts_gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
> We already have a standard property name and location for handling RTS
> on a GPIO and this is not it.
>
>> +               pinctrl-names = "default","rts_gpio";
>> +               pinctrl-0 = <&uart0_rts>;
> This belongs in the parent node.
>
>> +               pinctrl-1 = <&uart0_gpios>;
>> +               BT,reset_gpio    = <&gpio4 29 GPIO_ACTIVE_HIGH>;
>> +               BT,wake_gpio     = <&gpio4 26 GPIO_ACTIVE_HIGH>;
>> +               BT,wake_host_irq = <&gpio4 31 GPIO_ACTIVE_HIGH>;
> All the above need to be documented. Putting in an example is not documented.
>
> Drop the 'BT,' as the part preceding the comma should be a vendor name
> if present and use '-' rather than '_' in property names.
>
> 'reset-gpios' is the standard name for a reset gpio. An irq should use
> the 'interrupts' binding even if connected to a GPIO on the host.
>
> Rob


