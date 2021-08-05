Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21FBC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 21:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9681061078
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 21:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhHEVtt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 17:49:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:4672 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231375AbhHEVts (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 17:49:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="211157254"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="211157254"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 14:49:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="501795767"
Received: from psebesti-mobl1.amr.corp.intel.com ([10.251.9.183])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 14:49:33 -0700
Message-ID: <632cc53231c85d2b4cc588d5a18a258465368ccc.camel@linux.intel.com>
Subject: Re: [BlueZ PATCH] doc: Add a doc for Intel hardware variants
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Thu, 05 Aug 2021 14:49:32 -0700
In-Reply-To: <9513A8F2-3C17-4381-A953-42E056029E45@holtmann.org>
References: <20210805002123.22339-1-hj.tedd.an@gmail.com>
         <9513A8F2-3C17-4381-A953-42E056029E45@holtmann.org>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, 2021-08-05 at 15:16 +0200, Marcel Holtmann wrote:
> +HrP/QnJ/IcP
> > +- USB(0x8087:0x0026)
> > +- Legacy Bootloader device
> > +- Driver flag: BTUSB_WIDEBAND_SPEECH
> > +- HW variant: 0x13
> > +	intel/ibt-19-0-0.sfi
> > +	intel/ibt-19-0-1.sfi
> > +	intel/ibt-19-0-4.sfi
> > +	intel/ibt-19-16-4.sfi
> > +	intel/ibt-19-240-1.sfi
> > +	intel/ibt-19-240-4.sfi
> > +	intel/ibt-19-32-0.sfi
> > +	intel/ibt-19-32-1.sfi
> > +	intel/ibt-19-32-4.sfi
> 
> Any chance we can get SKU details included?

I will check with BT team for further details.

Regards,
Tedd

