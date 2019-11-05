Return-Path: <SRS0=VFYa=Y5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F0AC5DF62
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Nov 2019 23:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC8321D7D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Nov 2019 23:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bonstra.fr.eu.org header.i=@bonstra.fr.eu.org header.b="Kx/WZG/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfKEXZB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:25:01 -0500
Received: from vault.bonstra.fr.eu.org ([51.158.68.104]:39702 "EHLO
        vault.bonstra.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfKEXZB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Nov 2019 18:25:01 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Nov 2019 18:24:58 EST
Received: from val.bonstra.fr.eu.org (unknown [192.168.128.2])
        by vault.bonstra.fr.eu.org (Postfix) with ESMTP id A04E4BFAC5;
        Tue,  5 Nov 2019 23:18:16 +0000 (UTC)
Received: from [IPv6:fd7b:45cc:aa3d::3] (vlad.gr1 [IPv6:fd7b:45cc:aa3d::3])
        by val.bonstra.fr.eu.org (Postfix) with ESMTPSA id E8E5061384;
        Wed,  6 Nov 2019 00:18:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bonstra.fr.eu.org;
        s=dkim1; t=1572995896; x=1574205496;
        bh=c+12pXtSQjrl82OMI8b6OQudVV8kwcNsMllQXf/cjLI=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To;
        b=Kx/WZG/AzriX+F11bjD7JGCsa1frx+nNcpdx/XPCN7DWfmvWO+6lyF/HeRL0tMxAE
         5oR/yHd6IeN4ZjVPPorkmbQMp+24Fl14mcG1bD+IxpsneW6x9VqxfM9dmSVLADTqei
         33gaTms+xKliIHDYxMr4AYPxzuJVwyZyxkhq8g48nznGPaMY1vSaDQIgTnsFDt7rBN
         BhIZRosidFNMrt2HJZ8mPiBSxQyvERmwXuzRP3Axjae7pG1oMPQq/aGh19x4CefN82
         OrYdA/YWVigCx3gAjXaRmgEA7h+rCqYvl13LvmSIwDkSfkSURFy6KvWm85CiNrGKdZ
         XI7VubotryDTg==
To:     Rob Herring <robh@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
References: <20191030224333.70241-1-bonstra@bonstra.fr.eu.org>
 <20191030224333.70241-2-bonstra@bonstra.fr.eu.org>
 <20191105221756.GA15425@bogus>
From:   "Hugo \"Bonstra\" Grostabussiat" <bonstra@bonstra.fr.eu.org>
Autocrypt: addr=bonstra@bonstra.fr.eu.org; prefer-encrypt=mutual; keydata=
 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
 WCPfayXqHuvY/CkKPw==
Subject: Re: [PATCH v2 1/3] dt-bindings: net: bluetooth: add DT binding for
 Realtek controllers
Message-ID: <45ed51fc-baa1-122c-b9e1-188bf83397c0@bonstra.fr.eu.org>
Date:   Wed, 6 Nov 2019 00:17:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191105221756.GA15425@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Le 05/11/2019 à 23:17, Rob Herring a écrit :
> On Wed, Oct 30, 2019 at 11:43:31PM +0100, Hugo Grostabussiat wrote:
>> The rtl_bt driver already supports some Realtek controllers on ACPI
>> platforms.
>> This commit adds bindings for DT-only platforms.
>>
>> Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
>> ---
>>  .../bindings/net/realtek-bluetooth.txt        | 25 +++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt

>> +- config-name: postfix added to the name of the firmware file
>> +  containing the chip configuration
> 
> 'firmware-name' is the common property for this. It's the full filename 
> which is more flexible. 
> 
> What's the default name?
Depending on the chip, both a firmware file and a configuration file may
be required; the RTL8723BS is one of those chips.

For the firmware file, the default name is of the form:
rtl_bt/${CHIP_NAME}_fw.bin

For the config file:
rtl_bt/${CHIP_NAME}_config
