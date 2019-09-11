Return-Path: <SRS0=sfNh=XG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4072CC49ED6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Sep 2019 19:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A942075C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Sep 2019 19:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfIKTKh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Sep 2019 15:10:37 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58468 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfIKTKh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Sep 2019 15:10:37 -0400
Received: from marcel-macpro.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id 810C4CECBE;
        Wed, 11 Sep 2019 21:19:24 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Kernel module btusb.c: Adding module options and Patch for
 Cambridge Silicon Radio
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAEG94HT5G5Z-TLf7QgGk2=rGqEpOcSm1GV=-mFCZi0=LOveKDA@mail.gmail.com>
Date:   Wed, 11 Sep 2019 21:10:34 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <49926046-9534-41D5-88C6-D8F53AE37F4E@holtmann.org>
References: <CAEG94HT5G5Z-TLf7QgGk2=rGqEpOcSm1GV=-mFCZi0=LOveKDA@mail.gmail.com>
To:     pires.carvalho@gmail.com
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fernando,

> Please check the attached patch proposal for drivers/bluetooth/btusb.c
> 0.8.1 (for 5.3-rc6/rc8 kernels).
> 
> I haven't tested it thoroughly but I can get sound with these changes
> on my "Cambridge Silicon Radio, Ltd Bluetooth Dongle" adapters
> (ATTRS{idVendor}=="0a12", ATTRS{idProduct}=="0001",
> ATTRS{bcdDevice}=="8891").
> 
> Also, the added kernel module parameters should allow easier testing
> of the available fixups allowing them to be turned on/off via modprobe
> (and keep traditional behavior wen not used).
> 
> * Changes: Patching for Cambridge Silicon Radio, Ltd Bluetooth Dongle(HCI mode)
> *          Adapting patches for HCI_QUIRK_BROKEN_STORED_LINK_KEY
> *              based on patch by Szymon Janc <szymon.janc@codecoup.pl>
> *              https://pastebin.com/dHepfTmR
> *          Adding patch for CSR bcdDevice == 0x8891 by Sergey Kondakov from
> *                https://bugzilla.kernel.org/show_bug.cgi?id=60824#c37
> *          Minor Changes allowing some fixups/quirks to be tested and
> *          enabled/disabled via kernel module options:
> *              debug;
> *              disable_csrfix,     force_csrfix;
> *              disable_fakecsr,    force_fakecsr;
> *              disable_npsetup,    force_npsetup;
> *              disable_sniffer,    force_sniffer;
> *              disable_intelboot,  force_intelboot;
> *              disable_scofix,     force_scofix;
> *              disable_slkfix,     force_slkfix;
> *              disable_rocfix,     force_rocfix;
> *              disable_noisoc,     force_noisoc;
> *              disable_ath3012,    force_ath3012;
> *              disable_digianswer, force_digianswer;
> *              disable_intel,      force_intel;
> *              disable_intelnew,   force_intelnew;
> *              disable_marvel,     force_marvel;
> *              disable_mediatek,   force_mediatek;
> *              disable_qcarome,    force_qcarome;
> *              disable_bcm92035,   force_bcm92035;
> *              disable_swave,      force_swave;

why would I add a ton of kernel module options?

Regards

Marcel

