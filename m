Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505106;
	b=kdhigHMNdE7A4YJM5bSfQ0pYG+bsnCShfKtM/7x3c2VETYkuZmPKnRFsaF6lW95M86kO
	 Bqh27DwvmqEi1lDuczDTQwjjYAtPBCeeZw7j948fYEitfFlafnoBvFvNEJMQ79m4ihsII
	 OgPNqzOalb8flO1b/YZWvrIowpGnyhgI4FF2xKZ4mQ3san+Ikq9Tl4AFuGdYnRG+mTiP+
	 Hu0PU4C1wejeGuA/wAbh8PI2chkfzDyht8OLQsbRvYSnWAQPE371Z4Bud6JMueGpK1Qvh
	 V4gGBbw5q7Ptpyt8BiKcWzSpz4RsKafmgTNpSLd+vgxAhsvBW3bBbNl8gXKudZDg57w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r4erCelSuVgIqJMNJmZgPT3MvAk4eMGRoUT4gvTEkwQ=;
	b=GWTNscPB7MzgrPg1AjHR6wMFgjxlwOOFHZqBvLBkH1yJq1GzjzHqgvwLGXvwT/5OTSl9
	 DvlACvKgxIOAa5YbAxz9llvwwY7Xpo6bfU/TPqBn7lZ6slhZEXxs3B9hmv8/AUSOO7xkA
	 sLcsy31+k+ZKclF6GVrLMbyiCf5248ZP+ecZClwp7dFwDCIQPtP5r+UX8d5oDNL8tDyXo
	 3GABpAxw+6A5mAP8w5c38bpReAo65lskH/auX5pi01grakNx43T8i89SgYc4TbEfzsjO9
	 QreXblU2u7J18punhKqk0chtDLAdijXRfHjO8rquaDcjri+PYhazQeLCqzfSJ041a8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=DoSA4MK7;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7582606CFF1
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7582606CFF1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=DoSA4MK7
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3720addb068so155600eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 09:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1794505102; x=1795109902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r4erCelSuVgIqJMNJmZgPT3MvAk4eMGRoUT4gvTEkwQ=;
        b=DoSA4MK7Qve1Qfj7/Aa0f9+BYrYVLDaEuktxyU5RLoc1hvov00il3OR4IskuFy3/Gv
         6Gk1czbs2VlpeOPsMnyYzttyC8NaX4Xh7jZNKQRQyLyAAy7u6X2vrjAylkzKIGi5w4Wn
         kzpVQ43L5KM7rLLvAuWhLcImxAZ8+mJfdoOJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794505102; x=1795109902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r4erCelSuVgIqJMNJmZgPT3MvAk4eMGRoUT4gvTEkwQ=;
        b=xDowx/zj782/BBk7Pavvy2ilDe7lUAQ/M10cI8O3jN8DBy5EIPNolbu9KZdO7nrOLA
         1WaPTu0tY8+w/4LsYtzK4V3yMdGxL2iJi2Z7iMT6B1Z4RrPt4Q9oqvH1xSRAJ/7/CpBn
         uF3M+xQcdQ0TiShvUgd4BN9FFHanyZ9ZFhRc3AIU8R6/cflE4FyyWYdStNjC1/NlTFfm
         7a34pAZzE0veqMqeelF7+ilPhlNDc2XriDyWqYsiPDRcaM53BU68vQAHaW+regB67Vwh
         /5JUIlf29xHPY17oBIY74pjRQZWGH8Nlr9CEY+dFnoejgbm4qB49LBVYbZEx7+qmOVlU
         cVKQ==
X-Forwarded-Encrypted: i=1; AL+hErFrtoqdglhyv09RXswSk9sArU6KxRz6y+f1yCF0mgG/7WZmNnxFF0Ikkvz7mhg5meWJReXD2EruZDLYE6Z1tnE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZXGk/IS9ss3GKBn9UZMwH4x26hgjY9KA5TVfdpUlr+NMDQcB+
	SoXRYB2To1GK+z8Ibco05Y0tMqjgigF20YZW7TSvF1z7nz2t68Zc5tfLHuZljkTjkE4=
X-Gm-Gg: AYBFou22Je6gNZ3zskUa0cSNy/NzKF/uKeTBtlD5rC0vab4qHF5QX++/cSGswXW+j8u
	ASsL4yrFZ9p//1T9pufITt26VvMJ0SuQFjXfB+fUPVNcQkUj6mpzGtgPDX9t1RufwlYI6lviYkK
	6kZLL6DF3/ptR6nN1UnVlwxn3aaq24PHUBH+bSAaS+7VIm8LmBKXaTMD51id1eyV1iG++yW+1C3
	932nAT5em4JZeMFyD2NWgod/upWbbmP7rVW6W64Nsnl5J+67eNKpoZxVZIL1uyu03UvT5IoymxU
	Exx9eptfQIXbAbsFC5py9F6vPz/pgDPbobRDujtWl45gZU+8Iqxau2d7nx9Y19pOdXJgiViwpEU
	yTt+FG+QCNXuYX3J05Dad8NvI/DX5BaScAPEJPvPMbwRWjpoAvRsNdzNPxhdAS1Utw2vt6MHLmD
	q9MYj6fcC3rn3hELict6GKCBfyNArc3ewJWPmQtI0e1/NLMoQ0GRMN+OmmwNXdo3k+xr8Y1YdqR
	ArGKV9iY9GY/MIITbQGDqqbD0gNfiWc0em1SeI4DHrnjadaHgUDURaWwKuG8vVEkVI+HzBGWxFU
	jMZuqLMmK9YZc9odSXir9x8iDE4wSkqAr3iyDBaLs5r+EWD1IVlGpE7lYagFVHqSj/53PLf7U0J
	Skajznbk9Ywj9RT4ocEw9Nos+bgx2G6T5LZJgfJGamLA3d7w+1g29yKPqzFBKWIRDKbSbVwEecQ
	dowAP0VBS5eg==
X-Received: by 2002:a05:693c:6383:20b0:377:d6e5:e64a with SMTP id 5a478bee46e88-377d6e5e88amr3079385eec.7.1794505101583;
        Thu, 12 Nov 2026 09:38:21 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955ffcbc9sm69448eec.18.2026.11.12.09.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:38:20 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>
Subject: [BUG] Bluetooth: L2CAP: slab-use-after-free reading chan->sdu->len after the receive callback has consumed the SDU (seen on 7.3.1)
Date: Thu, 12 Nov 2026 23:08:11 +0530
Message-Id: <20261112173812.18696-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
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

Hi Marcel and Luiz,

We would like to report a bug in l2cap_le_rx_credits.

Summary
=======

Affected: reproduced directly on net/main at a2fd526d6442, i.e. on
7.4.0-rc1, as well as on the 7.3.1 tree it was first seen on.  The four
relevant code regions are byte-identical in both and in mainline at
79eb6679ef6a, and the code is present unchanged in every v7.3-rc tag we
have.

Problem: l2cap_ecred_data_rcv() hands a completed multi-frame SDU to the
channel's receive callback while chan->sdu still points at it, and only
clears chan->sdu after the call returns.  The callback takes ownership and
may free the skb; l2cap_ecred_recv() then updates the credits, and
l2cap_le_rx_credits() reads chan->sdu->len.

  BUG: KASAN: slab-use-after-free in l2cap_le_rx_credits
       net/bluetooth/l2cap_core.c:576 [inline]
  BUG: KASAN: slab-use-after-free in l2cap_chan_le_send_credits+0xa8/0x3e0
       net/bluetooth/l2cap_core.c:6811
  Read of size 4 at addr ffff88800e134070 by task kworker/u21:2/11352
  Workqueue: hci0 hci_rx_work

The read is 112 bytes into a freed 240-byte skbuff_head_cache object.
Offset 112 is sk_buff.len and sizeof(struct sk_buff) is 240, so the read is
exactly chan->sdu->len.

Conditions: a 6LoWPAN channel, because its receive callback frees the skb
outright.  An administrator enables 6LoWPAN through
/sys/kernel/debug/bluetooth/6lowpan_enable; after that bt_6lowpan_listen()
listens on L2CAP_PSM_IPSP and a connected LE peer triggers this by sending
one SDU across more than one K-frame.

Reproducer: tested, not included here - see section 5.

Fix: sent as a separate patch in this thread, verified at runtime on
net/main - the reproducer faults on the unpatched kernel, three runs, and
runs clean on the patched one, two runs.  Section 7 has the detail.

This bug was found with AI assistance.


1. Root cause
=============

Three functions are involved.  The reassembly completes here:

  /* net/bluetooth/l2cap_core.c, l2cap_ecred_data_rcv() */
	append_skb_frag(chan->sdu, skb, &chan->sdu_last_frag);
	skb = NULL;

	if (chan->sdu->len == chan->sdu_len) {
		err = l2cap_ecred_recv(chan, chan->sdu);
		if (!err) {
			chan->sdu = NULL;
			chan->sdu_last_frag = NULL;
			chan->sdu_len = 0;
		}
	}

chan->sdu is still set when l2cap_ecred_recv() is called, and is cleared
only after it returns.  Inside:

  /* l2cap_ecred_recv() */
	/* Wait recv to confirm reception before updating the credits */
	err = chan->ops->recv(chan, skb);

	if (err < 0 && chan->rx_avail != -1) {
		...
		return err;
	}

	/* Update credits whenever an SDU is received */
	l2cap_chan_le_send_credits(chan);

and l2cap_chan_le_send_credits() calls

  /* l2cap_le_rx_credits() */
	size_t sdu_len = chan->sdu ? chan->sdu->len : 0;

So in the window between chan->ops->recv() taking the skb and the caller
clearing chan->sdu, chan->sdu is dereferenced.

Only the multi-frame path is affected.  The single-frame path returns
l2cap_ecred_recv(chan, skb) with chan->sdu NULL, so l2cap_le_rx_credits()
reads a zero sdu_len there.  The fix makes the fragmented path behave the
same way.


2. Why it is a use-after-free and not just a stale read
=======================================================

The 6LoWPAN callback frees the skb on the success path:

  /* net/bluetooth/6lowpan.c, recv_pkt() */
		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
			kfree_skb(local_skb);
			goto drop;
		}
		...
		consume_skb(local_skb);
		consume_skb(skb);
	...
	return NET_RX_SUCCESS;

chan_recv_cb() returns that unchanged, i.e. 0, so l2cap_ecred_recv() takes
neither the error branch nor any ownership back, and goes straight on to the
credit update.  That makes the read unconditional and deterministic rather
than a race, which is why KASAN catches it every time on this path.

The ownership rule the code relies on is consistent across the callbacks:
on success the callback owns the skb, on failure the caller still does.
l2cap_sock_recv_cb() queues the skb with __sock_queue_rcv_skb() and leaves
it alone on error, which is why l2cap_ecred_data_rcv()'s error path can do
kfree_skb(chan->sdu).  The fix keeps that rule.

We note, without having demonstrated it, that the socket path looks exposed
to the same bug as a race rather than a certainty: l2cap_sock_recv_cb()
releases the socket lock before returning, so once the SDU is on
sk_receive_queue a concurrent recvmsg() can free it before
l2cap_le_rx_credits() reads chan->sdu->len.  KASAN would not usually catch
that because the skb is normally still queued.  The fix covers it either
way, since it stops the caller from holding a pointer it has given away.


3. KASAN reports
================

Quoted below, not attached - this mail carries no attachments.  We have
four logs in all, from four kernels; the two that matter are here.  The
timestamps and KASAN's speculative "?" frames are dropped for width,
nothing else is edited, and the unedited logs are available on request.

First, net/main at a2fd526d6442 - the tree this patch is against.  The
LOWRUN line is the reproducer's own marker, printed 185 ms before the
report:

  LOWRUN sdu
  ==================================================================
  BUG: KASAN: slab-use-after-free in l2cap_chan_le_send_credits+0x86/0x1d0
  Read of size 4 at addr ffff888011a76a70 by task kworker/u21:0/352
  CPU: 1 UID: 0 PID: 352 Comm: kworker/u21:0 Not tainted
      7.4.0-rc1-ga2fd526d6442 #2 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
      04/01/2014
  Workqueue: hci0 hci_rx_work
  Call Trace:
   <TASK>
   dump_stack_lvl+0x55/0x70
   print_report+0xcb/0x5e0
   kasan_report+0xb8/0xf0
   l2cap_chan_le_send_credits+0x86/0x1d0
   l2cap_ecred_recv+0x5a/0x90
   l2cap_recv_frame+0xd84/0x3f30
   l2cap_recv_acldata+0x702/0x710
   hci_rx_work+0x1d8/0x430
   process_one_work+0x3de/0x780
   worker_thread+0x287/0x4c0
   kthread+0x1af/0x1f0
   ret_from_fork+0x2ea/0x410

Second, and the one to read closely: the reproducer on an unmodified 7.3.1
kernel, "Not tainted 7.3.1 #2", with no local changes to net/bluetooth at
all - no modified sources and no added compiler flags.  It carries the
freeing stack as well, and shows the inline chain explicitly:

  ==================================================================
  BUG: KASAN: slab-use-after-free in l2cap_le_rx_credits
       net/bluetooth/l2cap_core.c:576 [inline]
  BUG: KASAN: slab-use-after-free in l2cap_chan_le_send_credits+0xa8/0x3e0
       net/bluetooth/l2cap_core.c:6811
  Read of size 4 at addr ffff88800e134070 by task kworker/u21:2/11352

  CPU: 1 UID: 0 PID: 11352 Comm: kworker/u21:2 Not tainted 7.3.1 #2
  Workqueue: hci0 hci_rx_work
  Call Trace:
   l2cap_le_rx_credits net/bluetooth/l2cap_core.c:576 [inline]
   l2cap_chan_le_send_credits+0xa8/0x3e0 net/bluetooth/l2cap_core.c:6811
   l2cap_ecred_recv+0x63/0x120 net/bluetooth/l2cap_core.c:6873
   l2cap_ecred_data_rcv net/bluetooth/l2cap_core.c:6976 [inline]
   l2cap_data_channel net/bluetooth/l2cap_core.c:7028 [inline]
   l2cap_recv_frame+0x6c3c/0x9650 net/bluetooth/l2cap_core.c:7162
   l2cap_recv_acldata+0x6fd/0xe60 net/bluetooth/l2cap_core.c:7902
   hci_acldata_packet net/bluetooth/hci_core.c:3865 [inline]
   hci_rx_work+0x3c0/0xbe0 net/bluetooth/hci_core.c:4092

  Freed by task 11352:
   recv_pkt net/bluetooth/6lowpan.c
   chan_recv_cb+0x88/0x150 net/bluetooth/6lowpan.c:367
   l2cap_ecred_recv+0x61/0x160 net/bluetooth/l2cap_core.c:6864
   l2cap_ecred_data_rcv net/bluetooth/l2cap_core.c:6976 [inline]

  The buggy address belongs to the object at ffff88800e134000
   which belongs to the cache skbuff_head_cache of size 240
  The buggy address is located 112 bytes inside of
   freed 240-byte region
  ==================================================================

The freeing task and the reading task are the same rx worker, two frames
apart in the same call chain, which is the whole bug.

The first report comes from a kernel where our coverage harness appends
compiler flags to net/bluetooth/Makefile -

  subdir-ccflags-y += -fno-inline -fno-inline-functions \
                      -finstrument-functions-after-inlining \
                      -mllvm -sanitizer-coverage-prune-blocks=0

- so there l2cap_le_rx_credits() is a real frame at :576 rather than
inlined.  No .c or .h file under net/bluetooth is modified in either
kernel.  That the same bug appears with and without those flags is itself
evidence that they change inlining and not semantics.


4. Impact
=========

Stating only what we verified, and our reading of
Documentation/process/threat-model.rst - please correct it:

  - Enabling 6LoWPAN requires root, through a debugfs file.  By
    threat-model.rst that alone is "excess of initial privileges", so our
    reproducer's own path does not cross a boundary.

  - What we think does: once an administrator has enabled it - which is how
    IPv6-over-BLE is meant to be used, not a debug-only setting -
    bt_6lowpan_listen() listens on L2CAP_PSM_IPSP, and the trigger is then
    an ordinary inbound SDU from a connected LE peer.  Fragmenting an SDU
    across two K-frames is normal protocol behaviour, needs no local
    privilege, and is the remote's choice.  So on a configured system this
    is reachable over the air.

  - The read itself is 4 bytes of a freed 240-byte skbuff_head_cache
    object, and its value feeds a credit calculation, so the visible
    consequence is a wrong credit count rather than a leak of the bytes.
    We have not attempted to turn the freed-object reuse into anything
    further, and we are not claiming an exploit.

We did not observe a crash without KASAN; the read is small and lands in
recycled slab memory.


5. Reproducer
=============

Tested, and deliberately not included.  security-bugs.rst says an
AI-assisted finding must be treated as public but its reproducer must not
be, so we are happy to send it to any maintainer who asks.

So you can judge whether to ask for it: a single C program, no external
dependencies and no Bluetooth hardware - it stands up a virtual controller
and answers it, so it runs on any KASAN kernel with CONFIG_BT_6LOWPAN=y and
CONFIG_BT_HCIVHCI=y.  KASAN fires inside hci_rx_work.

We have deliberately left out the sequence it drives.  Section 1 gives the
three functions and the window between them, and section 2 gives the
ownership rule they break, which is what the fix has to be judged against.

What does bound the scope, because it limits who is affected: the channel's
receive callback has to be one that frees the skb, which is the 6LoWPAN one;
and the SDU has to arrive in more than one frame, since the single-frame
path already passes chan->sdu NULL.

In fairness about what it is: this is the harness's own exploratory program,
not a minimised reproducer.  It is about 1100 lines and still carries some
dead scaffolding from the search - a few unused helpers and a table of SDU
shapes it no longer iterates - which is why it compiles with warnings.  We
kept it exactly as it ran rather than restructure a program we had already
verified.  If you would rather have a minimised one, say so and we will cut
it down and re-verify.


6. Suggested fix
================

Clear the reassembly state before handing the SDU to the callback, and
release the SDU on the spot if the callback refused it - which is what the
error path's kfree_skb(chan->sdu) did before.  The completion path then
returns rather than falling into that error path, because the reassembly
state is already clear there and the kfree_skb(chan->sdu) it would reach
has nothing left to free.  The patch is sent separately, against net/main
at a2fd526d6442.

This also makes l2cap_le_rx_credits() see chan->sdu == NULL and so compute
sdu_len 0 during the credit update, which is the correct value: the SDU has
just been delivered and no partial SDU is pending.  It is what the
single-frame path already produces.

We considered instead making l2cap_ecred_recv() not update the credits, or
passing the length down rather than re-reading it from chan->sdu, and
preferred this because it keeps the ownership rule in one place and does not
change the credit arithmetic.


7. What was and was not checked
===============================

Verified at runtime on net/main itself.  The kernel was built from
a2fd526d6442 with x86_64 defconfig plus KASAN and the Bluetooth, 6LoWPAN,
vhci and configfs options the test needs - 1664 =y options, gcc, and no
instrumentation of any kind, so net/bluetooth is exactly as shipped.  It was
booted by hand under qemu against the same unmodified rootfs image each
time, with the image opened read-only (-snapshot).  The only difference
between the two kernels is net/bluetooth/l2cap_core.c:

  unpatched  7.4.0-rc1-ga2fd526d6442   run 1: KASAN     run 2: KASAN
  patched    7.4.0-rc1-gc0de89ec9d04   run 1: no report run 2: no report

The clean runs are not setup failures, which is the thing worth checking:
the reproducer prints each step, and on both the unpatched and the patched
kernel it reported the same L2CAP LE channel - the same scid, the same MTU,
MPS and credits - sent the same frames, and exited 0.  The only difference
is the report.  On the unpatched kernel the console shows the program's own
marker immediately before the trace:

  [   47.223483] LOWRUN sdu
  [   47.408129] BUG: KASAN: slab-use-after-free in
                 l2cap_chan_le_send_credits+0x86/0x1d0
  [   47.408176] Read of size 4 at addr ffff888011a76a70 by task
                 kworker/u21:0/352
  [   47.408280] Workqueue: hci0 hci_rx_work

Why freeing the SDU in the completion block cannot double-free.  The
explicit kfree_skb() runs when the callback returns non-zero, and one
callback - 6LoWPAN's chan_recv_cb() -> recv_pkt() - returns a POSITIVE
NET_RX_DROP on paths that do not free the skb, so the caller must.  The one
path in recv_pkt() that does free it is skb_share_check() returning NULL,
which needs the skb to be shared.  It cannot be: net/bluetooth/l2cap_core.c
contains no skb_get() at all, its three skb_clone() calls are all on the
transmit side (l2cap_ertm_resend() and the broadcast loop),
net/bluetooth/6lowpan.c has none, and the only skb_get() in
net/bluetooth/hci_core.c is hdev->req_skb = skb_get(hdev->sent_cmd) on the
command path, which no ACL data frame reaches.  append_skb_frag() links
fragments and adjusts lengths without touching skb->users.  So a reassembly
head reaches the callback with users == 1, skb_shared() is false, and
skb_share_check() returns it untouched.  Freeing on a non-zero return is
also what the three other ops->recv() call sites in this file already do.

Earlier runs, for completeness: the same reproducer faults the same way on
an unmodified 7.3.1 kernel, and the harness hit the signature 19 times over
eight hours on a third kernel.  The patch also compiles warning-free in the
7.3.1 tree, where l2cap_core.o's .text goes from 147425 to 147441 bytes.


Affected versions.  The four code regions that matter -
l2cap_le_rx_credits(), l2cap_ecred_recv(), l2cap_chan_le_send_credits() and
l2cap_ecred_data_rcv()'s completion block - are byte-identical in the 7.3.1
tree we crashed and in net/main at a2fd526d6442, and the pattern is present
in mainline at 79eb6679ef6a.  net/bluetooth/6lowpan.c's recv_pkt() has the
same two consume_skb(skb) calls in both trees.  The code appears unchanged
in every v7.3-rc tag available to us.

Not determined: the commit that introduced it, hence no Fixes: tag.  Our
clone is shallow - 27 commits of l2cap_core.c history are reachable and
git blame lands on the shallow boundary - so we can give the bounds above
but not a SHA.  Please add the tag if you can resolve it.

Not demonstrated: the socket-path race described at the end of section 2,
and any consequence beyond the KASAN report itself.

Thanks,
Piyus Kedia
Kapil Vaswani
