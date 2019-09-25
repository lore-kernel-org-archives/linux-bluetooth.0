Return-Path: <SRS0=vN2J=XU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9161C432C2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Sep 2019 16:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98EA21D7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Sep 2019 16:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbfIYQdv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:33:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:7878 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389086AbfIYQdu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Sep 2019 12:33:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 09:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="214100831"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.251.25.152])
  by fmsmga004.fm.intel.com with ESMTP; 25 Sep 2019 09:33:50 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ v2 0/3] mesh: Fix Remote/Local dev key usage
Date:   Wed, 25 Sep 2019 09:33:26 -0700
Message-Id: <20190925163329.23767-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As discussed at the Bluetooth SIG Mesh Working Group, this patch set
locks down usage of Device Keys to nodes that have explicit permission
to use them.  This permission will typically be granted by the
Provisioner (mesh network owner) in the form of Application access to
the Device Key of the node that requests are directed to. This
*includes* the access to a nodes local Config Server.

Usage Model:

DevKeySend(remote == false)
	node.json is the only Device Key used. However, it is illegal
	for loopback messages (where DST == any of our element unicast
	addresses) so this call will return an immediate "Unauthorized"
	error in such a case.

DevKeySend(remote == true)
	keyring Device Key matching the DST address is used, with no
	fallback to the node.json key.  If the DST does not exist in
	the keyring, then an immediate "Unauthorized" error will be
	returned.

In the past, we would first try the Keyring, and automatically
fallback to the node.json key, but this was a backdoor to always
letting Apps modify their own Config Server.  The daemon can't tell
the difference between Client and Server opcodes, so this was
always a and really not a very good guess.


DevKeyMessageReceived(local == true)
	node.json (local) Device Key was used to decrypt this
	message, and message has full permission to change any
	model's states.  This message is always received from
	an *external* node that knows our Device Key.  (If an
	App wants to change it's own App controlled states, it
	already can).

DevKeyMessageReceived(local == false)
	Keyring Device Key was used to decrypt this message,
	so it was a *remote* node's device key.  This will most
	likely be a response to an App controlled Client model.
	However, if it is a Server message that changes a state,
	or requests the state value, the App should silently
	*reject* it...  For that operation, the remote node
	needs to know *our* Device Key.

This differentiation is needed with received messages, because *any*
message can be secured with a device key.  But just as with the Config
Client/Server, the *correct* device key must be used for any state
changes and state requests.  If a provisioner has an On/Off server for
example, it might get an "Off" request from a remote node, but it should
only execute the "Off" if it was secured with local Device Key...  not
the remote Device Key.

Likewise, when *responding* to legal Server Commands secured with local
Device Keys, the App must respond with DevKeySend(remote == false),
because that was the only key that would have been legal for the remote
node to have used.

The "remote" parameter name for Send, and "local" name for Receive was
deliberate as the "true" value in both cases is the more privledged form.


Brian Gix (3):
  mesh: Add local/remote bools to DevKey transactions
  mesh: Use explicit Local vs Remote Device key usage
  mesh: Fix Key Ring permissions for local nodes

 doc/mesh-api.txt | 15 ++++++++++++---
 mesh/manager.c   |  4 ----
 mesh/model.c     | 11 +++++++----
 mesh/node.c      | 39 +++++++++++++++------------------------
 4 files changed, 34 insertions(+), 35 deletions(-)

-- 
2.21.0

