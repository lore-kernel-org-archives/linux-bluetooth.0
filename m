Return-Path: <SRS0=UnQ+=ZI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21054C432C3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Nov 2019 12:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AB720700
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Nov 2019 12:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfKPMHv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 16 Nov 2019 07:07:51 -0500
Received: from hall.aurel32.net ([195.154.113.88]:52656 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbfKPMHv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 16 Nov 2019 07:07:51 -0500
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1iVwrl-00019G-Qj; Sat, 16 Nov 2019 13:07:49 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92.3)
        (envelope-from <aurelien@aurel32.net>)
        id 1iVwrl-0001MQ-Fe; Sat, 16 Nov 2019 13:07:49 +0100
Date:   Sat, 16 Nov 2019 13:07:49 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ v2 0/2] mesh: Fix inOOB and outOOB issues
Message-ID: <20191116120749.GC30589@aurel32.net>
References: <20191115231705.5596-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115231705.5596-1-brian.gix@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2019-11-15 15:17, Brian Gix wrote:
> This patchset includes modification to both the Daemon and the
> mesh-cfgclient.  All of the inOOB and outOOB scenarios have been tested,
> and are working according to the Bluetooth Profile specification, for
> the Provisioner "Initiator" role.
> 
> Brian Gix (1):
>   mesh: Fix inOOB and outOOB agent handling on prov initiate
> 
> Inga Stotland (1):
>   tools/mesh-cfgclient: Add full support inOOB and outOOB
> 
>  mesh/agent.c           |  12 +--
>  mesh/prov-initiator.c  |  69 +++++++++++++---
>  tools/mesh-cfgclient.c | 178 ++++++++++++++++++++++++++++++++++-------
>  tools/mesh-gatt/prov.c |   9 ++-
>  tools/mesh/agent.c     |  21 +++--
>  tools/mesh/agent.h     |   4 +-
>  6 files changed, 233 insertions(+), 60 deletions(-)

Thanks for the patches. I have just tried them and I confirm it fixes
output OOB with number. Output OOB with string still doesn't work. I
came up with this patch to fix it:

diff --git a/mesh/agent.c b/mesh/agent.c
index 623f2faf0..e5545d7f3 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -604,7 +604,7 @@ int mesh_agent_prompt_number(struct mesh_agent *agent, bool initiator,
 int mesh_agent_prompt_alpha(struct mesh_agent *agent, mesh_agent_key_cb_t cb,
 								void *user_data)
 {
-	return prompt_input(agent, "in-alpha", MESH_AGENT_REQUEST_IN_ALPHA,
+	return prompt_input(agent, "out-alpha", MESH_AGENT_REQUEST_OUT_ALPHA,
 							false, cb, user_data);
 }

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
