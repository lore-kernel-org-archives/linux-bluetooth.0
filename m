Return-Path: <SRS0=kuCk=2G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E1EC2D0CF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 09:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6604120725
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 09:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfLPJ5T convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:57:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:3181 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfLPJ5T (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Dec 2019 04:57:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 01:57:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,321,1571727600"; 
   d="scan'208";a="217118391"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2019 01:57:18 -0800
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 01:57:17 -0800
Received: from bgsmsx106.gar.corp.intel.com (10.223.43.196) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 01:57:17 -0800
Received: from bgsmsx110.gar.corp.intel.com ([169.254.11.108]) by
 BGSMSX106.gar.corp.intel.com ([169.254.1.134]) with mapi id 14.03.0439.000;
 Mon, 16 Dec 2019 15:27:14 +0530
From:   "Kishore, Ajay" <ajay.kishore@intel.com>
To:     Johan Hedberg <johan.hedberg@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH 1/5] obexd: Add initial support for MAP conversations
Thread-Topic: [PATCH 1/5] obexd: Add initial support for MAP conversations
Thread-Index: AQHVr36tbiXWIyoe+k+Zhj5GqvoZYae8jCrg
Date:   Mon, 16 Dec 2019 09:57:14 +0000
Message-ID: <A4827819204CC641A5E2541E6709F15337DAF437@BGSMSX110.gar.corp.intel.com>
References: <1575976621-11019-1-git-send-email-ajay.kishore@intel.com>
 <20191210172007.GA50352@meiermar-mobl.ger.corp.intel.com>
In-Reply-To: <20191210172007.GA50352@meiermar-mobl.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzg5OGY4ZmEtN2MwOS00ZjVlLWIyZmUtZjVjNDYzNGQ5MjE4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMVhCcTZKenNCVWNXNTY5OG8yTlhKNWZSMGtON014eFVSV0ZnekpzSDgyTUZTKzBXcWZyVmhrWVZuYnNXMGVDTCJ9
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johan,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org <linux-bluetooth-
> owner@vger.kernel.org> On Behalf Of Johan Hedberg
> Sent: Tuesday, December 10, 2019 10:50 PM
> To: Kishore, Ajay <ajay.kishore@intel.com>
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH 1/5] obexd: Add initial support for MAP conversations
> 
> Hi Ajay,
> 
> On Tue, Dec 10, 2019, Ajay Kishore wrote:
> > Changes made to add a new method for MAP conversation listing i.e
> > "ListConversations" to handle conversation listing object
> > "x-bt/MAP-convo-listing".
> >
> > Co-authored-by: Bharat Bhusan Panda <bharat.b.panda@intel.com>
> > Signed-off-by: Ajay Kishore <ajay.kishore@intel.com>
> > ---
> >  obexd/client/map.c | 68
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> 
> Maybe I missed it, but I didn't see a patch to update doc/obex-api.txt.
> That's one of the most important changes and what needs to be agreed on
> first.

Pushed a new patch ([PATCH 6/6] doc/obex-api: Update documentation) with
Update of documentation file doc/obex-api.txt.
> 
> Johan

Thanks.
Ajay Kishore
