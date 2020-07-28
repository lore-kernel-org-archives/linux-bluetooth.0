Return-Path: <SRS0=dFGF=BH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873E5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 07:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710E121D95
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 07:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgG1HOL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:14:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35475 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgG1HOK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 03:14:10 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3DC9FCECCD;
        Tue, 28 Jul 2020 09:24:11 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH BlueZ] Add a presubmit configuration file for Chromium OS
 repo
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200717231404.240644-1-sonnysasaka@chromium.org>
Date:   Tue, 28 Jul 2020 09:14:09 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8E0368F4-1F53-403B-8EDC-51533108E54A@holtmann.org>
References: <20200717231404.240644-1-sonnysasaka@chromium.org>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

> Chromium OS developers use gerrit and repo in their workflow.
> (https://gerrit.googlesource.com/git-repo/). This configuration file
> makes it easier when uploading patches to gerrit with the repo tool.
> 
> ---
> PRESUBMIT.cfg | 8 ++++++++
> 1 file changed, 8 insertions(+)
> create mode 100644 PRESUBMIT.cfg
> 
> diff --git a/PRESUBMIT.cfg b/PRESUBMIT.cfg
> new file mode 100644
> index 000000000..10f89b741
> --- /dev/null
> +++ b/PRESUBMIT.cfg
> @@ -0,0 +1,8 @@
> +# This is a configuration for Chromium OS repo pre-upload hooks.
> +# repohooks doc: https://chromium.googlesource.com/chromiumos/repohooks/
> +# Chromium OS BlueZ git repo: https://chromium.googlesource.com/chromiumos/third_party/bluez/
> +
> +[Hook Overrides]
> +cros_license_check: false
> +tab_check: false
> +checkpatch_check: true

I am not in favor of adding anything in the top-level directory that is not for for the BlueZ upstream usage.

Regards

Marcel

