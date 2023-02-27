Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5925C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Feb 2023 04:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjB0Etm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Feb 2023 23:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjB0Etl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Feb 2023 23:49:41 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F525FF31;
        Sun, 26 Feb 2023 20:49:25 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6ED8032001C6;
        Sun, 26 Feb 2023 23:49:22 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute5.internal (MEProxy); Sun, 26 Feb 2023 23:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1677473362; x=1677559762; bh=4d
        +M82rxS2ilvQGtMbSyOF3k0B4HgMWmUhmiwlaDXqU=; b=kXR6sS98fTXBb5o8t4
        nkK3s4aXdFsVDwtN/OZuJVfMtyPMULkf/u3PY4jS70u/Q8k4zZzQJ+AvD5ubRsm9
        yQj0fbPV42wCi5nvnwKW5JmzJgt7TmVInwlOY3N/Yhnq7o7J6IC6X656RpiVCEIy
        iwE8PCG6+YpZARF1bpLLXFmZZHIwNZzmZSj0HydWaqna0vK7O2gQ86w3rrloELFG
        Aplky0EUpHUozb/6pJ7esAbg4Ybm9scQVSZLOnnDveO2qryWS0D8S71dwL24nFy3
        nWkhQ5ZJoNt3yOVXOZYkugb9P7z6ir5ojQk259NpoptBGgVjJHu4MnPm4RssOkxW
        TxIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677473362; x=1677559762; bh=4d+M82rxS2ilvQGtMbSyOF3k0B4H
        gMWmUhmiwlaDXqU=; b=TCeG7wVvTlycIr/eNuzR2hc3bdetnoeAIDvwKPU8pp7Q
        2T13wEb1AB4UOC1EsP4FekqucjHu/7O7NfCkrXBBMyYkuqINqOTpeXAe1IH9A3Ih
        Tj80b/rLzXkIUfikfzUn37xr/SHQVFWRA7bQHH/LuPLg/MdD4pO8PNP51qs4aTgF
        CGGce8FJuFMU0j89iqXCtfofERdeosLzh5QrxueDuMLb7tC5oXd6mlS5fOCROE8a
        oRk3L/DSE+gbWiibg8H8Kwzi2aPmo2xXWuB7xo63NjJ6zoDhY5j7hD2R0cKxgmEA
        gvg8JBhyuvRyKZQ5yI03mUTrFjlP90Hrkjhc2VxKOQ==
X-ME-Sender: <xms:UTb8Y2sbaXD1Xwx6fzxcvxj3jlcl_oXGYdycdhk9HvfX1QsunBkMZw>
    <xme:UTb8Y7fq_KOk9dK7KgA4yaubgCRd31DZCeDt8ll7NDLmqUjM4PXIcRbztZmcG_wBr
    OpebFa9pW2Czj05uFc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekledgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpeetlhhi
    shhtrghirhcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrf
    grthhtvghrnhepudejjeeltdfgjedtieeileduhfeftdfhhefhffehiefhtdeiuddtvdek
    keejfffhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghl
    ihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:UTb8YxyypBeBPhlg2Gkm_90bIOqaOdT-KQ85aqCZlt-UGyWyvjiz7w>
    <xmx:UTb8YxNq2Mc4LscAwktSsbeYzJQWRTl_BPvAfU2bAQJxR5Z15sORfg>
    <xmx:UTb8Y28AOgbgxWjvOv-NWpMZxbSr2EDWYHnhIx0W-B9cXovdGh0Kuw>
    <xmx:Ujb8Y5Y1eLzCmdqkGFXtygDIgpdmxTEV3cGIgUYjfX11mnKqGc_HQg>
Feedback-ID: ifd214418:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6946A2D40074; Sun, 26 Feb 2023 23:49:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <ce2df843-dc68-49af-9551-48769c26871a@app.fastmail.com>
In-Reply-To: <20230224232339.124969-2-macroalpha82@gmail.com>
References: <20230224232339.124969-1-macroalpha82@gmail.com>
 <20230224232339.124969-2-macroalpha82@gmail.com>
Date:   Mon, 27 Feb 2023 14:49:01 +1000
From:   Alistair <alistair@alistair23.me>
To:     "Chris Morgan" <macroalpha82@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        "Vasily Khoruzhick" <anarsoul@gmail.com>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        "Johan Hedberg" <johan.hedberg@gmail.com>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Chris Morgan" <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/3 V2] dt-bindings: net: realtek-bluetooth: Add RTL8821CS
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, 25 Feb 2023, at 9:23 AM, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add compatible string for RTL8821CS for existing Realtek Bluetooth
> driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

Alistair

> ---
> .../bindings/net/realtek-bluetooth.yaml       | 23 +++++++++++--------
> 1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
> index 143b5667abad..f91d06d629b9 100644
> --- a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
> @@ -4,24 +4,29 @@
> $id: http://devicetree.org/schemas/net/realtek-bluetooth.yaml#
> $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: RTL8723BS/RTL8723CS/RTL8822CS Bluetooth
> +title: RTL8723BS/RTL8723CS/RTL8821CS/RTL8822CS Bluetooth
>  
> maintainers:
>    - Vasily Khoruzhick <anarsoul@gmail.com>
>    - Alistair Francis <alistair@alistair23.me>
>  
> description:
> -  RTL8723CS/RTL8723CS/RTL8822CS is WiFi + BT chip. WiFi part is connected over
> -  SDIO, while BT is connected over serial. It speaks H5 protocol with few
> -  extra commands to upload firmware and change module speed.
> +  RTL8723CS/RTL8723CS/RTL8821CS/RTL8822CS is a WiFi + BT chip. WiFi part
> +  is connected over SDIO, while BT is connected over serial. It speaks
> +  H5 protocol with few extra commands to upload firmware and change
> +  module speed.
>  
> properties:
>    compatible:
> -    enum:
> -      - realtek,rtl8723bs-bt
> -      - realtek,rtl8723cs-bt
> -      - realtek,rtl8723ds-bt
> -      - realtek,rtl8822cs-bt
> +    oneOf:
> +      - const: realtek,rtl8723bs-bt
> +      - const: realtek,rtl8723cs-bt
> +      - const: realtek,rtl8723ds-bt
> +      - const: realtek,rtl8822cs-bt
> +      - items:
> +          - enum:
> +              - realtek,rtl8821cs-bt
> +          - const: realtek,rtl8822cs-bt
>  
>    device-wake-gpios:
>      maxItems: 1
> -- 
> 2.34.1
> 
> 
