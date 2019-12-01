Return-Path: <SRS0=ukjF=ZX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03003C432C0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Dec 2019 22:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C1F20833
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Dec 2019 22:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfLAWNO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Dec 2019 17:13:14 -0500
Received: from hall.aurel32.net ([195.154.113.88]:56506 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbfLAWNO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Dec 2019 17:13:14 -0500
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1ibXSq-0002O4-Dr
        for linux-bluetooth@vger.kernel.org; Sun, 01 Dec 2019 23:13:12 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92.3)
        (envelope-from <aurelien@aurel32.net>)
        id 1ibXSq-00HUbG-22
        for linux-bluetooth@vger.kernel.org; Sun, 01 Dec 2019 23:13:12 +0100
Date:   Sun, 1 Dec 2019 23:13:12 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] mesh: fix (re)transmit count & interval steps
Message-ID: <20191201221255.GA48051@aurel32.net>
References: <20191111195406.3291-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111195406.3291-1-aurelien@aurel32.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2019-11-11 20:54, Aurelien Jarno wrote:
> The Foundation Model Layer uses little endian ordering. As a
> consequence the (re)transmit count and interval steps in the Config
> Relay, Config Model Publication and Config Network Transmit messages
> use the lower 3 bits for the (re)transmission count and the higher 5
> bits for the interval steps.
> 
> The figure 4.5 in section 4.3.2.16 of the Mesh Profile Bluetooth
> Specification provides a good clarification.
> 
> This patch therefore fixes those messages for both the daemon and
> configuration client parts.

Gentle ping on that patch.

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
