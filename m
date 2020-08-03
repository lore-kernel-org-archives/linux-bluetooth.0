Return-Path: <SRS0=SB5R=BN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE06C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 14:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74EB5206DA
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 14:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mnmoran.org header.i=@mnmoran.org header.b="m1eMr8lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgHCOG7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:06:59 -0400
Received: from hoster906.com ([192.252.156.27]:49114 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgHCOG6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Aug 2020 10:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=from
        :subject:to:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=dkim; bh=yXHqsbOynObuzhrZ2pPJ22ivg
        7HdNterhdvigB2i2yY=; b=m1eMr8lvvTYrhdnxIUvMMzRly9OvBMDNRCDdDwIz/
        OIrnPRFrFu+QIrE+2E9Xi8F8xdwZflLHvr95pfOyPVaZdyyLAInppP9eHqejC4/d
        HOeuJcsWefLfyjwXPIn1PQEMn9G6GLH9GIbJQiLI/uTGdVb4vAGlqIAiaUSSJryb
        kg=
Received: (qmail 31989 invoked by uid 503); 3 Aug 2020 14:06:57 -0000
Received: from unknown (HELO ?192.168.254.79?) (pop-before-smtp@162.39.210.203)
  by hoster906.com with ESMTPA; 3 Aug 2020 14:06:57 -0000
From:   "Michael N. Moran" <mike@mnmoran.org>
Subject: [PATCH BlueZ v2 0/1] mesh: Add strings for SIG Model IDs
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <ede1e2f7-e6eb-f878-6bd4-f540200da198@mnmoran.org>
Date:   Mon, 3 Aug 2020 10:06:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

My first BlueZ patch.

This patch adds a utility function returning a string
describing a SIG Model ID and uses this function
for in the mesh-cfgclient in the list-nodes command
output and in the display of received composition data.

The strings were taken directly from the Bluetooth Mesh Profile
and Mesh Model specifications.

Fixed style issues.

Michael N. Moran (1):
   Add strings for SIG Model IDs

  tools/mesh/cfgcli.c |  3 ++-
  tools/mesh/remote.c |  5 ++--
  tools/mesh/util.c   | 64 
+++++++++++++++++++++++++++++++++++++++++++++
  tools/mesh/util.h   |  1 +
  4 files changed, 70 insertions(+), 3 deletions(-)

-- 
2.26.2

