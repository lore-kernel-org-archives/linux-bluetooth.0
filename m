Return-Path: <SRS0=I8Nx=UK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA19C43218
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jun 2019 09:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A7620645
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jun 2019 09:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404425AbfFKJck (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:32:40 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40275 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404197AbfFKJck (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jun 2019 05:32:40 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 60079C0006;
        Tue, 11 Jun 2019 09:32:36 +0000 (UTC)
Message-ID: <61972141474cad5b43af0808fa701b0adff12971.camel@hadess.net>
Subject: Re: Apple magicmouse disconnects
From:   Bastien Nocera <hadess@hadess.net>
To:     Chris Murphy <chris@colorremedies.com>,
        Bluetooth <linux-bluetooth@vger.kernel.org>
Date:   Tue, 11 Jun 2019 11:32:35 +0200
In-Reply-To: <CAJCQCtRf8y4CM2Qf7VfJBd60FKwgvSSrVskW-XJJoZKOVFy4SQ@mail.gmail.com>
References: <CAJCQCtTnoLGDByW+S4Cc311KzsSReH-_uNgtV5=pe_Fou5q9Zg@mail.gmail.com>
         <CAJCQCtRf8y4CM2Qf7VfJBd60FKwgvSSrVskW-XJJoZKOVFy4SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, 2019-06-09 at 17:22 -0600, Chris Murphy wrote:
> This is a followup for this bug
> https://bugzilla.kernel.org/show_bug.cgi?id=103631
> 
> The problem still happens with kernel 5.2.0-rc4 and bluez-5.50-
> 6.fc30.x86_64
> 
> When I unset CONFIG_HID_BATTERY_STRENGTH the problem no longer
> happens. But as a consequence, there's no information at all about
> the
> mouse's battery strength. So I'd say the original patch is
> suboptimal.
> 
> https://bugzilla.kernel.org/attachment.cgi?id=203881&action=diff
> 
> But still better than random disconnects all day long. Any
> suggestions
> on how to collect more information on the device for a better fix?

linux-input@ is probably a more appropriate place to discuss this. Or
at least CC: your bug report there, as the changes would be in the hid
tree.

