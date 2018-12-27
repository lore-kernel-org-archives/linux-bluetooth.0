Return-Path: <SRS0=UKt+=PE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53338C43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Dec 2018 19:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB48208E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Dec 2018 19:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbeL0TWH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Dec 2018 14:22:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:10546 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbeL0TWH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Dec 2018 14:22:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2018 11:22:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,406,1539673200"; 
   d="scan'208";a="121475225"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga002.jf.intel.com with ESMTP; 27 Dec 2018 11:22:06 -0800
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 27 Dec 2018 11:22:06 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.175]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.172]) with mapi id 14.03.0415.000;
 Thu, 27 Dec 2018 11:22:06 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: RE: [PATCH BlueZ v5 27/30] mesh: Sample Provisioning Agent
Thread-Topic: [PATCH BlueZ v5 27/30] mesh: Sample Provisioning Agent
Thread-Index: AQHUl1Jx9q/MplaTdU6F0rPBT2MNiaWO8XCAgAQP93A=
Date:   Thu, 27 Dec 2018 19:22:05 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375D8E5F84@ORSMSX101.amr.corp.intel.com>
References: <20181219042016.25538-1-brian.gix@intel.com>
 <20181219042016.25538-28-brian.gix@intel.com>
 <3DB952F2-C235-4921-A4E9-4FADF5C10F31@holtmann.org>
In-Reply-To: <3DB952F2-C235-4921-A4E9-4FADF5C10F31@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWExOTAzMjYtMmE1Ny00MmVhLTlhMjMtZGFiZmYzNTUzYjVhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSVJZODJlaUs4ZUdKMGF3WXpZNGJqeXY1enJmd1JUOElpVitRdG41QUJSMnNMTFNyUElTRlVEeDZEelRmVzVTeCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Monday, December 24, 2018 1:10 PM
> To: Gix, Brian <brian.gix@intel.com>
> Cc: linux-bluetooth@vger.kernel.org; Johan Hedberg
> <johan.hedberg@gmail.com>; Stotland, Inga <inga.stotland@intel.com>
> Subject: Re: [PATCH BlueZ v5 27/30] mesh: Sample Provisioning Agent
> 
> Hi Brian,
> 
> > ---
> > mesh/agent.py | 40 ++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 40 insertions(+)
> > create mode 100755 mesh/agent.py
> 
> no, these all belong in the test directory. And we never used the .py suffix
> either.

The python scripts are all being moved to the test directory, but one point of clarification here:

agent.py is not stand-alone. It is imported into other files, much like the existing files:

./test/bluezutils.py
./test/dbusdef.py
./test/sap_client.py

This is the standard naming convention for included/imported python modules, and while it
*is* possible to include modules that do not follow that naming convention, it is ugly,
and will not seem "Natural" to anyone from the python world coming in and trying to use
these modules in BlueZ.  It would be like not using the ".h" extension on C header files.

Are you absolutely *certain* that you want to break with python precedence in order to avoid using
the .py file name extension?

> 
> Regards
> 
> Marcel

