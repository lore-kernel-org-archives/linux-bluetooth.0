Return-Path: <SRS0=iCSy=Q2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22332C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Feb 2019 21:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E271521479
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Feb 2019 21:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfBSVa2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:30:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:15345 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfBSVa2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Feb 2019 16:30:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 13:30:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="300986649"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga005.jf.intel.com with ESMTP; 19 Feb 2019 13:30:27 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.129]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.90]) with mapi id 14.03.0415.000;
 Tue, 19 Feb 2019 13:30:06 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: RE: [PATCH BlueZ 0/3] mesh: Save/restore application keys
Thread-Topic: [PATCH BlueZ 0/3] mesh: Save/restore application keys
Thread-Index: AQHUxBe6B3TPPwI1Uky1BMiVoR1wE6XnrDyA
Date:   Tue, 19 Feb 2019 21:30:06 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375D933EDA@ORSMSX103.amr.corp.intel.com>
References: <20190214034527.6310-1-inga.stotland@intel.com>
In-Reply-To: <20190214034527.6310-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2Y5N2Y2MDItYWRhYS00ZjRlLWFjNjAtMzEwY2FlNjVjNDQxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOW5sbkJGejRNTGExc3F3d0hyS3JKTzRXR28xS2NxcEZvRDljd01LZmJTTTZTUFZJUDNsTW1NT01RUjBnXC9ZencifQ==
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

applied patch set

> -----Original Message-----
> From: Stotland, Inga
> Sent: Wednesday, February 13, 2019 7:45 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Gix, Brian <brian.gix@intel.com>; johan.hedberg@gmail.com;
> luiz.dentz@gmail.com; Stotland, Inga <inga.stotland@intel.com>
> Subject: [PATCH BlueZ 0/3] mesh: Save/restore application keys
> 
> This set of patches fixes the application key add/update processing.
> An application key needs to be saved to a local node configuration file
> when:
> 	- a new application key is added by a configuration client
>     - an existing application key is updated by a configuration client
> 	  during key refresh procedure.
> 
> Also, fix error codes for AppKey List operation
> 
> Inga Stotland (3):
>   mesh: Separate functions for app key add and update
>   mesh: Save newly added or updated app key to config file
>   mesh: Return correct error code for Appkey List command
> 
>  mesh/appkey.c        |  92 ++++++++++++++++++++++---------------
>  mesh/appkey.h        |   4 +-
>  mesh/cfgmod-server.c |   8 +++-
>  mesh/mesh-db.c       | 107 ++++++++++++++++++++-----------------------
>  mesh/mesh-db.h       |   4 +-
>  mesh/storage.c       |   5 +-
>  6 files changed, 120 insertions(+), 100 deletions(-)
> 
> --
> 2.17.2

