Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F407C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD5D61179
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbhHFVtu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 17:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbhHFVtu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 17:49:50 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2195BC0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 14:49:33 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id a93so17702845ybi.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 14:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65NLcBVii93tCdR0I2NeRh9AZKxqiVCt6NJy/jl3+7A=;
        b=ibBZsmPXmJpWeNCVYQEXtNpYuIiHVOYgLo9q72sLuncucoTHMpsld8i5m3RMe33PNN
         JMEAXouUX7ejkqu7he2aifc+Z4H1vFcOlPWzk7y6Pb7Lon8uiWgQtRFm18nCoWPiFM1l
         In429g19/yHhsJreqGhUSYAFmOH6UsKJMLx2dAPY30M+U/uE/2sVxGG3Z5KUkgUZWUzD
         bQi5aH3L7IeWrkr3Oa7RtZGPLpYNtUvQR9PxDw3WEhiHMT2HI+wG5YUDRFEW+LLDqh8H
         LWJ+EUbsYdIh9Fl/brF5BCc/N3Gg1JIulQlsLRwbOJafB2UYbGRugD8CiL5ZRNcR10we
         MKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65NLcBVii93tCdR0I2NeRh9AZKxqiVCt6NJy/jl3+7A=;
        b=XsyGf7P4QyHAa2QiWc86/3VQfOLMfFW8l5RSaG5BaJfX+C2h7ry360jC1j9Y4sNVkh
         juW7Y8mo3pl6LybMUbJPElkHAWbbHNiRNvIAhd/KhEoq+zynqlt6OnhVm0CuM8/m8pAs
         XSxNkk5HPLp7St3cJ9o4oqAAi8HkuBE2JMwv/TrmhbZT3Hgh8IVPn8nDycBzLi4VJ332
         sVjWjPzVEZ1jSBleS4TCr1T+KRRu8Nyl+cFLh+TbyIzjxIff9/8HndRe2PhjP5YLjjRt
         kEzXf15hpwmQeoV7n5F1QaVHxH8lB9yye5thgZ7IyOsZZwQm/n4O8bEZr5w38PVOHMkx
         Qr5g==
X-Gm-Message-State: AOAM531RVDeKMI4U2ckOlEAjsGWFWjZL1G4bJig4lk+lRo0JTIXU6FKg
        qWJqqcLEvSD7zx1t7d8hsoQ7wwFtlIc74zqHGbM=
X-Google-Smtp-Source: ABdhPJzETM3JGbF/eFpGkTg36kKgOYN5U+jeyGZ53+0+SEYlffho/03gbC6GbU+traTr1CPCrenn44HaO+HbDCIeOkg=
X-Received: by 2002:a25:d6c6:: with SMTP id n189mr16101161ybg.432.1628286572249;
 Fri, 06 Aug 2021 14:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210806054941.31387-1-hj.tedd.an@gmail.com>
In-Reply-To: <20210806054941.31387-1-hj.tedd.an@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 6 Aug 2021 14:49:21 -0700
Message-ID: <CABBYNZ+73-69pKiPGXuddA8QKFQfM0aKgruCe9-t2EF2O5LMLQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3] doc: Add a doc for Intel hardware variants
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, Aug 6, 2021 at 4:40 AM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch adds a document for Intel hardware variants currently
> supported by the kernel and its firmware list.
> ---
>  doc/intel-variants.txt | 159 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 doc/intel-variants.txt
>
> diff --git a/doc/intel-variants.txt b/doc/intel-variants.txt
> new file mode 100644
> index 000000000..4f51ca9f5
> --- /dev/null
> +++ b/doc/intel-variants.txt
> @@ -0,0 +1,159 @@
> +Intel Hardware Varaints
> +=======================
> +
> +These are the list of Intel Bluetooth devices and its information.
> +
> +Some of devices were tested the following test cases:
> +       Firmware loading after cold boot
> +       Firmware loading after restart
> +       Device discovery
> +       Connection to LE Mouse
> +       A2DP
> +       HFP
> +       Update to new firmware if available
> +
> +All Intel firmware can be found from linux-firmware git repo.
> +https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
> +
> +
> +Device List
> +-----------
> +
> +Wilkins Peak (WP)
> +- HW ID:       USB(0x8087:0x07dc)
> +- Device Type: Legacy ROM device
> +- Driver flag: BTUSB_INTEL_BROKEN_INITIAL_NCMD
> +- HW variant:  0x07
> +- FW files:
> +       WP2 B3
> +       intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> +               tested: Patch Version: 87    Release Version: 20.60.0.2
> +                       70353356f ("linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B3/B4)")
> +       WP2 B5
> +       intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
> +               tested: Patch Version: 42    Release Version: 20.60.0.2
> +                       629a5e089 ("linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B5/B6)")
> +
> +       WP1 B3
> +       intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
> +
> +       WP1 B3
> +       intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
> +
> +
> +Stone Peak (StP)
> +- HW ID:       USB(0x8087:0x0a2a)
> +- Device Type: Legacy ROM device
> +- HW variant:  0x08
> +- FW files:
> +       StP
> +       intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
> +
> +       StP D1
> +       intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
> +               tested: FW Build: REL_50_0002    Release Version: 20.60.0.2
> +                       9489f5524 ("linux-firmware: Update firmware patch for Intel Bluetooth 7265 (D0)")
> +
> +
> +Sandy Peak (SdP)
> +- HW ID:       USB(0x8087:0x0aa7)
> +- Device Type: Legacy ROM device
> +- HCI Quirks:  HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
> +- HW variant:  0x08
> +       intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
> +               tested: FW Patch Version: 0x42(66)
> +                       195ecf149 ("linux-firmware: Intel BT 7265: Fix Security Issues")
> +
> +
> +Snow Field Peak (SfP) / Windstorm Peak (WsP)
> +- HW ID:       USB(0x8087:0x0a2b)
> +- Device Type: Legacy Bootloader device
> +- HCI Quirks:  HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
> +- HW variant:  0x0b
> +       SfP
> +       intel/ibt-11-5.sfi
> +               tested: FW Build: REL0522    Release Version: 20.100.0.3
> +                       f0896585b ("linux-firmware: Update firmware patch for Intel Bluetooth 8260")
> +- HW variant:  0x0c
> +       WsP
> +       intel/ibt-12-16.sfi
> +               tested: FW Build: REL1221    Release Version: 22.50.0.4
> +                       4116d72b9 ("linux-firmware: Update firmware file for Intel Bluetooth 8265")
> +               tested: FW Build: REL0306    Release Version: 21.10.0.6
> +                       1f8ebdfc2 ("linux-firmware: Update firmware file for Intel Bluetooth 8265")
> +
> +
> +Jefferson Peak (JfP)
> +- HW ID:       USB(0x8087:0x0aaa)
> +- Device Type: Legacy Bootloader device
> +- HCI Quirks:  HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
> +               HCI_QUIRK_VALID_LE_STATES
> +- HW variant:  0x11
> +       intel/ibt-17-0-1.sfi
> +       intel/ibt-17-16-1.sfi
> +
> +
> +Thunder Peak (ThP)
> +- HW ID:       USB(0x8087:0x0025)
> +- Device Type: Legacy Bootloader device
> +- HCI Quirks:  HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
> +               HCI_QUIRK_VALID_LE_STATES
> +- HW variant:  0x12
> +       intel/ibt-18-0-1.sfi
> +       intel/ibt-18-16-1.sfi
> +               tested: FW Build: REL19718    Release Version: 22.50.0.4
> +                       687d64a4d ("linux-firmware: Update firmware file for Intel Bluetooth 9260")
> +               tested: FW Build: REL13313    Release Version: 21.120.0.4
> +                       db3038082 ("linux-firmware: Update firmware file for Intel Bluetooth 9260")
> +
> +
> +Quasar(QsR) / Harrison Peak (HrP)
> +- HW ID:       USB(0x8087:0x0026)
> +- Device Type: Legacy Bootloader device
> +- HCI Quirks:  HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
> +- HW variant:  0x13
> +       Quasar with JfP
> +       intel/ibt-19-0-1.sfi
> +       intel/ibt-19-240-1.sfi
> +
> +       Quasar with HrP
> +       intel/ibt-19-0-4.sfi
> +       intel/ibt-19-240-4.sfi
> +
> +       intel/ibt-19-0-0.sfi
> +       intel/ibt-19-16-4.sfi
> +       intel/ibt-19-32-0.sfi
> +       intel/ibt-19-32-1.sfi
> +       intel/ibt-19-32-4.sfi
> +
> +
> +Cyclone Peak (CcP)
> +- HW ID:       USB(0x8087:0x0029)
> +- Device Type: Legacy Bootloader device
> +- HCI Quirks:  HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
> +- HW variant:  0x14
> +       intel/ibt-20-0-3.sfi
> +       intel/ibt-20-1-3.sfi
> +               tested: FW Build: REL25791    Release Version: 22.60.0.3
> +                       34803c20f ("linux-firmware: Update firmware file for Intel Bluetooth AX200")
> +       intel/ibt-20-1-4.sfi
> +
> +
> +Typhon Peak (TyP)
> +- HW ID:       USB(0x8087:0x0032)
> +- Device Type: TLV based Bootloader device
> +- HCI Quirks:  HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
> +- HW variant:  0x17
> +       intel/ibt-0041-0041.sfi
> +               tested: FW Build: REL25171    Release Version: 22.60.0.3
> +                       25ddc612f ("linux-firmware: Update firmware file for Intel Bluetooth AX210")
> +               tested: FW Build: REL17510    Release Version: 22.20.0.3
> +                       28185ecdc ("linux-firmware: Update firmware file for Intel Bluetooth AX210")
> +
> +
> +Garfield Peak (GfP)
> +- HW ID:       USB(0x8087:0x0033)
> +- Device Type: TLV based Bootloader device
> +- HCI Quirks:  HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
> +               HCI_QUIRK_VALID_LE_STATES
> +- HW variant:  0x18
> --
> 2.25.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
