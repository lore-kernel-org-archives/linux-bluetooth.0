Return-Path: <SRS0=4il6=YE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01642ECE58C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 14:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE897214E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 14:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kUVy5s3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfJKOrN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:47:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:58953 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbfJKOrN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Oct 2019 10:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570805208;
        bh=LsPU7W9YTeeBaQ9Wk1nYxmRBBhS6FmZXbYGQrLdCWI4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kUVy5s3ZlMlosv7ZEBoiXN7ipGuS6GzsCYYBH9N9FofjB91QgrCjzSP7bEVwCHR1s
         vTbkjn/eLneSSDrdXqnSZflxTxICnT7w4HfYvCq3f0uZtT+VXpHKiouICQm3KirYEI
         GZOQTMclM40dkl0pVN4JitZN13CwJDclyQWvWGt4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.112]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulmF-1i25xj0SHr-00rqXH; Fri, 11
 Oct 2019 16:46:48 +0200
Subject: Re: [PATCH V4 00/10] ARM: Add minimal Raspberry Pi 4 support
To:     Marcel Holtmann <marcel@holtmann.org>,
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
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <11857a63-252a-00d3-d777-aed1c515ec47@gmx.net>
Date:   Fri, 11 Oct 2019 16:46:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:NPnfcLzrB1pQn16JnjKeo8SoS3sJYtf2PAgJYi5A2u6+KvUP6yH
 4U0eloxlZaU7O+8nAy3MF+MmaZPiisXAB/TbdVu8P9LyadiST6MUQ9Qd8RGegUh7YnToTGz
 a2PJ8tovb7oJrb43vuHRzOA+QBlMzaAkcyWza8DiI9Lnm9Q5ZWsg6u1H2sNbncLs8JJe0tT
 uLrBVIMUDVzAfaPqyB0yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MDQs56KP1zs=:TkyJfzgmJbfegXhbTGl9Ef
 tcwvYSEQJD+fRvQaY1eKFini1uJ3disQP7nawDgJvlfh784422v+wGTn7mjNo3IdPluohtMgj
 hZdaFONFHwkX1dUw6CN8SVXtI1NZO2fbvCa6vZSqHbiUB88jnMHH9gt1fgpppb219rsQr7WyU
 1CREC3jExbHH27k5dG9vhLtMIZD/a/lYpMZWAkmM05ETOW1L2KuohDGRql6TxzsCnJGEYAAW1
 9Pwd8wu0ebKh3KQSig5Xi5djQwPkbEBDocWPD4luGPsY4N1efmENsAzcr3s1Vu5WwZoeZ8LsW
 MAtaZ2/Cmi4WWXIaaMUR3GVO9/Z31mMCgaha11LepXjo4uI3lNOfJb+eZHj/+NN+P+IDVpJ7j
 nUFWy2Lj1k6bl2ffOrsT64rT5eD59F/ZrixVtn1ljQDefv3UZMFEoYsKxt5cm8JrjWrvoRw8z
 hsLYMKu+7MlblFV+TRs9oIQHMB5GWHomI18Ptx0A3Bf0RTywHC6xbMGRzPsc0I0RWx4Fd6X++
 G+vLQI9AF6EN4qzPU6o2XnungESGfmEBBjviEV63mH3PVYyYjlaYKWJh5pwZKnf0QamWKZvXM
 0y/GKGJxwU58DBXLToDCMhLqJv/0LMJT9UvAhOqpznWGpBsM/xq26C/cMHU5km1hPTX9P3h8A
 uYQkQLB1E5bgRsl61Kc1bvIts8FT9GQz8qtD8TivQycxpnTQLrgykYrtq9FdOC6hI+ZeUW8T4
 T2gTDlz3g5af3+5jDv22ts69zAZ1zZS1puSqtIxPHgBJRj/+ce/Fii6HwK/3M2BwK4ohRHdjj
 mOuM4CcqFKmhnzErwJQvdOis1jLA2Nr/ecXTXxxJWfvdjSZ6uCj/KmUkUMeg/eLdhgvHfI9Dk
 LyylgVxRNEp2p/A4tAP1cUtcqFToWC0ChWGi/ft+sNjWVABwB7rPg71PxKmhiN/GOxQHqWW2A
 dz7+yZvSFv+EXhMHGuIVIsbQfniisGS3dVZzm3iXQZfjXiAnFzW2mViu2UcBNpT80O4S2q+Lr
 YH/19eDVK02vapneIW0N4/HNcPIJ8rbQeo3ne2u+B9FXksy6MCfY1kQIs6D9JxHi75M2K1D1V
 NXbXD+Tz5SWffNOpYnAodl+z8ufj9PYRivIl8b1QT+0FXYfwG/dxQEkSISfifCEm3p78QfkKU
 tEU4qar+wp8X4qufZ6rydwTvffd8Lrpr1Yw4GXoD3uk+0u7ICs0M6RN/j3soe1YpzjhMeMjrA
 wiCLMT+6b3pNmLT+3t4vr+qLqfD4ILYr4nMTQA2vKgkVUm7jqFIM+9kJuWew=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Am 06.10.19 um 17:28 schrieb Stefan Wahren:
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
Patches 2-10 applied so that we don't miss Linux 5.5
