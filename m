Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245085;
	b=hGaiL1WWY/1qwvkmrINaQ+Gdqzrj67mrsoc7b2hA1RgzWQu8Xzt64tGWDZVVutYeEzzb
	 go2Z9MG/+vBi43tTYSBET1S3AIvFKnIP8FWfGKns1hGnZ9h07IVIw77yCuuyf1DYw19mr
	 /Y7i6h5unToJ+SywHUpboN7dQ6ZeSWIw5VK0Hva7ItRSUg6PqRzd0Fe6z8vo6/uZTEUb7
	 JMMc/w/WvKg9mYsgUj2OGAoJm+TIfZpoccIE2WzKRW1M3I7ax9dUt42uxUgdIOfYcM+is
	 12shFvx/+gcri9HmOBd1s/OKBp2g+VR9SBZv+xK41LX9XfFS7iecGdPhYFn4E4LU8bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LHVGDWh/sS50wYe3wF1hYQAVIGOU8i5LOcYT/8mME6Q=;
	b=BE9xMfMYol2IpUx8W6f0AGwA7fiTP7pn0JJ3mEmgh6N8Xzt8DKFpK0KXlSNz6AbV1mrE
	 7t8z5rMp+BFCv6hIPYAzHoGDSi9ht5URugpuJc8GzrXieOGualZolH/PbiNS3eoHF9JbX
	 gdXszAbRWhSq19mc/yde1jTcsE5nL5o5ClBuRBW5FYZPNsgRyJ1XrG6VCk/cqMW3MmXyV
	 BwTk6GxSv4dDGv4mgIAR7v+UPNWViNO1sBqa3hzV4qv3B4AeVUS7RZD5r6lEeWFAZBIWJ
	 XjvY45EyjmSI46UkM0JqNRiTx+EX6nHCJYsnFGZhPYzk4TgR8oaTRpCKmak6xQb/qtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rFXBpNZO;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13784606A32C
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 07:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13784606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rFXBpNZO
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso707608a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 23:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795245084; x=1795849884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LHVGDWh/sS50wYe3wF1hYQAVIGOU8i5LOcYT/8mME6Q=;
        b=rFXBpNZOFLOly12r8x3SMfVJrgLh8ga5krVEA9J+19fIPWpDyZZkEJN1EH9mSzejR2
         OW2GXCrM1TeQ35SHBaE+YV2bDvbh1lgnqbYymFsvOaGgsEPV1qHNpQJ1A3CE1JFYR/OJ
         bmQTdiSERS2Q7b7Vo3JCAnm2FobQYHt+Ra5PteDqAzkZ4eOaONfHi+qgHoDzicU4G+Xh
         MjfumGI3g3Ic0NFPJ56NJvnWD/X/3KG+SxIBQ9B9mcJ3MBdXmyhJ5snlCC7Hy9112xur
         8lzKEkgLm3Nj26MQ0wQ5M9kM9y2zOOKexKpamaw4E5xucyCJth3yZakW9TQ0nFZLU6pe
         d0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795245084; x=1795849884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LHVGDWh/sS50wYe3wF1hYQAVIGOU8i5LOcYT/8mME6Q=;
        b=I3f2ECAphNy0IAE5Fh/wbDe9tlBGzaUl+3/+7cx4eSTKmlU6/1hikeDjz58G8EdGUd
         GpijILaVNsk5/2d6CibzeiLpw7DEY+Ve6pV6ZWmi1gG0KBaLM3r+h3JBviczxpfCERc2
         RonFoPZipPNK+40qHgv9nk1CqJbOoiLyeZyVPALJh1Yhna3hBqS5lzFKKUvmX1y6j48w
         6JTp2kVyr53UOYWDC5g7aIz5mJkDqPkqBV+CjZHu8ulQIFlBB+Ns5r/S0TdeDlFBHliP
         6Fa5N2XLsBikAvs8DMdTvtEDyE2Gpk2kjbNJkMRCf93kzqtaBEEy584okaSabql1gMwW
         EzGg==
X-Gm-Message-State: APuU4Z+A0xJ0+t5/nY2bTttIMQoxCNnczKI4VGdWauaJB7IkdPnlKMT2
	6XST0FjNBTztcMZ0Asv9ADPBK2tW9bynIOkr8008FM7/h2OjdQU8uoKQ
X-Gm-Gg: AZFdTZcDeg2blHAYvfUdnZieE5oWshJA3kA5Xdey/WRKdqKw1Cnm+HGDiGfspbNuX01
	4E7sjeVO9P5TswfIV4yBle1YwDPATu4uSzcvqPaVvAIQ9uUzo5BYYw29w1rQ4mSGWPqtDokFOIj
	kr6RZpWixn8fdgq2sjR+kcefYKz0iztfsA7YcjjZuza2mM3PI2QUHbEYLEiqFffkHqE3oex4c39
	tzXz4ALswszxG8bAVTaCbxmcmZcuKmuXJLMuSBGhmstmzhPWp8JhoWmknlj9UK0meLnR5F14j02
	uDl/54DBy654wMJ7rN2CGvBRsF0YNAMR4EHqGcOMaT9fWFZVS1q1YJtIBYSPbDFoajmnsgEpK3V
	ToKZ0zr+H/p1v5zf6QgwrpMvt/iJO0Db80th5QPauU25a+o7Rbp3nAEOx3OZQOPA/pKyASCPLDY
	xc28mQX8hxDhqse+Ls+RuFpkUd1mwq6kLDfhcgqy80zBBmbUCjGmqVJU41y1SiYVBqepuu4ql2O
	UlK4m7XDevFUhbMQMTvypJnNe/hkDN6aTNzMzHdIR2xKOXBYN7FUQrFtC35mBEsoeo/D1rR8rM2
	OFkqP64/PaSonCxLwOykPNiy
X-Received: by 2002:a17:90b:390c:b0:3a7:9e3d:b3 with SMTP id 98e67ed59e1d1-3b41c9beafamr4862865a91.66.1795245084275;
        Fri, 20 Nov 2026 23:11:24 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d11753sm10614548a91.5.2026.11.20.23.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:11:24 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 2/2] Bluetooth: 6lowpan: Disable notify_peers before netdev deletion
Date: Sat, 21 Nov 2026 15:11:10 +0800
Message-Id: <pm-bluetooth-objects-candidate-0228-v10-f6ced931e2322aa5c7b3-2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0228-v10-f6ced931e2322aa5c7b3-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0228-v10-f6ced931e2322aa5c7b3-0@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last-peer close path cancels notify_peers and queues adapter
deletion. Before deletion removes the adapter from the list, another
ready callback can find it and queue the embedded delayed work again:

  Last-peer close                   Later ready / deletion work
  cancel notify_peers
  queue delete_netdev
                                    add_peer_chan()
                                      requeue notify_peers
                                    unregister and free the adapter
                                    notification timer uses freed work

Disable the delayed work synchronously instead of only cancelling it.
This both drains an existing callback and rejects later queue attempts
for the adapter which is already being deleted.

The excerpt below retains the headline and stack traces.

Use disable_delayed_work_sync() before teardown, as commit
d236517c264e4 ("Bluetooth: coredump: Quiesce dump work on unregister")
does before freeing the Bluetooth coredump state.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in do_notify_peers+0x63/0x70
    Read of size 8 at addr ffff888117711030 by task kworker/3:1/50

    Workqueue: events do_notify_peers
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? do_notify_peers+0x63/0x70
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? do_notify_peers+0x63/0x70
     kasan_report+0xe0/0x110
     ? do_notify_peers+0x63/0x70
     do_notify_peers+0x63/0x70
     process_one_work+0x908/0x19c0
     ? __pfx_process_one_work+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     worker_thread+0x65c/0xe40
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kthread_parkme+0x175/0x220
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x34f/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf80
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>

    Allocated by task 500:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kvmalloc_node_noprof+0x353/0x930
     alloc_netdev_mqs+0xa0/0x1250
     chan_ready_cb+0x4ec/0xeb0
     l2cap_le_connect_req+0xccd/0x11a0
     l2cap_recv_frame+0x467f/0x8830
     l2cap_recv_acldata+0xe9f/0x10e0
     hci_rx_work+0x5a6/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    Freed by task 11:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     device_release+0xd7/0x280
     kobject_put+0x1ad/0x610
     netdev_run_todo+0x91c/0x13a0
     unregister_dev+0x82/0x280
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

Fixes: 18722c247023 ("Bluetooth: Enable 6LoWPAN support for BT LE devices")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
This patch was written with assistance from Codex (OpenAI).

 net/bluetooth/6lowpan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index f01eb68cbf5a9..f3f4e4b2c5f46 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -824,7 +824,8 @@ static void chan_close_cb(struct l2cap_chan *chan)
 	if (!err && last && dev && !atomic_read(&dev->peer_count)) {
 		spin_unlock(&devices_lock);
 
-		cancel_delayed_work_sync(&dev->notify_peers);
+		/* Prevent a later ready callback from requeueing work. */
+		disable_delayed_work_sync(&dev->notify_peers);
 
 		ifdown(dev->netdev);
 
