Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4E2C2D0F8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 08:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFBB23126
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 08:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgEMICo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 04:02:44 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48044 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgEMICn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 04:02:43 -0400
Received: from [192.168.1.91] (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2BC3BCED09;
        Wed, 13 May 2020 10:12:25 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] build: Add an option to explicitly disable installing
 hid2hci
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200506005528.2897-1-sonnysasaka@chromium.org>
Date:   Wed, 13 May 2020 10:02:11 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <77B1AB20-C903-427C-A3BD-E10C79815EF9@holtmann.org>
References: <20200506005528.2897-1-sonnysasaka@chromium.org>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

> ---
> configure.ac | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 1433ace4a..ba9937a16 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -218,8 +218,11 @@ if (test "${enable_udev}" != "no" && test -z "${path_udevdir}"); then
> fi
> AC_SUBST(UDEV_DIR, [${path_udevdir}])
> 
> +AC_ARG_ENABLE(hid2hci, AC_HELP_STRING([--disable-hid2hci],
> +		[disable hid2hci tool]), [enable_hid2hci=${enableval}])
> AM_CONDITIONAL(HID2HCI, test "${enable_tools}" != "no" &&
> -						test "${enable_udev}" != "no")
> +					test "${enable_udev}" != "no" &&
> +					test "${enable_hid2hci}" != "no")

I looked at this again. Lets turn this around and make this an --enable-hid2hci similar to --enable-sixaxis.

And you need to change the ${enable_tools} into ${enable_hid2hci} actually and not just add another dependency. Everything else seems to be already in the Makefile.tools for this.

Regards

Marcel

