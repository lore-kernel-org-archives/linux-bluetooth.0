Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CEF3B71A5
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788104464; cv=none; b=IFMgA43r2TaUZz2YD5+GK5cNcqv5REvQkkZHW9JU47A/46vCFt1I3blr6jbb4FKLi+P6VsRkxK6uslnVA0i4O2XbxxAjidWMn0jp8blMZSpVwZKR/SyQ5T6rD2a6Nn1XZJ6cEEN1MW7MxAAZc+4ytP2uFw3qFzknM/OCyMZVCjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788104464; c=relaxed/simple;
	bh=tnLILOdOW/cKeSMbjPa6oMLqJvejWX5bVqiDhmPxfQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TtBfdqBkePLg8pf82MXXwVcK7kHvyByDhVDJhHgXWLgzJMKHT/r5Ea6U2ovzhcl+6eTLDEPY+p73B4up2FaahnZr28GPevopcM0mV/kMMhkp0CiLJseHb5TLUxkMk5txyz6tm1sZSzUwYS4C4hZcIfdKnZLme/KrfvKF93w5vMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oj+3ZgpH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oj+3ZgpH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d560775ca2so17834605ad.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 08:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788104463; x=1788709263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LZbpV26tRtl5NtcUUtJnt6fbbq6NZJiubX4LdHyFX/4=;
        b=oj+3ZgpHz2wWDPb52I1/saEUm5ZtuEeJj5/mifrR7NqmByRtMgD/WgFxs1j3bYWOSY
         Sy/oJW+P0UXO/TpN5kJHCQcE7OWAxgaUNNu7O97NdimjyMUaymx+zhVPhX+kBvFPoH2C
         BHBUCEglHmZLAq4RBKezoOMZn+4SjVDSV+20NZoKl5jF8qXt+DdKqnlGooj0WbS4lMF3
         PWhPogR5QfkgEDc8krc85eqUrx5pSN4DephgpYrL7/40JW91oTsHebOcEVGkIzP61mlB
         uLD1aRAlKZLRfVUBXtsQf54/CZtBbN5/ETwotQ/PTLZWy0yfT89FbUghhPCIRiDpTuXU
         UTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788104463; x=1788709263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZbpV26tRtl5NtcUUtJnt6fbbq6NZJiubX4LdHyFX/4=;
        b=jllPuVod99lYhfUYiM699ItFOclxMbuaoFXH/gZ15Dl284NSwd32U1FjOn/fTsPmgm
         U4q7BvGfNnorQGDag117W2FCDUZHLany/UGSlou2K/X3PtLMO3eQDNCUJ9TO7E/Xd237
         MOvttHdcF85y7uVLpv2PqyaiV1lvDo+B1aqOBJGZW2XK3CKshxt0KhEWhk39XpXj+8cd
         NusO62cSfafhcwmge0wJhPYCK/Cpf2h2Q57EvjYniSgYiFnlFYJtmh1Y75NALiztRdIf
         XdadGKiYPY3CYUYhTcLqM03PrKj0eUBV5m5ejK/XKraVKIDaTbtPBLWngfotiD79tqh2
         DwMA==
X-Gm-Message-State: AFuF++mc/wGj0Gs5A+9X19t+oJ3PTQNn1+piwgX3KTaKaTlPFb7HEGOH
	t+VID8Hs2jHTsdmccwKvkXqCnyfci36eDCD2xtfFCUIHH/hDyq4gfTGsYBidZA==
X-Gm-Gg: AYBFou2wTzkzy/HVTO5SybysknVCX2NvKkAP56Pn01QyR8reRAYaCY8SBM2DnRNv7lr
	twZ36iUkVexczZ+iNNWKfm01MUtvjeKZ4oeaAa0ea7Fpps+S2mKi5WfUA3nwbfY205TmCFBAmT8
	4EBfscCve8qUZM4XRJkCLT3QB3ib7MiEaYGcm4ZdEoi+6+KKfquWpgzc0sLlbWxOPbWMpOvcVkh
	CoEaBFlYBeHTieoR+UghpTdb1HxiU4r+68BmKqlxJrq9jpzLynkNBRLzjbEK2Aa4JyM6yhweLAt
	olCD+NDtiFEe3laLVTQXZagjiyCtnMDbpoo8wX+EIN6kbcgKfMKLxVKVH+i1BaGVj1nSXQ7ijQy
	Ii4PjQPfA6In5KYK6mPbwYUUlMGbxEsmbbhuj+eBQTMdeWgDT4I3VF0aICbfD4SBfT3m4LtbRR8
	8Z3H9MAXTyRg272rUxBwuU3NATss/iTOjypnpbcjrgnm1Ui810i16tpnyPqLkRFmBTPJumVi44a
	R3kbHrAurNdzllBIVCZ1IPpV9gCmjfaqmaK
X-Received: by 2002:a17:90b:4b05:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-396d0fe2140mr32162153a91.10.1788104462497;
        Sun, 30 Aug 2026 08:41:02 -0700 (PDT)
Received: from MAC-113001deAir.pig-home.com ([49.214.15.228])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0ea80edsm16862058a91.1.2026.08.30.08.41.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Aug 2026 08:41:01 -0700 (PDT)
From: Jerry Wu <jhs730127@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Jerry Wu <jhs730127@gmail.com>
Subject: [PATCH BlueZ] gatt-database: Fix freeing wrong client notify IO
Date: Sun, 30 Aug 2026 23:40:54 +0800
Message-ID: <20260830154054.25086-1-jhs730127@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a non-bonded device disconnects, att_disconnected() drops its
device state and clear_ccc_state() invokes the CCC callback with a
NULL pending operation. ccc_write_cb() then takes the notifications
disabled path and calls queue_remove_if() on chrc->notify_ios with a
NULL ATT instance.

match_client_att() matches every entry when the ATT instance is NULL
and queue_remove_if() only removes the first match, so what gets freed
is the head of the queue, that is the client which subscribed first,
and not the one that went away. With two or more subscribers this is
deterministic, because the disconnecting client's IO is still queued
at that point: sock_hup() only runs on a later mainloop iteration.

The victim does not recover. Its link and its CCC value are left
untouched, so gatt_ccc_write_cb() takes the "value is identical"
shortcut on any subsequent write and AcquireNotify is never issued for
it again. To the application the notifications simply stop.

The disconnecting client does not need to be handled here at all, as
its IO is reclaimed through att_disconnect_cb() -> io_shutdown() ->
sock_hup(). Only remove an IO when there is an actual operation, and
let the NULL case fall through to the notify count accounting. That
also restores the StopNotify call when the last subscriber goes away,
which the early exit used to skip.

Fixes: 8eb1dee87e01 ("gatt: Fix not establishing a socket for each device")
Assisted-by: Claude:claude-opus-5
---

Notes for reviewers (below the --- line, not part of the commit):

Verified still present on current master (e814134, "doc: Remove obsolete
security-bugs.rst"). match_client_att(), the ccc_write_cb() disabled path
and the gatt_ccc_write_cb() "value is identical" shortcut are unchanged
since 8eb1dee87e01. Originally hit in production on 5.83.

Reproducing with two centrals and an external GATT application (one
implementing org.bluez.GattCharacteristic1 with AcquireNotify):

 1. Central A connects without bonding and enables notifications on a
    characteristic of the application. AcquireNotify is called and A
    becomes the head of chrc->notify_ios.
 2. Central B connects, also without bonding, and enables notifications
    on the same characteristic. notify_ios is now [A, B], ntfy_cnt is 2.
 3. Central B disconnects.

Observed: A stops receiving notifications at once, even though its LE
link is still up and btmon shows no disconnection for A. A's notify
socket was closed because A happened to be the queue head. A never
recovers, since its CCC value is still 0x0001, so rewriting the CCC is a
no-op and AcquireNotify is not called for it again. Only a full
reconnect of A brings notifications back.

Expected, and what this patch gives: A keeps its notify socket, and B's
socket is closed by sock_hup() as usual.

Steps 1 and 2 must not be swapped. If the client that disconnects
happens to be the queue head, the bug is invisible, which is why a test
with a single central always passes.

I also have a small standalone harness that links the real
src/shared/queue.c and exercises match_client_att() together with the
ccc_write_cb() disabled path, showing the queue head being freed before
the patch and kept after it. Happy to send it if that is useful.

 src/gatt-database.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 18b7aa667..87b166ade 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2971,8 +2971,15 @@ static uint8_t ccc_write_cb(struct pending_op *op, void *user_data)
 		if (!chrc->ntfy_cnt)
 			goto done;
 
-		client = queue_remove_if(chrc->notify_ios, match_client_att,
-							op ? op->att : NULL);
+		/*
+		 * A NULL op means clear_ccc_state() is clearing the CCC of a
+		 * device that has just disconnected. Its own IO is reclaimed
+		 * by att_disconnect_cb(), and match_client_att() matches any
+		 * entry when the ATT instance is NULL, which would free the
+		 * IO of an unrelated client, so only account for it here.
+		 */
+		client = op ? queue_remove_if(chrc->notify_ios,
+					match_client_att, op->att) : NULL;
 		if (client) {
 			client_io_free(client);
 			__sync_sub_and_fetch(&chrc->ntfy_cnt, 1);
-- 
2.50.1 (Apple Git-155)

