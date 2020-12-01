Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228B5C64E7A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 16:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6CB8208C3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 16:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgLAQaA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 11:30:00 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:61529 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLAQaA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 11:30:00 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A0D6B40009;
        Tue,  1 Dec 2020 16:29:18 +0000 (UTC)
Message-ID: <f2fbc270588a75ccebb8e14590b37b7c6bddab60.camel@hadess.net>
Subject: Re: [BlueZ,v5,1/7] battery: Add the internal Battery API
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 01 Dec 2020 17:29:18 +0100
In-Reply-To: <CABBYNZKGAujDpR3V4hRhsgSKO_UpYk9C1ge1w5rLg-jGFVc4pw@mail.gmail.com>
References: <20201130215602.386545-1-sonnysasaka@chromium.org>
         <5fc5738c.1c69fb81.8e7df.5ba8@mx.google.com>
         <CABBYNZKGAujDpR3V4hRhsgSKO_UpYk9C1ge1w5rLg-jGFVc4pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2020-11-30 at 16:27 -0800, Luiz Augusto von Dentz wrote:
> Hi Sonny,
> <snip>
> Applied, thanks.

Missed it :/
Any chance you could update the org.bluez.BatteryProvider1 docs as per
my review?

Cheers

