Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0152DC433E6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 18:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EE964F64
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 18:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhCDSzr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 13:55:47 -0500
Received: from kawka.in.waw.pl ([178.62.225.244]:41966 "EHLO kawka.in.waw.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231524AbhCDSzc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 13:55:32 -0500
Received: from zbyszek by kawka.in.waw.pl with local (Exim 4.84_2)
        (envelope-from <zbyszek@in.waw.pl>)
        id 1lHt6a-0006hy-Bm; Thu, 04 Mar 2021 18:53:48 +0000
Date:   Thu, 4 Mar 2021 18:53:48 +0000
From:   Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: patch to fix conflict with unistd.h
Message-ID: <20210304185348.GL7348@in.waw.pl>
References: <20210303081942.GH7348@in.waw.pl>
 <CABBYNZLYiGwYCQcihs9x-AJ33jS5dmUoY45GM4sk0PbmQW-iLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLYiGwYCQcihs9x-AJ33jS5dmUoY45GM4sk0PbmQW-iLg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Mar 04, 2021 at 08:37:04AM -0800, Luiz Augusto von Dentz wrote:
> Hi Zbigniew,
> 
> On Thu, Mar 4, 2021 at 1:02 AM Zbigniew Jędrzejewski-Szmek
> <zbyszek@in.waw.pl> wrote:
> >
> 
> Can you send it as a proper patch, look at HACKING if you don't know
> how to send it using e.g. git send-patch.

Can you be more precise? What was wrong with the first version.

Zbyszek
