Return-Path: <SRS0=/mwE=PU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACE1C43387
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jan 2019 15:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839412084E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jan 2019 15:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="D08lw16d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfALPA0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Jan 2019 10:00:26 -0500
Received: from mail-gw.unlimitedwebhosting.co.uk ([149.255.60.86]:55496 "EHLO
        mail-gw.unlimitedwebhosting.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbfALPAZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Jan 2019 10:00:25 -0500
Received: from uwhbsf01.unlimitedwebhosting.co.uk (mail-gw.unlimitedwebhosting.co.uk [149.255.60.72])
        by mail-gw.unlimitedwebhosting.co.uk (Postfix) with ESMTPS id 9F4DE6060EBE
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Jan 2019 15:00:20 +0000 (GMT)
X-ASG-Debug-ID: 1547305219-0554135c625afbc70001-Y6scnF
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net [149.255.62.7]) by uwhbsf01.unlimitedwebhosting.co.uk with ESMTP id LsN1chPtGtZg0VPq (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 12 Jan 2019 15:00:19 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1x9jj1+9r+Zx7FMCJbxgCN6yyhxwioQL7qECsRH30lQ=; b=D08lw16dDjq45WvT3lhq4FvjWP
        hTvXP8E2CwG7WBImsLgvBsxRsMxwb2SljZpEaqfvm6vdDD5aUUBFEcRzKD+Ruq/itGYpL0ZOWDF6D
        JoSLUloZVbHwgjeK3lAfLvWKeRdqjCH89wps0IOKqVnxe+rAtB/wX1stF7wOiXDb7bsxhfPlcxLDj
        mUGCCUJIL0orUdL3IwOzFzXaru1cXjxXX1hTV2bHYl4RqdMQhHncIalVxCn3t8PBsdGAi1Ufi81FX
        D4h1eO5R2eta3QN0saEhvG8mhheWil80hn4I/IB+AoEzn52jiV9fEQTHqIoNlxtyRGDrxtG69cBgL
        QjEDCd1w==;
Received: from [87.112.42.200] (port=41384 helo=[192.168.2.187])
        by cloud706.unlimitedwebhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <beagleboard@davidjohnsummers.uk>)
        id 1giKln-002ddh-0M; Sat, 12 Jan 2019 15:00:19 +0000
Subject: Re: [PATCHv2] Description of the realtek bluetooth device tree hooks
To:     Rob Herring <robh@kernel.org>
X-ASG-Orig-Subj: Re: [PATCHv2] Description of the realtek bluetooth device tree hooks
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mark.rutland@arm.com,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
 <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
 <20190111163420.GA20311@bogus>
From:   David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <1308b7df-9f09-c46e-e740-131bd1c42fef@davidjohnsummers.uk>
Date:   Sat, 12 Jan 2019 15:00:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190111163420.GA20311@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
X-Barracuda-Start-Time: 1547305219
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at unlimitedwebhosting.co.uk
X-Barracuda-Scan-Msg-Size: 4490
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65539
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Rob,

I'll hopefully make those changes this weekend, and resubmit - just so 
next weekend can move onto the device tree.

Oh yes, on the "-bluetooth" or "-bt"; as these devices have both and 
sdio input for wifi, and uart for bluetooth; I guess they will need to 
be listed twice in a device tree, both under uart and sdio. Now as both 
these parts of the device tree will want to specify the driver used, and 
the driver is different for bluetooth and for wifi - doesn't that mean 
we should specify compatible differently? Otherwise how will the kernel 
know which driver to load for wifi and which for bluetooth?

So question is am I missing something here, and this could be simplified?

On the interrupts, GPIO control lines, power supplies, etc, on the ASUS 
code that I'm basing the patches on (for Tinker Board S) - these bits 
are freestanding in the device tree, and mainly go in with the wifi 
patch (and not bluetooth). I'll put some though into how this is best 
arranged when going mainline. I think if I'm honest, if I wait to get 
all these extras in the documentation, this will only get settled when I 
get the wifi into the device tree - as problem is more natural there. 
This though would delay the bluetooth patch probably a month. I'd prefer 
to get something out there - even if I have to return later to tidy the 
documentation.

Regards, and thanks for the helpful comments.

David.


On 11/01/2019 16:34, Rob Herring wrote:
> On Thu, Jan 03, 2019 at 04:35:37PM +0000, David Summers wrote:
>> This adds the desrciption file that describes the hooks for the
>> realtek bluetooth serial devices, as needed to refer to the interface
>> in the device tree.
> Please follow conventions for patch subjects. 'git log --oneline
> --no-merges -- path/to/file' usually gives a good clue. In this case,
> something like:
>
> dt-bindings: net: Add Realtek serial bluetooth binding
>
>> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
>> ---
>>   .../bindings/net/realtek-bluetooth-serial.txt | 28 +++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
>> new file mode 100644
>> index 000000000000..0aabca1fc002
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
>> @@ -0,0 +1,28 @@
>> +Realtek bluetooth devices connected via a UART
>> +
>> +- compatible: should be "realtek,<name>-bluetooth"
>> +  except for "realtek,trl8761atv" - which only has a serial bluetooth connection
>> +       "realtek,rtl8723as-bluetooth"
>> +       "realtek,rtl8723bs-bluetooth"
>> +       "realtek,rtl8723ds-bluetooth"
>> +       "realtek,rtl8761atv"
>> +       "realtek,rtl8821as-bluetooth"
>> +       "realtek,rtl8821cs-bluetooth"
>> +       "realtek,rtl8822bs-bluetooth"
> Arguably, '-bluetooth' is not necessary as nothing else is attached to
> the serial port. At least shorten it to '-bt'.
>
>> +- These device are bluetooth devices, that connect via a uart
> s/device/devices/
>
>> +- all devices (except for rtl8761atv) are also wifi devices, this is connected
>> +  seperatly via sdio - and is not covered by this compatible node
> Really, this should be up above the property list in a description of
> the device(s).
>
>> +- ideally these will be referenced in a device tree serial node via serdev
> Not ideally, but it is only valid for this to be a child of a UART.
>
> serdev is a kernel thing, and shouldn't be part of the binding doc.
>
>> + http://events17.linuxfoundation.org/sites/events/files/slides/serdev-elce-2017-2.pdf
> Useful, but again, not part of this binding.
>
> There's no interrupts, GPIO control lines, power supplies, etc. for
> these chips? The binding should be complete even if your platform
> doesn't need these.
>
>> +
>> +Example:
>> +
>> +&uart0 {
>> +	status = "okay";
> Don't show status in examples.
>
>> +       	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
>> +       	bluetooth {
>> +               	  compatible = "realtek,rtl8723bs-bluetooth";
>> +       	};
> Mixed tabs and spaces. Use tabs.
>
>> +};
>> +
>> +this ensures that the bluetooth device is tied to the correct uart
>> -- 
>> beagleboard@davidjohnsummers.uk
>>

