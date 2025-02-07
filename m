Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734612E1CD;
	Fri,  7 Feb 2025 03:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738900554; cv=none; b=EK/hjP0PDW8ivQV8pqH0ww+1SiSQ5y6dDuGDx8U6IuDj7hqFh34V8ju8AoACy6Ynm0YIxIJCyU4BpFo9Bi2lYDQ/3xihdSsexoIbbgbG5YoZBYFK+YRJDuHTwOM5JpmG1nnhrwWoCqFYxcr8R9W62V+TV/y2Ekw80e1eSqiNnpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738900554; c=relaxed/simple;
	bh=NZLgomO4HbP3Vf4e8zuuTFk2koTjs0AyHNzO8h1NA+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EY0HIWKciRN3pjAxaG2nKHyCdDxbBCZoguo62ilyCiFijmNrfvZ3wWvZxswVpPbzTsH6DOtdTaT32oMbSRQ6dTpNxGBq+F/Dv4GucoPl5nOJDv9NZlNERjqQvZ3ADK6CmMLRZvE/+cU4az/nL+h/zJc0bSr6Vxw5zf+k43U3ee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5173aubU029396;
	Thu, 6 Feb 2025 19:55:33 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44hm0pwynn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 06 Feb 2025 19:55:33 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 6 Feb 2025 19:55:32 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 6 Feb 2025 19:55:30 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+b9cff96f1ca33356d180@syzkaller.appspotmail.com>
CC: <avkrasnov@salutedevices.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <luiz.dentz@gmail.com>,
        <luiz.von.dentz@intel.com>, <marcel@holtmann.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] Bluetooth: hci_ldisc: Clear and shrink the ready bit
Date: Fri, 7 Feb 2025 11:55:29 +0800
Message-ID: <20250207035529.2127772-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67a4b4c3.050a0220.264083.0006.GAE@google.com>
References: <67a4b4c3.050a0220.264083.0006.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PqlpbxM3 c=1 sm=1 tr=0 ts=67a58435 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=T2h4t0Lz3GQA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=AAl31e4ZCAWL5dhCsM8A:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: ZXTHRZPORhqX_WoCdpTNi4Yj8qM4KKHA
X-Proofpoint-GUID: ZXTHRZPORhqX_WoCdpTNi4Yj8qM4KKHA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_02,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=909 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2501170000
 definitions=main-2502070028

syzbot reported a null ptr deref in qca_close. [1]

When registering hci fails, clear the hci uart protocal ready bit.
And shrink the ready bit window.

[1]
KASAN: null-ptr-deref in range [0x0000000000000158-0x000000000000015f]
CPU: 1 UID: 0 PID: 5837 Comm: syz-executor233 Not tainted 6.14.0-rc1-next-20250204-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:serial_clock_vote drivers/bluetooth/hci_qca.c:301 [inline]
RIP: 0010:qca_close+0x72/0x2e0 drivers/bluetooth/hci_qca.c:723
Code: 64 af f6 f8 48 89 2c 24 42 80 7c 2d 00 00 74 08 4c 89 f7 e8 20 28 5d f9 4d 8b 26 49 8d bc 24 5a 01 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 4c 89 eb 0f 85 de 01 00 00 45 0f b6 ac 24 5a
RSP: 0018:ffffc90003cb79f0 EFLAGS: 00010206
RAX: 000000000000002b RBX: ffff888012bb2400 RCX: ffff88802e269e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000015a
RBP: 1ffff110025764b7 R08: ffffffff8187d8b3 R09: 1ffffffff2860723
R10: dffffc0000000000 R11: ffffffff88c8a130 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888012bb25b8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbb3e1c10d0 CR3: 000000000e738000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hci_uart_tty_close+0x205/0x290 drivers/bluetooth/hci_ldisc.c:557
 tty_ldisc_kill+0xa3/0x1a0 drivers/tty/tty_ldisc.c:613
 tty_ldisc_release+0x1a1/0x200 drivers/tty/tty_ldisc.c:781
 tty_release_struct+0x2b/0xe0 drivers/tty/tty_io.c:1690
 tty_release+0xd06/0x12c0 drivers/tty/tty_io.c:1861
 __fput+0x3e9/0x9f0 fs/file_table.c:448
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2a/0x28e0 kernel/exit.c:938
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1096
 x64_sys_call+0x26a8/0x26b0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: c411c62cc133 ("Bluetooth: hci_uart: fix race during initialization")
Reported-by: syzbot+b9cff96f1ca33356d180@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b9cff96f1ca33356d180
Tested-by: syzbot+b9cff96f1ca33356d180@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 drivers/bluetooth/hci_ldisc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index b955dc96b483..d5b97ff59330 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -683,8 +683,10 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	if (test_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
 		return 0;
 
+	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
+		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		hu->proto->close(hu);
 		hu->hdev = NULL;
 		hci_free_dev(hdev);
@@ -707,8 +709,6 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	hu->proto = p;
 
-	set_bit(HCI_UART_PROTO_READY, &hu->flags);
-
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		return err;
-- 
2.43.0

