Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A3AC63798
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 14:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD566128C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 14:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhGVNeA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 09:34:00 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54008 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbhGVNdi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 09:33:38 -0400
Received: from smtpclient.apple (p5b3d2eb8.dip0.t-ipconnect.de [91.61.46.184])
        by mail.holtmann.org (Postfix) with ESMTPSA id 07BE8CECDC;
        Thu, 22 Jul 2021 16:14:10 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] Bluetooth: sco: prevent information leak in
 sco_conn_defer_accept()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <YNXveZZwzS3crmHH@mwanda>
Date:   Thu, 22 Jul 2021 16:14:09 +0200
Cc:     =?utf-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?= 
        <frederic.dalleau@linux.intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2679DCD8-2606-4341-921A-1CC0B2DA3057@holtmann.org>
References: <YNXveZZwzS3crmHH@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

> Smatch complains that some of these struct members are not initialized
> leading to a stack information disclosure:
> 
>    net/bluetooth/sco.c:778 sco_conn_defer_accept() warn:
>    check that 'cp.retrans_effort' doesn't leak information
> 
> This seems like a valid warning.  I've added a default case to fix
> this issue.  It's sort of unusual to have case SCO_AIRMODE_CVSD,
> followed by a default case but I think it's nicely readable.  :)
> 
> Fixes: 2f69a82acf6f ("Bluetooth: Use voice setting in deferred SCO connection request")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> net/bluetooth/sco.c | 1 +
> 1 file changed, 1 insertion(+)

I actually prefer a separate default statement since otherwise I get confused. Your patch with that minor change has been applied to bluetooth-next tree.

Regards

Marcel

