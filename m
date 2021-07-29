Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7913AC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 11:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6166056C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 11:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhG2Lra (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 07:47:30 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54032 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhG2Lr3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 07:47:29 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6D42CCED14;
        Thu, 29 Jul 2021 13:47:25 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2] drivers/bluetooth: Remove all strcpy() uses
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210724122152.7133-1-len.baker@gmx.com>
Date:   Thu, 29 Jul 2021 13:47:25 +0200
Cc:     Kees Cook <keescook@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Adam Sampson <ats@offog.org>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B9CF4857-98A5-418D-B689-A13A230A6641@holtmann.org>
References: <20210724122152.7133-1-len.baker@gmx.com>
To:     Len Baker <len.baker@gmx.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Len,

> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. The safe replacement is strscpy() but in
> this case it is better to use the scnprintf to simplify the arithmetic.
> 
> This is a previous step in the path to remove the strcpy() function
> entirely from the kernel.
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
> Changelog v1 -> v2
> - Add spaces to the "plus" sign.
> - Use the correct size for the fw_dump_ptr buffer (Adam Sampson)
> 
> drivers/bluetooth/btmrvl_sdio.c | 29 ++++++++++++++---------------
> 1 file changed, 14 insertions(+), 15 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

