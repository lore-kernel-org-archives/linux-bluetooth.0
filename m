Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F44EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 16:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243268AbiBQQgc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:36:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiBQQgc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 11:36:32 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3300B2B2FCB
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 08:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645115775; x=1676651775;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MzY2Dpa7WXd8Y/qN3oUL9Os7oqX8hGXNVcYnW55LxR8=;
  b=ULgieVSftULPF/lG5n6fYUyMfkaHetotsDmWoW7IpJrlOMYgvOqKEmMZ
   u79fKDi6+xh+iWvTVAXSdRGsN/j6/FaSLd5jBn4ylYQ914hcn9hpm3yfB
   Tbot81hjqCFVo3/Zk8a3zXZW3Ifqa5yJrWeZM3IHWSMAQLquQxPM7CCBr
   LBd999CJVvRPZJNTRWFYFjcFGAqshCXbRpxWtPQ3GsRfDU3X0kAc4YYYB
   IxXhmxi5KKbjoE3DM0ez/qTxsfPSAj4x3Vii27KqFC7usVn2HnfUCeMh9
   wuHxdOEAOz3Hd3W/P+kluP9pN/H2TISz8pwnRoiMbNV+1XHus0pfLfiFw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="248508985"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="248508985"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 08:36:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="637220129"
Received: from angelara-mobl.amr.corp.intel.com (HELO [10.212.243.134]) ([10.212.243.134])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 08:36:14 -0800
Message-ID: <aad96edd229fbb2b2b8d19727696e24add6783cb.camel@linux.intel.com>
Subject: Re: [BlueZ PATCH] shared: Fix the incorrect type with bit shift
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Date:   Thu, 17 Feb 2022 08:36:13 -0800
In-Reply-To: <9ADB9AF8-0F3F-4B49-BA89-1026920C591A@holtmann.org>
References: <20220217063145.50497-1-hj.tedd.an@gmail.com>
         <9ADB9AF8-0F3F-4B49-BA89-1026920C591A@holtmann.org>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, 2022-02-17 at 10:55 +0100, Marcel Holtmann wrote:
> Hi Tedd,
> 
> > This patch fixes the following runtime error:
> > 
> > $ sudo ./monitor/btmon -w test.btsnoop
> >  Bluetooth monitor ver 5.63
> >  src/shared/btsnoop.c:339:18: runtime error: left shift of 65535 by 16 places cannot be represented in type 'int'
> 
> what compiler version is this? Or what warnings did you enable? Since this is weird, so while yes 0xffff can not be shifted, but we are also not shifting into an uint16_t. The fix is fine, I am just
> curious. There will be other places with the same problem.

I am using gcc 9.3.0 came with Ubuntu 20.04.
This is enabled by the "-fsanitize=undefined" option.

Recent change enabled LSAN, ASAN, and UBSAN by default.


> 
> Regards
> 
> Marcel
> 


