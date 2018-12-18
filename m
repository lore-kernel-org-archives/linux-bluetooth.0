Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C21C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 16:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDC0218A2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 16:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeLRQuN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:50:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:19173 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeLRQuN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 11:50:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 08:50:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,368,1539673200"; 
   d="scan'208";a="108345962"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga007.fm.intel.com with ESMTP; 18 Dec 2018 08:50:12 -0800
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 18 Dec 2018 08:50:11 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.175]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.234]) with mapi id 14.03.0415.000;
 Tue, 18 Dec 2018 08:50:11 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Szymon Janc <szymon.janc@codecoup.pl>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v3 00/30] Major rewrite for Multi-Node and DBus
Thread-Topic: [PATCH BlueZ v3 00/30] Major rewrite for Multi-Node and DBus
Thread-Index: AQHUlAzY/IpZ6d81qkWrt6HYgcLcF6WDSB4AgAFpxYD//+z/X4AAm/0A//+Agkk=
Date:   Tue, 18 Dec 2018 16:50:11 +0000
Message-ID: <370824AD-3981-4FE9-9D3B-B010EC4B3EBC@intel.com>
References: <20181215002624.9313-1-brian.gix@intel.com>
 <DEBB0CAA2616974FAE35E4B560B9A4375D8E01AF@ORSMSX101.amr.corp.intel.com>
 <17761993.WvVeqkb5i9@ix>
 <398288BA-8B31-4D3F-97CE-62E4CD683923@intel.com>,<5F351471-7372-4486-B8A9-5D146AB60160@holtmann.org>
In-Reply-To: <5F351471-7372-4486-B8A9-5D146AB60160@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> On Dec 18, 2018, at 8:26 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> 
> Hi Brian,
> 
>>>> This patch-set has been applied upstream.
>>> 
>>> There is something wrong with Makefile.mesh
>> 
>> This was tested by us on Fedora 27 and 28, without issues.
>> 
>> What build platform produced these errors?
> 
> start adding Fedora 29 to your test platform. However this has nothing to do with Fedora 29, the whole idea of just commenting something out and committing it is just not something we do. Actually it is something that should never be done if you are operating with git. Use your personal trees for testing.
> 
>> Since Marcel is backing out the entire patchset, we will create a v4 patchset that removes btmesh (the non-daemon executable) entirely.  It probably won’t actually be needed in the future anyway... The DBus APIs should be sufficient.
> 
> Be careful to not take tools away from people that might depend on it right now.

The only functionality that was available in btmesh that was not in the meshd daemon, was the ability to request a beacon be sent.  This is done automatically by the daemon.

The balance of btmesh functionality was to be a foreground app so that all the debug output is on the console. This can be done with the meshd executable with the -nd argument (no detach).

After consulting with Inga, we think btmesh should be removed entirely.

> Regards
> 
> Marcel
> 
