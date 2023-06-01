Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1130C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jun 2023 06:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjFAGfS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Jun 2023 02:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFAGfQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Jun 2023 02:35:16 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43CA11F
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 May 2023 23:35:15 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QWxFp0w92zyR6;
        Thu,  1 Jun 2023 09:35:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1685601310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UArfs/WKLJhfdJNJRjQjVcxFbRszy80iT15xUXOlilc=;
        b=dcgva+9gAziLI/TJ508JDIHJPVMR4E9l77uDb+EVc59ZRWPMHGThms5GcvzbDn0PhRB7u5
        eTi0JDMIOI9Dw2aiTncKWuAeprpaFhqn2l4iPlWpfSgE/QEOKUOXafxZnk41w+u0o6+YxS
        73ngrng/zBjwmjr2PB0p7DxDSu87QZo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1685601310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UArfs/WKLJhfdJNJRjQjVcxFbRszy80iT15xUXOlilc=;
        b=PPY3EZU18vv7VCEmJ0KpeDRsdHanPX7Y3zWVChD+x1KH51g+s41h0bpIJkWZbKwvUNHzte
        jALBGivyUfAQ3vCMt4Nz8K+QHiUl0/0ogX3HlEftYqXmWGQ/NeRGrn4sY+5b9ikvkeRnyI
        guBq5xahgecEuVP54co2ck7fqo9YaSg=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1685601310; a=rsa-sha256; cv=none;
        b=yQd8987neOmhIzS8VBe5VQXYgdfTtRMkgSyZZ3bM5X2tg9KHKvyR8jpCXuqv6XTLX2k5Jk
        DHBup7hUu1u5MhVOuRZTSeCwxRp+UszI089THT+FsHqlJpQg4NGTogB/Ua1i1z3zy3k2A6
        d4L5g4VrGjzbjWWa/hVwSNxTLAc/DaE=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 0/4] LE Set CIG Parameters / Create CIS fixes
Date:   Thu,  1 Jun 2023 09:34:42 +0300
Message-Id: <cover.1685565568.git.pav@iki.fi>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset fixes a few issues with emission of HCI Remove CIG, Set
CIG Parameters, Create CIS when multiple ISO sockets in the same CIG are
closed and reconnected rapidly.

v2: Dropped patches that added error checking in hci_le_set_cig_params,
    TBD separately later.  Returning errors there triggers some race
    condition in the emulator when it's cleaning up the connections, which
    needs some more looking.

    Simplified the Set CIG Parameters event parsing.

    The patches here now are enough to make the test suite pass, and
    enough to fix the race conditions encountered in BlueZ ISO ops.

Pauli Virtanen (4):
  Bluetooth: ISO: use hci_sync for setting CIG parameters
  Bluetooth: ISO: don't try to remove CIG if there are bound CIS left
  Bluetooth: ISO: use correct CIS order in Set CIG Parameters event
  Bluetooth: ISO: do not emit new LE Create CIS if previous is pending

 include/net/bluetooth/hci_core.h |   4 +-
 include/net/bluetooth/hci_sync.h |   2 +-
 net/bluetooth/hci_conn.c         | 123 ++++++++++++++++++-------------
 net/bluetooth/hci_event.c        |  72 +++++++++++++-----
 net/bluetooth/hci_sync.c         |  90 +++++++++++++++-------
 net/bluetooth/iso.c              |   2 +-
 6 files changed, 193 insertions(+), 100 deletions(-)

-- 
2.40.1

