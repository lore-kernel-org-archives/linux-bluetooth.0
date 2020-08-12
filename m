Return-Path: <SRS0=iWKJ=BW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE223C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 14:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0FF20756
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 14:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mnmoran.org header.i=@mnmoran.org header.b="aa0/V+SI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHLOot (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:44:49 -0400
Received: from hoster906.com ([192.252.156.27]:49204 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgHLOot (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Aug 2020 10:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=from
        :subject:to:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=dkim; bh=1BGXvAlqAjky12gnZjIc2GpJL
        aEX4ldCWFrER7CRVyc=; b=aa0/V+SIL1b+ug9XOhNFKxjiedeVBl2lTeV38OYT/
        7B1fmE5/1nGrklnCayOOXYHlxKeNsfDkxySIk8r28s3Bqqbw3LI+Yi/XyFNl9b2K
        XERS3e4R/RXyezrH3b3VBa4J5pGA7bwLhffAFphlg4zHfD46v5CDo7hhvEkQxG72
        P0=
Received: (qmail 3067 invoked by uid 503); 12 Aug 2020 14:44:48 -0000
Received: from unknown (HELO ?192.168.254.79?) (mike@mnmoran.org@162.39.210.203)
  by hoster906.com with ESMTPA; 12 Aug 2020 14:44:48 -0000
From:   "Michael N. Moran" <mike@mnmoran.org>
Subject: Single-Segment Segmented Mesh Messages
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <bc77bb7c-4ae6-aa1c-74d1-dfaceb48900b@mnmoran.org>
Date:   Wed, 12 Aug 2020 10:44:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I've been trying to wrap my head around the mesh d-bus api as described in "doc/mesh-api.txt". In particular, I'm looking at the org.bluez.mesh.Node1 interface Send() and DevKeySend() operations.

I don't see any way for a client application (Access Layer) to specify that a message that would fit into a single lower transport pdu should be sent as a single-segment message.

The motivation for this is to be able to test the reassembly capability of an actual mesh node/device.

For example, I would like to add an option to the test/test-mesh application to be able to send on/off messages using a single-segment message (if the destination element address is unicast).

As it is, it appears that the bluetooth-meshd makes the decision on its own based on the length of the upper transport layer pdu.

From the Mesh Profile v1.0 spec:

> 3.5.3.1 Segmentation
> 
> [...] If the Upper Transport PDU can fit into a single Lower Transport PDU using a Segmented Message format, then the lower transport layer can use a single segmented message to transmit this Upper Transport PDU.
> 
> [...] A single-segment segmented message should be used when delivery of an Upper Transport PDU can be more efficiently transmitted using a segmented message than an unsegmented message.
> 
> [...] A single-segment segmented message should be used when delivery of an Upper Transport PDU can be more efficiently transmitted using a segmented message than an unsegmented message.

