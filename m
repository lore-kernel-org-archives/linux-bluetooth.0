Return-Path: <SRS0=2sDM=QZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3A1C4360F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Feb 2019 21:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA55D2070D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Feb 2019 21:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550524239;
	bh=cciVyw5O4lvXY2g1ad2JMXM9Yge+uqQjZG1+z0+NScE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=abQq7QaQrpEBaCeajV4qP9t02f38avZkgLEea7dP/rVVLHFiOpfmh75I8ScfFiKPg
	 0FbQQQC/mRg467BuHHQkBMtY9cEPcKcpO0Z30C5VQVBKkiNMBw/ElJDWPyUaxFS3wT
	 thukJQ+E05BG7ur4dp6v7Y4S2GnAg3l8zRDog2vE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfBRVKi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:10:38 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41906 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfBRVKh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Feb 2019 16:10:37 -0500
Received: by mail-ot1-f66.google.com with SMTP id t7so14247240otk.8;
        Mon, 18 Feb 2019 13:10:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vfh9VEg4/DD5W56HTE1UyJO7PeETQccNa3gxtKG5ZfU=;
        b=akheDIgih6T3XPQJs3PUizv1stR3h6fZv8MTN2nmX9TZCRy2n7HYxxrXzwdqe/A4Ts
         qEKIclRaC9N7MKlwlsJhxGOZcHOFHhTPo0wFY7FGcOWfXRZC5Cthq/V5NuxloYcwRjpP
         jq9TaPInBteZZqcIDFSZgDGbR6G2uVULHF2ItT2Nj4iIYPfSG1s4nLnf5BxeQWIKohdO
         jWBdUqX+twr2cnPsgDbbR4HyfDy3XZWaSj9ez6NHqtor2gd7EzrVXohKDimcd2VEHBjc
         8RZ6DxouhvlgsB2jfDm3lnlfB7cV90HG/6HH0SZcQnHME4IbPyHFUKM/CH/Et9PcV7O5
         16pg==
X-Gm-Message-State: AHQUAuYpRsjycf1M2FPTgt9qkrC16omsVIe4cQaXmcXjS1QlSwyZnwGz
        qKswCpR8xud6yavoLPykzA==
X-Google-Smtp-Source: AHgI3IaBxXUPWP1IeKYNVsruYCspdQ3LnjBv1J7NyA3zKPf1UcF887+r635FYe1HPhnH9k5lbjcAmQ==
X-Received: by 2002:a9d:2f64:: with SMTP id h91mr15620192otb.14.1550524236851;
        Mon, 18 Feb 2019 13:10:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d11sm4453324otp.18.2019.02.18.13.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 13:10:36 -0800 (PST)
Date:   Mon, 18 Feb 2019 15:10:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
Message-ID: <20190218211035.GA28145@bogus>
References: <20190118170232.16142-1-anarsoul@gmail.com>
 <20190118170232.16142-4-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118170232.16142-4-anarsoul@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
> Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> new file mode 100644
> index 000000000000..8357f242ae4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> @@ -0,0 +1,35 @@
> +RTL8723BS/RTL8723CS Bluetooth
> +---------------------
> +
> +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
> +BT is connected over serial. It speaks H5 protocol with few extra commands
> +to upload firmware and change module speed.
> +
> +Required properties:
> +
> + - compatible: should be one of the following:
> +   * "realtek,rtl8723bs-bt"
> +   * "realtek,rtl8723cs-bt"
> +Optional properties:
> +
> + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
> + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
> + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
> + - firmware-postfix: firmware postfix to be used for firmware config

How is this used?

Rob

