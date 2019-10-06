Return-Path: <SRS0=Uexg=X7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361F4C4360C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E28C20835
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Dy2wdAZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfJFP3X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 11:29:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:38857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfJFP3Q (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 11:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570375736;
        bh=D9EXbZWdNzUEMKJgC9st3p2SqLaVHrzEQ2VeUp/pJgc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Dy2wdAZcfCOjc9DKMO4G6S4p4rKkFX/zkBUy45mXLjW6ZS0yLM5X/YdGuXVaMclyW
         RBmCk53r7AE6AVKEk600rS7Uf60NUZUixgWcopLQZpPcBIa+8I567INoZIWo1TqJXK
         LPa+A12hI/SJmYfNI/K0ijcetmTn0no0OLFj9EFA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.116]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M72sJ-1iBNQt0eQp-008bhB; Sun, 06 Oct 2019 17:28:56 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V4 00/10] ARM: Add minimal Raspberry Pi 4 support
Date:   Sun,  6 Oct 2019 17:28:18 +0200
Message-Id: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:oaevrIPGssMFFjgefH6bCBqGETYjbu6kvokh66JCjc8pzkbzgCn
 DduSlK/gv0//R/+upcRK6CZgVQqBmFkw9pmMBi2uIyuJ4imOQqV2WvfkVH173bLaQJbG8No
 9K0JvL5w4KwixDtDju0KS4b5plDqf2Z+lRf0xCOueFWmpmDxAQvUfUxr8GKIORHmaNH9JMO
 Fc2JPAe8NHraHgjucEynQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3lhL9fo9LXc=:aAW2l6Zdjh2q+QoFDgPCVI
 zqnMD5T8oL0CRty6U22ldNDK993Z2iM/oHnP8AThn3AiAwJU1V11o3gEBl1gN8bomN8p+sSY8
 XZVc2qM7DiYJaniqQOun6C4daDlszk6g3+HrKdgOG2ftzhBA1s5cXUw0dTUVZjGkSnjawtA/C
 rGFIy1OdxwfvcvcH6+wQGd4Xw+Gt+FKI9UVYpgD231O3C59GsMUbuXH8/nORZy7jmCkcvSc5l
 s08VbWPfxkPVBwOMyhaN+z+Jzp0J+YVDdnNlkAYl/ARV5XOzYQcbZuOzAUqxw77ChRI91geEQ
 aOtP9RtvDSTPybo450zyhOohsggqlTS1qYd4c+NS61yWuRAzNwzIXZRsc/I9Telt8YLp0j4RB
 a77vq7i7QMszjEZXQ3HoEjO+4LzQ7/0v4leFWZ15GZU5Rytm+v1NxHKOwKVZjvNGRfRIvj7qU
 rSY2qcKex2ZdTjNJd9nqPfbpsdUpnTx0L5O6C1EWeVVpeho/U2ialyswX/yMjHO9iCSP5esYh
 t+IyXIDTb7ykz6ILDdOBijMf76zaUPFgWKRGlemwRm/1zLKkPA5fAs9HjmrhVIwvsuxdnf9ct
 0rWVwnLNzMJzsBIpTIixd0u1R/HQBxzqci8eetzd7uFPIk9LCoPOUtAwpKvTBjye3UNpdGqr2
 SZNwwozAl5yaXkh35242bTY0My86jN4zK4M0loLDjujLNhnqHqWyamkg54GLNYMKSNkhuPYWK
 JdqNNbuBBAX1uvzQcS4QOMgHJhL+XInCCPcOKBu4NVspmxADm/A8RhfHfhnZiXZLsv96FgEmQ
 Y+wYWtg75d3mzLrKqjFb3Jh81pgugFwsG9lCWqRTqe5ea9NQJ6kav6rEyztWfScmW8d4bRCBM
 m6Ae39MtREFhm/mk4RkpXBIzfXEonkriPRVg6CL5W9DbnEbUUWr1ne70oq0MiYdxo2s6HeX4p
 hDyIaawD7sMGwS2DW1Nc6b/Fx+AlYQTg6TfRKhN9d1S0TncS08kivghH1rdQDX+EmOJvFjN63
 Sj3fynHJ2HGa53yT6TB13nORnxk10maexznek/NykFclnHZAhMgZwtwtj9aNyW8ibp3aWPU04
 1/tDWZHmlU34sK15s7yJgLuvXofOMW+UMXVEuDXktTC/8OEPtTNj8I1jBI5gbzqegz/0pqs2b
 QP7xJnpCgCRD5jjzi9qktVGN2rzQCoTkS0tEN7SmbnwzTvNJLJ4WEz1FvoykQlMmGoxeh4DGK
 YQGt7Douc7BJjTJm9WFO5LPiPo3UGvYbx3ccp4Q==
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series adds minimal support for the new Raspberry Pi 4, so we are abl=
e
to login via debug UART.

Patch 1:     Bluetooth driver fix
Patch 2-3:   Fix some DT schema warnings
Patch 4-5:   Prepare DTS for the new SoC BMC2711
Patch 6-9:   Add Raspberry Pi 4 DTS support
Patch 10:    Update MAINTAINERS

Unfortunately the Raspberry Pi Foundation didn't released a
peripheral documentation for the new SoC yet. So we only have a preliminar=
y
datasheet [1] and reduced schematics [2].

Known issues:
Since Linux 5.3-rc1 DMA doesn't work properly on that platform.
Nicolas Saenz Julienne investigates on that issue. As a temporary workarou=
nd
i reverted the following patch to test this series:

79a98672 "dma-mapping: remove dma_max_pfn"
7559d612 "mmc: core: let the dma map ops handle bouncing"

Changes in V4:
- add Rob's Reviewed-by
- enable ZONE_DMA for ARCH_BCM2835
- fix spi reference in bcm2711.dtsi
- fix bluetooth section in RPi 4 dts
- drop "always-on" for armv8-timer
- add necessary Bluetooth driver fix
- add arm64 dts link
- additional comments to the dts files as requested by Florian

Changes in V3:
- rebased series
- add Reviewed-by
- enable ARM_GIC for ARCH_BCM2835 on arm64 too
- configure i2c pull-up in bcm2711.dtsi
- move i2c2 to bcm2835-common.dtsi
- add missing compatibles to DT schema as suggested by Rob
- fix DT schema warnings in dtsi files
- replace brcm pintrl with generic pinctrl as suggested by Linus
- make dma_zone_size depend on CONFIG_ZONE_DMA as suggested by Matthias

Changes in V2:
- use separate board file for BCM2711
- enable ARM_GIC for ARCH_BCM2835
- add Acked-by and Reviewed-by
- fix arm-pmu and timer nodes for BCM2711 reported by Marc Zyngier
- enable HDMI at board level
- move HDMI and pixelvalve into bcm2835-common.dtsi as suggested by Eric A=
nholt
- fix DWC2 probing warning by setting USB role to peripheral
- fix order of node references in bcm2711.dtsi
- disable I2C clock stretching quirk for BCM2711
- mark PLLD_PER as critical clock
- make PLLH clock unavailable on BCM2711
- fix compile warning in clk-bcm2835 for arm64

Changes since RFC:
- change BCM2838 -> BCM2711 as discussed in RFC
- update MAINTAINERS accordingly
- drop "spi: bcm2835: enable shared interrupt support" from series
- squash all pinctrl-bcm2835 changes into one patch
- introduce SoC specific clock registration as suggested by Florian
- fix watchdog probing for Raspberry Pi 4
- convert brcm,bcm2835.txt to json-schema
- move VC4 node to bcm2835-common.dtsi
- fallback to legacy pull config for Raspberry Pi 4
- revert unintended change of mailbox in bcm283x.dtsi
- add reference for arm64

[1] - https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm27=
11/rpi_DATA_2711_1p0_preliminary.pdf
[2] - https://www.raspberrypi.org/documentation/hardware/raspberrypi/schem=
atics/rpi_SCH_4b_4p0_reduced.pdf

Stefan Wahren (10):
  bluetooth: hci_bcm: Fix RTS handling during startup
  ARM: dts: bcm283x: Remove simple-bus from fixed clocks
  ARM: dts: bcm283x: Remove brcm,bcm2835-pl011 compatible
  ARM: dts: bcm283x: Move BCM2835/6/7 specific to bcm2835-common.dtsi
  dt-bindings: arm: Convert BCM2835 board/soc bindings to json-schema
  dt-bindings: arm: bcm2835: Add Raspberry Pi 4 to DT schema
  ARM: bcm: Add support for BCM2711 SoC
  ARM: dts: Add minimal Raspberry Pi 4 support
  arm64: dts: broadcom: Add reference to RPi 4 B
  MAINTAINERS: Add BCM2711 to BCM2835 ARCH

 .../devicetree/bindings/arm/bcm/bcm2835.yaml       |  54 ++
 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |  67 --
 MAINTAINERS                                        |   3 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts              | 123 +++
 arch/arm/boot/dts/bcm2711.dtsi                     | 844 ++++++++++++++++=
+++++
 arch/arm/boot/dts/bcm2835-common.dtsi              | 194 +++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   4 -
 arch/arm/boot/dts/bcm2835.dtsi                     |   1 +
 arch/arm/boot/dts/bcm2836.dtsi                     |   1 +
 arch/arm/boot/dts/bcm2837.dtsi                     |   1 +
 arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi  |   7 +
 arch/arm/boot/dts/bcm283x.dtsi                     | 190 +----
 arch/arm/mach-bcm/Kconfig                          |   4 +-
 arch/arm/mach-bcm/Makefile                         |   3 +-
 arch/arm/mach-bcm/bcm2711.c                        |  24 +
 arch/arm64/Kconfig.platforms                       |   5 +-
 arch/arm64/boot/dts/broadcom/Makefile              |   3 +-
 arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts   |   2 +
 drivers/bluetooth/hci_bcm.c                        |   2 +
 20 files changed, 1272 insertions(+), 261 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835=
.txt
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-4-b.dts
 create mode 100644 arch/arm/boot/dts/bcm2711.dtsi
 create mode 100644 arch/arm/boot/dts/bcm2835-common.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi
 create mode 100644 arch/arm/mach-bcm/bcm2711.c
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts

=2D-
2.7.4

