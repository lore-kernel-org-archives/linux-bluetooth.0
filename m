Return-Path: <SRS0=2B3h=CF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_20,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36201C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 20:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B68020825
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 20:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0Ucf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:32:35 -0400
Received: from fgw23-4.mail.saunalahti.fi ([62.142.5.110]:36680 "EHLO
        fgw23-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgH0Ucf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Aug 2020 16:32:35 -0400
X-Greylist: delayed 963 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Aug 2020 16:32:35 EDT
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 30dabc35-e8a2-11ea-8ccc-005056bdfda7;
        Thu, 27 Aug 2020 23:16:29 +0300 (EEST)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id EFFC036C0F6; Thu, 27 Aug 2020 23:16:28 +0300 (EEST)
Date:   Thu, 27 Aug 2020 23:16:28 +0300
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Bluez 5.55 release?
Message-ID: <20200827201628.GA3296@reaktio.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello all,

It has been a while since the previous release, so how about new bluez 5.55 release? 
Is there a plan for next release, certain features/patches that need to be finished before cutting a release?


Thanks a lot,

-- Pasi

