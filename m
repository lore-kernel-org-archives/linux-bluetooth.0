Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17397C7619A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Mar 2023 16:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCQQqD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Mar 2023 12:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCQQpl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Mar 2023 12:45:41 -0400
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5483D09B
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 09:45:38 -0700 (PDT)
Received: from github.com (hubbernetes-node-b43ed3a.va3-iad.github.net [10.48.201.107])
        by smtp.github.com (Postfix) with ESMTPA id EC01DE173A
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1679071538;
        bh=RLE1Bdx1f0tIKVg7FWwTqH0ymzhWPP+idOdIZwJ0xdg=;
        h=Date:From:To:Subject:From;
        b=ns1u7Vv+htZ/GtDBsoVJnbER8EjYx7FBs79p2aaas9Yqr9esxWkOPaLlED95WLn7C
         akUOY6vhat5Sk91WYLIJ00CfpmmAdfUkSzhR/mbtMtBCznkJvRhZ51mEd3SGA+Otjx
         tkXN19eCpYO3Z5cF0ZwzC7p70XZvvO3HPDCUtvTw=
Date:   Fri, 17 Mar 2023 09:45:37 -0700
From:   Pauli Virtanen <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/806230-39260c@github.com>
Subject: [bluez/bluez] 306a80: shared/gatt-client: Fix not creating a request
 for...
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 306a8083ad19459136cb46b7ec7fb27b070fb118
      https://github.com/bluez/bluez/commit/306a8083ad19459136cb46b7ec7fb27b070fb118
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-17 (Fri, 17 Mar 2023)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: Fix not creating a request for notifications

Notifications were using bt_att_send directly instead of
bt_gatt_client_write_value thus it wouldn't create a request which
causes the instance to not be able to track it which in turn may cause
the client to trigger its idle callback too early.

Fixes: https://github.com/bluez/bluez/issues/490


  Commit: 28422cd231196037ae7d52f8803ff282482c607e
      https://github.com/bluez/bluez/commit/28422cd231196037ae7d52f8803ff282482c607e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-03-17 (Fri, 17 Mar 2023)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: add CIG/CIS/PHY properties, don't show unset QoS properties

Add CIG, CIS, and PHY properties to BAP transport.  The other QoS
properties are there, and these may also be useful to clients, e.g.  to
manage CIG/CIS allocation as client.

Hide transport QoS properties when they are not configured.


  Commit: 39260c3cfa056321feaf1d49fe8db92e17b386f0
      https://github.com/bluez/bluez/commit/39260c3cfa056321feaf1d49fe8db92e17b386f0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-03-17 (Fri, 17 Mar 2023)

  Changed paths:
    M doc/media-api.txt

  Log Message:
  -----------
  doc: describe new ISO Transport properties

Document the currently undocumented transport QoS properties.


Compare: https://github.com/bluez/bluez/compare/806230e4fda7...39260c3cfa05
