Return-Path: <SRS0=UCBE=UR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CCDC31E5B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 20:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0318F20679
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 20:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfFRUEV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:04:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:64769 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730398AbfFRUEV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jun 2019 16:04:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 13:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,390,1557212400"; 
   d="scan'208";a="160156330"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2019 13:04:20 -0700
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Jun 2019 13:04:19 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX153.amr.corp.intel.com ([169.254.12.252]) with mapi id 14.03.0439.000;
 Tue, 18 Jun 2019 13:04:19 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     =?windows-1250?Q?Micha=B3_Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 0/1] mesh: Move HCI handling to mesh-io-generic
Thread-Topic: [PATCH BlueZ 0/1] mesh: Move HCI handling to mesh-io-generic
Thread-Index: AQHVJcjDSjBUtBqdoUSLgirFfevJ66ah1QzBgAABaTY=
Date:   Tue, 18 Jun 2019 20:04:19 +0000
Message-ID: <F5913AD6-9050-422D-8BED-AB6CD2B434D3@intel.com>
References: <20190618112655.19963-1-michal.lowas-rzechonek@silvair.com>,<34B4A752-E039-4CAD-A8A7-E8CC137DC8A4@intel.com>
In-Reply-To: <34B4A752-E039-4CAD-A8A7-E8CC137DC8A4@intel.com>
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

Hi Micha³ (again)

> On Jun 18, 2019, at 12:59 PM, Gix, Brian <brian.gix@intel.com> wrote:
> 
> Hi Micha³,
> 
>> On Jun 18, 2019, at 4:27 AM, Micha³ Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com> wrote:
>> 
>> This patch enables us to implement more I/O layers, particularly non-HCI
>> ones.
>> 
>> As of Bluetooth 5.1, standard HCI commands don't allow precise control
>> over mesh-related advertising, making this I/O layer very inefficient.
>> Therefore, it is desirable to have an option to use a non-HCI transport
>> to talk to radio transceiver, at least until Bluetooth extends HCI so
>> that standard BLE Controllers achieve good performance.
> 
> The intent if the architecture was to allow for finer control with future controllers, and thus a mesh-io.c which doesn’t assume anything about underlying controllers, and then an *initial* mesh-io-generic.c which is what gets used by 4.x controllers... as more controllers are supported with finer tuning available, then mesh-io-<bt5+>.c can be added to the abstracted list.

We are also talking about how to share controllers between bluetoothd and meshd...   one idea is using the MGMT interface to send and receive specific advertisements...   that would necessitate a mesh-io-mgmt.c. However, it will also require support in the kernel.


> 
>> 
>> Another use case would be a non-local radio: the mesh stack can run on a
>> secure device, but due to physical constraints it might need to use
>> radio transceiver located at a distance, connected e.g. via LAN.
>> 
>> Micha³ Lowas-Rzechonek (1):
>> mesh: Move HCI handling to mesh-io-generic
>> 
>> mesh/main.c            |   4 +-
>> mesh/mesh-io-api.h     |   3 +-
>> mesh/mesh-io-generic.c | 203 ++++++++++++++++++++++++++++++++++++-----
>> mesh/mesh-io.c         |  17 ++--
>> mesh/mesh-io.h         |   2 +-
>> mesh/mesh.c            | 189 +++-----------------------------------
>> mesh/mesh.h            |   4 +-
>> 7 files changed, 209 insertions(+), 213 deletions(-)
>> 
>> -- 
>> 2.19.1
>> 
