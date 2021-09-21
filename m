Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173F1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 03:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E164B611C7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 03:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhIUDty (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:49:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:18700 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231817AbhIUDtw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Sep 2021 23:49:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="245692025"
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="245692025"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 20:48:20 -0700
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="652803122"
Received: from nvhitchb-mobl.amr.corp.intel.com ([10.209.76.49])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 20:48:20 -0700
Message-ID: <055f1d07ae9f5f7485061c8de9a6e96e29465b4c.camel@linux.intel.com>
Subject: Re: Deprecated Python Libraries
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Barry Byford <31baz66@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Date:   Mon, 20 Sep 2021 20:48:20 -0700
In-Reply-To: <CAAu3APZAJD-uPUO1d4g=7smD34LUzkn87MkQKfdEcTC41FM5Vg@mail.gmail.com>
References: <CAAu3APZAJD-uPUO1d4g=7smD34LUzkn87MkQKfdEcTC41FM5Vg@mail.gmail.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Barry,

On Fri, 2021-09-17 at 08:03 +0100, Barry Byford wrote:
> The Python examples in the test directory have some dependencies that
> have issues:
> 
> optparse
> According to the documentation this has now been deprecated
> 
> https://docs.python.org/3/library/optparse.html#:~:text=Deprecated%20since%20version%203.2
> 
> dbus-python
> This has some known issues according to the documentation
> 
> https://dbus.freedesktop.org/doc/dbus-python/#:~:text=Alternative%20ways%20to%20get%20your%20Python%20code%20onto%20D-Bus
> 
> The above documentation has recommendations of switching to
> import argparse
> from gi.repository import Gio
> 
> Both of these should already be on systems because argparse is built
> in to Python and gi.repository is used for GLib elsewhere in the
> examples.
> Would there be any interest in getting patches to change to these
> different libraries?
> Are these test scripts used in any of the automated tests?
> Can I submit a PR via https://github.com/bluez/bluez/pulls?

If you have a patch, please submit it via mailing list instead of github.
Github is for other purpose and not ready to accept the patches/PR at this point.

> 
> Thanks,
> Barry

Regards,
Tedd Ho-Jeong An


