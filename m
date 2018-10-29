Return-Path: <SRS0=L2xa=NJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C05CC0044C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Oct 2018 12:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4007C2054F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Oct 2018 12:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4007C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbeJ2U6k convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:58:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:55161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728947AbeJ2U6k (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Oct 2018 16:58:40 -0400
Received: from [212.186.199.82] ([212.186.199.82]) by web-mail.gmx.net
 (3c-app-gmx-bs10.server.lan [172.19.170.61]) (via HTTP); Mon, 29 Oct 2018
 13:10:15 +0100
MIME-Version: 1.0
Message-ID: <trinity-57c6852c-55a5-44e1-aaac-732cb9e2bb40-1540815015379@3c-app-gmx-bs10>
From:   "ulrich berl" <ulrich.berl@gmx.net>
To:     linux-bluetooth@vger.kernel.org
Subject: Advertise changing data in python
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 29 Oct 2018 13:10:15 +0100
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-Provags-ID: V03:K1:nzH56cfBSkyADvtIRWc4YFFxHIR6czGLPaxwp3ay0r7QefjpyAw5S5oRb9G1NIb2/Fpvt
 Tuj/smAFQEhoxlxRJhhAcV4G8wNwH94g1QBJevNQK5BRoCe5kqqWEcgCNHQPGmxCdJ409arYTRzr
 6I1EeB1cotsQsr7FzvRqdg+BICl9bbv8ST41za81yjNoKzR2tBlEoDnf4HUxB+ppY69lGKyFJypX
 5D03WoRh83Z/AAy5xeu6zQGCjdzo5xqM2nzEBmTowjn1SEGVl0gbEiJ0crGZCQG6dj+F5KrO7K+h
 Ik=
X-UI-Out-Filterresults: notjunk:1;V01:K0:615HfsC3JiE=:lGfErccR6ILRVhsjh5oMqm
 1MjSVKXqRxfs6Ce2tyQwT8LYYRC46doKtvs6hxtdJiq0tydrxDpHZixe3cF+luRL3J+uuZAGV
 Vp/nIMwgki4nOb0Rqc4GXx4V3nRdqYutfb2RQ980mIdI1Kr6ihglQ0BNQdwSJCvF7MCF+dqPY
 DkQvWUgUkz46eTTAxZJxTv/AMvNKlwGERY3B9y0/NG1PdVMr8nM1LmFvfIlJRGLLwxiqmImuS
 CEiUqEuMykEKHMiRkqtdlVmeL1u1riAZxpsOWREYibU6T4VSBq2LG00nXCJ5mR2gr6faOl3cZ
 nZ+38jJres5RDaTOnuxIwwmjLLTwdI36XkrcPOHTF0O1qlORazu6VQj2Bq6Zk8+8uJM/PUZQK
 WopiEcJkBOfhQnU/juligdacWW5C0U1FEtAwhXX+ZVuUFSOhmcrNe0vqSZbNCIaY3jgiia7vl
 2B+3FiLUN0UedeE9r9+EiUzkwz4vpFXzQjUewhszDIxX4claywOf
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Actually i do some tests with bluez/test/example-advertisement - it works fine.

Now i need to advertise changing data (like timestamp, counter, ...) provided in the manufacturer data.

In a loop i have to do a RegisterAdvertisement for each changed manufacturer data ?
Or i have to register the TestAdvertisement once and then change only the self.add_manufacturer_data part?

Thanks.
