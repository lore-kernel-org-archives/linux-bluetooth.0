Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914BBC432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 21:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B4360FE6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 21:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbhHaVYJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 17:24:09 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41876 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240571AbhHaVYG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 17:24:06 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5EE36CECE5;
        Tue, 31 Aug 2021 23:23:07 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [BlueZ PATCH] lib: fix variable-length array declarations in hci
 structures
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210831163545.3646157-1-pab@pabigot.com>
Date:   Tue, 31 Aug 2021 23:23:06 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3CBFA8E8-ABA1-495F-BFD4-A4E3CBC1E21B@holtmann.org>
References: <20210831163545.3646157-1-pab@pabigot.com>
To:     "Peter A. Bigot" <pab@pabigot.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Peter,

> Use of zero as the size for arrays as the last element of a structure
> is a GNU C extension, which as of GCC 10 produces diagnostics when
> values in the extended array are referenced.  Switch to the C99
> standard idiom for flexible array members, already in use in a few
> other headers.
> 
> Signed-off-by: Peter A. Bigot <pab@pabigot.com>
> ---
> 
> No changes from previous submission except the BlueZ subject prefix
> that I hope will get this into bluez.
> 
> lib/hci.h | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/hci.h b/lib/hci.h
> index 3382b87bf..a61568bce 100644
> --- a/lib/hci.h
> +++ b/lib/hci.h
> @@ -729,7 +729,7 @@ typedef struct {
> typedef struct {
> 	uint8_t		flt_type;
> 	uint8_t		cond_type;
> -	uint8_t		condition[0];
> +	uint8_t		condition[];
> } __attribute__ ((packed)) set_event_flt_cp;
> #define SET_EVENT_FLT_CP_SIZE 2

does this break any API assumptions? Since as long as libbluetooth exists these headers are API.

Regards

Marcel

