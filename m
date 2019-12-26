Return-Path: <SRS0=A3U8=2Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB028C2D0C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Dec 2019 20:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE1620828
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Dec 2019 20:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfLZUkS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Dec 2019 15:40:18 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:60582 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZUkS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Dec 2019 15:40:18 -0500
Received: from [192.168.0.171] (188.147.97.8.nat.umts.dynamic.t-mobile.pl [188.147.97.8])
        by mail.holtmann.org (Postfix) with ESMTPSA id E9037CECEC;
        Thu, 26 Dec 2019 21:49:30 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: deprecated tools: rfcomm, can we un-deprecate it?
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <0aad7250-65f9-3e4c-e5ca-434139a9ae64@message-id.googlemail.com>
Date:   Thu, 26 Dec 2019 21:40:16 +0100
Cc:     BlueZ devel list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <2203E98B-B581-4C14-94DF-164D7E036234@holtmann.org>
References: <0aad7250-65f9-3e4c-e5ca-434139a9ae64@message-id.googlemail.com>
To:     Stefan Seyfried <stefan.seyfried@googlemail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Stefan,

> as the bluez package maintainer for openSUSE, I'm trying to transition
> the package to build without "--enable-deprecated".
> 
> Now the users started asking me what to use as a replacement for the
> deprecated tools.
> 
> For many of the tools, the answer is "just use bluetoothctl and let
> bluetoothd handle things" (hciconfig, hcitool, sdptool)
> 
> But for rfcomm, I have not been able to find a suitable replacement.
> 
> All the other implementations of rfcomm services that I could find in a
> quick search (some python modules, blueman) just basically reimplement
> the functionality of rfcomm (socket(), bind(), connect(), ioctl()...),
> some of them in really odd / crazy ways, which is probably not the way
> to go...
> 
> So is there a way to set up a rfcomm device via bluetoothctl? I could
> not find one, but maybe I did not look hard enough?
> 
> If not, could we please un-deprecate rfcomm, because having everyone out
> there reinvent the functionality in crazy ways probably is not a good idea.
> 
> Or should I just continue to build the package with --enable-deprecated?
> But that will ship tools with known unfixed security issues (hcidump).

have a look at doc/profile-api.txt.

Regards

Marcel

