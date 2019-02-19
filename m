Return-Path: <SRS0=iCSy=Q2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF00C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Feb 2019 21:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361722146F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Feb 2019 21:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="2elFioHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfBSVJ2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:09:28 -0500
Received: from mail-gw.thundercloud.uk ([149.255.60.87]:58131 "EHLO
        mail-gw.thundercloud.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfBSVJ2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Feb 2019 16:09:28 -0500
Received: from mailbsf01.thundercloud.uk (mail-gw.thundercloud.uk [149.255.60.72])
        by mail-gw.thundercloud.uk (Postfix) with ESMTPS id E234B62C2A8C
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Feb 2019 21:09:25 +0000 (GMT)
X-ASG-Debug-ID: 1550610563-05541312653109b0001-Y6scnF
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net [149.255.62.7]) by mailbsf01.thundercloud.uk with ESMTP id vAmvGc2wXNrvlIsU (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 19 Feb 2019 21:09:23 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q0ySjtH8j43IV9rMNu6araMj86TY/R79rsof0VLvboQ=; b=2elFioHmdMd+QNe0H8MA4XBc8h
        PUVK8uihwM+t5Uf0Y4P28yaUc/2z6zBz53xSTerUMxLAeNVGeu9s1BvilNppsGyQyHbKD1uWJd2mA
        +H04xrDG4CR7X3dqdKBI+xmKfHgN2HzQo16446+ljXYDI6EE50J9F2gEYputbfbFx+r2FDxR5GeTf
        0uSEaGOvOFx43WPLMW6U/Rz97DCA4ebjxIWKpgW/xZk39icL3UiFxXmCdNhZ5/e9PbYmmgqcZY2Yu
        Z7/AZYxZhJqnBR2vLF4j0s+nsOh+5NcVx/e3OormKY/hKc4y+DIm5jAcBNhryCU8Pe6FN4MHTeXtF
        vHCPOqlg==;
Received: from [87.114.170.31] (port=59590 helo=[192.168.2.187])
        by cloud706.unlimitedwebhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <beagleboard@davidjohnsummers.uk>)
        id 1gwCdm-000L5r-Pf; Tue, 19 Feb 2019 21:09:22 +0000
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
To:     Rob Herring <robh@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>
X-ASG-Orig-Subj: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        netdev <netdev@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
References: <20190118170232.16142-1-anarsoul@gmail.com>
 <20190118170232.16142-4-anarsoul@gmail.com> <20190218211035.GA28145@bogus>
 <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
 <1245842044.588056.1550527701604@email.ionos.de>
 <CA+E=qVdMNmVkytCzXqYgJtV196-G=c_bWx+aLvs=Y0iuRpjdRg@mail.gmail.com>
 <CAL_JsqLROpJMoEPLXaAL_JG1SNufstMDmB4xy_V_p4=duHKPSA@mail.gmail.com>
From:   David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <6a26ff97-0b9c-cfdd-9428-74580694220a@davidjohnsummers.uk>
Date:   Tue, 19 Feb 2019 21:09:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLROpJMoEPLXaAL_JG1SNufstMDmB4xy_V_p4=duHKPSA@mail.gmail.com>
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
X-Barracuda-Start-Time: 1550610563
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at thundercloud.uk
X-Barracuda-Scan-Msg-Size: 3136
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.67592
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 19/02/2019 14:17, Rob Herring wrote:
> On Mon, Feb 18, 2019 at 4:28 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>> On Mon, Feb 18, 2019 at 2:08 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>>> Hi Vasily,
>> Hi Stefan,
>>
>>>> Vasily Khoruzhick <anarsoul@gmail.com> hat am 18. Februar 2019 um 22:24 geschrieben:
>>>>
>>>>
>>>> On Mon, Feb 18, 2019 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
>>>>> On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
>>>>>> Add binding document for bluetooth part of RTL8723BS/RTL8723CS
>>>>>>
>>>>>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>>>>>> ---
>>>>>>   .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
>>>>>>   1 file changed, 35 insertions(+)
>>>>>>   create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
>>>>>> new file mode 100644
>>>>>> index 000000000000..8357f242ae4c
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
>>>>>> @@ -0,0 +1,35 @@
>>>>>> +RTL8723BS/RTL8723CS Bluetooth
>>>>>> +---------------------
>>>>>> +
>>>>>> +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
>>>>>> +BT is connected over serial. It speaks H5 protocol with few extra commands
>>>>>> +to upload firmware and change module speed.
>>>>>> +
>>>>>> +Required properties:
>>>>>> +
>>>>>> + - compatible: should be one of the following:
>>>>>> +   * "realtek,rtl8723bs-bt"
>>>>>> +   * "realtek,rtl8723cs-bt"
>>>>>> +Optional properties:
>>>>>> +
>>>>>> + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
>>>>>> + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
>>>>>> + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
>>>>>> + - firmware-postfix: firmware postfix to be used for firmware config
>>> sorry, i didn't noticed your great series before. David and i working at the same stuff but for the Asus Tinker Board.
>>>
>>> I created a similiar yet untested patch version for hci_h5 [1]. Maybe it's useful.
>> Looks good to me, but you may need to add firmware-postfix.
>>
>>> Just a comment about the binding. It's really necessary to add the reset-gpio? Can't we use the enable-gpio with inverse polarity for this?
>> Yes, we can use enable-gpio instead of reset-gpio on pine64 and pinebook.
> Then why do we have both? Reset and enable are distinct. The inverse
> of enable-gpios is typically powerdown-gpios, not reset-gpios.
>
> Rob

Both data sheets that I know:

http://cit.odessa.ua/media/pdf/Intel-Compute-Stick/FN-Link_F23BDSM25-W1.pdf
http://files.pine64.org/doc/datasheet/pine64/RTL8723BS.pdf

BT_RST_N BT Reset IN / BT_DIS# General Purpose I/O Pin

So from the datasheet there is only one pin. And from its name it sounds 
like reset.

This said though the datasheets of these Realtek devices are a bit thin ....

