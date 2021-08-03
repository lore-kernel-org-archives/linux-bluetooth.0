Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59AAC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 20:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722B060FA0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 20:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhHCUdM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 16:33:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:1787 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhHCUdL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 16:33:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="274828155"
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="274828155"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 13:32:59 -0700
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="521426514"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 13:32:58 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mB15o-004rIN-GE
        for linux-bluetooth@vger.kernel.org; Tue, 03 Aug 2021 23:32:52 +0300
Date:   Tue, 3 Aug 2021 23:32:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: [v1,1/5] serdev: Split and export serdev_acpi_get_uart_resource()
Message-ID: <YQmn9MkkgtzSXUrH@smile.fi.intel.com>
References: <20210803192905.72246-1-andriy.shevchenko@linux.intel.com>
 <6109a142.1c69fb81.eedb4.954c@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6109a142.1c69fb81.eedb4.954c@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Aug 03, 2021 at 01:04:18PM -0700, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=525847

...

> ##############################
> Test: TestRunner: smp-tester - FAIL - 2.09 seconds
> Run test-runner with smp-tester
> Total: 8, Passed: 7 (87.5%), Failed: 1, Not Run: 0
> 
> Failed Test Cases
> SMP Client - SC Request 2                            Failed       0.022 seconds
> 
> ##############################
> Test: TestRunner: userchan-tester - PASS - 1.95 seconds
> Run test-runner with userchan-tester
> Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0

Hmm... I have read logs and I have no clue how my series may affect this. Any
BT expert here to shed a light?

-- 
With Best Regards,
Andy Shevchenko


