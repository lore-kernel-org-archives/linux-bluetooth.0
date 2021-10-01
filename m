Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6555C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 03:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924C161A40
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 03:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhJADjI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 23:39:08 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:41734 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhJADjH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 23:39:07 -0400
Date:   Fri, 01 Oct 2021 03:37:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1633059441;
        bh=wbT/YxksNbpXIxygDUBBltEQxbsIjbL1dpqdJhyCWhs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=jQTOqCJ17snc2K7xVW85S02omw7lzG3eBod0NjAsxgOaH3tQO8UlUNC7EC3Zwj7d8
         /xvI4dAc2co/C5eyA0poho2CXP1VWXXgeOIXLHBW1oAnAtdNLug6GHryyCVjpCP2Lh
         jEWIH1fBr6zvEMZzK5EVXD4eG6HlH/Zgry01Udzc=
To:     Marcel Holtmann <marcel@holtmann.org>
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     danielwinkler@google.com, Johan Hedberg <johan.hedberg@intel.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        regressions@lists.linux.dev, sonnysasaka@chromium.org,
        linux-kernel@vger.kernel.org
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCH] Bluetooth: add quirk disabling query LE tx power
Message-ID: <275acce4-9eab-9cba-7145-5a75a69ca530@protonmail.com>
In-Reply-To: <FA02CDD7-CFEC-4481-9940-BA95D81FD3F3@holtmann.org>
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com> <20210930063106.19881-1-redecorating@protonmail.com> <20210930141256.19943-1-redecorating@protonmail.com> <FA02CDD7-CFEC-4481-9940-BA95D81FD3F3@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_QyD3q1wsYzPCN4Wpoew4UPb3trelXIZ8pQMlvRTglU"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is a multi-part message in MIME format.

--b1_QyD3q1wsYzPCN4Wpoew4UPb3trelXIZ8pQMlvRTglU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/21 03:58, Marcel Holtmann wrote:
> so I really need the btmon traces from the device init (so unload and rel=
oad the module) and we need to see what commands are supported and what com=
mands are failing.
I'll attach the full file I got with btmon -w MacBookPro16,1.btsnoop, but t=
hese seem
like the important bits:

< HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0=09#43 [hc=
i0] 9.217379

> HCI Event: Command Complete (0x0e) plen 68=09=09=09=09#44 [hci0] 9.218033

      Read Local Supported Commands (0x04|0x0002) ncmd 1

        Status: Success (0x00)

        Commands: 223 entries
=09## many many lines here ##
=09LE Read Transmit Power (Octet 38 - Bit 7)
=09LE Read RF Path Compensation (Octet 39 - Bit 0)

=09LE Write RF Path Compensation (Octet 39 - Bit 1)

=09LE Set Privacy Mode (Octet 39 - Bit 2)

=09Read Local Simple Pairing Options (Octet 41 - Bit=20

At the end of the trace:

< HCI Command: LE Read Transmit Power (0x08|0x004b) plen 0=09=09#69 [hci0] =
9.226953
> HCI Event: Command Complete (0x0e) plen 4=09=09=09=09#70 [hci0] 9.227515
      LE Read Transmit Power (0x08|0x004b) ncmd 1
        Status: Unknown HCI Command (0x01)
=3D Close Index: F8:FF:C2:06:46:63=09=09=09=09=09[hci0] 9.227666

I'm guessing that this means it reports that it supports the command but it=
 doesn't,
so if this is the case, I'd have to change the description of the quirk to =
clarify that.

> Since you say this is on a MacBook, I assume this is an UART based Broadc=
om chip. Sometimes Broadcom has been really flaky with their actually imple=
mented commands. However in some cases firmware updates do fix this. So any=
 chance you can boot OS X and check that the latest firmware is loaded.

Bluetooth for this device is indeed through uart:

# lspci -vvvnnd '8086:a328'
00:1e.0 Communication controller [0780]: Intel Corporation Cannon Lake PCH =
Serial IO UART Host Controller    [8086:a328] (rev 10)

    Subsystem: Intel Corporation Device [8086:7270]

    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-

    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-

    Latency: 0, Cache Line Size: 256 bytes

    Interrupt: pin A routed to IRQ 20

    IOMMU group: 8

    Region 0: Memory at 4000000000 (64-bit, non-prefetchable) [size=3D4K]

    Capabilities: [80] Power Management version 3

        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-=
,D3cold-)

        Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-

    Capabilities: [90] Vendor Specific Information: Len=3D14 <?>

    Kernel driver in use: intel-lpss

    Kernel modules: intel_lpss_pci

$ cat /sys/bus/pci/devices/0000:00:1e.0/dw-apb-uart.0/serial0/serial0-0/mod=
alias

acpi:BCM2E7C:APPLE-UART-BLTH:

I've just updated macOS to 11.6, which should have updated firmware. The is=
sue is still present.
--b1_QyD3q1wsYzPCN4Wpoew4UPb3trelXIZ8pQMlvRTglU
Content-Type: application/octet-stream; name=MacBookPro161.btsnoop
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=MacBookPro161.btsnoop

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

--b1_QyD3q1wsYzPCN4Wpoew4UPb3trelXIZ8pQMlvRTglU--

