Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B289FC55ABD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Nov 2020 17:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794D221D79
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Nov 2020 17:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgKMRH6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Nov 2020 12:07:58 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:47952 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgKMRH6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Nov 2020 12:07:58 -0500
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 3AE023B2B40
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2020 17:01:12 +0000 (UTC)
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 707C14000B;
        Fri, 13 Nov 2020 17:00:50 +0000 (UTC)
Message-ID: <38dcad476ea9efa71eff2065cdd7d57c184bd6b6.camel@hadess.net>
Subject: Re: [PATCH] tools/hcitool.c
From:   Bastien Nocera <hadess@hadess.net>
To:     Bisseling <spam@bisseling.de>, linux-bluetooth@vger.kernel.org,
        marcel@holtmann.org
Date:   Fri, 13 Nov 2020 18:00:49 +0100
In-Reply-To: <96d6eb8d-cf31-7cae-3e78-6761cb74961a@bisseling.de>
References: <96d6eb8d-cf31-7cae-3e78-6761cb74961a@bisseling.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, 2020-11-13 at 17:54 +0100, Bisseling wrote:
> Please review and pull:
> 
> https://github.com/GeorgBisseling/bluez/commit/69b61d7c71d08ddfd1b5b0f1862e456601264a01
> 
> 

You can create a pull request against:
https://github.com/bluez/bluez/pulls

Otherwise you'll need to use git-sendemail to send the patch itself to
the list.

