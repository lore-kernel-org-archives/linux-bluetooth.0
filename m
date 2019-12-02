Return-Path: <SRS0=9PGa=ZY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C503DC43215
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 19:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DCC21835
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 19:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="emEElaLY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QHVRb8Jk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfLBTDJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:03:09 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39347 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727963AbfLBTDI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Dec 2019 14:03:08 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3CEA622091;
        Mon,  2 Dec 2019 14:03:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 02 Dec 2019 14:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=2vsm1/M5oTih6PJrh0YiOplzSPP
        8P4CXH6c05UTxHWg=; b=emEElaLYMa7YTVxguo6O1JQpmULBWsQ8tCKQT40jEed
        DPonOo/EJ6Qo1PQXi5UAxjQskTDGQ5GcZcORZgPSP+HRUODnb8IDqmei41DKQBf6
        4y/coegy6oy00NC15tf7OlQQ4dII7GMjYHNOAT3GaDLCrJmNTIaFlaO/nVIkzZYM
        XPAbbTQNDjVMI+ne9NAA0HNSGZkQekZjC2EUIu/Amga3TEWWy3varfZM8SHrNSk+
        3EKyFIzhH/pMO+TrfLGrAXnOxPRUiDHrzOkkNfFgWpGbFAQibZjwwXuDkVIBRI0Y
        YVGVZaj/tTTrsHQ+UoSY1IP++1+e3GShPvYgKDpB3Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2vsm1/
        M5oTih6PJrh0YiOplzSPP8P4CXH6c05UTxHWg=; b=QHVRb8JkbRYNbW6TLzImSt
        DOQGijgw3aC3Zpy8GqUfo1yKSSw1b+oHfP4gdGqKOTSGaDnTX9x781kaZcJUpQjO
        C+8g5XaBynieIHbdCYmYnCtYicO1mjiTjSGaMxW+2R7P7T6sJaL7nvCqEpeh3kYZ
        m7s0/RRU26C4tqUwdrssN4Mu4xBw4KIXlMhkwDY+LzXCqFyQxUGGIRLhjWWKpyUf
        lpWFBiFhu7K+pTnhb/YFxARY2mH/8LunmoFvrCcPFrIOxpNBxBIsLKfrs3Zqcvuz
        3y7ITE0e3wx2ng8i1hUu3vgNIkTm/zzVsA4yVXABcEQ7EJoT7IggH5LOV2M03Y8Q
        ==
X-ME-Sender: <xms:6F_lXUYkjCDp7aUKrGmmwCMNBFzeAw81dUTdzhzpM-SRt-tsprW0kQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejhedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrg
    hinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppeeltddrkeelrdeikedrjeeinecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghhnecuve
    hluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:6F_lXTpL74kHEYUIPLaioHXFibx3i96q0k402yCDBXM5ROBaIhsVFw>
    <xmx:6F_lXZ8QnB85PrZ_qdEYnJiVaVC6UNOeSKfljlDgusDL5BWPmB-Gcg>
    <xmx:6F_lXS_39O-3u8Iccr2W8i_mdIx6Ewy4ilp_bAldYeS6UUWdPo3c-w>
    <xmx:61_lXSCv4qsCFuTtwGjN70SkTnAe13F5ACWRy4uqnIVBvvXksPekhg>
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2FC1A80064;
        Mon,  2 Dec 2019 14:03:04 -0500 (EST)
Date:   Mon, 2 Dec 2019 20:03:02 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: net: bluetooth: add DT bindings for
 Realtek controllers
Message-ID: <20191202190302.5rtv3p6wkyol4y4b@gilmour.lan>
References: <20191130202314.142096-1-bonstra@bonstra.fr.eu.org>
 <20191130202314.142096-2-bonstra@bonstra.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qkf2aoim2t2545gg"
Content-Disposition: inline
In-Reply-To: <20191130202314.142096-2-bonstra@bonstra.fr.eu.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--qkf2aoim2t2545gg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Nov 30, 2019 at 09:23:12PM +0100, Hugo Grostabussiat wrote:
> The rtl_bt driver already supports some Realtek controllers on ACPI
> platforms.
> This commit adds bindings for DT-only platforms.
>
> Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
> ---
>  .../bindings/net/realtek-bluetooth.yaml       | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
> new file mode 100644
> index 000000000000..6b62e5132c90
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/realtek-bluetooth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek Bluetooth controllers device tree bindings
> +
> +description: |
> +  Device tree bindings for serial attached Realtek Bluetooth controllers.
> +
> +maintainers:
> +  - Marcel Holtmann <marcel@holtmann.org>
> +  - Johan Hedberg <johan.hedberg@gmail.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: realtek,rt8723bs-bt

This can be
compatible:
  const: realtek,rt8723bs-bt

> +  powerdown-gpios:
> +    description: GPIO line controlling the power down (BT_DIS#) signal
> +    maxItems: 1
> +
> +  device-wake-gpios:
> +    description: GPIO line controlling the device wakeup (BT_WAKE) signal
> +    maxItems: 1
> +
> +  host-wake-gpios:
> +    description: GPIO line sampling the host wakeup (BT_HOST_WAKE) signal
> +    maxItems: 1
> +
> +  firmware-name:
> +    description: |
> +      Name of the configuration file to load in addition to firmware
> +    $ref: http://devicetree.org/schemas/types.yaml#/definitions/string
> +
> +required:
> +  - compatible

Setting additionalProperties to false would be great here too.

Thanks!
Maxime

--qkf2aoim2t2545gg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXeVf5gAKCRDj7w1vZxhR
xSZyAP9Jq4dzAGIuHEpsruCUumvqfk6iJEGz7e9fEM+G3oj0wwD+LgrZzvPLSgPc
NVwLv6OPXK2Cqo/tcGM7SAjNGX8VwAc=
=4oWJ
-----END PGP SIGNATURE-----

--qkf2aoim2t2545gg--
