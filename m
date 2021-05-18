Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB63C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 21:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE24D61261
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 21:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbhERWAW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 18:00:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:43258 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233561AbhERWAW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 18:00:22 -0400
IronPort-SDR: aUxvuNLqiGQoi63d/3bZOAuc4IOdy6NM405ZDaXsbHKx7Fl6lLW9/QLtlKRNrKKhMm3y6/tEjN
 kTb4JtLcjFHQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200886747"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="200886747"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:59:03 -0700
IronPort-SDR: VNg5s1qpmb/ow5/f51Cfbewf+KtH7qqHXFnvUdy+voxTDyc12HsPiljCHMnpoSo5fo5ucSBtP1
 W5beEFpzWtqw==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="411459254"
Received: from yurikohe-mobl.amr.corp.intel.com ([10.209.83.49])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:59:03 -0700
Message-ID: <895354ffe5ba4a9080ea6c10e1d66ec424e74349.camel@linux.intel.com>
Subject: Re: Bluetooth: Add a new QCA_ROME device (0cf3:e500)
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Daniel Lenski <dlenski@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date:   Tue, 18 May 2021 14:58:01 -0700
In-Reply-To: <CAOw_LSHKPDfRo98zLe9Luc2cY1htLyfuGGF0XE6BYsvKtBPxNA@mail.gmail.com>
References: <20210518185938.322908-1-dlenski@gmail.com>
         <60a41617.1c69fb81.892b5.9705@mx.google.com>
         <CAOw_LSHKPDfRo98zLe9Luc2cY1htLyfuGGF0XE6BYsvKtBPxNA@mail.gmail.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan

On Tue, 2021-05-18 at 14:41 -0700, Daniel Lenski wrote:
> Hi all,
> I'm somewhat confused about why CheckPatch is failing to approve this
> patch. It says that a commit referenced in the commit message does not
> exist:
> 
> On Tue, May 18, 2021 at 12:31 PM <bluez.test.bot@gmail.com> wrote:
> > Test: CheckPatch - FAIL - 0.84 seconds
> > Run checkpatch.pl script with rule in .checkpatch.conf
> > Bluetooth: Add a new QCA_ROME device (0cf3:e500)
> > WARNING: Unknown commit id '0a03f98b98c2', maybe rebased or not pulled?
> > #9:
> > commit 0a03f98b98c2 ("Bluetooth: Add a new 04ca:3015 QCA_ROME device").
> 
> However, this commit *does* exist, and it is — as far as I can tell —
> the *only* commit which exists with this text in its title.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=0a03f98b98c201191e3ba15a0e33f46d8660e1fd
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/?qt=grep&q=Add+a+new+04ca%3A3015+QCA_ROME+device
> 
> Any suggestions about how to resolve this?

You can ignore this error.
This is an issue in the CI which is not pulling the entire kernel tree to
reduce the running time.

> 
> -Dan Lenski

Regards,
Tedd

