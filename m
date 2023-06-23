Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3869EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 17:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjFWRTP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjFWRS6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 13:18:58 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A912270E
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 10:18:51 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QnkVH3QFgz49Q1F;
        Fri, 23 Jun 2023 20:18:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1687540727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WzOcSf/bHwWB2E+FE3P82aAvpuOucs1Xa1S+/LYS7p0=;
        b=O6YVdcDeVI3bG/mb4isa9MEGt/uMZ/rjU8TU9516hxQ3Kce4rL4N0mFixuXQwJmxr3x4Kf
        pURLiFHifh/eZj6n0xVlpKau88IYip5tveukmk3o/Nb/DaThOoEgkqUxOz0EvfzmMvz/mE
        6OKJn928nvsPcTC1mWwVEPqi4KUPIAGEb7ZQcCifOIntwkfLwZjCxNIMnoHjEidc/HJBVH
        be1kiFEMTF8rr0iZG8nPhZUB8jcj2ijR8l2l3i6HOGRKQS6y7bzrwun0hYCEN8PH496XbN
        9dLpzd9k0GNW/umMYdWEyaXoqW02Z63g1iOD2iqRoqv/B2jjDFqy1cbzQilhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1687540727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WzOcSf/bHwWB2E+FE3P82aAvpuOucs1Xa1S+/LYS7p0=;
        b=XgyoF+3If7/kMSJNi1zyQvM7lqnMverBYVu9vGa0OFzPmnCMcILlh/dUpMG3weB7RS0nUb
        xm896r/N1h6H8jtjp5o/TrIAPVowEqp14zge8xfUT/KqdostM0nyg0jhnln5rxkXSUk9YS
        7IullYzRUvBdzbABiMHvqyyxkeaus2lMCHeto8bhFeFCV6EcTwNdd4uIwoVvEleKKOsk/i
        SgpjFGtDb9PuZK7jkBW/DcB1YFXgUsX9KRi/jP0v8B4zNay0zi6lBMST8s4bCSinA3yCU2
        l5z561vi5pzh+g2zg1A8IwQ8p/qtUPCsCZ2mVTUh3N/jSdbJFzdXKbnSZma8lg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1687540727; a=rsa-sha256;
        cv=none;
        b=tOkm/1xIzCzKOJ9hpCULTg77DdXIi14UWsviIwJ7/qRcqWjp3nvi2SLe5KdlGOu68Cjgig
        DXMrrngyd17l4SeQZw7OosLaWdOB6xfANzecWzlb47+SS7ZGANZc7f2u5gyhVXdHLLHM3U
        dobq6Vsc+sTh55ZpOU0MSgsZeATXVKS4rQdQZo4bgVTmczyEq2bzw6xvZa2HEKsXv4NO3t
        9EEitGJXRpdoRw9qFZKDyvmuL9Fp95vf+OhuKMQvMAXdX6RLmhD7Gu65l6TLUWn6A7OYEJ
        kc+XcNTUBlJhrrqU3DYnTHVxDiqFjWWRgV/sXJN7ef81yzECRjL4G7d6XUkbIg==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH RFC 0/5] hci_conn and ISO concurrency fixes
Date:   Fri, 23 Jun 2023 20:18:37 +0300
Message-ID: <cover.1687525956.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series addresses additional KASAN errors seen in the same test case
as in the previous one.  These are mostly due to hci_conn being deleted
at a bad time, or manipulated without necessary locks.

With this series, the test setup doesn't seem to be producing KASAN
crashes any more.

The test setup is still

while true; do bluetoothctl power on; sleep 12; bluetoothctl power off; sleep 1.5; bluetoothctl power off; sleep 2.5; done;
while true; do sudo systemctl restart bluetooth; sleep 110; done
while true; do systemctl --user restart pipewire wireplumber pipewire-pulse; sleep 91; done
while true; do paplay sample.flac & sleep 2; kill %1; sleep 0.7; done

and equivalent operations manually, on VM + connect to TWS earbuds,
and let it run until it hits a crash.

There's an RFC question here: it would seem useful to be able to keep
references to hci_conn around without RCU or other locks, and be able
to safely continue later if the conn is still around. I.e.

    hci_conn_get(conn);
    hci_dev_unlock(hdev);
    ...
    hci_dev_lock(hdev);
    if (!hci_conn_is_alive(hdev, conn)) {
	    hci_conn_put(conn);
	    goto bail_out;
    }
    hci_conn_put(conn);
    ...

The first commit here adds this function. It should also be RCU-correct
too, but I'll need to think that through a second time.

It seems in several parts in hci_sync.c it is assumed the conn is not
deleted while the code is blocking waiting for controller events.  At
first sight it's not so clear that it's really guaranteed there can't be
UAF here, so I'm wondering if there would be a need to start polluting
hci_sync.c with locks and aliveness checks after waits.

Or if it's guaranteed by something not apparent and nothing needs to be
done, or if some other thing should be better (such as serializing
operations that delete hci_conn through hci_sync).

Pauli Virtanen (5):
  Bluetooth: hci_conn: add hci_conn_is_alive
  Bluetooth: hci_sync: iterate conn_hash safely in
    hci_disconnect_all_sync
  Bluetooth: hci_conn: hold ref while hci_connect_le_sync is pending
  Bluetooth: ISO: fix use-after-free in __iso_sock_close
  Bluetooth: ISO: fix locking in iso_conn_ready

 include/net/bluetooth/hci_core.h |  18 ++++
 net/bluetooth/hci_conn.c         |  24 ++++--
 net/bluetooth/hci_sync.c         | 140 ++++++++++++++++++++++++++++---
 net/bluetooth/iso.c              |  69 +++++++++++----
 4 files changed, 214 insertions(+), 37 deletions(-)

-- 
2.41.0

