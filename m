Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C42206BD;
	Fri,  7 Feb 2025 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936960; cv=none; b=ZJTgJTXbsa7M2yeQGb6l51RxuhQEg3ljI2C5JeJvfwihpKeLJ7hlv/2otDojCFqEg/cG2CFurgsL1ltjF9IT1ld91pbIbwLQxyXeVRoPz2VhWwr9y4h0gBVxd1CVf5CV6TBPfGpr/5R8bwd+FZuFM2LbpEm3eVkm2f4EwsiFN2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936960; c=relaxed/simple;
	bh=HIIggp/uq9xkSdrU++JDXosmKvgpXWHZlnGO+MgCUUY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwiStqGgjoHNvoXRUX7eb1S5nX3Zsl9tjtXu17RRPgZ8jKJdutB03NFHsX74b22WIHnHvDv5VLL9FmU2FknSXIfRuv/tgNL9YG8dug+xqiL0Ms/pJcfM0GnocWbjW5ZfwMalt4cy47FuZTBaJwje8rre7mXo8EUObYtMAk1nNl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517DQe5T014863;
	Fri, 7 Feb 2025 14:02:21 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44hak8enmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 07 Feb 2025 14:02:21 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Fri, 7 Feb 2025 06:02:19 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Fri, 7 Feb 2025 06:02:17 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+10bd8fe6741eedd2be2e@syzkaller.appspotmail.com>
CC: <eadavis@qq.com>, <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH next] Bluetooth: l2cap: protect conn refcnt under hci dev lock
Date: Fri, 7 Feb 2025 22:02:16 +0800
Message-ID: <20250207140216.3076952-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67a4b4c3.050a0220.264083.0005.GAE@google.com>
References: <67a4b4c3.050a0220.264083.0005.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ecXHf6EH c=1 sm=1 tr=0 ts=67a6126d cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=T2h4t0Lz3GQA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=OQl0BKc0XvGlAwITThUA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: UVJF461PDW67flGQDtia9Sk6A-InyIAB
X-Proofpoint-GUID: UVJF461PDW67flGQDtia9Sk6A-InyIAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=871 priorityscore=1501
 impostorscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2501170000
 definitions=main-2502070107

syzbot reported a corrupted list in hci_chan_del. [1]

Use hci dev lock to protect the reference count of conn to avoid race
conditions on l2cap_sock_shutdown and l2cap_connect_cfm paths.

The get/put actions of conn are unbalanced due to abnormal exit, so remove
the redundant get/put actions of conn in l2cap_recv_acldata().

[1]
kernel BUG at lib/list_debug.c:61!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5896 Comm: syz-executor213 Not tainted 6.14.0-rc1-next-20250204-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:__list_del_entry_valid_or_report+0x12c/0x190 lib/list_debug.c:59
Code: 8c 4c 89 fe 48 89 da e8 32 8c 37 fc 90 0f 0b 48 89 df e8 27 9f 14 fd 48 c7 c7 a0 c0 60 8c 4c 89 fe 48 89 da e8 15 8c 37 fc 90 <0f> 0b 4c 89 e7 e8 0a 9f 14 fd 42 80 3c 2b 00 74 08 4c 89 e7 e8 cb
RSP: 0018:ffffc90003f6f998 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: 01454d423f7fbf00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff819f077c R09: 1ffff920007eded0
R10: dffffc0000000000 R11: fffff520007eded1 R12: dead000000000122
R13: dffffc0000000000 R14: ffff8880352248d8 R15: ffff888021297e00
FS:  00007f7ace6686c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7aceeeb1d0 CR3: 000000003527c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_rcu include/linux/rculist.h:168 [inline]
 hci_chan_del+0x70/0x1b0 net/bluetooth/hci_conn.c:2858
 l2cap_conn_free net/bluetooth/l2cap_core.c:1816 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_conn_put+0x70/0xe0 net/bluetooth/l2cap_core.c:1830
 l2cap_sock_shutdown+0xa8a/0x1020 net/bluetooth/l2cap_sock.c:1377
 l2cap_sock_release+0x79/0x1d0 net/bluetooth/l2cap_sock.c:1416
 __sock_release net/socket.c:642 [inline]
 sock_close+0xbc/0x240 net/socket.c:1393
 __fput+0x3e9/0x9f0 fs/file_table.c:448
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 ptrace_notify+0x2d2/0x380 kernel/signal.c:2522
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc7/0x1d0 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x24a/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-by: syzbot+10bd8fe6741eedd2be2e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=10bd8fe6741eedd2be2e
Tested-by: syzbot+10bd8fe6741eedd2be2e@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 net/bluetooth/l2cap_core.c | 4 ----
 net/bluetooth/l2cap_sock.c | 7 +++++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index adb8c33ac595..503626f70be5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7497,8 +7497,6 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 	if (!conn)
 		conn = l2cap_conn_add(hcon);
 
-	conn = l2cap_conn_hold_unless_zero(conn);
-
 	hci_dev_unlock(hcon->hdev);
 
 	if (!conn)
@@ -7592,8 +7590,6 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		break;
 	}
 
-	l2cap_conn_put(conn);
-
 drop:
 	kfree_skb(skb);
 }
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 46ea0bee2259..2a99394925a5 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1359,10 +1359,12 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 
 	l2cap_chan_lock(chan);
 	conn = chan->conn;
-	if (conn)
+	l2cap_chan_unlock(chan);
+	if (conn) {
+		hci_dev_lock(conn->hcon->hdev);
 		/* prevent conn structure from being freed */
 		l2cap_conn_get(conn);
-	l2cap_chan_unlock(chan);
+	}
 
 	if (conn)
 		/* mutex lock must be taken before l2cap_chan_lock() */
@@ -1375,6 +1377,7 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	if (conn) {
 		mutex_unlock(&conn->chan_lock);
 		l2cap_conn_put(conn);
+		hci_dev_unlock(conn->hcon->hdev);
 	}
 
 	lock_sock(sk);
-- 
2.43.0

