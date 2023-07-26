Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CC9C001DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 21:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGZV0E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjGZV0C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 17:26:02 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470A12D63
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 14:25:47 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RB6Q04tW5zyZR;
        Thu, 27 Jul 2023 00:25:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1690406744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1UZLBqdilnWq8IuSS/IZsjbqLGBcHWnP1VV2ew10fAk=;
        b=weFZX6ddMwcSsJ6Vg+7DSV04tD4d5LV6Z5KqlBdTs24StBssPuI5edZ9HbOUuv+n2lJyGp
        U67df9dOJBZwV5sAS4vHdyu9qxWeMM/xRreME7VEjxjVcRG8RVhqBzDr5gj2ZzSjZnZGMA
        IAbNBnf0BGemlPD9sEClH/w+lQYVHNo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1690406744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1UZLBqdilnWq8IuSS/IZsjbqLGBcHWnP1VV2ew10fAk=;
        b=anu3H94by7RsiPzsG3oFyQRgCcrpjOeJ0IFCxUFPUYhLFzDA/aBMakebkp0Erz9cxfx6+a
        XCn317XizhFCAvv7Jk4TRFio/ygMEyPA/cKju6dh1PUnJR+b/2mO08MDOm9sGC/1JnlxpH
        thSR7d1t3b0ElqhW9eWU68m5DyWcHpU=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1690406744; a=rsa-sha256; cv=none;
        b=MmfBdIuxyn2zK/nCEfy43nFAjY4TndnaoUu+qs0vkdlEIvLiikJt13e4hMckmcYYEJvykk
        x9bV0t0h+NbnfmnZb8f2INflSaGhU2TRgjCe1lnxkxwM3TNIUyJ3RR0H1FHtf9ugxeVEVG
        bnbuKJS2T3ywk/mqUSRyVBU3QgChe7Y=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH RFC 0/6] Locking in hci_sync
Date:   Thu, 27 Jul 2023 00:25:20 +0300
Message-ID: <cover.1690399379.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The current guarantees that a given hci_conn is not freed concurrently
appear to be:

- hci_dev_lock is held, or,
- rcu_read_lock is held  (doesn't guarantee valid conn state), or,
- hci_conn_get refcount held (doesn't guarantee valid conn state),
- current task is running from hdev->workqueue (which is ordered)

The last condition is not exactly true as hci_conn_del is currently
called also elsewhere, but is assumed in hci_event.c and hci_core.c.

It does not appear possible to assume in hdev->req_workqueue, especially
in hci_sync callbacks, that a given conn stays alive at any time if none
of the above precautions are taken.  Similarly, any conn_hash iteration
without locks there appears invalid.

E.g. Disconnect events emitted from remote appear possible to occur at
any time in hci_sync.  There are also some hci_conn_del callsites not in
hdev->workqueue which can run concurrently, eg in __iso_sock_close
(which also doesn't hold hdev->lock).

KASAN crashes are known on real HW, and the deletion race conditions can
be hit in VHCI (see the other BlueZ tester patch series).

***

What to do?

One way to guard against using already freed conns is hci_conn_get +
check that the connection was not deleted, inside suitable critical
section. I didn't find a reliable existing check if hci_conn_del was
run.

To enable using hci_conn_get, the series here suggests again adding
HCI_CONN_DELETED flag to indicate whether hci_conn_del has run (with
hdev->lock or in hdev->workqueue).

It also adds some helpers to make writing hci_sync callbacks that
operate on a given hci_conn or need hdev->lock easier to write. The
patches here add hci_conn_sync_queue, which check if hci_conn was
deleted in meantime, and hold hdev->lock in the callback (but release it
during waits), so that concurrent modification of hci_conn can only
happen during event waits. This is something that is already assumed but
might not be true eg. if the two workqueues run jobs on different CPU.

The last two patches in the series are some motivating ISO related
changes, for proper cleanup of CIS, lookup by handles doesn't quite
work (and also doesn't protect against the deletion race).

***

I tried to find some alternatives, but this seemed minimal one.

I don't see how to make use of hci_conn_drop/hold here, as they appear
to have different purpose, if we change that then how socket channels
work seem to a new mechanism. E.g. nonzero refcnt from socket should not
keep connection alive when eg. Disconnect event from remote occurs.  In
that case we also need to clean up the connection ASAP so the handle can
be reused.

One alternative that makes continuing conn_hash iteration a bit simpler
would be to remove hci_conn from conn_hash only when hci_conn_get
refcount hits zero, so holding hci_conn_get reference would keep the
conn a valid iteration cursor. Also setting conn->type to INVALID_LINK
on deletion could then make lookup functions skip deleted conns.
However, one would need to take a look at all places where conn_hash is
iterated and think it through.

It maybe could also be possible to not allow events to be processed
while hci_sync is running, except when it is waiting for an event (=
more or less, take hci_cmd_sync_dev_lock in all callbacks so hdev->lock
serializes things).  However, it seems a deletion flag would be needed
also here, as the conn might be gone while we are waiting for events.

Pauli Virtanen (6):
  Bluetooth: hci_conn: hci_conn_cleanup is not needed, combine with del
  Bluetooth: hci_conn: add hci_conn_is_alive
  Bluetooth: hci_sync: add hci_conn_sync_queue and
    hci_cmd_sync_dev_(un)lock
  Bluetooth: hci_sync: fix locking in hci_conn_abort and
    hci_disconnect_all_sync
  Bluetooth: hci_sync: delete CIS in BT_OPEN/CONNECT/BOUND when aborting
  Bluetooth: ISO: handle bound CIS cleanup via hci_conn

 include/net/bluetooth/hci_core.h |  22 +++++
 include/net/bluetooth/hci_sync.h |   3 +
 net/bluetooth/hci_conn.c         | 157 ++++++++++++++++++++-----------
 net/bluetooth/hci_sync.c         |  97 +++++++++++++++----
 net/bluetooth/iso.c              |  14 +--
 5 files changed, 211 insertions(+), 82 deletions(-)

-- 
2.41.0

