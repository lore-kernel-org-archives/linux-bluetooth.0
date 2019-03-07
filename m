Return-Path: <SRS0=Hm6j=RK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85282C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Mar 2019 09:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD5820652
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Mar 2019 09:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfCGJQG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:16:06 -0500
Received: from mga01.intel.com ([192.55.52.88]:3335 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfCGJQG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Mar 2019 04:16:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 01:16:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="132001764"
Received: from jrissane-mobl.fi.intel.com ([10.237.67.34])
  by orsmga003.jf.intel.com with ESMTP; 07 Mar 2019 01:16:04 -0800
Message-ID: <dc2e705ca9bef128b045f23371e7f6daa5ab957f.camel@linux.intel.com>
Subject: Re: [PATCH 0/3] bluetooth: 6lowpan: multiple peers and addresses
From:   Jukka Rissanen <jukka.rissanen@linux.intel.com>
To:     Michael Scott <mike@foundries.io>,
        Josua Mayer <josua.mayer@jm0.eu>,
        linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net
Date:   Thu, 07 Mar 2019 11:16:03 +0200
In-Reply-To: <eb35ff67-1ec8-d5b6-05b9-b065ade27335@foundries.io>
References: <20190208152519.16181-1-josua.mayer@jm0.eu>
         <a0d7f533-964c-7d5b-69be-840c26d05fd8@jm0.eu>
         <12348b37-c8ef-cf4a-a86e-ab09fadbc792@foundries.io>
         <eb35ff67-1ec8-d5b6-05b9-b065ade27335@foundries.io>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Mike & Josua,

On Wed, 2019-03-06 at 10:10 -0800, Michael Scott wrote:
> Josua,
> 
> On 2/28/19 12:30 PM, Michael Scott wrote:
> > Hi Josua,
> > 
> > On 2/28/19 12:00 PM, Josua Mayer wrote:
> > > Ping
> > > 
> > > Did anyone get a chance to look at this yet?
> > > @Jukka I have added you in CC since this is about both 6lowpan
> > > and ble.
> > > 

The patches looked ok.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka


