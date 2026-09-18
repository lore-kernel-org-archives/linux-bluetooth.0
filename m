Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4EB20D4FF;
	Fri, 18 Sep 2026 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695315; cv=none; b=EVNDvjY3u9lCX1P0Zjted3o45Gv85lw3AXnIr2/ju1Ra0DjQHZ417+31wbg9Olgg1uRj6wyRjbGYLytfm7qMqoGH1rmjH+zGUzqn4zQkmZ6iA7Do4/3MBsD6aonnDbeDaPbCzXBtAFvXS4wMgzwE/R8OCAZqU2GcsDP8v36mFnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695315; c=relaxed/simple;
	bh=OO3p7AUFJCIXL+2eKySVcyAHYE5+GVryUB1jkc9i1LI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GWFnnvG0AMyV6yAXRxtoYRmXujyWvTXY0CoOqYoesoO9sxGcUhOHs0lKmDFdPlJMsOwVLFIi26apNUCcClW5+1+BLxP1iwbf1gC/wyx1+9YuYL+PlWhXnPGcEgr5j2NZOxPWI9cCQfZ1/4opMcW8uGEbf9YaeJKSpIKc8hFu7oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABnOe1GlaxqBv1ECA--.11730S2;
	Fri, 18 Sep 2026 09:35:03 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Xin Chen <xin.chen2@oss.qualcomm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH] Bluetooth: hci_core: Fix leak of request command on tx timeout
Date: Fri, 18 Sep 2026 01:35:01 +0000
Message-Id: <20260918013501.1851186-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnOe1GlaxqBv1ECA--.11730S2
X-Coremail-Antispam: 1UD129KBjvAXoWfXr48ZrWxtrW5Gw48Kw45Wrg_yoW5Ww4DCo
	W5J340qF48GryxKF4rJ3Za9r15Gr1xCa4fArnY9F45urn3X3W3JrnFyayfCa4xJa15KF1x
	Gw17tr1Sqa1Fqrn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYy7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWx
	JVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	W8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxV
	WxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CE
	Vc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUpbyAUUUUU=
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

When a command transmission times out, hci_cmd_timeout() calls
hci_cmd_sync_cancel_sync() to mark the pending request as
HCI_REQ_CANCELED and wake up the waiter. However, nothing releases
the request command skb in this path: hci_cmd_sync_complete(), the
only place which frees hdev->req_skb during normal operation, bails
out early because the request status is no longer HCI_REQ_PEND.
Since commit f5afdff569a09 ("Bluetooth: hci_core: use skb_get()
instead of skb_clone() for req_skb"), hdev->req_skb holds an extra
reference to the same skb object as hdev->sent_cmd, so both pointers
keep the buffer alive and it leaks unless the device is closed,
which a fuzzer never does. This is the leak reported by kmemleak as
"memory leak in __hci_cmd_sync_sk".

Free the request command and the last sent command on the timeout
path and clear HCI_CMD_PENDING, mirroring the cleanup done by
hci_dev_close_sync(). This is safe because the waiter has already
been woken up and later command completion events tolerate a NULL
sent_cmd/req_skb via the hci_cmd_data() NULL checks.

Fixes: 63298d6e752fc ("Bluetooth: hci_core: Cancel request on command timeout")
Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
---
 net/bluetooth/hci_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d7355c73f93e8..d7a527d91d565 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1433,6 +1433,18 @@ static void hci_cmd_timeout(struct work_struct *work)
 		bt_dev_err(hdev, "command 0x%4.4x tx timeout", opcode);
 
 		hci_cmd_sync_cancel_sync(hdev, ETIMEDOUT);
+
+		/* The request has been canceled so hci_cmd_sync_complete()
+		 * will no longer release the request command. Free it along
+		 * with the last sent command, which shares the same data
+		 * buffer, otherwise they leak when the device stays up.
+		 */
+		kfree_skb(hdev->sent_cmd);
+		hdev->sent_cmd = NULL;
+
+		kfree_skb(hdev->req_skb);
+		hdev->req_skb = NULL;
+		hci_dev_clear_flag(hdev, HCI_CMD_PENDING);
 	} else {
 		bt_dev_err(hdev, "command tx timeout");
 	}
-- 
2.34.1


-- 
Below is the crash report:
BUG: memory leak
unreferenced object 0xffff88800b4b3000 (size 240):
  comm "syz.0.963", pid 18664, jiffies 4295035394
  hex dump (first 32 bytes):
    00 26 94 0c 80 88 ff ff 80 e8 fe 08 81 88 ff ff  .&..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc c3a6fa22):
    kmemleak_alloc_recursive home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4550 [inline]
    slab_alloc_node home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4874 [inline]
    kmem_cache_alloc_node_noprof+0x267/0x4c0 home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4926
    __alloc_skb+0x236/0x500 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/core/skbuff.c:702
    alloc_skb home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/skbuff.h:1385 [inline]
    bt_skb_alloc home/zzzrrll/tmp/kf_src/linux-7.1.13/include/net/bluetooth/bluetooth.h:520 [inline]
    hci_cmd_sync_alloc+0x30/0x120 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:58
    hci_cmd_sync_add home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:99 [inline]
    __hci_cmd_sync_sk+0x7b/0x510 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:168
    __hci_cmd_sync_status_sk home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:263 [inline]
    __hci_cmd_sync_status home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:287 [inline]
    hci_inquiry_sync+0xe5/0x190 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:6120
    hci_inquiry+0x277/0x3f0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_core.c:372
    sock_do_ioctl+0x7c/0x1e0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/socket.c:1302
    sock_ioctl+0x423/0x5d0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/socket.c:1423
    vfs_ioctl home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:51 [inline]
    __do_sys_ioctl home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:597 [inline]
    __se_sys_ioctl+0xbb/0x130 home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:583
    do_syscall_x64 home/zzzrrll/tmp/kf_src/linux-7.1.13/arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0x187/0x520 home/zzzrrll/tmp/kf_src/linux-7.1.13/arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888015014b00 (size 704):
  comm "syz.0.963", pid 18664, jiffies 4295035394
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 01 04 05 33 8b 9e 13 05  ...........3....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 62ed5507):
    kmemleak_alloc_recursive home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4550 [inline]
    slab_alloc_node home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4874 [inline]
    kmem_cache_alloc_node_noprof+0x267/0x4c0 home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4926
    kmalloc_reserve+0x69/0x120 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/core/skbuff.c:613
    __alloc_skb+0x33c/0x500 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/core/skbuff.c:713
    alloc_skb home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/skbuff.h:1385 [inline]
    bt_skb_alloc home/zzzrrll/tmp/kf_src/linux-7.1.13/include/net/bluetooth/bluetooth.h:520 [inline]
    hci_cmd_sync_alloc+0x30/0x120 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:58
    hci_cmd_sync_add home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:99 [inline]
    __hci_cmd_sync_sk+0x7b/0x510 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:168
    __hci_cmd_sync_status_sk home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:263 [inline]
    __hci_cmd_sync_status home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:287 [inline]
    hci_inquiry_sync+0xe5/0x190 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:6120
    hci_inquiry+0x277/0x3f0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_core.c:372
    sock_do_ioctl+0x7c/0x1e0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/socket.c:1302
    sock_ioctl+0x423/0x5d0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/socket.c:1423
    vfs_ioctl home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:51 [inline]
    __do_sys_ioctl home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:597 [inline]
    __se_sys_ioctl+0xbb/0x130 home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:583
    do_syscall_x64 home/zzzrrll/tmp/kf_src/linux-7.1.13/arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0x187/0x520 home/zzzrrll/tmp/kf_src/linux-7.1.13/arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88800c942600 (size 240):
  comm "syz.3.1200", pid 20339, jiffies 4295059978
  hex dump (first 32 bytes):
    00 25 4b 0b 80 88 ff ff 00 30 4b 0b 80 88 ff ff  .%K......0K.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc d3272932):
    kmemleak_alloc_recursive home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4550 [inline]
    slab_alloc_node home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4874 [inline]
    kmem_cache_alloc_node_noprof+0x267/0x4c0 home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4926
    __alloc_skb+0x236/0x500 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/core/skbuff.c:702
    alloc_skb home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/skbuff.h:1385 [inline]
    bt_skb_alloc home/zzzrrll/tmp/kf_src/linux-7.1.13/include/net/bluetooth/bluetooth.h:520 [inline]
    hci_cmd_sync_alloc+0x30/0x120 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:58
    hci_cmd_sync_add home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:99 [inline]
    __hci_cmd_sync_sk+0x7b/0x510 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:168
    __hci_cmd_sync_status_sk home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:263 [inline]
    __hci_cmd_sync_status home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:287 [inline]
    hci_cmd_sync_status+0x4f/0xe0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:298
    hci_dev_cmd+0x2ca/0x420 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_core.c:699
    sock_do_ioctl+0x7c/0x1e0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/socket.c:1302
    sock_ioctl+0x423/0x5d0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/socket.c:1423
    vfs_ioctl home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:51 [inline]
    __do_sys_ioctl home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:597 [inline]
    __se_sys_ioctl+0xbb/0x130 home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:583
    do_syscall_x64 home/zzzrrll/tmp/kf_src/linux-7.1.13/arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0x187/0x520 home/zzzrrll/tmp/kf_src/linux-7.1.13/arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88800ca6ac00 (size 704):
  comm "syz.3.1200", pid 20339, jiffies 4295059978
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1a 0c 01 04 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a1b85eb5):
    kmemleak_alloc_recursive home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4550 [inline]
    slab_alloc_node home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4874 [inline]
    kmem_cache_alloc_node_noprof+0x267/0x4c0 home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4926
    kmalloc_reserve+0x69/0x120 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/core/skbuff.c:613
    __alloc_skb+0x33c/0x500 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/core/skbuff.c:713
    alloc_skb home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/skbuff.h:1385 [inline]
    bt_skb_alloc home/zzzrrll/tmp/kf_src/linux-7.1.13/include/net/bluetooth/bluetooth.h:520 [inline]
    hci_cmd_sync_alloc+0x30/0x120 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:58
    hci_cmd_sync_add home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:99 [inline]
    __hci_cmd_sync_sk+0x7b/0x510 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:168
    __hci_cmd_sync_status_sk home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:263 [inline]
    __hci_cmd_sync_status home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:287 [inline]
    hci_cmd_sync_status+0x4f/0xe0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:298
    hci_dev_cmd+0x2ca/0x420 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_core.c:699
    sock_do_ioctl+0x7c/0x1e0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/socket.c:1302
    sock_ioctl+0x423/0x5d0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/socket.c:1423
    vfs_ioctl home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:51 [inline]
    __do_sys_ioctl home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:597 [inline]
    __se_sys_ioctl+0xbb/0x130 home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:583
    do_syscall_x64 home/zzzrrll/tmp/kf_src/linux-7.1.13/arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0x187/0x520 home/zzzrrll/tmp/kf_src/linux-7.1.13/arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88800b4b2500 (size 240):
  comm "syz.0.1229", pid 20584, jiffies 4295063225
  hex dump (first 32 bytes):
    00 2f 94 0c 80 88 ff ff 00 26 94 0c 80 88 ff ff  ./.......&......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 1152a240):
    kmemleak_alloc_recursive home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4550 [inline]
    slab_alloc_node home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4874 [inline]
    kmem_cache_alloc_node_noprof+0x267/0x4c0 home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4926
    __alloc_skb+0x236/0x500 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/core/skbuff.c:702
    alloc_skb home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/skbuff.h:1385 [inline]
    bt_skb_alloc home/zzzrrll/tmp/kf_src/linux-7.1.13/include/net/bluetooth/bluetooth.h:520 [inline]
    hci_cmd_sync_alloc+0x30/0x120 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:58
    hci_cmd_sync_add home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:99 [inline]
    __hci_cmd_sync_sk+0x7b/0x510 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:168
    __hci_cmd_sync_status_sk home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:263 [inline]
    __hci_cmd_sync_status home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:287 [inline]
    hci_cmd_sync_status+0x4f/0xe0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:298
    hci_dev_cmd+0x2ca/0x420 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_core.c:699
    sock_do_ioctl+0x7c/0x1e0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/socket.c:1302
    sock_ioctl+0x423/0x5d0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/socket.c:1423
    vfs_ioctl home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:51 [inline]
    __do_sys_ioctl home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:597 [inline]
    __se_sys_ioctl+0xbb/0x130 home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:583
    do_syscall_x64 home/zzzrrll/tmp/kf_src/linux-7.1.13/arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0x187/0x520 home/zzzrrll/tmp/kf_src/linux-7.1.13/arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888015017180 (size 704):
  comm "syz.0.1229", pid 20584, jiffies 4295063225
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1a 0c 01 04 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a1b85eb5):
    kmemleak_alloc_recursive home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4550 [inline]
    slab_alloc_node home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4874 [inline]
    kmem_cache_alloc_node_noprof+0x267/0x4c0 home/zzzrrll/tmp/kf_src/linux-7.1.13/mm/slub.c:4926
    kmalloc_reserve+0x69/0x120 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/core/skbuff.c:613
    __alloc_skb+0x33c/0x500 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/core/skbuff.c:713
    alloc_skb home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/skbuff.h:1385 [inline]
    bt_skb_alloc home/zzzrrll/tmp/kf_src/linux-7.1.13/include/net/bluetooth/bluetooth.h:520 [inline]
    hci_cmd_sync_alloc+0x30/0x120 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:58
    hci_cmd_sync_add home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:99 [inline]
    __hci_cmd_sync_sk+0x7b/0x510 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:168
    __hci_cmd_sync_status_sk home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:263 [inline]
    __hci_cmd_sync_status home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:287 [inline]
    hci_cmd_sync_status+0x4f/0xe0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_sync.c:298
    hci_dev_cmd+0x2ca/0x420 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/bluetooth/hci_core.c:699
    sock_do_ioctl+0x7c/0x1e0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/socket.c:1302
    sock_ioctl+0x423/0x5d0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/socket.c:1423
    vfs_ioctl home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:51 [inline]
    __do_sys_ioctl home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:597 [inline]
    __se_sys_ioctl+0xbb/0x130 home/zzzrrll/tmp/kf_src/linux-7.1.13/fs/ioctl.c:583
    do_syscall_x64 home/zzzrrll/tmp/kf_src/linux-7.1.13/arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0x187/0x520 home/zzzrrll/tmp/kf_src/linux-7.1.13/arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f


<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f
BUG: memory leak
unreferenced object 0xffff888015014b00 (size 704):
  comm "syz.0.963", pid 18664, jiffies 4295035394
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 01 04 05 33 8b 9e 13 05  ...........3....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 62ed5507):
    kmem_cache_alloc_node_noprof+0x267/0x4c0
    kmalloc_reserve+0x69/0x120
    __alloc_skb+0x33c/0x500
    hci_cmd_sync_alloc+0x30/0x120
    __hci_cmd_sync_sk+0x7b/0x510
    hci_inquiry_sync+0xe5/0x190
    hci_inquiry+0x277/0x3f0
    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88800c942600 (size 240):
  comm "syz.3.1200", pid 20339, jiffies 4295059978
  hex dump (first 32 bytes):
    00 25 4b 0b 80 88 ff ff 00 30 4b 0b 80 88 ff ff  .%K......0K.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc d3272932):
    kmem_cache_alloc_node_noprof+0x267/0x4c0
    __alloc_skb+0x236/0x500
    hci_cmd_sync_alloc+0x30/0x120
    __hci_cmd_sync_sk+0x7b/0x510
    hci_cmd_sync_status+0x4f/0xe0
    hci_dev_cmd+0x2ca/0x420
    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88800ca6ac00 (size 704):
  comm "syz.3.1200", pid 20339, jiffies 4295059978
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1a 0c 01 04 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a1b85eb5):
    kmem_cache_alloc_node_noprof+0x267/0x4c0
    kmalloc_reserve+0x69/0x120
    __alloc_skb+0x33c/0x500
    hci_cmd_sync_alloc+0x30/0x120
    __hci_cmd_sync_sk+0x7b/0x510
    hci_cmd_sync_status+0x4f/0xe0
    hci_dev_cmd+0x2ca/0x420
    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88800b4b2500 (size 240):
  comm "syz.0.1229", pid 20584, jiffies 4295063225
  hex dump (first 32 bytes):
    00 2f 94 0c 80 88 ff ff 00 26 94 0c 80 88 ff ff  ./.......&......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 1152a240):
    kmem_cache_alloc_node_noprof+0x267/0x4c0
    __alloc_skb+0x236/0x500
    hci_cmd_sync_alloc+0x30/0x120
    __hci_cmd_sync_sk+0x7b/0x510
    hci_cmd_sync_status+0x4f/0xe0
    hci_dev_cmd+0x2ca/0x420
    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888015017180 (size 704):
  comm "syz.0.1229", pid 20584, jiffies 4295063225
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1a 0c 01 04 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a1b85eb5):
    kmem_cache_alloc_node_noprof+0x267/0x4c0
    kmalloc_reserve+0x69/0x120
    __alloc_skb+0x33c/0x500
    hci_cmd_sync_alloc+0x30/0x120
    __hci_cmd_sync_sk+0x7b/0x510
    hci_cmd_sync_status+0x4f/0xe0
    hci_dev_cmd+0x2ca/0x420
    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f


<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f
BUG: memory leak
unreferenced object 0xffff88800c942600 (size 240):
  comm "syz.3.1200", pid 20339, jiffies 4295059978
  hex dump (first 32 bytes):
    00 25 4b 0b 80 88 ff ff 00 30 4b 0b 80 88 ff ff  .%K......0K.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc d3272932):
    kmem_cache_alloc_node_noprof+0x267/0x4c0
    __alloc_skb+0x236/0x500
    hci_cmd_sync_alloc+0x30/0x120
    __hci_cmd_sync_sk+0x7b/0x510
    hci_cmd_sync_status+0x4f/0xe0
    hci_dev_cmd+0x2ca/0x420
    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88800ca6ac00 (size 704):
  comm "syz.3.1200", pid 20339, jiffies 4295059978
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1a 0c 01 04 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a1b85eb5):
    kmem_cache_alloc_node_noprof+0x267/0x4c0
    kmalloc_reserve+0x69/0x120
    __alloc_skb+0x33c/0x500
    hci_cmd_sync_alloc+0x30/0x120
    __hci_cmd_sync_sk+0x7b/0x510
    hci_cmd_sync_status+0x4f/0xe0
    hci_dev_cmd+0x2ca/0x420
    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88800b4b2500 (size 240):
  comm "syz.0.1229", pid 20584, jiffies 4295063225
  hex dump (first 32 bytes):
    00 2f 94 0c 80 88 ff ff 00 26 94 0c 80 88 ff ff  ./.......&......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 1152a240):
    kmem_cache_alloc_node_noprof+0x267/0x4c0
    __alloc_skb+0x236/0x500
    hci_cmd_sync_alloc+0x30/0x120
    __hci_cmd_sync_sk+0x7b/0x510
    hci_cmd_sync_status+0x4f/0xe0
    hci_dev_cmd+0x2ca/0x420
    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888015017180 (size 704):
  comm "syz.0.1229", pid 20584, jiffies 4295063225
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1a 0c 01 04 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a1b85eb5):
    kmem_cache_alloc_node_noprof+0x267/0x4c0
    kmalloc_reserve+0x69/0x120
    __alloc_skb+0x33c/0x500
    hci_cmd_sync_alloc+0x30/0x120
    __hci_cmd_sync_sk+0x7b/0x510
    hci_cmd_sync_status+0x4f/0xe0
    hci_dev_cmd+0x2ca/0x420
    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f


<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f
BUG: memory leak
unreferenced object 0xffff88800ca6ac00 (size 704):
  comm "syz.3.1200", pid 20339, jiffies 4295059978
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1a 0c 01 04 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a1b85eb5):
    kmem_cache_alloc_node_noprof+0x267/0x4c0
    kmalloc_reserve+0x69/0x120
    __alloc_skb+0x33c/0x500
    hci_cmd_sync_alloc+0x30/0x120
    __hci_cmd_sync_sk+0x7b/0x510
    hci_cmd_sync_status+0x4f/0xe0
    hci_dev_cmd+0x2ca/0x420
    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88800b4b2500 (size 240):
  comm "syz.0.1229", pid 20584, jiffies 4295063225
  hex dump (first 32 bytes):
    00 2f 94 0c 80 88 ff ff 00 26 94 0c 80 88 ff ff  ./.......&......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 1152a240):
    kmem_cache_alloc_node_noprof+0x267/0x4c0
    __alloc_skb+0x236/0x500
    hci_cmd_sync_alloc+0x30/0x120
    __hci_cmd_sync_sk+0x7b/0x510
    hci_cmd_sync_status+0x4f/0xe0
    hci_dev_cmd+0x2ca/0x420
    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888015017180 (size 704):
  comm "syz.0.1229", pid 20584, jiffies 4295063225
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1a 0c 01 04 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a1b85eb5):
    kmem_cache_alloc_node_noprof+0x267/0x4c0
    kmalloc_reserve+0x69/0x120
    __alloc_skb+0x33c/0x500
    hci_cmd_sync_alloc+0x30/0x120
    __hci_cmd_sync_sk+0x7b/0x510
    hci_cmd_sync_status+0x4f/0xe0
    hci_dev_cmd+0x2ca/0x420
    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f


<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f
BUG: memory leak
unreferenced object 0xffff88800b4b2500 (size 240):
  comm "syz.0.1229", pid 20584, jiffies 4295063225
  hex dump (first 32 bytes):
    00 2f 94 0c 80 88 ff ff 00 26 94 0c 80 88 ff ff  ./.......&......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 1152a240):
    kmem_cache_alloc_node_noprof+0x267/0x4c0
    __alloc_skb+0x236/0x500
    hci_cmd_sync_alloc+0x30/0x120
    __hci_cmd_sync_sk+0x7b/0x510
    hci_cmd_sync_status+0x4f/0xe0
    hci_dev_cmd+0x2ca/0x420
    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888015017180 (size 704):
  comm "syz.0.1229", pid 20584, jiffies 4295063225
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1a 0c 01 04 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a1b85eb5):
    kmem_cache_alloc_node_noprof+0x267/0x4c0
    kmalloc_reserve+0x69/0x120
    __alloc_skb+0x33c/0x500
    hci_cmd_sync_alloc+0x30/0x120
    __hci_cmd_sync_sk+0x7b/0x510
    hci_cmd_sync_status+0x4f/0xe0
    hci_dev_cmd+0x2ca/0x420
    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f


<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f
BUG: memory leak
unreferenced object 0xffff888015017180 (size 704):
  comm "syz.0.1229", pid 20584, jiffies 4295063225
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1a 0c 01 04 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a1b85eb5):
    kmem_cache_alloc_node_noprof+0x267/0x4c0
    kmalloc_reserve+0x69/0x120
    __alloc_skb+0x33c/0x500
    hci_cmd_sync_alloc+0x30/0x120
    __hci_cmd_sync_sk+0x7b/0x510
    hci_cmd_sync_status+0x4f/0xe0
    hci_dev_cmd+0x2ca/0x420
    sock_do_ioctl+0x7c/0x1e0
    sock_ioctl+0x423/0x5d0
    __se_sys_ioctl+0xbb/0x130
    do_syscall_64+0x187/0x520
    entry_SYSCALL_64_after_hwframe+0x77/0x7f


<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

---

