Return-Path: <SRS0=CqyX=RZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B150C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 14:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D48218A5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 14:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfCVOAo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:00:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:26494 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbfCVOAo (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Mar 2019 10:00:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 07:00:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="144315780"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2019 07:00:43 -0700
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 22 Mar 2019 07:00:43 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.129]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.63]) with mapi id 14.03.0415.000;
 Fri, 22 Mar 2019 07:00:43 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Johan Hedberg <johan.hedberg@gmail.com>
CC:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Luiz Von Dentz" <luiz.dentz@gmail.com>
Subject: Re: [PATCH BlueZ] test: Enable test-mesh to send raw vendor commands
Thread-Topic: [PATCH BlueZ] test: Enable test-mesh to send raw vendor
 commands
Thread-Index: AQHU4GJHtLMbq64yGUW+wrDcBbusaqYXrqwA////1qk=
Date:   Fri, 22 Mar 2019 14:00:42 +0000
Message-ID: <2815DD46-4BB1-46DC-881D-1C30200DAED9@intel.com>
References: <20190322034927.6247-1-inga.stotland@intel.com>,<82D05BF3-3E54-4BB1-B22B-72F1C94051A5@gmail.com>
In-Reply-To: <82D05BF3-3E54-4BB1-B22B-72F1C94051A5@gmail.com>
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

Hi Johan,

> On Mar 22, 2019, at 12:02 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> 
> Hi Inga,
> 
>> On 22 Mar 2019, at 5.49, Inga Stotland <inga.stotland@intel.com> wrote:
>> +#       5 - on/off model client menu
>> +#       6 - send raw message
>> +#       7 - exit
> 
> Please don’t use numeric identifiers for commands in interactive tools. Use intuitive, human readable strings like we do in the other interactive tools in the tree. Numbers might be convenient for computers, but they’re not particularly human friendly :)

We do plan on making better tools, but this is mostly intended as a tester script to quickly allow us to test stuff, particularly the d-bus APIs, and demonstrate the way the methods are called from python.


> 
> Johan
