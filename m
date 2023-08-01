Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D454FC001DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 16:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjHAQiv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 12:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjHAQit (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 12:38:49 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A781FE5
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 09:38:48 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RFgm60Q2cz49Q4D;
        Tue,  1 Aug 2023 19:38:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1690907926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IMGGkyFmtLIiLQWPgOi3/yfrQT0lH9bzCBdkcDEgnpo=;
        b=uhrIAk3Slh+56DAbkWfXGvH5hcL9WUYvbksAGgF8TI4UaN3LNSSR1Gku7isFbmNR/oShHo
        AwPORZFAHjnbfsV/N1arrHrLniFMf4NiZ+CQ9lPscuJ4NTWLIvjCgN9FEhP+4Fvc3gTAbE
        i3VD0cgKTFNoMoqlmWH6EEGMf7tvP2vsXsWgs+45TbgKTHEnsk6j7E1oqB/as+EJkYTdYv
        0iPEB2lDQoVpsDjz1vaHo6ibE/dMP7aL2nKppMdv3X1uLdqCHrwlYgUzwITm4PM8FErV4Z
        WUiGJGUCQA/CGUSsFJy/FubBqD0bvQCU7oSk7OKMy/voNx2ALEsriN4zR7tZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1690907926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IMGGkyFmtLIiLQWPgOi3/yfrQT0lH9bzCBdkcDEgnpo=;
        b=mRD0NxqRDPjs5Uw90yEhTB2fIum46kO4KtShkdfE8yLePtGgoQyPxH16XJtvQqYf4xncUS
        BfGczXI4OjOxxL43YlOAqBIZZE4GlMKEv5TvQCXu+WA1Jggc4NRe+eZ1+OJ8/gtcsT89UA
        vJXwWAYHuo41+7015OMeFmDSXBGVFyeG8RkSUZbhed9PYuGLNcM0KCwQuPnkgfLYDogFJj
        5eRxkzgpyUl0roS7FqRQ4wQcfpqsWke4NPSIPYP4oLddW9cB2xQxbfP3Fz+6MUjwiYiQTg
        6nl5K0WuLdADLrDUrXFbfoeXXDrQdyWTjGe05SyvcyGJ57dm+BbriKq44klBIA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1690907926; a=rsa-sha256;
        cv=none;
        b=tu3ZBc6ueDNdAgqwWlcN6zk1PR3vgGGl5RqdycpXdahwouetxF/Ny8bj4ZZceQRGCU7Z8S
        PB+jfbYoLPdIzcbcsXlIh4mg3norBHzSi+WEzZyOWxjcitDp4cR11V+2A/F+G+ZdeWDZhn
        Fq7Ef5n46vfK04vC/eIqJ49eTbi70EOXn2s8kSMN1y2SY89dTeSXuxZca8Sr5sCDFm+sQV
        0DjSRgL/w2+CQLcP/Fz8lRDpVooF0ap9/VJSki914NpTOONjyAcptSUdsbpVkcrnfiaMxO
        Eh8E8yaXCyFpQzzoEuwfYZorhP+lDL3Hes1yNLrXfHLmaF+CP2HiZBuxHzyIIQ==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 0/5] Additional tests for ISO and hci_sync
Date:   Tue,  1 Aug 2023 19:38:37 +0300
Message-ID: <cover.1690907478.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a few tests checking ISO socket handling of invalid input
parameters and cleanup in some race conditions:

    ISO QoS CIG 0xF0 - Invalid
    ISO QoS CIS 0xF0 - Invalid
    ISO Connect2 CIG 0x01 - Success/Invalid
    ISO AC 6(ii) CIS 0xEF/auto - Success
    ISO AC 6(ii) CIS 0xEF/0xEF - Invalid
    ISO Defer Close - Success
    ISO Connect Close - Success
    ISO Defer Wait Close - Success
    ISO Connect Wait Close - Success

There's also one for a hci_sync race condition that triggers GPF:

    eSCO Simultaneous Disconnect - Failure

I have a patch series fixing these, but we'll revisit the
HCI_CONN_DELETED flag there, so maybe discussion needed.

These fail on current bluetooth-next/master, so it could make most sense
to wait for the fixes first.

v2:
- emit correct event from HCI_Create_Connection_Cancel + fix compile

Pauli Virtanen (5):
  btdev: check error conditions for HCI_Create_Connection_Cancel
  btdev: fix Command Status command opcodes for Setup Sync Conn
  sco-tester: test local and remote disconnecting simultaneously
  iso-tester: test with large CIS_ID and invalid CIG_ID/CIS_ID
  iso-tester: add tests checking Remove CIG is emitted

 emulator/btdev.c   |  90 ++++++++++++++++++++----
 monitor/bt.h       |   4 ++
 tools/iso-tester.c | 168 +++++++++++++++++++++++++++++++++++++++++++++
 tools/sco-tester.c |  59 ++++++++++++++++
 4 files changed, 308 insertions(+), 13 deletions(-)

-- 
2.41.0

