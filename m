Return-Path: <SRS0=r7wX=SZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C3AC10F03
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 22:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93299218D3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 22:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tutanota.com header.i=@tutanota.com header.b="Zw+bs8Ox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfDWWun (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:50:43 -0400
Received: from w1.tutanota.de ([81.3.6.162]:11140 "EHLO w1.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfDWWun (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Apr 2019 18:50:43 -0400
Received: from w2.tutanota.de (unknown [192.168.1.163])
        by w1.tutanota.de (Postfix) with ESMTP id 3C601FA02FB
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2019 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tutanota.com;
        s=20161216; t=1556059841;
        bh=EEfNK91K1o524/CdrhufpnjZ9jrdk6osGWiYNY+Wl6Y=;
        h=Date:From:To:Subject:From;
        b=Zw+bs8OxMM4GyTj34vQFKY5wYKs4EF/PpGegAAr4OPGVBb+HQhrjd9kp5xqXsgDeB
         EbVRFmKBhLEOGm26j8cqJODPXXwApekIvufO8TGTcJQb8aRBKhfuAM5cavUgxupM1M
         ZZD0Vz+2T+UcMaU2t1/iS1YL4sgSLgwnNfAs5yTBJdbrTXvbMG026y5rDLptq0ql8F
         NhFKSriEMim+NspqULSSzVU7ss4brHSXXoFgVYfgSTQ5r867m3h8xYq5QHqnSFPfnD
         +Bznw4XBIBEeYOjqd+wgpyWChTrg098pAlpXYS9xzdzpoWVsZUKnh8IOsuKjeYiXnA
         btCva8u2rZtCA==
Date:   Wed, 24 Apr 2019 00:50:41 +0200 (CEST)
From:   <akz@tutanota.com>
To:     Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Message-ID: <LdBOD-Q--3-1@tutanota.com>
Subject: Bluez-plugins and pairing PS3 controller broke bluetooth dongle at
 hardware level
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Used this bluetooth dongle (https://mediabridgeproducts.com/?wc-api=WC_Quick_View&product=569) for years with no problem. Yesterday installed bluez-plugins on Arch, which contains a necessary plugin to pair PS3 controllers, then I paired a PS3 controller, and now I can't pair anything except the PS3 controller.

Hear me out, I've tried a Linux live CD, and a Windows computer, on all systems devices just pair then immediately disconnect.

I've checked rfkill, it's not blocked on hardware.

I think it actually broke the bluetooth dongle at a hardware level.
