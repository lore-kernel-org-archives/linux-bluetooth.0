Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E88DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 23:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3796120D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 23:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241455AbhIPXcZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 19:32:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:63291 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234929AbhIPXcY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 19:32:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="308228844"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="308228844"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 16:31:03 -0700
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="453105472"
Received: from cjoseph-mobl.amr.corp.intel.com ([10.252.131.10])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 16:31:02 -0700
Message-ID: <870dfd6edabca3e8354b099046c28e07c38a2762.camel@linux.intel.com>
Subject: Re: Bluetooth: hci_bcm: remove duplicated brcm,bcm4330-bt compatible
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-bluetooth@vger.kernel.org
Date:   Thu, 16 Sep 2021 16:31:02 -0700
In-Reply-To: <413556b2-61c6-941c-60b0-991965e41e87@canonical.com>
References: <20210916170528.138275-1-krzysztof.kozlowski@canonical.com>
         <61438790.1c69fb81.b0356.7bdc@mx.google.com>
         <413556b2-61c6-941c-60b0-991965e41e87@canonical.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi 

On Thu, 2021-09-16 at 21:26 +0200, Krzysztof Kozlowski wrote:
> On 16/09/2021 20:06, bluez.test.bot@gmail.com wrote:
> > This is automated email and please do not reply to this email!
> > 
> > Dear submitter,
> > 
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=548291
> > 
> > ---Test result---
> > 
> > Test Summary:
> > CheckPatch                    FAIL      0.44 seconds
> > GitLint                       PASS      0.10 seconds
> > BuildKernel                   PASS      519.20 seconds
> > TestRunner: Setup             PASS      345.93 seconds
> > TestRunner: l2cap-tester      PASS      2.70 seconds
> > TestRunner: bnep-tester       PASS      1.93 seconds
> > TestRunner: mgmt-tester       PASS      31.31 seconds
> > TestRunner: rfcomm-tester     PASS      2.09 seconds
> > TestRunner: sco-tester        PASS      2.12 seconds
> > TestRunner: smp-tester        PASS      2.16 seconds
> > TestRunner: userchan-tester   PASS      1.95 seconds
> > 
> > Details
> > ##############################
> > Test: CheckPatch - FAIL - 0.44 seconds
> > Run checkpatch.pl script with rule in .checkpatch.conf
> > Bluetooth: hci_bcm: remove duplicated brcm,bcm4330-bt compatible
> > WARNING: Unknown commit id '81534d4835de', maybe rebased or not pulled?
> > #9: 
> > Fixes: 81534d4835de ("Bluetooth: btbcm: Add BCM4330 and BCM4334 compatibles")
> 
> Although you asked not to reply to this email, but you also sent it to
> public mailing list, so I will reply.
> 
> Your report is incorrect. Commit ID 81534d4835de is from mainline,
> merged into Linus' tree as: v5.13-rc1~94^2~197^2~38
> 
> > total: 0 errors, 1 warnings, 7 lines checked
> > 
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> > 
> > "[PATCH] Bluetooth: hci_bcm: remove duplicated brcm,bcm4330-bt" has style problems, please
> > review.
> > 
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> Checkpatch does not report any warnings like that, so this is false
> positive of your system, not checkpatch.
> 
It is a known issue and will be fixed soon.
Sorry for the trouble.


> 
> 
> Best regards,
> Krzysztof

Regards,
Tedd

