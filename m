Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F24C433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FAE22208
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Zh+sW3py"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIPXZy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgIPXZw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 19:25:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA90CC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:25:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r9so360498ybd.20
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=5VqPIiOtUqaGVZkI9SNh9ZvqzIGC8rBwWvJX1ib7LmM=;
        b=Zh+sW3pyztmP7nAARrr1tB6GMmz6Xsxr8sFItA0pQa4bY/xOG5uMHus4fca2t2ciA0
         UvywXzjtCMqtb/u3yll4GTmKRzjh94Hd4J+zCjdQzAt3sSCIfd0wiU0iA7MUEGcoFWMW
         bTyO6jS4ZBP54pZTVLhGyeTiUyIXCm1zn2wC3m3n98lxfFBu3ufni4+YwmYoie08Wp7y
         53CgAOLcbw3JQHPDlR/n+zp/p1sTGXsIPUbxWfcaR2+ZCK6XsWkmTg/zZwAH2niFAmIT
         tN5goGtum1rQi4CjsnFcpK8qfTI7CqGeGpT49EzwLlD9MVKWpPVMCNy5sWbICxBOC09r
         OUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=5VqPIiOtUqaGVZkI9SNh9ZvqzIGC8rBwWvJX1ib7LmM=;
        b=JLlGXX6cgtythW1Jpi1kVBF7ZAWPQwZmxynuHCqbGUhNUl8mzXYqVEgzPZn6Q8m/ZJ
         E8u9XWuwdiA7e3tDE9kTNCm6Q3mPhRKLQIikbeUTcuCxSYGXHhj9WkYiYWAzFrohWkaE
         8zd3FPI041Wvt8TxO+c/N73CJM6900fiv8X+dGg2lxNx3L3CHUfl8s7GZp4te3PF230V
         6ep6p0w3gvKzDXYUl5rDbrbh2t+m4jr3KfdTWDa+wD0sRPH2AQ+MBoaV5lPGmKIMZKYa
         l96a0Jt4ai0d+nBUGGiztICV0VLaInrC1T9BDtCvWaYkgG+b8EJAg6edTZE1AHJs+itU
         8Y0w==
X-Gm-Message-State: AOAM532yyEdiWPwOoHxqxwzK1pHb1o2/cuoFqgxhM+EU+NkpmU0uKw+K
        JaAashzRn/MFFJFMiPWTFUsSFAH4vcEhuQ5V7COl
X-Google-Smtp-Source: ABdhPJxdHxL3Fk3YvsJQjOTENpu98RPKaJSc4Ng2OVqpLMJCCahrSxHb9Y6w4vq6Pyp6AJQR4qHGNde5NHyv9q17uQNJ
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:5a56:: with SMTP id
 o83mr34602706ybb.55.1600298751096; Wed, 16 Sep 2020 16:25:51 -0700 (PDT)
Date:   Wed, 16 Sep 2020 16:25:32 -0700
Message-Id: <20200916232542.1584854-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [Bluez PATCH 00/10] Bluetooth: Add new MGMT interface for advertising add
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maintainers,

This patch series defines the new two-call MGMT interface in userspace
for adding advertising instances. Bluez will detect if kernel supports
the new MGMT commands, and use them if so. Each new advertising instance
will be configured by a MGMT call to set advertising parameters,
followed by a MGMT call to set advertising data. The new data pipeline
is meant to be unnoticeable from the clients' perspective, with the
exception of new intervals and tx power support, and new exposed
advertising manager properties.

All changes have been tested on hatch (extended advertising) and kukui
(no extended advertising) chromebooks with manual testing verifying
correctness of parameters/data in btmon traces, and our automated test
suite of 25 single- and multi-advertising usage scenarios.

Thank you in advance for your review!
Daniel Winkler



Daniel Winkler (10):
  advertising: Detect if extended advertising mgmt commands are
    supported
  advertising: Parse intervals and tx power from adv
  advertising: Use new mgmt interface for advertising add
  advertising: Catch tx power selected event and handle it
  advertising: Query LE TX range at manager initialization
  advertising: Expose SupportedCapabilities for advertising
  client: Add SupportedCapabilities to bluetoothctl
  monitor: Add new MGMT adv commands and events to monitor
  doc/advertising-api: update API with new interface
  doc/mgmt-api: Add new MGMT interfaces to mgmt-api

 client/main.c           |   1 +
 doc/advertising-api.txt |  50 +++++
 doc/mgmt-api.txt        | 243 ++++++++++++++++++++
 lib/mgmt.h              |  45 ++++
 monitor/packet.c        |  84 +++++++
 src/advertising.c       | 476 ++++++++++++++++++++++++++++++++++++++--
 6 files changed, 884 insertions(+), 15 deletions(-)

-- 
2.28.0.618.gf4bc123cb7-goog

