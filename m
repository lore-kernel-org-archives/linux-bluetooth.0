Return-Path: <SRS0=5U9h=TX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE5DC282DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 13:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1127E21019
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 13:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfEWNDB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 May 2019 09:03:01 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:34395 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWNDB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 May 2019 09:03:01 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0E6CF24001C;
        Thu, 23 May 2019 13:02:54 +0000 (UTC)
Message-ID: <79f883b5639c3031fcc05eacac4cef2e5e2d0523.camel@hadess.net>
Subject: Re: [PATCH v2] Fix cups backend location
From:   Bastien Nocera <hadess@hadess.net>
To:     Ludwig Nussel <ludwig.nussel@suse.de>,
        linux-bluetooth@vger.kernel.org
Date:   Thu, 23 May 2019 15:02:53 +0200
In-Reply-To: <20190523122805.10235-1-ludwig.nussel@suse.de>
References: <20190523122805.10235-1-ludwig.nussel@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2019-05-23 at 14:28 +0200, Ludwig Nussel wrote:
> The default upstream location for backends is
> $exec_prefix/lib/cups/backend, see
> https://github.com/apple/cups/blob/master/config-scripts/cups-directories.m4
> https://github.com/apple/cups/blob/master/backend/Makefile

Looks good!

