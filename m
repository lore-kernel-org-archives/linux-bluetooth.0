Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3AFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Dec 2021 16:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbhLGQMS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 11:12:18 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55478 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbhLGQMS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 11:12:18 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id DFD96CED0C;
        Tue,  7 Dec 2021 17:08:46 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH] skbuff: Fix missing EXPORT_SYMBOL for skb_pull_data
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211207010011.3619889-1-luiz.dentz@gmail.com>
Date:   Tue, 7 Dec 2021 17:08:46 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <94AA92C2-152C-48DF-BE1B-8BC009F0213C@holtmann.org>
References: <20211207010011.3619889-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds the missing EXPORT_SYMBOL(skb_pull_data).
> 
> Fixes: 54dda1e8cf3c ("skbuff: introduce skb_pull_data")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

so I decided to rebase the tree instead since this was too embarrassing to have as a fix.

Regards

Marcel

