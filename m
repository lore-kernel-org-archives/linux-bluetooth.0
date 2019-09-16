Return-Path: <SRS0=loPc=XL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242E0C4CECD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 10:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0443F20644
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 10:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbfIPKz5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:55:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:27031 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732701AbfIPKz4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Sep 2019 06:55:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 03:55:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="177008851"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga007.jf.intel.com with ESMTP; 16 Sep 2019 03:55:55 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Sep 2019 03:55:55 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.221]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.93]) with mapi id 14.03.0439.000;
 Mon, 16 Sep 2019 03:55:55 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     =?windows-1250?Q?Micha=B3_Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 1/1] mesh: Add local/remote bools to DevKey
 transactions
Thread-Topic: [PATCH BlueZ 1/1] mesh: Add local/remote bools to DevKey
 transactions
Thread-Index: AQHVa52TiigZ9MdeYUO+JqwhakK/NqcuiMWA//+an5Y=
Date:   Mon, 16 Sep 2019 10:55:54 +0000
Message-ID: <8DD9DDA0-1081-479F-B215-2E815B1A8F27@intel.com>
References: <20190915081408.18116-1-brian.gix@intel.com>
 <20190915081408.18116-2-brian.gix@intel.com>,<20190916095845.htvyalekgr4k2ybt@mlowasrzechonek2133>
In-Reply-To: <20190916095845.htvyalekgr4k2ybt@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Micha³, 

> On Sep 16, 2019, at 11:58 AM, Micha³ Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com> wrote:
> 
> Hi Brian,
> 
>> On 09/15, Brian Gix wrote:
>> DevKey operations require authorization on the part of the applications
>> making the requests. Messages to state changing Servers should use keys
>> from the local Key Database to demonstrate authority.
> 
> Alright, so if I understand this correctly:
> 
> 1. If the application would like to change Config Server states on the
>   local node, it would need to:
>    - call ImportRemoteNode, passing the address of a *local* node and
>      the device key obtained from provisioner
>    - call DevKeySend to a *local* address, with remote flag set to true
>    - receive responses via DevKeyMessageReceived from *local* node,
>      with remote flag set to true
> 
>   Essentially this means that talking to a local node using device
>   security behaves in the same manner as if the node was a remote one.
> 
> 2. If the application would like to implement an external model that
>   uses device security, it would:
>    - receive DevKeyMessageReceived calls from remote nodes, with remote
>      flag set to false
>    - send responses by calling DevKeySend to a *remote* address with
>      remote flag set to false
> 
> This means that calling DevKeySend to a *local* address with remote flag
> false would be forbidden, in order to force the application to use
> ImportRemoteNode first?

I think that is all basically correct. I switched the Boolean bit-sense  such that the boolean parameter is “remote” on the send and “local” on the receive.

And most importantly, your last point is an emphatic yes....    you will need to import your own device key to the key ring if you want to talk to your own builtin servers.  The one exception will be nodes that have called “Create()” which are generating brand new mesh networks with themselves as unicast 0001.


> 
> -- 
> Micha³ Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
> Silvair http://silvair.com
> Jasnogórska 44, 31-358 Krakow, POLAND
