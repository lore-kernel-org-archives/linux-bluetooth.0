Return-Path: <SRS0=KRcZ=RD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBCCC43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Feb 2019 18:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8717C218B0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Feb 2019 18:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfB1Sub convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:50:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:3771 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfB1Sua (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Feb 2019 13:50:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 10:50:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,424,1544515200"; 
   d="scan'208";a="125960540"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga007.fm.intel.com with ESMTP; 28 Feb 2019 10:50:30 -0800
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 28 Feb 2019 10:50:30 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.129]) by
 ORSMSX121.amr.corp.intel.com ([169.254.10.201]) with mapi id 14.03.0415.000;
 Thu, 28 Feb 2019 10:50:29 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: RE: [PATCH BlueZ 0/3 v2] mesh: Implement Leave() method
Thread-Topic: [PATCH BlueZ 0/3 v2] mesh: Implement Leave() method
Thread-Index: AQHUynhj5qzkEgr7cUuiRic4q6aWxqX1l/UA
Date:   Thu, 28 Feb 2019 18:50:29 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375D93A12D@ORSMSX103.amr.corp.intel.com>
References: <20190222063148.4995-1-inga.stotland@intel.com>
In-Reply-To: <20190222063148.4995-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGQ2YjdiNDMtN2Y5NS00MzEyLWE2ODAtYzlkOTRhY2FhZDI5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZFRucE1WV3VNMXF1aXU3b1l5QTZGUDVacHR2dlZ1YUxxdDZ0M2NGNWQ1eFVaVFV6d2FuT2RkM0xZWXRSbXN2SyJ9
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Patch-set applied

> -----Original Message-----
> From: Stotland, Inga
> Sent: Thursday, February 21, 2019 10:32 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Gix, Brian <brian.gix@intel.com>; johan.hedberg@gmail.com;
> luiz.dentz@gmail.com; Stotland, Inga <inga.stotland@intel.com>
> Subject: [PATCH BlueZ 0/3 v2] mesh: Implement Leave() method
> 
> This set of patches includes implementation of Leave() method on Network
> interface and a number of fixes that allow to cleanly remove a node info
> form the running daemon and the persistent storage
> 
> Inga Stotland (3):
>   mesh: Re-arrange node cleanup functions
>   mesh: Cleanup storage save and remove procedures
>   mesh: Implement Leave() method on Network interface
> 
>  mesh/mesh.c    | 33 ++++++++++++++++++++++++---------
>  mesh/node.c    | 50 ++++++++++++++++++++++++++++++++++++-----------
> ---
>  mesh/node.h    |  5 +++--
>  mesh/storage.c | 46 ++++++++++++++++++++++++++++++----------------
>  mesh/storage.h |  2 +-
>  5 files changed, 94 insertions(+), 42 deletions(-)
> 
> --
> 2.17.2

