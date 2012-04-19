Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] Bluetooth: Fix crash on SCO socket shutdown
Date: Thu, 19 Apr 2012 16:12:29 +0200
Message-ID: <1334844749-13441-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1334844749-13441-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <y>
 <1334844749-13441-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Crash occurs in following scenario

1. First SCO socket and SCO link is created
2. Shutdown and release first SCO socket
3. Create second SCO socket before timer for conn->disc_work fired.
Meaning SCO link is still up.
4. Shutdown and release second SCO socket -> CRASH

kernel: [ 184.351753]
kernel: [ 184.353547] Pid: 1610, comm: bluetoothd Tainted: G C 3.3.0-rc6+ #4 Dell Inc. Latitude E6420/0K0DNP
kernel: [ 184.355305] RIP: 0010:[<ffffffffa0451ff5>] [<ffffffffa0451ff5>] __sco_sock_close+0xe5/0x1e0 [bluetooth]
kernel: [ 184.357030] RSP: 0018:ffff880204c83f08 EFLAGS: 00010292
kernel: [ 184.358742] RAX: ffff8801a9fe4d80 RBX: ffff880225014800 RCX: 00000000ffff8f1d
kernel: [ 184.360399] RDX: ffff880221d95130 RSI: 0000000000000286 RDI: 0000000000000286
kernel: [ 184.362134] RBP: ffff880204c83f28 R08: 0000000000000000 R09: 0000000000000000
kernel: [ 184.363845] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
kernel: [ 184.365598] R13: 00007f20f6201e10 R14: 00007f20f620ab40 R15: 00007f20f61e3a00
kernel: [ 184.367274] FS: 00007f20f4b97720(0000) GS:ffff88022dc40000(0000) knlGS:0000000000000000
kernel: [ 184.368934] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: [ 184.370611] CR2: 0000000000000010 CR3: 0000000204954000 CR4: 00000000000406e0
kernel: [ 184.372059] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kernel: [ 184.373456] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
kernel: [ 184.374833] Process bluetoothd (pid: 1610, threadinfo ffff880204c82000, task ffff880205f52de0)
kernel: [ 184.376202] Stack:
kernel: [ 184.377590] ffff880204c83f28 ffff880225014800 0000000000000000 00007f20f6201e10
kernel: [ 184.378961] ffff880204c83f48 ffffffffa0452169 0000000000000002 ffff8801bb1a3c00
kernel: [ 184.380430] ffff880204c83f78 ffffffff815474bd 00007fffd79ca6a0 0000000000000000
kernel: [ 184.381895] Call Trace:
kernel: [ 184.383370] [<ffffffffa0452169>] sco_sock_shutdown+0x79/0xd0 [bluetooth]
kernel: [ 184.384828] [<ffffffff815474bd>] sys_shutdown+0x7d/0x90
kernel: [ 184.386253] [<ffffffff8166bba9>] system_call_fastpath+0x16/0x1b
kernel: [ 184.387672] Code: 1f 80 00 00 00 00 48 83 bb c0 02 00 00 00 74 86 c6 43 0e 08 be f4 01 00 00 48 89 df e8 b5 e9 ff ff 48 8b 83 c0 02 00 00 4c 8b 20 <f0> 41 ff 4c 24 10 0f 94 c0 84 c0 7
kernel: [ 184.390653] RIP [<ffffffffa0451ff5>] __sco_sock_close+0xe5/0x1e0 [bluetooth]
kernel: [ 184.392239] RSP <ffff880204c83f08>
kernel: [ 184.393777] CR2: 0000000000000010

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 net/bluetooth/sco.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d20d719..8b0a3bb 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -99,8 +99,10 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 	struct hci_dev *hdev = hcon->hdev;
 	struct sco_conn *conn = hcon->sco_data;
 
-	if (conn)
+	if (conn) {
+		conn->hcon = hcon;
 		return conn;
+	}
 
 	conn = kzalloc(sizeof(struct sco_conn), GFP_ATOMIC);
 	if (!conn)
-- 
1.7.9.4

