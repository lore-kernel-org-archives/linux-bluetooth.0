Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE21C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 18:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B6F22DD6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 18:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbhAYScA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:32:00 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37699 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbhAYSb4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 13:31:56 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.1.150] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1101E1BF20F;
        Mon, 25 Jan 2021 18:31:13 +0000 (UTC)
Message-ID: <bdbd7c8ca23256a067bdacb0fa956a0bebebcc9f.camel@hadess.net>
Subject: Re: [PATCH] Bluetooth: L2CAP: Try harder to accept device not
 knowing options
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Florian Dollinger <dollinger.florian@gmx.de>
Date:   Mon, 25 Jan 2021 19:31:13 +0100
In-Reply-To: <23573e40ef24668f33fac9a648213b81cad41568.camel@hadess.net>
References: <20201208172912.4352-1-hadess@hadess.net>
         <CABBYNZ+41BSkQEGbXsemCgWQhmaEjB3KOkLrFyOjv_=_zMQy_Q@mail.gmail.com>
         <23573e40ef24668f33fac9a648213b81cad41568.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2021-01-25 at 19:29 +0100, Bastien Nocera wrote:
> <snip>
> Marcel, any chance of a review on this one? I've sent you the
> results
> of the PTS tests privately, but looks like you weren't CC:ed on the
> earlier mail thread.

Our e-mails only just crossed paths.

Thanks for merging it!

