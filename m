Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634FFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Dec 2021 20:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhLIUSs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:18:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:32874 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231796AbhLIUSq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Dec 2021 15:18:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238422613"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="238422613"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 12:15:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="564949130"
Received: from csadams-mobl3.amr.corp.intel.com (HELO [10.209.101.33]) ([10.209.101.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 12:15:10 -0800
Message-ID: <34192a7d9103c17c7c0a4397ac114e984e44e6f9.camel@linux.intel.com>
Subject: Re: [PATCH BlueZ 0/6] tools/mesh-gatt meshctl tool improvements
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Daniele Biagetti <dbiagio79@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     Daniele Biagetti <daniele.biagetti@cblelectronics.com>
Date:   Thu, 09 Dec 2021 12:15:10 -0800
In-Reply-To: <20211207225604.35156-1-daniele.biagetti@cblelectronics.com>
References: <20211207225604.35156-1-daniele.biagetti@cblelectronics.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniele,

It seems like the patches has some format issues. Please check the test report
email for details or run checkpatch script.

Also, please include the commit message in each patch.

On Tue, 2021-12-07 at 23:55 +0100, Daniele Biagetti wrote:
> Hi all,
> 
> The present patch series adds some functionalities and improvements to the meshctl tool.
> More precisely:
> - Add onoff set unacknowledge message to onoff client model
> 
> - Fix status messages processing
>    The status messages was processed and displayed even if they do
>    not belong to the present model. This fix ensure that the status
>    messages are processed only if they have the correct opcode.
> 
> - Fix unwanted return in onoff client model
>    Replaced the return statement with a warning message in case of
>    transmission or reception of messages coming from unknown addresses
>    (such as group addresses)
> 
> - Add subscription delete message to config client model
> 
> - Generic level model
>    Limited to the following messages:
>    * Generic Level Get
>    * Generic Level Set
>    * Generic LevelSet Unacknowledge
>    * Generic Level Status
> 
> - Generic OnPowerUp model
> 
> Best regards
> 
> Daniele Biagetti (6):
>   tools/mesh-gatt: Add onoff set unack message to onoff client model
>   tools/mesh-gatt: Fix status messages processing
>   tools/mesh-gatt: Fix unwanted return in onoff client model
>   tools/mesh-gatt: Add subscription delete message to config client
>     model
>   tools/mesh-gatt: Add generic level model support
>   tools/mesh-gatt: Add generic power onoff client model
> 
>  Makefile.tools                    |   6 +-
>  tools/mesh-gatt/config-client.c   |  40 +++++
>  tools/mesh-gatt/level-model.c     | 288 ++++++++++++++++++++++++++++++
>  tools/mesh-gatt/level-model.h     |  21 +++
>  tools/mesh-gatt/local_node.json   |  10 +-
>  tools/mesh-gatt/node.c            |  11 ++
>  tools/mesh-gatt/onoff-model.c     |  56 +++---
>  tools/mesh-gatt/onpowerup-model.c | 250 ++++++++++++++++++++++++++
>  tools/mesh-gatt/onpowerup-model.h |  21 +++
>  tools/meshctl.c                   |   8 +
>  10 files changed, 688 insertions(+), 23 deletions(-)
>  create mode 100644 tools/mesh-gatt/level-model.c
>  create mode 100644 tools/mesh-gatt/level-model.h
>  create mode 100644 tools/mesh-gatt/onpowerup-model.c
>  create mode 100644 tools/mesh-gatt/onpowerup-model.h
> 

Regards,
Tedd

