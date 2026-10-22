Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671405;
	b=qM9Jze11vkaFcv0o06tJR+8YluB8t1fsaagsJP6qOmz8ouKmM8st718LRF3PAnfmQY4Y
	 MMvQhgWmWWiKgp6jvwRiLQmn+TkCLy9OcEsfeeXMdXGGL7x9oAChL8sxAsBaY2a7ECTxe
	 +z+/MX7K63Cf5B+NS/sceId63i2AWrLigEZg/wpYYYNbVx4DAPP6ZxSVsLO/z1oVmhEwQ
	 wdor7OQod2mTNziGk9N5IuNNAZXdwpfAE7knkQfpzbsfM2haqrtSPCHs67UX8MRiHUfnr
	 qlP+p2wTuRtRpdTuUFGCCEszB5I/FNr89OgPYwqx1VLrl34ZkUEmFh0z8vDGpUPt/ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bBrHNmc7PbGGn5lyfOcxeR3zOs/o7WqUiB6nA5M0+7g=;
	b=IKBbZTs4/kPu+q5XgCg7xfWPgWrKAuTdeJWySQWRS2+VGxyETql0qgn7LCI1wDDAks/T
	 eYmCKTQsUoMjETAdm9d5Fpj+JPHSFl6i4IAqU2I1BGfZVqvBIzfy9+JWSwTAIhvHIAoKi
	 54cJysJem080/85p93DDznuFFJ0hIOKCcldECZhDF6NW0srOYlPDL73DbgW+ucyuGLJ3w
	 dA9p/raFZ9avcIGzCbKsh1bl9C0loiVADnVog+FRK6UVBfy9NtSbXnCEw691OyfVcYVJD
	 p7JHmHB9f1uS9A4K5/JE3jbetbK9HkYJPk3Y3STtyy4y202hovrxPv7TWBymXl3kBNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PqFqk2Bn;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E43606A319
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 12:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8E43606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PqFqk2Bn
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso922753a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792671404; x=1793276204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bBrHNmc7PbGGn5lyfOcxeR3zOs/o7WqUiB6nA5M0+7g=;
        b=PqFqk2Bn6B1j7bDpEQYx9WIZ0ehLDS5VViOBQ8t+zlYJzoRZEv+iTgtCsTLU/BUG2Q
         7qnn4IOJ5mYCNRnJga7zmNIig5dOr1m0gYHzfMLcYs7vFKTisD30F2sz7Kk4xebtvlAP
         PA0R3Y3AANWiQyyRMl2mmz5U2smFwyW2ReDX3GHoQXni5CUJl9X6fOUyp1Cur9XNH8Xn
         wvu1e8AC652+Qv6igOd2ywYn3vd3BP2L06qP549xidwOatJXX8jXw3gmE7CXWFGK58h8
         5eL5wI6jy4XZPWI70x8sjbUSzOVZ9V5Ec2vdnfzCs7RXk0RSbFSPl9vroM2kvcs20inA
         o91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671404; x=1793276204;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bBrHNmc7PbGGn5lyfOcxeR3zOs/o7WqUiB6nA5M0+7g=;
        b=zTpS5WudxogPBX9Kyb3RfqTRcX6tfvn+f8JwcFCL7xis/PnOL9DG/hM1fY6SQIxwXr
         hf2paMzzP1H/LsF/ZVey6fJmfalEBhMSg7mITLMhccrnHc3loM4Tox21gZEeKsVtAWEE
         5ZTiFF1q+h44YzT8YjOHep3yhLLCCfogGDeh03OFTVgwiP3LaR+qZAqoCobzZ7Vyd+R3
         ktVdIQWPQuxuaj3yCknsZg6vUR66DpDCHOt65aap7DAHsU63kFB5jaI76H6kxXnFscuj
         +O1M/wr0oPDkGGzI6bb8FNDr2nLkqjXuVr+EE6CasCXwaMRGWevEHMjMY+JuCEV+MGEM
         qHRQ==
X-Gm-Message-State: AFq9FYKxzKDsro1Q65ncrjnyGOx9CFia8UxfDvBcc9UlUj8CmYFuWloq
	isiXcYBM0PFsF6BY66bdTdfnXqPhOTVaqfGXV3BkehQFDcizOaZXuJki
X-Gm-Gg: AYBFou0PcptR42G/tPGCvQirRs7DmiAEWxzbySSKH0Orfu+YSCXhvJAeA6MInNIjhTx
	qfjzpZZU/uCo1kE7y4zaGFlRpgm17OmITwKNHuQxn7v3Zp0eOEtJyMbTauI3I/Xc0njevTi8BXZ
	2T43YtIDj2CU4L+MGwJ30kqauyb9Yj1N6Uv7Gf2pJ3aZ8dCzUKwg/JkuV2ZV0EV2Nb9w4brKI0H
	HxXNT4lxWh/M4XI/57OVRIPAhUYaphLlqr2RjL9sT7Ws63HOqeEcnS2IeTcsGP5dv5jk3aHZ0Sr
	81FsHI5kZySIxLEPxQJ/2KPHsepWqjqhR2zFMtLteEFsQoVPfswdG2HXEhtGt9tjKTQB+DIyiB/
	6UJCd3LgjzRCOISloX9k0C5MsWZZspFdWtep16YrkZi7RNnfhcGCKnCIH2l7eJUajJYe13/PkKX
	GQQVL3sVJtOofqsSIAbOXdKGxc+PckxvrVv92blPW7pxf2c9RNjOYxie/Mgtdcj0jOqMboJMLDD
	Jow+x+rBM2E/ZrDCe3qhLvFxUIeYP6dtlaavGv9C5p8bQOdoQI=
X-Received: by 2002:a17:90b:3d86:b0:3ac:e6a:1b2b with SMTP id 98e67ed59e1d1-3ad86cb08f3mr4143140a91.0.1792671404071;
        Thu, 22 Oct 2026 05:16:44 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490d4bfsm4782330a91.10.2026.10.22.05.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:16:43 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: hci_sync: Copy the LE accept list under hdev->lock
Date: Thu, 22 Oct 2026 20:16:36 +0800
Message-Id: <pm-bluetooth-objects-candidate-0158-v12-0137c5e23ffb6986d911@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The LE accept-list mirror consists of bdaddr_list entries that are
added, removed and freed under hdev->lock. The ordinary branch of
hci_update_accept_list_sync() traverses this list without that lock.
The request worker's req_lock does not serialize raw HCI completions,
and the RCU sections protect connection and pending-action lookups,
not the accept-list nodes.

Changing connectability can reach this iterator through
set_connectable_sync(), hci_update_connectable_sync(),
hci_update_passive_scan_sync() and hci_passive_scan_sync(). With a
populated mirror, a privileged raw HCI sender can issue
HCI_OP_LE_CLEAR_ACCEPT_LIST while request work is reconciling it:

  Request work                    HCI event work
  select b and successor t
                                  hci_cc_le_clear_accept_list()
                                    hci_dev_lock(hdev)
                                    hci_bdaddr_list_clear()
                                      unlink nodes and kfree(b)
                                    hci_dev_unlock(hdev)
  read b->bdaddr_type

The clear completion can therefore free the selected node before its
field read, or the saved successor before the iterator advances.
KASAN reported a one-byte read of bdaddr_type from the freed node.

Copy each entry's address and type under hdev->lock and reconcile the
private array instead. Release the mutex before issuing synchronous
commands, since their completion handlers also acquire it. Free the
copy after iteration and use the existing error path to disable
accept-list filtering if allocation fails.

This change has not been runtime-tested.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in hci_passive_scan_sync+0x1cc4/0x1f80
    Read of size 1 at addr ffff888105ee6c56 by task kworker/u17:1/499

    Workqueue: hci0 hci_cmd_sync_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? hci_passive_scan_sync+0x1cc4/0x1f80
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? hci_passive_scan_sync+0x1cc4/0x1f80
     kasan_report+0xe0/0x110
     ? hci_passive_scan_sync+0x1cc4/0x1f80
     hci_passive_scan_sync+0x1cc4/0x1f80
     ? pmbd_gate_site_armed+0x31/0x1c0
     ? __pfx_hci_passive_scan_sync+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? pmbd_probe_hit_cookie+0x10/0x1c0
     ? __pfx_pmbd_probe_hit_cookie+0x10/0x10
     ? hci_update_passive_scan_sync+0x43f/0x9e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x280
     hci_update_passive_scan_sync+0x473/0x9e0
     hci_update_connectable_sync+0x13c/0x250
     set_connectable_sync+0x39/0xb0
     hci_cmd_sync_work+0x1b3/0x450
     ? srso_alias_return_thunk+0x5/0xfbef5
     process_one_work+0x908/0x19c0
     ? __pfx_process_one_work+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_is_held_type+0x8f/0x100
     ? srso_alias_return_thunk+0x5/0xfbef5
     worker_thread+0x65c/0xe40
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

    Allocated by task 511:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     hci_bdaddr_list_add+0x179/0x390
     hci_cc_le_add_to_accept_list+0x189/0x2d0
     hci_cmd_complete_evt+0x373/0xab0
     hci_event_packet+0x4e8/0xc70
     hci_rx_work+0x367/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    Freed by task 511:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     hci_bdaddr_list_clear+0x134/0x230
     hci_cc_le_clear_accept_list+0x80/0x1f0
     hci_cmd_complete_evt+0x373/0xab0
     hci_event_packet+0x4e8/0xc70
     hci_rx_work+0x367/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    The buggy address belongs to the object at ffff888105ee6c40
                                                                which
                                belongs to the cache kmalloc-32 of size 32
    The buggy address is located 22 bytes inside of
                                                                freed
                                32-byte region [ffff888105ee6c40,
                                ffff888105ee6c60)

    The buggy address belongs to the physical page:
        page: refcount:0 mapcount:0 mapping:0000000000000000
    index:0xffff888105ee69c0 pfn:0x105ee6
    flags: 0x200000000000200(workingset|node=0|zone=2)
    page_type: f5(slab)
        raw: 0200000000000200 ffff888100042780 ffffea0004187150
    ffffea00042534d0
        raw: ffff888105ee69c0 000000000040003f 00000000f5000000
    0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff888105ee6b00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
     ffff888105ee6b80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
    >ffff888105ee6c00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                                                     ^
     ffff888105ee6c80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
     ffff888105ee6d00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
    ==================================================================

Fixes: e8907f76544f ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 3")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Sashiko review follow-up: earlier accept-list patch
  - Address the outer-iterator lifetime issue raised by Sashiko:
    https://sashiko.dev/#/patchset/88963
  - Copy accept-list addresses before issuing synchronous commands.

Related accept-list membership fix:
https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0118-v7-e6b713327ef914d6d02a@gmail.com

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2872,6 +2872,31 @@
 
 	*n = i;
 	return p;
+}
+
+static struct conn_params *le_accept_list_copy(struct hci_dev *hdev,
+					       size_t *n)
+{
+	struct bdaddr_list *entry;
+	struct conn_params *params;
+	size_t i = 0;
+
+	hci_dev_lock(hdev);
+
+	*n = list_count_nodes(&hdev->le_accept_list);
+	params = kvzalloc_objs(struct conn_params, *n);
+	if (!params)
+		goto unlock;
+
+	list_for_each_entry(entry, &hdev->le_accept_list, list) {
+		bacpy(&params[i].addr, &entry->bdaddr);
+		params[i].addr_type = entry->bdaddr_type;
+		i++;
+	}
+
+unlock:
+	hci_dev_unlock(hdev);
+	return params;
 }
 
 /* Clear LE Accept List */
@@ -2904,7 +2929,6 @@
 static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 {
 	struct conn_params *params;
-	struct bdaddr_list *b, *t;
 	u8 num_entries = 0;
 	bool pend_conn, pend_report;
 	u8 filter_policy;
@@ -2969,20 +2993,27 @@
 	 * report. If not present in either list, then remove it from
 	 * the controller.
 	 */
-	list_for_each_entry_safe(b, t, &hdev->le_accept_list, list) {
+	params = le_accept_list_copy(hdev, &n);
+	if (!params) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	for (i = 0; i < n; i++) {
 		rcu_read_lock();
 
-		if (hci_conn_hash_lookup_le(hdev, &b->bdaddr, b->bdaddr_type)) {
+		if (hci_conn_hash_lookup_le(hdev, &params[i].addr,
+					    params[i].addr_type)) {
 			rcu_read_unlock();
 			continue;
 		}
 
 		pend_conn = hci_pend_le_action_lookup(&hdev->pend_le_conns,
-						      &b->bdaddr,
-						      b->bdaddr_type);
-		pend_report = hci_pend_le_action_lookup(&hdev->pend_le_reports,
-							&b->bdaddr,
-							b->bdaddr_type);
+						      &params[i].addr,
+						      params[i].addr_type);
+		pend_report = hci_pend_le_action_lookup(
+			&hdev->pend_le_reports, &params[i].addr,
+			params[i].addr_type);
 
 		rcu_read_unlock();
 
@@ -2990,13 +3021,15 @@
 		 * remove it from the acceptlist.
 		 */
 		if (!pend_conn && !pend_report) {
-			hci_le_del_accept_list_sync(hdev, &b->bdaddr,
-						    b->bdaddr_type);
+			hci_le_del_accept_list_sync(hdev, &params[i].addr,
+						    params[i].addr_type);
 			continue;
 		}
 
 		num_entries++;
 	}
+
+	kvfree(params);
 
 	/* Since all no longer valid accept list entries have been
 	 * removed, walk through the list of pending connections
