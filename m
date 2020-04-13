Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E17C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 17:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302EB20735
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 17:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbgDMRpo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:45:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:20468 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729163AbgDMRpn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 13:45:43 -0400
IronPort-SDR: hHQwALlefuY2iPsZhiYZJ+XpzpyMY1pDY5caLfLmUWvR9Z9/f6g7bCHzPn3Bite+sFO6J3MksZ
 Anwenh/NI3uw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 10:45:43 -0700
IronPort-SDR: uTddtHGIuKbCZWtho54om2HwOBaJxTgdbwtdlfpj/6viTJWVPt3wWHQigXTMrd6Gocoh2nS7xK
 BUnhRw1CJczw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="399679896"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.135.23.176])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2020 10:45:42 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com, przemyslaw.fierek@silvair.com
Subject: [PATCH BlueZ v4 0/4] mesh: Always deliver tokens via JoinComplete
Date:   Mon, 13 Apr 2020 10:45:31 -0700
Message-Id: <20200413174535.21488-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset implements API change discussed in
https://marc.info/?l=linux-bluetooth&m=157660821400352&w=2
v4:
 - Restore original C parameters on the response for dbus
   send_with_reply.  Any parameters can now be "returned" by the App,
   and a NULL message indicates an internally generated time-out

v3:
 - Add distribution independant timeout for JoinComplete() method calls
   such that a 30 second timeout of the call is treated as failure, so
   stale nodes clean up correctly

v2:
 - Fix mesh-cfgclient to send JoinComplete reply before calling Attach


Brian Gix (1):
  mesh: Add Time-outs to critical dbus send-with-replies

Michał Lowas-Rzechonek (1):
  doc/mesh: Change API to deliver tokens via JoinComplete

Przemysław Fierek (2):
  mesh: Change API to deliver tokens via JoinComplete
  tools/mesh-cfgclient: Add waiting for 'JoinComplete'

 doc/mesh-api.txt       | 22 ++++++++----
 mesh/dbus.c            | 40 ++++++++++++++++++++++
 mesh/dbus.h            |  6 ++++
 mesh/mesh.c            | 68 ++++++++++++++++++++++++++++--------
 tools/mesh-cfgclient.c | 78 +++++++++++++++++++++++++-----------------
 5 files changed, 160 insertions(+), 54 deletions(-)

-- 
2.21.1

