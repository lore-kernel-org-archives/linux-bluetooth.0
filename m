Return-Path: <SRS0=J5Bo=YA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7F2C352AA
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Oct 2019 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B2921655
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Oct 2019 10:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZQ13ROs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfJGKIB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:08:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35131 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJGKIB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Oct 2019 06:08:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id v8so11848962eds.2;
        Mon, 07 Oct 2019 03:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dn9u+AQKVD5vEeR5O+ZMbgafJ8myFQvunYd7F14BjUc=;
        b=tZQ13ROs/x70DbNqEI/FjmJoV1nMwJQmdxKd20Erg9hO06T/BCXd1yb2JpVwNWtYir
         ei4t43xOj29kj35hefm+zMFbtsSfHrSlSTt2sb5pjeHiiUuc7vKYIGWOC+7UC2X5Wb2K
         0o4fyXxxRKQtZFJj80q6J2+deGfTQFbjQ1x1SrPxRfmSdE8nCak9eSispdRXbyrEdavV
         SUfminpAhmLnOBItMWFDY9E7VCTSV3j74gQU44OV/1zZZWD4EvTd1BF5Ebkg1J55rwQR
         eF5RTGqf16LAxTrktdoavwQC0OeDVsX/50V2a6MXMhT1qCj8cGvuB732S94oa8cfAoIC
         RZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Dn9u+AQKVD5vEeR5O+ZMbgafJ8myFQvunYd7F14BjUc=;
        b=AP9Xid4wY0T2toRLSsiCahmidyU6B+SFtMnWN+sTN4jHCrm8xWFp8jPg+OXx0KzRxy
         a9v8qie0uYrZu7ujjS1bHJKF3UNJivGPmJ+aSueyiEXa8eeBHQJL67VuNjTi+T1pzy9c
         F/T9ge2c7QfqBlBhvye1iQ/KDxLeqzR5PuQ7TPBQgmiOJEHJh222y020r5Up0PzMmzRg
         J/niULUHAPZJHtswz7N23WVGcCLONMVmMSxOCw6riLBRgyP1Jj23MWJlujLgvMA7Af6X
         sEsPo3jCwtO9ra2qntYD8iGb0PPSnBpXSbF8bIlsLET9BvCda1kCjFJXbXXNUfTMBV8I
         SBXw==
X-Gm-Message-State: APjAAAXw+bJTDJC0SewGdOOXkgDEBhkDRwh+AOJ9kFaMYLNKTUPBdAYG
        vM04fFfUa9pNnVbWyNFr71Q=
X-Google-Smtp-Source: APXvYqxd3RPv7VVa3gnsqkSTt5rIlFKbSDaX2ZGZ2Tr4Yxvx1eqpjxYnWugNAfXvvHrr3tA/u3JUdA==
X-Received: by 2002:a05:6402:2022:: with SMTP id ay2mr28181500edb.109.1570442878236;
        Mon, 07 Oct 2019 03:07:58 -0700 (PDT)
Received: from ziggy.stardust ([37.223.136.165])
        by smtp.gmail.com with ESMTPSA id r16sm3173394eds.72.2019.10.07.03.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 03:07:57 -0700 (PDT)
Subject: Re: [PATCH V4 00/10] ARM: Add minimal Raspberry Pi 4 support
To:     Stefan Wahren <wahrenst@gmx.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-bluetooth@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <fd251f79-0fd8-5e5b-c3de-e87bdeb8299a@gmail.com>
Date:   Mon, 7 Oct 2019 12:07:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



On 06/10/2019 17:28, Stefan Wahren wrote:
> This series adds minimal support for the new Raspberry Pi 4, so we are able
> to login via debug UART.
> 
> Patch 1:     Bluetooth driver fix
> Patch 2-3:   Fix some DT schema warnings
> Patch 4-5:   Prepare DTS for the new SoC BMC2711
> Patch 6-9:   Add Raspberry Pi 4 DTS support
> Patch 10:    Update MAINTAINERS
> 
> Unfortunately the Raspberry Pi Foundation didn't released a
> peripheral documentation for the new SoC yet. So we only have a preliminary
> datasheet [1] and reduced schematics [2].
> 
> Known issues:
> Since Linux 5.3-rc1 DMA doesn't work properly on that platform.
> Nicolas Saenz Julienne investigates on that issue. As a temporary workaround
> i reverted the following patch to test this series:
> 
> 79a98672 "dma-mapping: remove dma_max_pfn"
> 7559d612 "mmc: core: let the dma map ops handle bouncing"
> 

Just for reference, the patches from Nicolas are queued for v5.5 inclusion, so
it is a better basis to test using his series:
https://patchwork.kernel.org/cover/11141719/

Regards,
Matthias

> Changes in V4:
> - add Rob's Reviewed-by
> - enable ZONE_DMA for ARCH_BCM2835
> - fix spi reference in bcm2711.dtsi
> - fix bluetooth section in RPi 4 dts
> - drop "always-on" for armv8-timer
> - add necessary Bluetooth driver fix
> - add arm64 dts link
> - additional comments to the dts files as requested by Florian
> 
> Changes in V3:
> - rebased series
> - add Reviewed-by
> - enable ARM_GIC for ARCH_BCM2835 on arm64 too
> - configure i2c pull-up in bcm2711.dtsi
> - move i2c2 to bcm2835-common.dtsi
> - add missing compatibles to DT schema as suggested by Rob
> - fix DT schema warnings in dtsi files
> - replace brcm pintrl with generic pinctrl as suggested by Linus
> - make dma_zone_size depend on CONFIG_ZONE_DMA as suggested by Matthias
> 
> Changes in V2:
> - use separate board file for BCM2711
> - enable ARM_GIC for ARCH_BCM2835
> - add Acked-by and Reviewed-by
> - fix arm-pmu and timer nodes for BCM2711 reported by Marc Zyngier
> - enable HDMI at board level
> - move HDMI and pixelvalve into bcm2835-common.dtsi as suggested by Eric Anholt
> - fix DWC2 probing warning by setting USB role to peripheral
> - fix order of node references in bcm2711.dtsi
> - disable I2C clock stretching quirk for BCM2711
> - mark PLLD_PER as critical clock
> - make PLLH clock unavailable on BCM2711
> - fix compile warning in clk-bcm2835 for arm64
> 
> Changes since RFC:
> - change BCM2838 -> BCM2711 as discussed in RFC
> - update MAINTAINERS accordingly
> - drop "spi: bcm2835: enable shared interrupt support" from series
> - squash all pinctrl-bcm2835 changes into one patch
> - introduce SoC specific clock registration as suggested by Florian
> - fix watchdog probing for Raspberry Pi 4
> - convert brcm,bcm2835.txt to json-schema
> - move VC4 node to bcm2835-common.dtsi
> - fallback to legacy pull config for Raspberry Pi 4
> - revert unintended change of mailbox in bcm283x.dtsi
> - add reference for arm64
> 
> [1] - https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2711/rpi_DATA_2711_1p0_preliminary.pdf
> [2] - https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_4b_4p0_reduced.pdf
> 
> Stefan Wahren (10):
>   bluetooth: hci_bcm: Fix RTS handling during startup
>   ARM: dts: bcm283x: Remove simple-bus from fixed clocks
>   ARM: dts: bcm283x: Remove brcm,bcm2835-pl011 compatible
>   ARM: dts: bcm283x: Move BCM2835/6/7 specific to bcm2835-common.dtsi
>   dt-bindings: arm: Convert BCM2835 board/soc bindings to json-schema
>   dt-bindings: arm: bcm2835: Add Raspberry Pi 4 to DT schema
>   ARM: bcm: Add support for BCM2711 SoC
>   ARM: dts: Add minimal Raspberry Pi 4 support
>   arm64: dts: broadcom: Add reference to RPi 4 B
>   MAINTAINERS: Add BCM2711 to BCM2835 ARCH
> 
>  .../devicetree/bindings/arm/bcm/bcm2835.yaml       |  54 ++
>  .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |  67 --
>  MAINTAINERS                                        |   3 +-
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts              | 123 +++
>  arch/arm/boot/dts/bcm2711.dtsi                     | 844 +++++++++++++++++++++
>  arch/arm/boot/dts/bcm2835-common.dtsi              | 194 +++++
>  arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   4 -
>  arch/arm/boot/dts/bcm2835.dtsi                     |   1 +
>  arch/arm/boot/dts/bcm2836.dtsi                     |   1 +
>  arch/arm/boot/dts/bcm2837.dtsi                     |   1 +
>  arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi  |   7 +
>  arch/arm/boot/dts/bcm283x.dtsi                     | 190 +----
>  arch/arm/mach-bcm/Kconfig                          |   4 +-
>  arch/arm/mach-bcm/Makefile                         |   3 +-
>  arch/arm/mach-bcm/bcm2711.c                        |  24 +
>  arch/arm64/Kconfig.platforms                       |   5 +-
>  arch/arm64/boot/dts/broadcom/Makefile              |   3 +-
>  arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts   |   2 +
>  drivers/bluetooth/hci_bcm.c                        |   2 +
>  20 files changed, 1272 insertions(+), 261 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
>  create mode 100644 arch/arm/boot/dts/bcm2711-rpi-4-b.dts
>  create mode 100644 arch/arm/boot/dts/bcm2711.dtsi
>  create mode 100644 arch/arm/boot/dts/bcm2835-common.dtsi
>  create mode 100644 arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi
>  create mode 100644 arch/arm/mach-bcm/bcm2711.c
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts
> 
> --
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
