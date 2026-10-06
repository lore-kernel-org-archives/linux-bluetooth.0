Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC2393DCD
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791321721; cv=none; b=VT0N8RFIz0/yTdxWfAPNnTFqwNFpJAcPhdEPXxtC9rVapGZlu8Py0ykvFpQWVec+9WL3iIHaiqqZ5RlcCkDMkYP8CpQ5ZMt/1429zNteoDrWu/s0j5VEL7m30hE95D9uEr4Cv1q82fshKjxYZDZD5M+hIQ4ZMARzFTDkSt5XsmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791321721; c=relaxed/simple;
	bh=byMrUcuXizhXLYsEYCDdvLYPqWlJmUU28xIbnW2zRWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHD+qqoriSWya4+1oWOiUZmMCUX5ueth+hbMxWCXrPlqRk45mlUT82wLNRckt4PIEGLvIvZyo4o8JhCCwEsOoIg8CwCOkReagrc0w87yD2YhD2eclvG75aGpKRhF3z/WHlcOC8pEKwxAfXPXiVIjPw1GrAM0t5v+gmVp3s+HdZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5SbWeym; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5SbWeym"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-7bf1151c2f4so151832137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791321718; x=1791926518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=747DO8pMObmlt2LsNi5++qG5AkL16Gja5YdprxdZyOE=;
        b=N5SbWeymhIJPW7gJF7IGfNblh8dyfx5CpXEXaZE+k1WKu/ghWUzoyAtK6ZPhtbQiJ0
         lzxZN37SelSoYzbS9p4NkIp32yIE8nC/W0HHIC6Ne9aG22xpKmmcdfSMLd35l04JFHKE
         Wexzp2Pr8RVvzBmEMPtZ9t4X3zqBWj26XtZ3zUbdJetkrii94bb6Wo4DHlSCzacbpaSZ
         njXWZidGTEhpbsuzX+mmwXkXpsFR3cq0z/rCCZTskYhebE5u63pkWjCUNQOPjOICPbG2
         vmBcFuNjagE1jRnEi0sM0L/mPyoXAbApz9FOMn4mi1Zxjlm67TAu03E7OuAs5iX/nf/u
         74ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791321718; x=1791926518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=747DO8pMObmlt2LsNi5++qG5AkL16Gja5YdprxdZyOE=;
        b=ww1Y7lk6cOur8IICTm/fWWEc9lN1rjbm/27b7dodiUNiASFvjOrLOIvvJBfUVsAyiN
         X4BuDE17lT8R7pPf8PcqEaUDTVjTNn8o0ssWh2tXllyycNDnGqbxsQl3yZEXXVUN4K7s
         fq+VADWJxXFwHvbmRMH2c2bUDram5rPWgQsfOsiFXKMyapSed1Y7fvaHlRejXfL3hkHD
         NwYE7h94PMkOiatsvXHwl3IyABLHORryNJajqG5DtVfNVUCdtAQWy8lfOMAKZDVyRcRt
         5fjP2OYzmIMJ88nn0wnTVeD/ZdtF7JHb8UIDJ/d+FRQPEAKorxZLeqjhlQf4BDPL77OR
         xG5g==
X-Gm-Message-State: AFq9FYJqIMDiWnfuPFWj35l4gj0jaM1IAvpqE0qg1OJdoGPGpnB6Dpx2
	4zwUJpEZ4ktB7vtdhHEw5KlSYjohmMEAL4cwptqmuxAmDn1cwIrgaV4Qc5FTUMBT
X-Gm-Gg: AYBFou0jz1V88prKckgvqpWrQ8gIzH+cSYMhrxK6ZW+y/fU4OOgisGC854rdMetqBr4
	uTw6Na8rv7aj75b/aMlS8hlUNsdJreOZ4Ixicwfu+ECVS9qQcN74sJknP6NIStkhtNPLblP64yI
	c0FR/5JZhWEI7/uST6J6pg6rafxo0g6rsy8a4owHro1rmd7Xj/5o1OVlACx+hjeSOcYeVdIKgff
	R3RlNy57D3q3JLNbHp1QQSw48/1Jkz3MWZ2VCFvFDP6dZ4tfeoNj5hFSDSiHnbGlcglwwAz+LiI
	E/b+rV2GAfmmGJfjhYgpB7ARgE/l3vVynVFZI61D3O/EyOjKJbYaTsC7Y816+fBNi0PXaygeUk0
	HWB9foeOEYGaJIbXycCazg8HpOXTmhME12so2zFczpSRXUfC4yWCUkcZMgnRr+GjDI4lpjKHXkU
	kXaAVKOo7e0xq6961KO/bfy+1oFoGVY6H4yDCIj/wFut+K1IaViADpvaStRNnPei7aRg/mguchr
	gWigd0gMnelwErCZHb22/5J1rvV6jRBRk2kGheG
X-Received: by 2002:a05:6102:5087:b0:7bc:a347:2058 with SMTP id ada2fe7eead31-7ca38917256mr23051137.2.1791321718012;
        Tue, 06 Oct 2026 14:21:58 -0700 (PDT)
Received: from hitalo (190-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.190])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98e399296casm512258241.0.2026.10.06.14.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 14:21:57 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	michael.bommarito@gmail.com,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH] Bluetooth: Add missing newline to bt_dev_{err,warn}_ratelimited()
Date: Tue,  6 Oct 2026 17:21:42 -0400
Message-ID: <20261006212142.2168838-1-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bt_dev_err_ratelimited() and bt_dev_warn_ratelimited() pass the format
string to bt_err_ratelimited()/bt_warn_ratelimited() without appending
a newline, unlike bt_dev_err() and bt_dev_warn(), which go through
BT_ERR()/BT_WARN() and add one. Only 2 of the 22 in-tree callers (both
in virtio_bt) put the newline in their own format string.

A printk record without a trailing newline is stored with prb_commit()
instead of prb_final_commit(), and readers of the log buffer (/dev/kmsg,
syslog) do not see it until it is finalized, which only happens when the
next record is reserved. These messages therefore stay invisible until
some unrelated message is printed, and journald, which timestamps a
record when it reads it, logs them with the time of that later message.

This was observed with a MediaTek MT7921 controller (USB 04ca:3802):
when an eSCO link is closed, the host still receives a few SCO packets
for the handle after Disconnection Complete, so hci_scodata_packet()
logs "SCO packet for unknown connection handle". Comparing the record's
kernel timestamp (_SOURCE_MONOTONIC_TIMESTAMP) with the time journald
received it, over one capture:

  emitted       logged        delay
  15:36:52.896  15:37:00.214    7.3 s
  15:37:03.410  15:39:05.574  122.2 s
  15:39:05.574  15:39:12.506    6.9 s
  15:39:19.791  15:40:54.109   94.3 s
  15:41:22.021  15:41:24.647    2.6 s

Each message showed up together with the next kernel message; the 94 s
one looked as if it had been logged in the middle of a later, healthy
eSCO connection.

bt_dev_err_ratelimited() lost its newline in commit 657cc646475b
("Bluetooth: Remove usage of BT_ERR_RATELIMITED macro"), which replaced
BT_ERR_RATELIMITED(), the variant that appended "\n", with a direct call
to bt_err_ratelimited(). bt_dev_warn_ratelimited() never had one.

Append the newline in both macros, as BT_ERR() and BT_WARN() do, and
drop it from the two virtio_bt format strings so that their messages do
not gain an empty line.

Fixes: 36278a5d4d35 ("Bluetooth: Adding a bt_dev_warn_ratelimited macro.")
Fixes: 657cc646475b ("Bluetooth: Remove usage of BT_ERR_RATELIMITED macro")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Hitalo Souza <enghitalo@gmail.com>
---
Testing:

- Booted bluetooth-next (base c85976511aa9) with and without this patch
  in QEMU/KVM (x86_64 defconfig + kvm_guest.config, BT=y, BT_HCIVHCI=y).
  A small userspace program emulates a BR/EDR controller over hci_vhci,
  brings it up with HCIDEVUP and injects one SCO packet for handle
  0x0123, which has no connection, so hci_scodata_packet() logs through
  bt_dev_err_ratelimited(). /dev/kmsg is then read 1 s and 10 s later,
  and once more after writing another record to /dev/kmsg:

                         without patch   with patch
    after 1 s            not visible     visible
    after 10 s           not visible     visible
    after next printk    visible         visible

  Without the patch the record (seq 411, 5.730471) only became readable
  together with the next one (seq 412, 15.733219).

- Same result on 7.1.13 (Manjaro) on real hardware, with a throwaway
  module that calls bt_dev_err_ratelimited(NULL, ...) and the same macro
  with "\n" appended.

- GCC 16.2.1, W=1, net/bluetooth/ and drivers/bluetooth/: x86_64
  defconfig + BT, BT_HCIBTUSB{,_MTK,_QCOM}, BT_VIRTIO; x86_64
  allmodconfig (WERROR=y); i386 defconfig + the same options. No
  warnings (the x86_64 defconfig build was also clean without the
  patch). allnoconfig vmlinux builds (Bluetooth is off there; two
  unrelated W=1 warnings in arch/x86/mm/pgtable.c and
  fs/proc/proc_sysctl.c). Checked in the objects that all 22 format
  strings end with exactly one newline.

- LLVM 22.1.8 (LLVM=1), W=1, same directories and options: arm64
  defconfig, arm multi_v7_defconfig, riscv defconfig and powerpc
  ppc64_defconfig (big-endian). No warnings.

- sparse v0.6.5-rc1 on the same directories: the same 16 reports before
  and after, none on the lines touched here.

The change, this changelog and the test harness were prepared with an
AI assistant (Claude, see Assisted-by) while debugging HFP problems with
an MT7921 adapter: it noticed the delayed log lines by comparing
journald's receive time with the kernel timestamps, traced them to the
missing newline, wrote the patch and the reproducers and ran the checks
above.

 drivers/bluetooth/virtio_bt.c     | 4 ++--
 include/net/bluetooth/bluetooth.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 8c55b538d..638140406 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -228,7 +228,7 @@ static void virtbt_rx_handle(struct virtio_bluetooth *vbt, struct sk_buff *skb)
 
 	if (skb->len < min_hdr) {
 		bt_dev_err_ratelimited(vbt->hdev,
-				       "rx pkt_type 0x%02x payload %u < hdr %zu\n",
+				       "rx pkt_type 0x%02x payload %u < hdr %zu",
 				       pkt_type, skb->len, min_hdr);
 		kfree_skb(skb);
 		return;
@@ -251,7 +251,7 @@ static void virtbt_rx_work(struct work_struct *work)
 
 	if (!len || len > VIRTBT_RX_BUF_SIZE) {
 		bt_dev_err_ratelimited(vbt->hdev,
-				       "rx reply len %u outside [1, %u]\n",
+				       "rx reply len %u outside [1, %u]",
 				       len, VIRTBT_RX_BUF_SIZE);
 		kfree_skb(skb);
 	} else {
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index b624da502..cd9189244 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -296,9 +296,9 @@ void bt_err_ratelimited(const char *fmt, ...);
 	BT_DBG("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
 
 #define bt_dev_warn_ratelimited(hdev, fmt, ...)			\
-	bt_warn_ratelimited("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
+	bt_warn_ratelimited("%s: " fmt "\n", bt_dev_name(hdev), ##__VA_ARGS__)
 #define bt_dev_err_ratelimited(hdev, fmt, ...)			\
-	bt_err_ratelimited("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
+	bt_err_ratelimited("%s: " fmt "\n", bt_dev_name(hdev), ##__VA_ARGS__)
 
 /* Connection and socket states */
 enum bt_sock_state {

base-commit: c85976511aa95b5ba68b57b0b3c87c67f3cedcce
-- 
2.55.0

