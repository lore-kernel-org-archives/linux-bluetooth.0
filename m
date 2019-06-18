Return-Path: <SRS0=UCBE=UR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE01C31E5B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 19:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D754B20B1F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 19:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfFRT7S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jun 2019 15:59:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:26747 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbfFRT7S (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jun 2019 15:59:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 12:59:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,390,1557212400"; 
   d="scan'208";a="334972300"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga005.jf.intel.com with ESMTP; 18 Jun 2019 12:59:17 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.18]) with mapi id 14.03.0439.000;
 Tue, 18 Jun 2019 12:59:17 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     =?windows-1250?Q?Micha=B3_Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 0/1] mesh: Move HCI handling to mesh-io-generic
Thread-Topic: [PATCH BlueZ 0/1] mesh: Move HCI handling to mesh-io-generic
Thread-Index: AQHVJcjDSjBUtBqdoUSLgirFfevJ66ah1QzB
Date:   Tue, 18 Jun 2019 19:59:16 +0000
Message-ID: <34B4A752-E039-4CAD-A8A7-E8CC137DC8A4@intel.com>
References: <20190618112655.19963-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190618112655.19963-1-michal.lowas-rzechonek@silvair.com>
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

> On Jun 18, 2019, at 4:27 AM, Micha³ Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com> wrote:
> 
> This patch enables us to implement more I/O layers, particularly non-HCI
> ones.
> 
> As of Bluetooth 5.1, standard HCI commands don't allow precise control
> over mesh-related advertising, making this I/O layer very inefficient.
> Therefore, it is desirable to have an option to use a non-HCI transport
> to talk to radio transceiver, at least until Bluetooth extends HCI so
> that standard BLE Controllers achieve good performance.

The intent if the architecture was to allow for finer control with future controllers, and thus a mesh-io.c which doesn’t assume anything about underlying controllers, and then an *initial* mesh-io-generic.c which is what gets used by 4.x controllers... as more controllers are supported with finer tuning available, then mesh-io-<bt5+>.c can be added to the abstracted list.

> 
> Another use case would be a non-local radio: the mesh stack can run on a
> secure device, but due to physical constraints it might need to use
> radio transceiver located at a distance, connected e.g. via LAN.
> 
> Micha³ Lowas-Rzechonek (1):
>  mesh: Move HCI handling to mesh-io-generic
> 
> mesh/main.c            |   4 +-
> mesh/mesh-io-api.h     |   3 +-
> mesh/mesh-io-generic.c | 203 ++++++++++++++++++++++++++++++++++++-----
> mesh/mesh-io.c         |  17 ++--
> mesh/mesh-io.h         |   2 +-
> mesh/mesh.c            | 189 +++-----------------------------------
> mesh/mesh.h            |   4 +-
> 7 files changed, 209 insertions(+), 213 deletions(-)
> 
> -- 
> 2.19.1
> 
