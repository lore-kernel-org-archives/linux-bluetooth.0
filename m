Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F57C432BE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 15:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2862460F42
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 15:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbhH2PvM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Aug 2021 11:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbhH2PvL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Aug 2021 11:51:11 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20648C061575
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Aug 2021 08:50:19 -0700 (PDT)
Received: from monolith.lan (91-152-122-41.elisa-laajakaista.fi [91.152.122.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id C5F341B00188;
        Sun, 29 Aug 2021 18:50:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1630252215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2si6XWMCbQPjqdTAIENbIuOFv95gcAwkago37fkP+Qo=;
        b=VXnAcE7DfbJNV4fzu+9CmBKRoOAiMyLlXPJHUFzp8fHh50WBQRUTta3Y3Ve/NqNXkSXxS2
        kaw5hXHjRYSKbCsmygq5g0D+3l47fyOaLW7F2ScYkAxmQcTGiub+723XME88VQeDEz0ux+
        PF6qzFxBEfHYMUOB/q3GHetDbqBtor/mQtX9c+9P8HZgisjnk1iBEKPx7LDXcZ9YTohGEZ
        InnQD64Ik6zV+AuBPWDI+EECn85rq9yTAZBSKlPzUvpA4XPeWqrw5m+TCqQ3nuK/3ajpUG
        lhjssPrZM0okoFri10FkHXFpikNIJfW6SHu5yit6kh2b+jd9+CFY/zZTLwXb/g==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/2] AVDTP SEID pool seems too small
Date:   Sun, 29 Aug 2021 18:50:10 +0300
Message-Id: <20210829155012.164880-1-pav@iki.fi>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1630252215; a=rsa-sha256;
        cv=none;
        b=J8buDMQZHQuJWfCJLAJops8WVIGsVlOeSV9Qocs7nGDdfQ/NtB/0EHJwjKg71N5mhGnSFO
        oXctvVoA28n913E0ZyQ6vAnQE6E3nJDltVdO3AXr8mHNa+EEIvNwXULtzpo1W28tNzbwU+
        uEOTT29/NIJNmpagjE6Wglx4WKfrXuOLFCBmJz0BcgEa81rVX9Yp/nje/a4GnnBZ+6UZVw
        9WFfSQECAzb7W6j4Ij0jj+18D6nAWfaFU/3qCcHpsq4XQlBqnQXHRDOuMrZ6MbjsYrvX3P
        h5bsKtdRx/FpqdEBJ9ViAIWOrcul/ma6oZec0TJjYz+k4KG8pNckdtrilxvedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1630252215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2si6XWMCbQPjqdTAIENbIuOFv95gcAwkago37fkP+Qo=;
        b=DOtZDGlJM6DZl7mlvB2CLEVZmXzXfEoTIgqFCmoIW07UZACM6mMKfGAo4vi+IzYQrLBzRW
        Prm3r9V6mysjWN7z6WpiV5JENpvJTKaMq/Mpjqgs/XvQRCezD7vc9pkLldM49veZwirouz
        sSyCraUWJ5yxBU9sl15wDdoRdD6ak8IGYSPQ0vi8hzcZ6X9Z20+HcuGBWmOM6xbaCDia+J
        NhfK5Qq68iSkoHjw9wB78hbX3NszcCGYSjaBripXCtNpfcb49zveNIChoWsqYhG6MCYx9x
        rw9knkuvMAEtId6U+42YwnMVHLTQGdR0jFX+qcBXOLCDBI84gEwhuKG6x0HGWw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

It seems that if media application is registered to multiple BT
adapters, BlueZ can easily run out of free AVDTP SEIDs.  This occurs in
practice when running Pipewire (or Pulseaudio) and plugging in 3+
adapters: their media application has 10+ SEPs for various vendor A2DP
codecs, registered for each adapter.  After having registered 32 SEPs
across all adapters, Media1.RegisterApplication starts failing, due to
SEP registration not finding free SEIDs.

However, if I understand the AVDTP spec and BlueZ implementation
correctly, this behavior is not quite correct: (i) the SEID pool in
BlueZ is limited to 8*sizeof(int) == 32 entries, which is smaller than
the 0x3E = 62 entries (AVDTP1.3, 8.20.1).  Also, (ii) BlueZ allocates
SEIDs from a pool shared by all adapters, whereas it seems they should
be device & connection local (AVDTP1.3, 4.10). Since adapters are
separate devices in this context, this then appears to imply that each
should have separate SEID pool.

If this interpretation is right (I don't know the AVDTP spec very
well, so...), here are two patches that address this.  In (limited)
tests this seemed to work.

Pauli Virtanen (2):
  shared/util: use 64-bit bitmap in util_get/clear_uid
  avdtp: use separate local SEID pool for each adapter

 android/avdtp.c        |  2 +-
 profiles/audio/a2dp.c  |  2 +-
 profiles/audio/avdtp.c | 55 ++++++++++++++++++++++++++++++++++++------
 profiles/audio/avdtp.h |  4 ++-
 src/advertising.c      |  2 +-
 src/shared/util.c      | 27 ++++++++++++---------
 src/shared/util.h      |  4 +--
 unit/test-avdtp.c      |  2 +-
 8 files changed, 71 insertions(+), 27 deletions(-)

-- 
2.31.1

