Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BF7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 17:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0AC2075A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 17:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgFVR2o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:28:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:47731 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbgFVR2o (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 13:28:44 -0400
IronPort-SDR: +jKSF22dC1WzbYeY6AO5Wurkii6Z+OauhklVS/7rtB059P4ClIyVFYy82D8sFny3Oj3AEEhGS6
 l+bDqwcR2qCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="161906137"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="161906137"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 10:28:44 -0700
IronPort-SDR: v4f9kSERP0A6Lh5riOtLtL+jF8FmGNpQK/f8SxR244QL8Gfpk6/zyeZNJURtJk5d5QbVErdDh8
 /hybQIkB+m5Q==
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="310997461"
Received: from apander1-mobl.amr.corp.intel.com (HELO han1-mobl3.jf.intel.com) ([10.255.228.143])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 10:28:43 -0700
Message-ID: <2db64e58e9aca20f4203ae3e34d5f12543a65afa.camel@linux.intel.com>
Subject: Re: [bluez,v4,2/3] btmgmt: Add command "remove" into "monitor"
 btmgmt submenu
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Mon, 22 Jun 2020 10:28:36 -0700
In-Reply-To: <CABBYNZKWN5G0qfnpirOZddEuHJtdYpzPDMJGJKpns3gXD3G9EQ@mail.gmail.com>
References: <20200619155612.bluez.v4.2.Ib8ae2d78936aa9f16a318aca14cf8c7198449bac@changeid>
         <5eed44b6.1c69fb81.44ef1.7e06@mx.google.com>
         <CABBYNZKWN5G0qfnpirOZddEuHJtdYpzPDMJGJKpns3gXD3G9EQ@mail.gmail.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Mon, 2020-06-22 at 09:57 -0700, Luiz Augusto von Dentz wrote:
> Hi Tedd,
> 
> On Fri, Jun 19, 2020 at 9:57 PM <bluez.test.bot@gmail.com> wrote:
> > 
> > This is automated email and please do not reply to this email!
> > 
> > Dear submitter,
> > 
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > While we are preparing for reviewing the patches, we found the following
> > issue/warning.
> > 
> > Test Result:
> > checkpatch Failed
> > 
> > Outputs:
> > WARNING:SSCANF_TO_KSTRTO: Prefer kstrto<type> to single variable sscanf
> > #78: FILE: tools/btmgmt.c:4686:
> > +       if (sscanf(argv[1], "%hx", &monitor_handle) != 1) {
> > +               error("Wrong formatted handle argument");
> > +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > +       }
> 
> We might want to turn off this warning since it doesn't apply to
> userspace where kstrto is not available.

I made a change.
Also, I submit the patch to add .checkpatch.conf in the tree which will also
help others to run checkpatch before submissing.

Once it is checked in, I will update the CI.

> 
> > - total: 0 errors, 1 warnings, 80 lines checked
> > 
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-
> > inplace.
> > 
> > Your patch has style problems, please review.
> > 
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT
> > FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING
> > 
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > 
> > 
> > 
> > ---
> > Regards,
> > Linux Bluetooth
> 
> 
Regards,
Tedd Ho-Jeong An

