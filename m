Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D11C43464
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676AA21734
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgIRWm4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:42:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:46113 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgIRWm4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 18:42:56 -0400
IronPort-SDR: 53TWkJBSrYvr7LzPu3y/Yl3n+LGRhu+DKjts2YaiqCl3jYRtUv1YN/q1/oekETyz93XeC5GAiL
 zYY/3TliyjnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="147729531"
X-IronPort-AV: E=Sophos;i="5.77,276,1596524400"; 
   d="scan'208";a="147729531"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 15:42:48 -0700
IronPort-SDR: oozfPNG0+KHYsooF04kJO++GlpN7d1bC7DbgVyqOlZ3o/du4BHSLDQl5XqiVZDt/R5/ZUXtwtF
 IFlEY0mOc6Yg==
X-IronPort-AV: E=Sophos;i="5.77,276,1596524400"; 
   d="scan'208";a="340000393"
Received: from hgreve-mobl.amr.corp.intel.com (HELO han1-mobl3.jf.intel.com) ([10.255.229.3])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 15:42:48 -0700
Message-ID: <3115c5127f4130fc3b304a302cc742ab97034479.camel@linux.intel.com>
Subject: Re: [BlueZ v4 03/20] btio: Add SPDX License Identifier
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Fri, 18 Sep 2020 15:42:38 -0700
In-Reply-To: <CABBYNZ+8-GsnTeJyCETo-3pGHSDxxDUS_6szMvbGfS8_ngyRVA@mail.gmail.com>
References: <20200918210846.37797-1-tedd.an@linux.intel.com>
         <20200918210846.37797-4-tedd.an@linux.intel.com>
         <CABBYNZ+8-GsnTeJyCETo-3pGHSDxxDUS_6szMvbGfS8_ngyRVA@mail.gmail.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Fri, 2020-09-18 at 15:13 -0700, Luiz Augusto von Dentz wrote:
> Hi Tedd,
> 
> On Fri, Sep 18, 2020 at 2:17 PM <tedd.an@linux.intel.com> wrote:
> > From: Tedd Ho-Jeong An <tedd.an@intel.com>
> > 
> > This patch adds SPDX License Identifier and removes the license text.
> > 
> > -------------------------------------
> >        License            COUNT
> > -------------------------------------
> >  GPL-2.0-or-later     :      2
> > 
> > License: GPL-2.0-or-later
> >    btio/btio.h
> >    btio/btio.c
> > ---
> >  btio/btio.c | 15 +--------------
> >  btio/btio.h | 15 +--------------
> >  2 files changed, 2 insertions(+), 28 deletions(-)
> > 
> > diff --git a/btio/btio.c b/btio/btio.c
> > index 844d6007f..c18b6a012 100644
> > --- a/btio/btio.c
> > +++ b/btio/btio.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> 
> It still appears to be using C++ comment style.

That's how Linux kernel uses and checkpatch.pl check based on this rule.
If use "//" in header file, checkpatch willl fail with something like this:

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'src/agent.h', please
use '/*' instead
#16: FILE: src/agent.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in
line 1
#16: FILE: src/agent.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

Then, we need to turn off "SPDX_LICENSE_TAG" flag from checkpatch rule...

> 
> >  /*
> >   *
> >   *  BlueZ - Bluetooth protocol stack for Linux
> > @@ -6,20 +7,6 @@
> >   *  Copyright (C) 2009-2010  Nokia Corporation
> >   *
> >   *
> > - *  This program is free software; you can redistribute it and/or modify
> > - *  it under the terms of the GNU General Public License as published by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, write to the Free Software
> > - *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-
> > 1301  USA
> > - *
> >   */
> > 
> >  #ifdef HAVE_CONFIG_H
> > diff --git a/btio/btio.h b/btio/btio.h
> > index 23e0ef72b..f0259cf1d 100644
> > --- a/btio/btio.h
> > +++ b/btio/btio.h
> > @@ -1,3 +1,4 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >  /*
> >   *
> >   *  BlueZ - Bluetooth protocol stack for Linux
> > @@ -6,20 +7,6 @@
> >   *  Copyright (C) 2009-2010  Nokia Corporation
> >   *
> >   *
> > - *  This program is free software; you can redistribute it and/or modify
> > - *  it under the terms of the GNU General Public License as published by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, write to the Free Software
> > - *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-
> > 1301  USA
> > - *
> >   */
> >  #ifndef BT_IO_H
> >  #define BT_IO_H
> > --
> > 2.17.1
> > 
> 
> 

