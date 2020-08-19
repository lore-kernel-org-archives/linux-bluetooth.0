Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF0AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 15:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D3420882
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 15:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=omicronenergy.com header.i=@omicronenergy.com header.b="b8uFkOQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHSPJw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:09:52 -0400
Received: from ns.omicron.at ([212.183.10.25]:36752 "EHLO ns.omicron.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgHSPJu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 11:09:50 -0400
Received: from MGW02-ATKLA.omicron.at ([172.25.62.35])
        by ns.omicron.at (8.15.2/8.15.2) with ESMTPS id 07JF9me1006602
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 17:09:48 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 ns.omicron.at 07JF9me1006602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omicronenergy.com;
        s=default; t=1597849788;
        bh=iwYDqaF8wLGR9iRaH+BfDezv0AUJ8LlIY9TDOWahSMo=;
        h=From:To:CC:Subject:Date:From;
        b=b8uFkOQUAqLbBVKgtpeB0madR6IMa4tX2hlsAqEuyrXuIm/iaHhntARIP8BIEMxoe
         KDqschd3uxLK4C9eA120yX6YSmWE8uhhXC8eR9580ElXeWst5RLHxEswd2hmz+88ik
         fBLCFqDcJXTB90uusJ6MsPqjE2F6+R9rBNcQ2juI=
Received: from MGW02-ATKLA.omicron.at (localhost [127.0.0.1])
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTP id 1874AA0054
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 17:09:47 +0200 (CEST)
Received: from MGW01-ATKLA.omicron.at (unknown [172.25.62.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTPS id 1660DA0053
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 17:09:47 +0200 (CEST)
Received: from EXC04-ATKLA.omicron.at ([172.22.100.189])
        by MGW01-ATKLA.omicron.at  with ESMTP id 07JF9l7E027212-07JF9l7G027212
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=CAFAIL)
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 17:09:47 +0200
Received: from marmar13.omicron.at (172.22.32.104) by EXC04-ATKLA.omicron.at
 (172.22.100.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 17:09:41 +0200
From:   Mark Marshall <mark.marshall@omicronenergy.com>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Mark Marshall <mark.marshall@omicronenergy.com>
Subject: [PATCH BlueZ 0/2] Add support for LE profiles (LE-L2CAP)
Date:   Wed, 19 Aug 2020 17:09:29 +0200
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.32.104]
X-ClientProxiedBy: EXC04-ATKLA.omicron.at (172.22.100.189) To
 EXC04-ATKLA.omicron.at (172.22.100.189)
Message-ID: <60274e5a-d210-425d-bba5-946119fd4f87@EXC04-ATKLA.omicron.at>
X-FE-Policy-ID: 1:1:1:SYSTEM
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I wanted to create a custom profile that used LE-L2CAP, and I found
that there were a couple features missing that I needed.

1)
It is not possible to set the Address Type in the profile.  
2)
It is not possible to discover the "Auto Chosen" PSM value.

The first patch allows the address type to be specified in the DBus
API.

The second patch allows information about the profile to be read back.
This is needed because, on both Andorid and iOS, when using LE-L2CAP,
the application must inform the OS about which PSM to use.  It is
possible for the server to advertise this value with GATT, but the
applciation has to read it from somewhere.


Mark Marshall (2):
  src/profile.c: Allow the "Address Type" to be set
  src/profile.c: Add a GetProfileInfo method

 doc/profile-api.txt |  23 +++++++++
 src/profile.c       | 113 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 1 deletion(-)

-- 
2.17.1

