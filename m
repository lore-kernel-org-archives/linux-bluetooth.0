Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D00B26738D;
	Sun, 26 Apr 2026 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230627; cv=none; b=UC5rQ5a6qyE7NvetpALVAaAxs+myRJ2+XBqIgT6XsninYsypz1qhC9mqHl7WoELqSLCzD4ZC/q4Dewnpt/QxSYr1fO7ING3wOBXw3BUa8hs6iHHKn995TMMEfQcrwWAg2CKPq+KkbXC3yQUN6FJ0xf7RjKqwtTlT0aLKmiIpTQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230627; c=relaxed/simple;
	bh=yxs0t7cDOuQrH76nlGNiykltD0x1yots232V7QppWQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMwgEw/aRcvFK/uziBJI+bkOP/utolCDhGkFodaE769D+wGDX9dRVtzO5dgUGCDYsuv0xkVbDpDIQZQOK1oBGQBZIU1WB5KJutA0w7HTrZ1MBcThDoW9+n2/Hh+7up4B6cJK7se3YxqnKOCVwwiEu8pH0IF55OuPMYXm8ARnNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPPcEmAs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPPcEmAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777230625; x=1808766625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yxs0t7cDOuQrH76nlGNiykltD0x1yots232V7QppWQU=;
  b=kPPcEmAsvrFkAyhtAUndgolHxY1G/SLlIgoK1W5C8oOF7Hizv8BSn8G2
   rcFMMkZ33rN5SrQxvYdTgFY2VJ+6+8cPLg6n40aWTRXhVJdQ1mPR72qne
   85QPo6p7hpMzfUtL140z1ZeY/H+7gFc4mg6Ef0sQA4k3bIDXhPWvA4SEC
   NOGrzSVY0J2oQ8Jg4MzduKAzenozBcgHfIACE8TZzglIfLCvawhx/SHin
   u9+V3vuMhdRVNMuIXQkvx/hwSihNERqlQ8kzzsQUnQsIoVKMDr44aVV5p
   i2CXHDKlTegEgqFto7tjc+JyIejalono45UeO6ZTbx0GyEIrkuxWxtEkZ
   Q==;
X-CSE-ConnectionGUID: csr7BpWbSquJbafYqCaznQ==
X-CSE-MsgGUID: dWSY9C3JTc28bt3q2XkeoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="77286636"
X-IronPort-AV: E=Sophos;i="6.23,200,1770624000"; 
   d="scan'208";a="77286636"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 12:10:24 -0700
X-CSE-ConnectionGUID: 2s+JDn8mRcWyqVEkxXVfAQ==
X-CSE-MsgGUID: 184bo4lnQ92bGqQwCASFRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,200,1770624000"; 
   d="scan'208";a="233330237"
Received: from arjan-box.jf.intel.com ([10.88.27.153])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 12:10:24 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	syzbot+00f5a866124dc44cce14@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_send_cmd (4)
Date: Sun, 26 Apr 2026 12:11:36 -0700
Message-ID: <20260426191142.467942-1-arjan@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <69ed492c.050a0220.e51af.0005.GAE@google.com>
References: <69ed492c.050a0220.e51af.0005.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This email is created by automation to help kernel developers
deal with a large volume of AI generated bug reports by decoding
oopses into more actionable information.


Decoded Backtrace

1. __queue_work -- crash site (kernel/workqueue.c:2297)

   2275  static void __queue_work(int cpu, struct workqueue_struct *wq,
   2276                           struct work_struct *work)
   2277  {
   2278      struct pool_workqueue *pwq;
   2279      struct worker_pool *last_pool, *pool;
   2280      unsigned int work_flags;
   2281      unsigned int req_cpu = cpu;
   2289      lockdep_assert_irqs_disabled();
   2291      /*
   2292       * For a draining wq, only works from the same workqueue are
   2293       * allowed. The __WQ_DESTROYING helps to spot the issue that
   2294       * queues a new work item to a wq after destroy_workqueue(wq).
   2295       */
   2296      if (unlikely(wq->flags & (__WQ_DESTROYING | __WQ_DRAINING) &&
-> 2297             WARN_ONCE(!is_chained_work(wq),
   2298                             "workqueue: cannot queue %ps on wq %s\n",
   2299                             work->func, wq->name))) {
   2300          return;
   2301      }

2. queue_work_on (kernel/workqueue.c:2432)

   2422  bool queue_work_on(int cpu, struct workqueue_struct *wq,
   2423                     struct work_struct *work)
   2424  {
   2425      bool ret = false;
   2426      unsigned long irq_flags;
   2428      local_irq_save(irq_flags);
   2430      if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)) &&
   2431          !clear_pending_if_disabled(work)) {
-> 2432          __queue_work(cpu, wq, work);
   2433          ret = true;
   2434      }
   2436      local_irq_restore(irq_flags);
   2437      return ret;
   2438  }

3. hci_send_cmd (net/bluetooth/hci_core.c:3111)

   3092  int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
   3093                   const void *param)
   3094  {
   3095      struct sk_buff *skb;
   3097      BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
   3099      skb = hci_cmd_sync_alloc(hdev, opcode, plen, param, NULL);
   3100      if (!skb) {
   3101          bt_dev_err(hdev, "no memory for command");
   3102          return -ENOMEM;
   3103      }
   3105      /* Stand-alone HCI commands must be flagged as
   3106       * single-command requests.
   3107       */
   3108      bt_cb(skb)->hci.req_flags |= HCI_REQ_START;
   3110      skb_queue_tail(&hdev->cmd_q, skb);
-> 3111      queue_work(hdev->workqueue, &hdev->cmd_work);    // hdev->workqueue is __WQ_DRAINING
   3113      return 0;
   3114  }

   Inlined caller: hci_conn_auth (net/bluetooth/hci_conn.c:2459)

   2438  static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level,
   2439                           __u8 auth_type)
   2440  {
   2454      if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->flags)) {
   2455          struct hci_cp_auth_requested cp;
   2456          cp.handle = cpu_to_le16(conn->handle);
-> 2459          hci_send_cmd(conn->hdev, HCI_OP_AUTH_REQUESTED,
   2460                       sizeof(cp), &cp);
   2461      }
   2464      return 0;
   2465  }

4. hci_conn_security (net/bluetooth/hci_conn.c:2551)

   2487  int hci_conn_security(struct hci_conn *conn, __u8 sec_level,
   2488                        __u8 auth_type, bool initiator)
   2489  {
   2544  auth:
   2548      if (initiator)
   2549          set_bit(HCI_CONN_AUTH_INITIATOR, &conn->flags);
-> 2551      if (!hci_conn_auth(conn, sec_level, auth_type))
   2552          return 0;
   2563  }

5. l2cap_info_timeout (net/bluetooth/l2cap_core.c:1685)
   -- running on the 'events' workqueue, NOT on hdev->workqueue

   1675  static void l2cap_info_timeout(struct work_struct *work)
   1676  {
   1677      struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
   1678                                             info_timer.work);
   1680      conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
   1681      conn->info_ident = 0;
   1683  
   1684      mutex_lock(&conn->lock);
-> 1685      l2cap_conn_start(conn);
   1686      mutex_unlock(&conn->lock);
   1687  }


Tentative Analysis

The WARNING fires in __queue_work() at kernel/workqueue.c:2297 when
hci_send_cmd() attempts to queue hci_cmd_work onto hdev->workqueue
after that workqueue has entered the draining or destroying state.

The call chain is:
  l2cap_info_timeout (events wq)
    -> l2cap_conn_start
    -> hci_conn_security
    -> hci_conn_auth [inlined]
    -> hci_send_cmd
    -> queue_work(hdev->workqueue, &hdev->cmd_work)   // <-

The race arises in hci_dev_close_sync() (net/bluetooth/hci_sync.c):

  1. HCI_UP is cleared with test_and_clear_bit(HCI_UP, ...).
  2. drain_workqueue(hdev->workqueue) is called -- sets __WQ_DRAINING.
  3. hci_conn_hash_flush() -> l2cap_conn_del() ->
     disable_delayed_work_sync(&conn->info_timer) -- cancels the timer.

The l2cap_info_timeout callback runs on the 'events' workqueue, which
is entirely separate from hdev->workqueue.  Draining hdev->workqueue
has no effect on pending events workqueue items.  If the
l2cap_info_timeout work item was already queued on the events
workqueue before step 3 cancels it, the timeout fires in the window
between steps 2 and 3, reaching hci_send_cmd with hdev->workqueue
already in the __WQ_DRAINING state.

hci_send_cmd() does not check HCI_UP before calling queue_work(),
unlike hci_recv_frame() and the hci_dev_ioctl() handler, which both
guard with test_bit(HCI_UP, &hdev->flags).


Potential Solution

Add the same HCI_UP guard to hci_send_cmd() that already exists in
hci_recv_frame() and hci_dev_ioctl():

    if (!test_bit(HCI_UP, &hdev->flags))
        return -ENETDOWN;

Place this check at the top of hci_send_cmd(), before the skb
allocation.  Since HCI_UP is cleared before drain_workqueue() in
hci_dev_close_sync(), this guard catches the race without introducing
any resource leak, lock imbalance, or side effects on callers.


More information

Oops-Analysis: http://oops.fenrus.org/reports/lkml/69ed492c.050a0220.e51af.0005.GAE_google.com/
Assisted-by: GitHub Copilot linux-kernel-oops-x86.
