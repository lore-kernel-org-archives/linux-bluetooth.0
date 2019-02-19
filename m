Return-Path: <SRS0=iCSy=Q2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F49AC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Feb 2019 08:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FB821902
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Feb 2019 08:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfBSI5R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:57:17 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:58055 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfBSI5R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Feb 2019 03:57:17 -0500
Received: from [192.168.178.52] ([109.104.34.73]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MKbwg-1gdFs63oVQ-00L0kR; Tue, 19 Feb 2019 09:56:50 +0100
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
References: <20190118170232.16142-1-anarsoul@gmail.com>
 <20190118170232.16142-4-anarsoul@gmail.com> <20190218211035.GA28145@bogus>
 <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <6a61bca4-c458-6d98-68e6-ef49b191019c@i2se.com>
Date:   Tue, 19 Feb 2019 09:56:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:wht6XshRJSZw5SLNmwIESxEopFXtFOue70HBGTSF/lanmGZEk/Y
 R2ylCRKk0ZRx6XLP5vaFMef1GNeaefi06BeJpMcw9UtD7Q7bxr+ET8taXfQH8ddiYw/QpRa
 TEd2D9XH9H9ImIVf68UKptZBYgQ/jZ3aVvJCXjMEXWUjp1p8THWwtMDNL0F5OdShGBaS6lF
 Gv/k2tJ7sfldcRjdijX6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FJk39dRHJ7M=:kxq/7OnfQ6e1kyQzD0rjo5
 Wbt6Kw4DCj6DPRl+7ABjSCDOmy8TwsPgTDYPIac1Eh1QdVkmSlgpyTLA2MTPURAVKsAhTXhgP
 sZmg2JDOBtmQxeDlMdUSeV3VNIYigmmuZO7FNihU0tOXkv3npcYouhg3RVNYVgmGSFUkzkh97
 1XIUj4yDmlKUZKGcOl2bJ4ZwXGBHeiXYirv/29wxg2tTjGt5txzhFD3QIlwMBtIg9Plzt5CV8
 SptsFJIlkm79oNPY3kxJBUg81lv5ZcyZNyldlu9jZzslHibQayU1yrqvny3GrPLDmSDmqdZnz
 x94rsRxj6Ja3PMFhmPWjzqB8DsNUbZA4BwmE9BTbNubUibnGN1jHxSJ55idB2NoPkFgR0unWa
 ChnBHFHeH+BzLLFil3o2v8ec2+XT5g+ttu4FCWCo/GcbnCvAnA7WxlHX6fxYVOI2T6vU2QHb3
 tU8t0ZsOsAeKFCY3AQztTfgpGaLShMOaNYo0tlidbnTFEEZTzqkm8Z9H2JL4QmKUEzlWfYm6g
 lUKBxJsvddupDqOABB84gTmNDy76XLQA+viMVAKtotoTi/08vUttulCWGvghpzySBzbiezho2
 KEVh57ndTMWpU8Y+d7sU3IzTGyjzjqzHJ1Me94cl7++iISJPakBObaxTVOEqK3hCmmmTxBVfT
 RnnreOH7CmarQvv0yHTUCVvMN5RoKXG5b0qeLNwerxgfaxilHeQNkG9I0WfKpehkMQfvxW383
 lddEDeyq8JFXZdGlmh9WUQPg5Pi25tyZJKeImhfe9N6sV3z1fKVt9r8I28wKZanKg2C2Be3/w
 guTPTlsUJxqQL2sYoHikoXyRAnXgULrvSb4Uq27ANyy03fCzC1OCgu9IYFPzOAdgnRJ9vae68
 hN+W9KQj2vtH5XpwzxcQ==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Vasily,

Am 18.02.19 um 22:24 schrieb Vasily Khoruzhick:
> On Mon, Feb 18, 2019 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
>> On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
>>> Add binding document for bluetooth part of RTL8723BS/RTL8723CS
>>>
>>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>>> ---
>>>  .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
>>>  1 file changed, 35 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
>>> new file mode 100644
>>> index 000000000000..8357f242ae4c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
>>> @@ -0,0 +1,35 @@
>>> +RTL8723BS/RTL8723CS Bluetooth
>>> +---------------------
>>> +
>>> +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
>>> +BT is connected over serial. It speaks H5 protocol with few extra commands
>>> +to upload firmware and change module speed.
>>> +
>>> +Required properties:
>>> +
>>> + - compatible: should be one of the following:
>>> +   * "realtek,rtl8723bs-bt"
>>> +   * "realtek,rtl8723cs-bt"
>>> +Optional properties:
>>> +
>>> + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
>>> + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
>>> + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
>>> + - firmware-postfix: firmware postfix to be used for firmware config
>> How is this used?
> rtl8723bs-bt needs 2 firmware binaries -- one is actual firmware,
> another is firmware config which is specific to the board. If
> firmware-postfix is specified, driver appends it to the name of config
> and requests board-specific config while loading firmware. I.e. if
> 'pine64' is specified as firmware-postfix driver will load
> rtl8723bs_config-pine64.bin.

this is a common problem (e.g. brcmfmac has the same problem [1]).

Why not using the "model" property instead of inventing a new software
specific property?

[1] - https://patchwork.kernel.org/patch/10764463/

>
>> Rob
>>
> _

