Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83E4A07
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765197656; cv=none; b=AXlA/d/01YbyFo8akGIvxjEIexF5c9xml9+Gt5xi0QFY3N8RdIoRXYMh+3KybxqwM+THcefW2TEmy9h0q6AIi/4dWAltPD8Yt7fm2mgBm0PvYau+Xj5Ru5OYMRGfk4IWO9RfVnzHViic3oN2ItLCoaqOlq+Hz/Co7Jfk1hRR0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765197656; c=relaxed/simple;
	bh=yhe9BvYjxz3aR27ayl4Guih+qpgBVhoMYRj5F5KD5Yc=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=ew24oIBRYKB/pwbJpvuwZvUwwSP9ugDyG9wCl3zDN834B8NzmT+oB01UKQcJzyF3/Cd7KdOJiWX8/NeZtkVjq2gGCxPwDNyLZF1j03ziOCmPI1uGgASWOUqsSnynNdUWE6uVF0eGAxf/Xx9EBC30tMX3ErZeatNb/aO0KwZw2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4dQ1Yk0dN0z1DDQ
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 20:31:22 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4dQ1YZ4Qxfz5TCG9
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 20:31:14 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dQ1YN147Hz6FyC2;
	Mon, 08 Dec 2025 20:31:04 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 5B8CUr9D076502;
	Mon, 8 Dec 2025 20:30:53 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 8 Dec 2025 20:30:56 +0800 (CST)
Date: Mon, 8 Dec 2025 20:30:56 +0800 (CST)
X-Zmail-TransId: 2afa6936c500890-7254e
X-Mailer: Zmail v1.0
Message-ID: <20251208203056891J84Xq6wiMu3r7HXa_mRb3@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>
Cc: <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <chen.junlin@zte.com.cn>,
        <jiang.kun2@zte.com.cn>
Subject: =?UTF-8?B?W1JGQyBsaW51eC1uZXh0IDAvMl0gQmx1ZXRvb3RoOiBoY2lfY29ubjogRml4IFdBUk5JTkcgaW4gaGNpX2Nvbm5fdGltZW91dA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5B8CUr9D076502
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.35.20.165 unknown Mon, 08 Dec 2025 20:31:22 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6936C518.000/4dQ1Yk0dN0z1DDQ

From: Qiu Yutan <qiu.yutan@zte.com.cn>

This patch series primarily accomplishes the following:
1. Adds tracepoints for debugging purposes.
2. Fixes the WARNING in hci_conn_timeout.
3. Provide a method to reproduce the issue quickly.

Overview:

This is a reference patch intended to facilitate discussion on the issue with
Bluetooth experts in the community.

The fix in this patch series modifies hci_conn_drop to decrement conn->refcnt 
by 1 only when it is positive, thereby avoiding the WARNING in hci_conn_timeout. 
At a deeper level, underlying this issue is the lack of strictly symmetric increment 
and decrement operations on conn->refcnt within the Bluetooth module.

More imporantly, we have developed a reproducer that can reliably reproduce the issue, 
which will facilitate in-depth community discussion on the refcnt problem. 

Reproduction:

By running the local C program for reproducing the issue, we can quickly replicate the problem.
The idea behind this reproducer is to reconstruct the same scenario based on the packet types
and sequence received when the WARNING previously occurred.

The sequence of events we constructed is as follows:

hci_conn_complete_evt   (refcnt=1)
          |
hci_remote_features_evt (refcnt=0)
          |
hci_auth_complete_evt   (refcnt=1) 
          |
hci_auth_complete_evt   (refcnt=0)  ---trigger---> hci_conn_timeout 
          |                                               |                              
          |                                               v
hci_encrypt_change_evt  (refcnt=-1)                    WARN_ON


To ensure the issue can be reliably reproduced, we added a 5-second sleep in hci_conn_del.
This is because the function calls cancel_delayed_work_sync(&conn->disc_work), and without
the sleep, the problem might not occur.

Steps as follows:
1. modify bluetooth module, compile and reboot the kernel.
//net/bluetooth/hci_conn.c
void hci_conn_del(struct hci_conn *conn) 
{
        msleep(5000);
	...
}

2. enable tracepoint of bluetooth.
$ echo 1 > /sys/kernel/debug/tracing/events/bluetooth/enable

3. compile C program and excute a.out.
$ gcc repro.c
$ ./a.out

4. check the trace log.
$ cat /sys/kernel/debug/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 7/7   #P:60
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
  kworker/u181:2-7529    [059] .....  7643.565065: hci_conn_hold: conn_addr=00000000d1dbbaf1, orig refcnt=0
  kworker/u181:2-7529    [059] .....  7643.565249: hci_conn_drop: conn_addr=00000000d1dbbaf1, orig refcnt=1
  kworker/u181:2-7529    [059] .....  7643.565300: hci_conn_hold: conn_addr=00000000d1dbbaf1, orig refcnt=0
  kworker/u181:2-7529    [059] .....  7643.565300: hci_conn_drop: conn_addr=00000000d1dbbaf1, orig refcnt=1
  kworker/u181:2-7529    [059] .....  7643.565303: hci_conn_drop: conn_addr=00000000d1dbbaf1, orig refcnt=0
  kworker/u181:2-7529    [059] .....  7651.011494: hci_conn_del: conn_addr=00000000d1dbbaf1, orig refcnt=-1
           a.out-11836   [042] .....  7657.155559: hci_conn_del: conn_addr=00000000c292b8f7, orig refcnt=0

5. check dmesg.
$ dmesg | grep -i warn            
[ 7646.448461] WARNING: CPU: 59 PID: 11837 at net/bluetooth/hci_conn.c:622 hci_conn_timeout+0x5e/0xb0 [bluetooth]
[ 7646.448929]  ? __warn+0x81/0x130

The C reproduction program is as follows:
#define _GNU_SOURCE 

#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/epoll.h>
#include <sys/ioctl.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/swap.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <sys/wait.h>
#include <unistd.h>

#include <linux/capability.h>
#include <linux/falloc.h>
#include <linux/rfkill.h>
#ifndef __NR_open_tree
#define __NR_open_tree 428
#endif

static bool write_file(const char* file, const char* what, ...)
{
        char buf[1024];
        va_list args;
        va_start(args, what);
        vsnprintf(buf, sizeof(buf), what, args);
        va_end(args);
        buf[sizeof(buf) - 1] = 0;
        int len = strlen(buf);
        int fd = open(file, O_WRONLY | O_CLOEXEC);
        if (fd == -1)
                return false;
        if (write(fd, buf, len) != len) {
                int err = errno;
                close(fd);
                errno = err;
                return false;
        }
        close(fd);
        return true;
}

static int runcmdline(char* cmdline)
{
        int ret = system(cmdline);
        if (ret) {
        }
        return ret;
}

#define BTPROTO_HCI 1
#define ACL_LINK 1
#define SCAN_PAGE 2

typedef struct {
        uint8_t b[6];
} __attribute__((packed)) bdaddr_t;

#define HCI_COMMAND_PKT 1
#define HCI_EVENT_PKT 4
#define HCI_VENDOR_PKT 0xff

struct hci_command_hdr {
        uint16_t opcode;
        uint8_t plen;
} __attribute__((packed));

struct hci_event_hdr {
        uint8_t evt;
        uint8_t plen;
} __attribute__((packed));

#define HCI_EV_HARDWARE_ERROR 0x10
struct hci_ev_hardware_error {
        uint8_t     code;
} __attribute__((packed));

#define HCI_EV_KEY_REFRESH_COMPLETE     0x30
struct hci_ev_key_refresh_complete {
        uint8_t    status;
        uint16_t  handle;
} __attribute__((packed));

#define HCI_EV_AUTH_COMPLETE            0x06
struct hci_ev_auth_complete {
        uint8_t     status;
        uint16_t   handle;
} __attribute__((packed));

#define HCI_EV_ENCRYPT_CHANGE           0x08
struct hci_ev_encrypt_change {
        uint8_t     status;
        uint16_t   handle;
        uint8_t     encrypt;
} __attribute__((packed));

#define HCI_EV_CONN_COMPLETE 0x03
struct hci_ev_conn_complete {
        uint8_t status;
        uint16_t handle;
        bdaddr_t bdaddr;
        uint8_t link_type;
        uint8_t encr_mode;
} __attribute__((packed));

#define HCI_EV_CONN_REQUEST 0x04
struct hci_ev_conn_request {
        bdaddr_t bdaddr;
        uint8_t dev_class[3];
        uint8_t link_type;
} __attribute__((packed));

#define HCI_EV_REMOTE_FEATURES 0x0b
struct hci_ev_remote_features {
        uint8_t status;
        uint16_t handle;
        uint8_t features[8];
} __attribute__((packed));

#define HCI_EV_CMD_COMPLETE 0x0e
struct hci_ev_cmd_complete {
        uint8_t ncmd;
        uint16_t opcode;
} __attribute__((packed));

#define HCI_OP_WRITE_SCAN_ENABLE 0x0c1a

#define HCI_OP_READ_BUFFER_SIZE 0x1005
struct hci_rp_read_buffer_size {
        uint8_t status;
        uint16_t acl_mtu;
        uint8_t sco_mtu;
        uint16_t acl_max_pkt;
        uint16_t sco_max_pkt;
} __attribute__((packed));

#define HCI_OP_READ_BD_ADDR 0x1009
struct hci_rp_read_bd_addr {
        uint8_t status;
        bdaddr_t bdaddr;
} __attribute__((packed));

#define HCI_EV_LE_META 0x3e
struct hci_ev_le_meta {
        uint8_t subevent;
} __attribute__((packed));

#define HCI_EV_LE_CONN_COMPLETE 0x01
struct hci_ev_le_conn_complete {
        uint8_t status;
        uint16_t handle;
        uint8_t role;
        uint8_t bdaddr_type;
        bdaddr_t bdaddr;
        uint16_t interval;
        uint16_t latency;
        uint16_t supervision_timeout;
        uint8_t clk_accurancy;
} __attribute__((packed));

struct hci_dev_req {
        uint16_t dev_id;
        uint32_t dev_opt;
};

struct vhci_vendor_pkt_request {
        uint8_t type;
        uint8_t opcode;
} __attribute__((packed));

struct vhci_pkt {
        uint8_t type;
        union {
                struct {
                        uint8_t opcode;
                        uint16_t id;
                } __attribute__((packed)) vendor_pkt;
                struct hci_command_hdr command_hdr;
        };
} __attribute__((packed));

#define HCIDEVUP _IOW('H', 201, int)
#define HCISETSCAN _IOW('H', 221, int)

static int vhci_fd = -1;

static void rfkill_unblock_all()
{
        int fd = open("/dev/rfkill", O_WRONLY);
        if (fd < 0)
        exit(1);
        struct rfkill_event event = {0};
        event.idx = 0;
        event.type = RFKILL_TYPE_ALL;
        event.op = RFKILL_OP_CHANGE_ALL;
        event.soft = 0;
        event.hard = 0;
        if (write(fd, &event, sizeof(event)) < 0)
        exit(1);
        close(fd);
}

static void hci_send_event_packet(int fd, uint8_t evt, void* data, size_t data_len)
{
        struct iovec iv[3];
        struct hci_event_hdr hdr;
        hdr.evt = evt;
        hdr.plen = data_len;
        uint8_t type = HCI_EVENT_PKT;
        iv[0].iov_base = &type;
        iv[0].iov_len = sizeof(type);
        iv[1].iov_base = &hdr;
        iv[1].iov_len = sizeof(hdr);
        iv[2].iov_base = data;
        iv[2].iov_len = data_len;
        if (writev(fd, iv, sizeof(iv) / sizeof(struct iovec)) < 0)
        exit(1);
}

static void hci_send_event_cmd_complete(int fd, uint16_t opcode, void* data, size_t data_len)
{
        struct iovec iv[4];
        struct hci_event_hdr hdr;
        hdr.evt = HCI_EV_CMD_COMPLETE;
        hdr.plen = sizeof(struct hci_ev_cmd_complete) + data_len;
        struct hci_ev_cmd_complete evt_hdr;
        evt_hdr.ncmd = 1;
        evt_hdr.opcode = opcode;
        uint8_t type = HCI_EVENT_PKT;
        iv[0].iov_base = &type;
        iv[0].iov_len = sizeof(type);
        iv[1].iov_base = &hdr;
        iv[1].iov_len = sizeof(hdr);
        iv[2].iov_base = &evt_hdr;
        iv[2].iov_len = sizeof(evt_hdr);
        iv[3].iov_base = data;
        iv[3].iov_len = data_len;
        if (writev(fd, iv, sizeof(iv) / sizeof(struct iovec)) < 0)
        exit(1);
}

static bool process_command_pkt(int fd, char* buf, ssize_t buf_size)
{
        struct hci_command_hdr* hdr = (struct hci_command_hdr*)buf;
        if (buf_size < (ssize_t)sizeof(struct hci_command_hdr) ||
            hdr->plen != buf_size - sizeof(struct hci_command_hdr))
        exit(1);
        switch (hdr->opcode) {
        case HCI_OP_WRITE_SCAN_ENABLE: {
                uint8_t status = 0;
                hci_send_event_cmd_complete(fd, hdr->opcode, &status, sizeof(status));
                return true;
        }
        case HCI_OP_READ_BD_ADDR: {
                struct hci_rp_read_bd_addr rp = {0};
                rp.status = 0;
                memset(&rp.bdaddr, 0xaa, 6);
                hci_send_event_cmd_complete(fd, hdr->opcode, &rp, sizeof(rp));
                return false;
        }
        case HCI_OP_READ_BUFFER_SIZE: {
                struct hci_rp_read_buffer_size rp = {0};
                rp.status = 0;
                rp.acl_mtu = 1021;
                rp.sco_mtu = 96;
                rp.acl_max_pkt = 4;
                rp.sco_max_pkt = 6;
                hci_send_event_cmd_complete(fd, hdr->opcode, &rp, sizeof(rp));
                return false;
        }
        }
        char dummy[0xf9] = {0};
        hci_send_event_cmd_complete(fd, hdr->opcode, dummy, sizeof(dummy));
        return false;
}

static void* event_thread(void* arg)
{
        while (1) {
                char buf[1024] = {0};
                ssize_t buf_size = read(vhci_fd, buf, sizeof(buf));
                if (buf_size < 0)
        exit(1);
                if (buf_size > 0 && buf[0] == HCI_COMMAND_PKT) {
                        if (process_command_pkt(vhci_fd, buf + 1, buf_size - 1))
                                break;
                }
        }
        return NULL;
}
#define HCI_HANDLE_1 200
#define HCI_HANDLE_2 201

#define HCI_PRIMARY 0
#define HCI_OP_RESET 0x0c03

static void initialize_vhci()
{
        int hci_sock = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
        if (hci_sock < 0)
        exit(1);
        vhci_fd = open("/dev/vhci", O_RDWR);
        if (vhci_fd == -1)
        exit(1);
        const int kVhciFd = 202;
        if (dup2(vhci_fd, kVhciFd) < 0)
        exit(1);
        close(vhci_fd);
        vhci_fd = kVhciFd;
        struct vhci_vendor_pkt_request vendor_pkt_req = {HCI_VENDOR_PKT, HCI_PRIMARY};
        if (write(vhci_fd, &vendor_pkt_req, sizeof(vendor_pkt_req)) != sizeof(vendor_pkt_req))
        exit(1);
        struct vhci_pkt vhci_pkt;
        if (read(vhci_fd, &vhci_pkt, sizeof(vhci_pkt)) != sizeof(vhci_pkt))
        exit(1);
        if (vhci_pkt.type == HCI_COMMAND_PKT && vhci_pkt.command_hdr.opcode == HCI_OP_RESET) {
                char response[1] = {0};
                hci_send_event_cmd_complete(vhci_fd, HCI_OP_RESET, response, sizeof(response));
                if (read(vhci_fd, &vhci_pkt, sizeof(vhci_pkt)) != sizeof(vhci_pkt))
        exit(1);
        }
        if (vhci_pkt.type != HCI_VENDOR_PKT)
        exit(1);
        int dev_id = vhci_pkt.vendor_pkt.id;
        pthread_t th;
        if (pthread_create(&th, NULL, event_thread, NULL))
        exit(1);
        int ret = ioctl(hci_sock, HCIDEVUP, dev_id);
        if (ret) {
                if (errno == ERFKILL) {
                        rfkill_unblock_all();
                        ret = ioctl(hci_sock, HCIDEVUP, dev_id);
                }
                if (ret && errno != EALREADY)
        exit(1);
        }
        struct hci_dev_req dr = {0};
        dr.dev_id = dev_id;
        dr.dev_opt = SCAN_PAGE;
        if (ioctl(hci_sock, HCISETSCAN, &dr))
        exit(1);

        struct hci_ev_conn_request request;
        memset(&request, 0, sizeof(request));
        memset(&request.bdaddr, 0xaa, 6);
        *(uint8_t*)&request.bdaddr.b[5] = 0x10;
        request.link_type = ACL_LINK;
        printf("send HCI_EV_CONN_REQUEST\n");
        hci_send_event_packet(vhci_fd, HCI_EV_CONN_REQUEST, &request, sizeof(request));
        printf("send HCI_EV_CONN_REQUEST done\n");

        struct hci_ev_conn_complete complete;
        memset(&complete, 0, sizeof(complete));
        complete.status = 0;
        complete.handle = HCI_HANDLE_1;
        memset(&complete.bdaddr, 0xaa, 6);
        *(uint8_t*)&complete.bdaddr.b[5] = 0x10;
        complete.link_type = ACL_LINK;
        complete.encr_mode = 0;
        printf("send HCI_EV_CONN_COMPLETE\n");
        hci_send_event_packet(vhci_fd, HCI_EV_CONN_COMPLETE, &complete, sizeof(complete));
        printf("send HCI_EV_CONN_COMPLETE done\n");

        struct hci_ev_remote_features features;
        memset(&features, 0, sizeof(features));
        features.status = 0;
        features.handle = HCI_HANDLE_1;
        printf("send HCI_EV_REMOTE_FEATURES\n");
        hci_send_event_packet(vhci_fd, HCI_EV_REMOTE_FEATURES, &features, sizeof(features));
        printf("send HCI_EV_REMOTE_FEATURES done\n");

        struct {
                struct hci_ev_le_meta le_meta;
                struct hci_ev_le_conn_complete le_conn;
        } le_conn;
        memset(&le_conn, 0, sizeof(le_conn));
        le_conn.le_meta.subevent = HCI_EV_LE_CONN_COMPLETE;
        memset(&le_conn.le_conn.bdaddr, 0xaa, 6);
        *(uint8_t*)&le_conn.le_conn.bdaddr.b[5] = 0x11;
        le_conn.le_conn.role = 1;
        le_conn.le_conn.handle = HCI_HANDLE_2;
        printf("send HCI_EV_LE_META\n");
        hci_send_event_packet(vhci_fd, HCI_EV_LE_META, &le_conn, sizeof(le_conn));
        printf("send HCI_EV_LE_META done\n");

        struct hci_ev_auth_complete auth;
        memset(&auth, 0, sizeof(auth));
        auth.status = 0;  // not sure
        auth.handle = HCI_HANDLE_1; // not sure
        printf("send HCI_EV_AUTH_COMPLETE\n");
        hci_send_event_packet(vhci_fd, HCI_EV_AUTH_COMPLETE, &auth, sizeof(auth));
        printf("send HCI_EV_AUTH_COMPLETE done\n");

        struct hci_ev_encrypt_change encrypt;
        memset(&encrypt, 0, sizeof(encrypt));
        encrypt.status = 1;  // not sure
        encrypt.handle = HCI_HANDLE_1; // not sure
        encrypt.encrypt = 1;
        printf("send HCI_EV_ENCRYPT_CHANGE\n");
        hci_send_event_packet(vhci_fd, HCI_EV_ENCRYPT_CHANGE, &encrypt, sizeof(encrypt));
        printf("send HCI_EV_ENCRYPT_CHANGE done\n");

        pthread_join(th, NULL);
        close(hci_sock);
}

static void setup_gadgetfs();
static void setup_binderfs();
static void setup_fusectl();
static void sandbox_common_mount_tmpfs(void)
{
        write_file("/proc/sys/fs/mount-max", "100000");
        if (mkdir("./syz-tmp", 0777))
        exit(1);
        if (mount("", "./syz-tmp", "tmpfs", 0, NULL))
        exit(1);
        if (mkdir("./syz-tmp/newroot", 0777))
        exit(1);
        if (mkdir("./syz-tmp/newroot/dev", 0700))
        exit(1);
        unsigned bind_mount_flags = MS_BIND | MS_REC | MS_PRIVATE;
        if (mount("/dev", "./syz-tmp/newroot/dev", NULL, bind_mount_flags, NULL))
        exit(1);
        if (mkdir("./syz-tmp/newroot/proc", 0700))
        exit(1);
        if (mount("syz-proc", "./syz-tmp/newroot/proc", "proc", 0, NULL))
        exit(1);
        if (mkdir("./syz-tmp/newroot/selinux", 0700))
        exit(1);
        const char* selinux_path = "./syz-tmp/newroot/selinux";
        if (mount("/selinux", selinux_path, NULL, bind_mount_flags, NULL)) {
                if (errno != ENOENT)
        exit(1);
                if (mount("/sys/fs/selinux", selinux_path, NULL, bind_mount_flags, NULL) && errno != ENOENT)
        exit(1);
        }
        if (mkdir("./syz-tmp/newroot/sys", 0700))
        exit(1);
        if (mount("/sys", "./syz-tmp/newroot/sys", 0, bind_mount_flags, NULL))
        exit(1);
        if (mount("/sys/kernel/debug", "./syz-tmp/newroot/sys/kernel/debug", NULL, bind_mount_flags, NULL) && errno != ENOENT)
        exit(1);
        if (mount("/sys/fs/smackfs", "./syz-tmp/newroot/sys/fs/smackfs", NULL, bind_mount_flags, NULL) && errno != ENOENT)
        exit(1);
        if (mount("/proc/sys/fs/binfmt_misc", "./syz-tmp/newroot/proc/sys/fs/binfmt_misc", NULL, bind_mount_flags, NULL) && errno != ENOENT)
        exit(1);
        if (mkdir("./syz-tmp/pivot", 0777))
        exit(1);
        if (syscall(SYS_pivot_root, "./syz-tmp", "./syz-tmp/pivot")) {
                if (chdir("./syz-tmp"))
        exit(1);
        } else {
                if (chdir("/"))
        exit(1);
                if (umount2("./pivot", MNT_DETACH))
        exit(1);
        }
        if (chroot("./newroot"))
        exit(1);
        if (chdir("/"))
        exit(1);
        setup_gadgetfs();
        setup_binderfs();
        setup_fusectl();
}

static void setup_gadgetfs()
{
        if (mkdir("/dev/gadgetfs", 0777)) {
        }
        if (mount("gadgetfs", "/dev/gadgetfs", "gadgetfs", 0, NULL)) {
        }
}

static void setup_fusectl()
{
        if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
        }
}

static void setup_binderfs()
{
        if (mkdir("/dev/binderfs", 0777)) {
        }
        if (mount("binder", "/dev/binderfs", "binder", 0, NULL)) {
        }
        if (symlink("/dev/binderfs", "./binderfs")) {
        }
}

static void loop();

static void sandbox_common()
{
        prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
        if (getppid() == 1)
        exit(1);
        struct rlimit rlim;
        rlim.rlim_cur = rlim.rlim_max = (200 << 20);
        setrlimit(RLIMIT_AS, &rlim);
        rlim.rlim_cur = rlim.rlim_max = 32 << 20;
        setrlimit(RLIMIT_MEMLOCK, &rlim);
        rlim.rlim_cur = rlim.rlim_max = 136 << 20;
        setrlimit(RLIMIT_FSIZE, &rlim);
        rlim.rlim_cur = rlim.rlim_max = 1 << 20;
        setrlimit(RLIMIT_STACK, &rlim);
        rlim.rlim_cur = rlim.rlim_max = 128 << 20;
        setrlimit(RLIMIT_CORE, &rlim);
        rlim.rlim_cur = rlim.rlim_max = 256;
        setrlimit(RLIMIT_NOFILE, &rlim);
        if (unshare(CLONE_NEWNS)) {
        }
        if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
        }
        if (unshare(CLONE_NEWIPC)) {
        }
        if (unshare(0x02000000)) {
        }
        if (unshare(CLONE_NEWUTS)) {
        }
        if (unshare(CLONE_SYSVSEM)) {
        }
        typedef struct {
                const char* name;
                const char* value;
        } sysctl_t;
        static const sysctl_t sysctls[] = {
            {"/proc/sys/kernel/shmmax", "16777216"},
            {"/proc/sys/kernel/shmall", "536870912"},
            {"/proc/sys/kernel/shmmni", "1024"},
            {"/proc/sys/kernel/msgmax", "8192"},
            {"/proc/sys/kernel/msgmni", "1024"},
            {"/proc/sys/kernel/msgmnb", "1024"},
            {"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
        };
        unsigned i;
        for (i = 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
                write_file(sysctls[i].name, sysctls[i].value);
}

static int wait_for_loop(int pid)
{
        if (pid < 0)
        exit(1);
        int status = 0;
        while (waitpid(-1, &status, __WALL) != pid) {
        }
        return WEXITSTATUS(status);
}

static void drop_caps(void)
{
        struct __user_cap_header_struct cap_hdr = {};
        struct __user_cap_data_struct cap_data[2] = {};
        cap_hdr.version = _LINUX_CAPABILITY_VERSION_3;
        cap_hdr.pid = getpid();
        if (syscall(SYS_capget, &cap_hdr, &cap_data))
        exit(1);
        const int drop = (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
        cap_data[0].effective &= ~drop;
        cap_data[0].permitted &= ~drop;
        cap_data[0].inheritable &= ~drop;
        if (syscall(SYS_capset, &cap_hdr, &cap_data))
        exit(1);
}

static int do_sandbox_none(void)
{
        if (unshare(CLONE_NEWPID)) {
        }
        int pid = fork();
        if (pid != 0)
                return wait_for_loop(pid);
        initialize_vhci();
        sandbox_common();
        drop_caps();
        if (unshare(CLONE_NEWNET)) {
        }
        write_file("/proc/sys/net/ipv4/ping_group_range", "0 65535");
        sandbox_common_mount_tmpfs();
        loop();
        exit(1);
}

static void setup_sysctl()
{
        int cad_pid = fork();
        if (cad_pid < 0)
        exit(1);
        if (cad_pid == 0) {
                for (;;)
                        sleep(100);
        }
        char tmppid[32];
        snprintf(tmppid, sizeof(tmppid), "%d", cad_pid);
        struct {
                const char* name;
                const char* data;
        } files[] = {
                {"/sys/kernel/debug/x86/nmi_longest_ns", "10000000000"},
                {"/proc/sys/kernel/hung_task_check_interval_secs", "20"},
                {"/proc/sys/net/core/bpf_jit_kallsyms", "1"},
                {"/proc/sys/net/core/bpf_jit_harden", "0"},
                {"/proc/sys/kernel/kptr_restrict", "0"},
                {"/proc/sys/kernel/softlockup_all_cpu_backtrace", "1"},
                {"/proc/sys/fs/mount-max", "100"},
                {"/proc/sys/vm/oom_dump_tasks", "0"},
                {"/proc/sys/debug/exception-trace", "0"},
                {"/proc/sys/kernel/printk", "7 4 1 3"},
                {"/proc/sys/kernel/keys/gc_delay", "1"},
                {"/proc/sys/vm/oom_kill_allocating_task", "1"},
                {"/proc/sys/kernel/ctrl-alt-del", "0"},
                {"/proc/sys/kernel/cad_pid", tmppid},
        };
        for (size_t i = 0; i < sizeof(files) / sizeof(files[0]); i++) {
                if (!write_file(files[i].name, files[i].data)) {
                }
        }
        kill(cad_pid, SIGKILL);
        while (waitpid(cad_pid, NULL, 0) != cad_pid)
                ;
}

#define SWAP_FILE "./swap-file"
#define SWAP_FILE_SIZE (128 * 1000 * 1000)

static const char* setup_swap()
{
        swapoff(SWAP_FILE);
        unlink(SWAP_FILE);
        int fd = open(SWAP_FILE, O_CREAT | O_WRONLY | O_CLOEXEC, 0600);
        if (fd == -1)
                return "swap file open failed";
        fallocate(fd, FALLOC_FL_ZERO_RANGE, 0, SWAP_FILE_SIZE);
        close(fd);
        char cmdline[64];
        sprintf(cmdline, "mkswap %s", SWAP_FILE);
        if (runcmdline(cmdline))
                return "mkswap failed";
        if (swapon(SWAP_FILE, SWAP_FLAG_PREFER) == 1)
                return "swapon failed";
        return NULL;
}

void loop(void)
{
                if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {}
        syscall(__NR_open_tree, /*dfd=*/0xffffff9c, /*filename=*/0ul, /*flags=AT_NO_AUTOMOUNT*/0x800ul);

}
int main(void)
{
                syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
        syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/7ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
        syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
        setup_sysctl();
        const char* reason;
        (void)reason;
        if ((reason = setup_swap()))
                printf("the reproducer may not work as expected: swap setup failed: %s\n", reason);
                        do_sandbox_none();
        return 0;
}


Qiu Yutan (2):
  Bluetooth: hci_conn: Add tracepoints for debugging
  Bluetooth: hci_conn: fix WARNING in hci_conn_timeout

 include/net/bluetooth/hci_core.h |  5 +-
 include/trace/events/bluetooth.h | 80 ++++++++++++++++++++++++++++++++
 net/bluetooth/hci_conn.c         |  4 ++
 3 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/bluetooth.h

-- 
2.27.0
