Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B99C4727C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 07:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF922158C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 07:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgJAHQP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 03:16:15 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51012 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAHQP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 03:16:15 -0400
Received: from marcel-macbook.fritz.box (p4fefc7f4.dip0.t-ipconnect.de [79.239.199.244])
        by mail.holtmann.org (Postfix) with ESMTPSA id 14780CECD2;
        Thu,  1 Oct 2020 09:23:13 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH BlueZ] doc/coding-style: Allow spaces after tabs for
 indenting wrapped lines
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200916232924.129991-1-sonnysasaka@chromium.org>
Date:   Thu, 1 Oct 2020 09:16:12 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <ED6A96A4-A97A-423B-9E62-80BDA3A07164@holtmann.org>
References: <20200916232924.129991-1-sonnysasaka@chromium.org>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

> The "only tabs for indentation" rule was enforced long ago to align with
> Linux kernel net coding style. This is no longer the case today so we
> are relaxing the coding style to allow spaces after tabs if it can
> increase readability.
> 
> ---
> doc/coding-style.txt | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/doc/coding-style.txt b/doc/coding-style.txt
> index f0bf880e3..6a7415847 100644
> --- a/doc/coding-style.txt
> +++ b/doc/coding-style.txt
> @@ -104,9 +104,16 @@ void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
> void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
> 							btd_adapter_pin_cb_t cb)
> 
> +5)
> +void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
> +				 btd_adapter_pin_cb_t cb)
> +
> The referred style for line wrapping is to indent as far as possible to the
> right without hitting the 80 columns limit.
> 
> +It is acceptable to add padding with spaces after tabs to increase
> +readability, for example to indent function arguments at the parenthesis.
> +

NAK. The userspace style is a bit different than the kernel one.

Regards

Marcel

