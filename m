Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B004C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 14:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613CF60F13
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 14:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238703AbhHDOq4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:46:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51236 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbhHDOqz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 10:46:55 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 48E1DCECD6;
        Wed,  4 Aug 2021 16:46:42 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: net/bluetooth/cmtp/core.c: potential buffer overrun in
 session->name
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2cfa6b86-da6a-207f-ec1a-e180e6275896@canonical.com>
Date:   Wed, 4 Aug 2021 16:46:42 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F17862C9-9F3B-4A03-B136-EF014738641D@holtmann.org>
References: <2cfa6b86-da6a-207f-ec1a-e180e6275896@canonical.com>
To:     Colin Ian King <colin.king@canonical.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Colin,

> Static analysis with Coverity has detected a potential buffer overrun
> with a sprintf into session->name in function cmtp_add_connection in
> net/bluetooth/cmtp/core.c
> 
> The analysis is as follows:
> 
> Out-of-bounds write (OVERRUN)
> sprintf_overrun: sprintf will overrun its first argument session->name
> which can accommodate 18 bytes. The number of bytes written may be 21
> bytes, including the terminating null.
> 
> 363        sprintf(session->name, "%pMR", &session->bdaddr);
> 
> So, %pMR produces can potentially produce 0x............MR\0 (where . is
> a hex digit) so this accounts for 21 chars. session->name is defined as:
> 
> char name[BTNAMSIZ];
> 
> and BTNAMSIZE is:
> 
> #define BTNAMSIZ 18
> 
> Although an obvious fix is to increase BTNAMSIZE to 21 I'm not sure if
> this is actually the correct fix.

go for it.

Regards

Marcel

