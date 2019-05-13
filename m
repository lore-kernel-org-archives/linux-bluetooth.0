Return-Path: <SRS0=zNJH=TN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB73C04AA7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 May 2019 16:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88643208CA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 May 2019 16:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfEMQZe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 May 2019 12:25:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:42237 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbfEMQZd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 May 2019 12:25:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 09:25:33 -0700
X-ExtLoop1: 1
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga006.fm.intel.com with ESMTP; 13 May 2019 09:25:33 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.171]) with mapi id 14.03.0415.000;
 Mon, 13 May 2019 09:25:32 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Michal Lowas-Rzechonek <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>
Subject: RE: [PATCH] mesh: Fixed log MIC usage in segmented messages
Thread-Topic: [PATCH] mesh: Fixed log MIC usage in segmented messages
Thread-Index: AQHVCUxamMxUmrxa9kagkMwDtpes56ZpOA0g
Date:   Mon, 13 May 2019 16:25:32 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4376CB4EE08@ORSMSX103.amr.corp.intel.com>
References: <20190507072702.27144-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190507072702.27144-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjgyNjkyNGMtN2E3Ni00Zjc0LWExM2YtMTAxZjQ5YTk5YzFlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiU1dDaHRtSVNTUGdaY2k5aDVTTkd1QXRNc2VoV3ZFNGpFb3pCR2dVS1ZvWExwT3FtZnhTeTQ1dHlwQlFkMXdUSiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Michal & Jakub,

> From: Michal Lowas-Rzechonek
> 
> +#define CEILDIV(val, div) (((val) / (div)) + ((val) % (div) != 0))
> +


>  	/* Use large MIC if it doesn't affect segmentation */
>  	if (msg_len > 11 && msg_len <= 376) {
> -		if ((out_len / 12) == ((out_len + 4) / 12)) {
> +		if (CEILDIV(out_len, 12) == CEILDIV(out_len + 4, 12)) {
>  			szmic = true;
>  			out_len = msg_len + sizeof(uint64_t);
>  		}

I see what you are doing here, and agree that it will fix a problem... for instance with out_len == 20

I am uncomfortable with two things:

1. The name CEILDIV...   I found a definition for it (divide and round up) but I think it perhaps either the macro should be renamed something like "SEG_COUNT"  *or* a comment added defining what CEILDIV means for the uninitiated (like me):

/* CEILDIV() is a Divide and Round Up macro */



2. Using a Boolean result as an Integer for addition makes the macro a bit difficult to puzzle out, if you don't know what it is trying to do.

What about:
(((val) / (div)) + (((val) % (div)) ? 1 : 0))
