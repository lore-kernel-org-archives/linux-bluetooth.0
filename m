Return-Path: <SRS0=pNHN=QB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF83C282C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jan 2019 19:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35FD218D0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jan 2019 19:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="ESVodoCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfAYTDM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:03:12 -0500
Received: from mail-gw.unlimitedwebhosting.co.uk ([149.255.60.84]:37764 "EHLO
        mail-gw.unlimitedwebhosting.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbfAYTDL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Jan 2019 14:03:11 -0500
Received: from uwhbsf01.unlimitedwebhosting.co.uk (mail-gw.unlimitedwebhosting.co.uk [149.255.60.72])
        by mail-gw.unlimitedwebhosting.co.uk (Postfix) with ESMTPS id C443B60ACA2E
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jan 2019 19:03:10 +0000 (GMT)
X-ASG-Debug-ID: 1548442989-055413020b14ac310001-Y6scnF
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net [149.255.62.7]) by uwhbsf01.unlimitedwebhosting.co.uk with ESMTP id pBOZYz9Ow9eUDPeg (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 25 Jan 2019 19:03:09 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:Subject:Sender:
        Reply-To:To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yo1eQmO9UZfvCFkTgTtZ71d+tAKgLMdj97/If3TiNMQ=; b=ESVodoCObeyquPLfbWfktrcNWf
        0p68ebadNPwg9rhyzh2BheFYpvtqhB1/xpL3DWVAe04wnV+m2kwEQiWuKuhzgmOfmNsV+s3H8lmrP
        GVYFka6Hqi+is9lLfDoEwee+LfIIZyM82dpTCQ7+xnSN0eOXe6vR3L7lR0GsKv63veozogdo5n+6T
        CudagWtRIbGJFqlrM65iYKZ0/Czf5lEFv85Aenw25GW6kWna6DNDKzsx02vUd8rxlp258lDzlYeeV
        E/uOyg/BVqhzHAzBpAme15DhyBYhdfAWSqY8073MwLc4TjWucsvzjWJSuAhkzEnnEaOlp4XfW2ljz
        9Tnpeu2Q==;
Received: from [87.113.131.230] (port=38460 helo=[192.168.2.187])
        by cloud706.unlimitedwebhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <beagleboard@davidjohnsummers.uk>)
        id 1gn6ku-000P5m-PR; Fri, 25 Jan 2019 19:03:08 +0000
Subject: Re: [PATCH v4 2/2] dt-bindings: Create the file for Realtek Bluetooth
 serial devices
Cc:     linux-bluetooth@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v4 2/2] dt-bindings: Create the file for Realtek Bluetooth
 serial devices
References: <20190121203928.32723-1-beagleboard@davidjohnsummers.uk>
 <20190121203928.32723-2-beagleboard@davidjohnsummers.uk>
 <CAGb2v64j=hGFhb3GVocRo9B1uY+tFBjbrm6F71L4ejA+cruUvA@mail.gmail.com>
From:   David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <1fee0e05-5b41-ab24-8fe7-0f8c58479f19@davidjohnsummers.uk>
Date:   Fri, 25 Jan 2019 19:03:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAGb2v64j=hGFhb3GVocRo9B1uY+tFBjbrm6F71L4ejA+cruUvA@mail.gmail.com>
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
X-Barracuda-Start-Time: 1548442989
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at unlimitedwebhosting.co.uk
X-Barracuda-Scan-Msg-Size: 4950
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 1.21
X-Barracuda-Spam-Status: No, SCORE=1.21 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=MISSING_HEADERS
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.66384
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        1.21 MISSING_HEADERS        Missing To: header
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chen-Yu,

Thanks for the interest, and sorry for the slow reply - I've been away 
on business.

The latter was why my patches were so terse. I'd done v3 at the weekend:

https://www.spinics.net/lists/linux-bluetooth/msg78694.html

But Rob and Marcel wanted minor changes:

https://www.spinics.net/lists/linux-bluetooth/msg78706.html
https://www.spinics.net/lists/linux-bluetooth/msg78713.html

Now as I was going away, I quickly made the changes requested, and 
posted night before I left.

Your questions are good, but without a clear answer. What I will say is 
that

  * the device drive hci_h5 is a bluetooth hci 3 wire driver
  * I take this to be GND,RX,TX
  * I also assume this means BCSP
  * BCSP is either 3 wire or 5 wire
  * The device tree hooks I took from

    https://github.com/TinkerBoard/debian_kernel/commit/6a3128ade33f758887048578ada61a4b7ab8e678

  * a patch direct from ASUS, and so I take it this is how the board is
    wired up.
  * If you look at the datasheet:
    http://files.pine64.org/doc/datasheet/pine64/RTL8723BS.pdf
  * You can see as well and RX and TX on pin 42,42 there is a UART_CTS
    on 44,  BT_WAKE on 6, BT_HOST_WAKE
  * So I'm guessing these are wired up as described in the asus device tree

Now my problem is I don't have a board, I'm trying to mainline this your 
Arm Arch users.

So really this asks the question as to if the hci_h5 is the correct 
driver for the RTL8723BS; I think hci_h5 is intended just for 3 wire - 
so probably can't get changes there. Does make you wonder if there 
should be a more general driver?

Anyway, I'm not expert here. Really just want to get this chip supported 
in the device tree. So I just did the minimal to load the module.

If you have any thoughts though, do let the thread know.

Regards,

David.


On 22/01/2019 02:40, Chen-Yu Tsai wrote:
> Hi,
>
> Interested party here. I'd like to get this working on the Pine64 which has
> an RTL8723BS module. I had made some changes and had it working but didn't
> get around to doing the patches yet.
>
> On Tue, Jan 22, 2019 at 4:39 AM David Summers
> <beagleboard@davidjohnsummers.uk> wrote:
>> With the changes requested by Marcel Holtmann and Rob Herring.
>>
>> Capitalisation as requested.
>>
>> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> The commit log is a bit lacking, as it doesn't provide any context or details
> relevant to the changes in this patch, but also has details that should be
> in the changelog, and not the commit log.
>
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
>> +       pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
>> +       bluetooth {
>> +               compatible = "realtek,rtl8723bs-bt";
>> +               uart_rts_gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
>> +               pinctrl-names = "default","rts_gpio";
>> +               pinctrl-0 = <&uart0_rts>;
>> +               pinctrl-1 = <&uart0_gpios>;
>> +               BT,reset_gpio    = <&gpio4 29 GPIO_ACTIVE_HIGH>;
>> +               BT,wake_gpio     = <&gpio4 26 GPIO_ACTIVE_HIGH>;
>> +               BT,wake_host_irq = <&gpio4 31 GPIO_ACTIVE_HIGH>;
> You haven't listed these three properties in the bindings.
>
> Second, for the last one, the property name says irq, but it takes
> a GPIO phandle. This is slightly misleading.
>
> Furthermore, ACPI already uses the names "device-wake-gpios",
> "enable-gpios", and "host-wake-gpios". Would it be possible to
> stick to those?
>
> Last, you don't actually add support for them in the driver.
>
> So why are they there?
>
> Regards
> ChenYu
>
>> +       };
>> +};
>> +
>> +this ensures that the Bluetooth device is tied to the correct uart.
>> --
>> beagleboard@davidjohnsummers.uk
>>

