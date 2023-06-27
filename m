Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22073EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 17:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjF0Rni (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 13:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjF0Rnh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 13:43:37 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB71296B;
        Tue, 27 Jun 2023 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687887815; x=1719423815;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5FPbiCFxxpqYYHb1+aatl89rGo96V81c3lwF9lJh8dg=;
  b=e/CcmFPcpKKfK0ToE3f7RTOKtk8Pt099JCFK+a7tYuJdU0yTgYXvGE7+
   0foKIyug0WTRe+CYalueOlb0rH/dPCTexG0cIf5166G5JobDStQbMt9sh
   Sd1XKzULXh6izJ9GM7NkubL6DQ6m7Z1JYCq8sTBOxZDS8L2hATCBvx8h3
   A=;
X-IronPort-AV: E=Sophos;i="6.01,163,1684800000"; 
   d="scan'208";a="12747707"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 17:43:32 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com (Postfix) with ESMTPS id 87289669AE;
        Tue, 27 Jun 2023 17:43:29 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 27 Jun 2023 17:43:28 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Tue, 27 Jun 2023 17:43:25 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Christian Brauner <brauner@kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        <netdev@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v1 net-next 0/2] af_unix: Followup fixes for SO_PASSPIDFD.
Date:   Tue, 27 Jun 2023 10:43:12 -0700
Message-ID: <20230627174314.67688-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.41]
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series fixes 2 issues introduced by commit 5e2ff6704a27 ("scm: add
SO_PASSPIDFD and SCM_PIDFD").

The 1st patch fixes a warning in scm_pidfd_recv() reported by syzkaller.
The 2nd patch fixes a regression that bluetooth can't be built as module.


Alexander Mikhalitsyn (1):
  net: scm: introduce and use scm_recv_unix helper

Kuniyuki Iwashima (1):
  af_unix: Skip SCM_PIDFD if scm->pid is NULL.

 include/net/scm.h  | 39 ++++++++++++++++++++++++++++-----------
 net/unix/af_unix.c |  4 ++--
 2 files changed, 30 insertions(+), 13 deletions(-)

-- 
2.30.2

