Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E463FE344
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585957; cv=none; b=eGe75EqXEI4YTE7+VpniLl7xhPYF/WtdBlOn1ShwyPHb5qWLWuGtsmSnuy46nsZebd1ypi+TxS7JSDQfrUGI8x6QABoXj5gpK12gdtUhfivEHOGU+1FjL8t7c6fbJYrbEFnVAsawQn3JwCjNgXFbzoGat8RntTC2uBRREfffeAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585957; c=relaxed/simple;
	bh=suqqPZQ4y7T6U5ONdlfbDEhZPCpA2hZpC57daMlfS9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKlW2Xh67we2YsLa8pDW3Lt2lmpb3IaUOb8/e+/h7Ro6XRp3VK7f++2zHSDWf17ggCAB8MRREiH5+3/5oO6HRYlzQsLlYfc5M4RqOdm7o5VjNm5BuRDbA9eiJsnsZhQwkpEbEb8IR8ELzwPyqY3GMeEMwQvvd+dspjjfpemNIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=wp48ExiP; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="wp48ExiP"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1469c1b83so4801586a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 08:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1787585953; x=1788190753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OENTk8cjPfC9H38uVIzpl4K9G/NOAUfmEmPfYCmr4HA=;
        b=wp48ExiPmY42AR4WY4c3fxVnKadk2GYDo0l5lEQft8SFdRnNrP/xXDNMJDf4NpC7Da
         mFJLxQdFGatuiLsNQ7TjMUEym+6K5metqsE4uHnEE190ZdB3XmmaHYPW1vYOuQ7acqvg
         HUbrcdv1Z1bTXJB6XsiDY3omT5Qig5Eo3rQ4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585953; x=1788190753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OENTk8cjPfC9H38uVIzpl4K9G/NOAUfmEmPfYCmr4HA=;
        b=b/qQEENfSMB/POmAEh96Yh+PIQjkKy4WmTIY92fO3Yk1Nyeu58ZD6QqU2ZWFroXq+L
         JthqFfIiqBSW9FJ81SFyDQfZuTu+HN/+NA8/vUuooKmkpvDniEAJex7W0gCmnRqqB89T
         A9CofM1uNawt6stBcH19PKKjhkYQXVquJWQXNeGIfLMSqHv5rv4j5hLEuS3iP0M4YoEk
         Irbnr1lHXWEAadQ/l9lTySPUpbq8T8szKaKb19RF4FtQMUehzzDRVhDwERcayJzNQJKN
         1rqzWmjfoq15pvEqJtGE4FNgUyWZNgUAh0ukdu0iTi22R5/1XbLo56R+KyMxbw+VEwCw
         Dfpw==
X-Gm-Message-State: AFuF++lNF9t5chPZq6FU/DJdZV8qVxMbAPDEtdlwJW5Rk57SBFr0o8A8
	xJbrFjr3AKU11kVxz8kyNZxQ5F/27ChrnRRibZuZyEoWB0p9LN4FgxEN704QkxTI5cs09X/tsBV
	KetB90Ww=
X-Gm-Gg: AR+sD12UjmKPJXvB/aFZkB5l2UeIC4HZMKMitYFRsmBxPAiEhN931JaXU5HwzAwEiG7
	GJmt6Fh793YUuK5ROp45UKq5UtT7W0ahuPpNLX08KKStJh4hWaDTDCqKMRcFTOeHXw1nvebQdG/
	VHq0naasixfIJVQC+4MafDO5C+zHAGqq6nb2zFOW7xD1mV6A5Ow06cWTlgm4yd5TcS3nC5enSCS
	zt93eozK504XlnIDGVK4bvWvuo/SVhiKpNsUVqRyAduCEomAvr2gPOIUkaBFpFNSV87hOXyIkhO
	HeYAEkam41aRNyj80O6+pkyT1YykSY3UmX757eiQj0zYYfH32KWrSWE3B9tFR+zZ/zl+dP47i2V
	yid26I3YKDHylPKvBX1TcfWXEcvU95FruWhd2czaVAWC4z6txcHJJJshc4NKhpBPm8JPZrudAM4
	9TXgNJLoZdHFnvouxgIjf0cLpX4SYOpOQAVpc80oMGZ8hM6WtQOGKLpuZ5wjpc0m4/9lcgHaeF3
	OGqltjb51INFntV7smzFEXmS3dJDGIGlNIVF1NhUwaz2T5P3Jok9u23+M2qXRRS5S9NNlMqAaMt
	uPprQ/efAdWEVHDhoHqtLMUzN9+nIqNA/ThqRwhcOrL5KbEjc86w8w==
X-Received: by 2002:a05:6a20:7292:b0:3b4:7e2d:a3c2 with SMTP id adf61e73a8af0-3cd301c72f7mr41618230637.18.1787585953431;
        Mon, 24 Aug 2026 08:39:13 -0700 (PDT)
Received: from leesin ([147.46.121.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199daed9asm1197608a12.5.2026.08.24.08.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:39:12 -0700 (PDT)
From: Jaeyoung Chung <jjy600901@snu.ac.kr>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org,
	eulgyukim@snu.ac.kr,
	jjy600901@snu.ac.kr
Subject: [BUG] general protection fault in __l2cap_chan_add
Date: Tue, 25 Aug 2026 00:39:07 +0900
Message-ID: <20260824153908.2327306-1-jjy600901@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

We found a "general protection fault in __l2cap_chan_add" on Linux v7.2.
The issue was found by our own race fuzzer. We have not analyzed the root cause,
so we do not have a proposed fix to offer.

To reproduce the race reliably, we applied the delay patch below to the
kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
crash log we observed, the delay patch and the reproducer are all included
below.

The following kernel config options are required to reproduce the issue:
    CONFIG_BT=y
    CONFIG_BT_BREDR=y
    CONFIG_BT_HCIVHCI=y
    CONFIG_KASAN=y

We hope this report is useful. Please let us know if any further
information would help.

Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>

Kernel delay patch:
==================================================================
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1156aba4e83c..1c16fec62f14 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -30,6 +30,7 @@
 #include <linux/debugfs.h>
 #include <linux/crc16.h>
 #include <linux/filter.h>
+#include <linux/delay.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -96,6 +97,8 @@ static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
 	return NULL;
 }
 
+unsigned long syz_l2cap_victim;
+
 static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn,
 						   u16 cid)
 {
@@ -104,6 +107,11 @@ static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn,
 	list_for_each_entry(c, &conn->chan_l, list) {
 		if (c->scid == cid)
 			return c;
+		if ((unsigned long)c == syz_l2cap_victim &&
+		    strncmp(current->comm, "syzrepro", 8) == 0) {
+			syz_l2cap_victim = 0;
+			mdelay(500);
+		}
 	}
 	return NULL;
 }
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4058ff50cc27..8dffd01db9fe 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -29,6 +29,7 @@
 #include <linux/filter.h>
 #include <linux/sched/signal.h>
 #include <linux/uio.h>
+#include <linux/delay.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -36,6 +37,8 @@
 
 #include "smp.h"
 
+extern unsigned long syz_l2cap_victim;
+
 static struct bt_sock_list l2cap_sk_list = {
 	.lock = __RW_LOCK_UNLOCKED(l2cap_sk_list.lock)
 };
@@ -1430,6 +1433,11 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	conn = l2cap_conn_hold_unless_zero(chan->conn);
 	l2cap_chan_unlock(chan);
 
+	if (strncmp(current->comm, "syzrepro1", 9) == 0) {
+		syz_l2cap_victim = conn ? 0 : (unsigned long)chan;
+		mdelay(250);
+	}
+
 	if (conn)
 		/* mutex lock must be taken before l2cap_chan_lock() */
 		mutex_lock(&conn->lock);

==================================================================

C reproducer:
==================================================================
#define _GNU_SOURCE

#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/prctl.h>
#include <sys/socket.h>
#include <sys/uio.h>
#include <unistd.h>

#ifndef AF_BLUETOOTH
#define AF_BLUETOOTH 31
#endif
#define BTPROTO_L2CAP 0
#define BTPROTO_HCI 1

#define HCI_COMMAND_PKT 0x01
#define HCI_EVENT_PKT 0x04
#define HCI_VENDOR_PKT 0xff

#define HCI_EV_CONN_COMPLETE 0x03
#define HCI_EV_CONN_REQUEST 0x04
#define HCI_EV_REMOTE_FEATURES 0x0b
#define HCI_EV_CMD_COMPLETE 0x0e

#define HCI_OP_RESET 0x0c03
#define HCI_OP_WRITE_SCAN_ENABLE 0x0c1a
#define HCI_OP_READ_BUFFER_SIZE 0x1005
#define HCI_OP_READ_BD_ADDR 0x1009

#define ACL_LINK 0x01
#define SCAN_PAGE 0x02
#define HCI_PRIMARY 0
#define HCI_HANDLE_1 200

#define HCIDEVUP _IOW('H', 201, int)
#define HCISETSCAN _IOW('H', 221, int)

typedef struct {
	uint8_t b[6];
} __attribute__((packed)) my_bdaddr_t;

struct sockaddr_l2 {
	uint16_t l2_family;
	uint16_t l2_psm;
	my_bdaddr_t l2_bdaddr;
	uint16_t l2_cid;
	uint8_t l2_bdaddr_type;
} __attribute__((packed));

struct hci_command_hdr {
	uint16_t opcode;
	uint8_t plen;
} __attribute__((packed));

struct hci_event_hdr {
	uint8_t evt;
	uint8_t plen;
} __attribute__((packed));

struct hci_ev_cmd_complete {
	uint8_t ncmd;
	uint16_t opcode;
} __attribute__((packed));

struct hci_ev_conn_request {
	my_bdaddr_t bdaddr;
	uint8_t dev_class[3];
	uint8_t link_type;
} __attribute__((packed));

struct hci_ev_conn_complete {
	uint8_t status;
	uint16_t handle;
	my_bdaddr_t bdaddr;
	uint8_t link_type;
	uint8_t encr_mode;
} __attribute__((packed));

struct hci_ev_remote_features {
	uint8_t status;
	uint16_t handle;
	uint8_t features[8];
} __attribute__((packed));

struct hci_rp_read_bd_addr {
	uint8_t status;
	my_bdaddr_t bdaddr;
} __attribute__((packed));

struct hci_rp_read_buffer_size {
	uint8_t status;
	uint16_t acl_mtu;
	uint8_t sco_mtu;
	uint16_t acl_max_pkt;
	uint16_t sco_max_pkt;
} __attribute__((packed));

struct hci_dev_req {
	uint16_t dev_id;
	uint32_t dev_opt;
};

struct vhci_vendor_pkt_request {
	uint8_t type;
	uint8_t opcode;
} __attribute__((packed));

struct my_rfkill_event {
	uint32_t idx;
	uint8_t type;
	uint8_t op;
	uint8_t soft;
	uint8_t hard;
} __attribute__((packed));

#define RFKILL_TYPE_ALL 0
#define RFKILL_OP_CHANGE_ALL 3

static int vhci_fd = -1;
static int hci_sock = -1;
static int hci_dev_id = -1;

#define LOG(fmt, ...)                                                          \
	do {                                                                   \
		fflush(stdout);                                                \
	} while (0)

#define LOGE(fmt, ...)                                                         \
	do {                                                                   \
		fflush(stdout);                                                \
	} while (0)

static void hci_send_event_packet(int fd, uint8_t evt, void *data,
				  size_t data_len)
{
	struct iovec iv[3];
	struct hci_event_hdr hdr;
	uint8_t type = HCI_EVENT_PKT;

	hdr.evt = evt;
	hdr.plen = data_len;

	iv[0].iov_base = &type;
	iv[0].iov_len = sizeof(type);
	iv[1].iov_base = &hdr;
	iv[1].iov_len = sizeof(hdr);
	iv[2].iov_base = data;
	iv[2].iov_len = data_len;

	if (writev(fd, iv, 3) < 0)
		LOGE("writev(event) failed");
}

static void hci_send_event_cmd_complete(int fd, uint16_t opcode, void *data,
					size_t data_len)
{
	struct iovec iv[4];
	struct hci_event_hdr hdr;
	struct hci_ev_cmd_complete evt_hdr;
	uint8_t type = HCI_EVENT_PKT;

	hdr.evt = HCI_EV_CMD_COMPLETE;
	hdr.plen = sizeof(struct hci_ev_cmd_complete) + data_len;
	evt_hdr.ncmd = 1;
	evt_hdr.opcode = opcode;

	iv[0].iov_base = &type;
	iv[0].iov_len = sizeof(type);
	iv[1].iov_base = &hdr;
	iv[1].iov_len = sizeof(hdr);
	iv[2].iov_base = &evt_hdr;
	iv[2].iov_len = sizeof(evt_hdr);
	iv[3].iov_base = data;
	iv[3].iov_len = data_len;

	if (writev(fd, iv, 4) < 0)
		LOGE("writev(cmd_complete) failed");
}

static void process_command_pkt(int fd, char *buf, ssize_t buf_size)
{
	struct hci_command_hdr *hdr = (struct hci_command_hdr *)buf;

	if (buf_size < (ssize_t)sizeof(struct hci_command_hdr))
		return;

	switch (hdr->opcode) {
	case HCI_OP_READ_BD_ADDR: {
		struct hci_rp_read_bd_addr rp;
		memset(&rp, 0, sizeof(rp));
		rp.status = 0;
		memset(&rp.bdaddr, 0xaa, 6);
		hci_send_event_cmd_complete(fd, hdr->opcode, &rp, sizeof(rp));
		return;
	}
	case HCI_OP_READ_BUFFER_SIZE: {
		struct hci_rp_read_buffer_size rp;
		memset(&rp, 0, sizeof(rp));
		rp.status = 0;
		rp.acl_mtu = 1021;
		rp.sco_mtu = 96;
		rp.acl_max_pkt = 4;
		rp.sco_max_pkt = 6;
		hci_send_event_cmd_complete(fd, hdr->opcode, &rp, sizeof(rp));
		return;
	}
	case HCI_OP_WRITE_SCAN_ENABLE: {
		uint8_t status = 0;
		hci_send_event_cmd_complete(fd, hdr->opcode, &status,
					    sizeof(status));
		return;
	}
	}

	{
		char dummy[0xf9];
		memset(dummy, 0, sizeof(dummy));
		hci_send_event_cmd_complete(fd, hdr->opcode, dummy,
					    sizeof(dummy));
	}
}

static void *event_thread(void *arg)
{
	(void)arg;
	prctl(PR_SET_NAME, "syzhci", 0, 0, 0);
	for (;;) {
		char buf[1024];
		ssize_t n;

		memset(buf, 0, sizeof(buf));
		n = read(vhci_fd, buf, sizeof(buf));
		if (n < 0) {
			if (errno == EINTR)
				continue;
			return NULL;
		}
		if (n > 0 && (uint8_t)buf[0] == HCI_COMMAND_PKT)
			process_command_pkt(vhci_fd, buf + 1, n - 1);
	}
	return NULL;
}

static void rfkill_unblock_all(void)
{
	struct my_rfkill_event ev;
	int fd = open("/dev/rfkill", O_WRONLY);

	if (fd < 0) {
		return;
	}
	memset(&ev, 0, sizeof(ev));
	ev.idx = 0;
	ev.type = RFKILL_TYPE_ALL;
	ev.op = RFKILL_OP_CHANGE_ALL;
	if (write(fd, &ev, sizeof(ev)) < 0)
		LOGE("write rfkill failed");
	close(fd);
}

static void inject_fake_acl_link(void)
{
	struct hci_ev_conn_request request;
	struct hci_ev_conn_complete complete;
	struct hci_ev_remote_features features;

	memset(&request, 0, sizeof(request));
	memset(&request.bdaddr, 0xaa, 6);
	request.bdaddr.b[5] = 0x10;
	request.link_type = ACL_LINK;
	hci_send_event_packet(vhci_fd, HCI_EV_CONN_REQUEST, &request,
			      sizeof(request));

	memset(&complete, 0, sizeof(complete));
	complete.status = 0;
	complete.handle = HCI_HANDLE_1;
	memset(&complete.bdaddr, 0xaa, 6);
	complete.bdaddr.b[5] = 0x10;
	complete.link_type = ACL_LINK;
	complete.encr_mode = 0;
	hci_send_event_packet(vhci_fd, HCI_EV_CONN_COMPLETE, &complete,
			      sizeof(complete));

	memset(&features, 0, sizeof(features));
	features.status = 0;
	features.handle = HCI_HANDLE_1;
	hci_send_event_packet(vhci_fd, HCI_EV_REMOTE_FEATURES, &features,
			      sizeof(features));
}

static int setup_vhci(void)
{
	struct vhci_vendor_pkt_request vendor_pkt_req;
	struct hci_dev_req dr;
	pthread_t th;
	char buf[1024];
	ssize_t n;
	int ret, tries;

	hci_sock = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
	if (hci_sock < 0) {
		return -1;
	}

	vhci_fd = open("/dev/vhci", O_RDWR);
	if (vhci_fd < 0) {
		return -1;
	}

	vendor_pkt_req.type = HCI_VENDOR_PKT;
	vendor_pkt_req.opcode = HCI_PRIMARY;
	if (write(vhci_fd, &vendor_pkt_req, sizeof(vendor_pkt_req)) !=
	    (ssize_t)sizeof(vendor_pkt_req)) {
		return -1;
	}

	for (tries = 0; tries < 64; tries++) {
		memset(buf, 0, sizeof(buf));
		n = read(vhci_fd, buf, sizeof(buf));
		if (n < 0) {
			return -1;
		}
		if (n >= 4 && (uint8_t)buf[0] == HCI_VENDOR_PKT) {
			hci_dev_id = (uint8_t)buf[2] |
				     ((uint8_t)buf[3] << 8);
			break;
		}
		if (n > 0 && (uint8_t)buf[0] == HCI_COMMAND_PKT)
			process_command_pkt(vhci_fd, buf + 1, n - 1);
	}
	if (hci_dev_id < 0) {
		return -1;
	}

	if (pthread_create(&th, NULL, event_thread, NULL)) {
		return -1;
	}
	pthread_detach(th);

	ret = ioctl(hci_sock, HCIDEVUP, hci_dev_id);
	if (ret) {
		if (errno == ERFKILL) {
			rfkill_unblock_all();
			ret = ioctl(hci_sock, HCIDEVUP, hci_dev_id);
		}
		if (ret && errno != EALREADY) {
			return -1;
		}
	}

	memset(&dr, 0, sizeof(dr));
	dr.dev_id = hci_dev_id;
	dr.dev_opt = SCAN_PAGE;
	if (ioctl(hci_sock, HCISETSCAN, &dr)) {
		return -1;
	}

	inject_fake_acl_link();
	usleep(200000);
	return 0;
}

static pthread_barrier_t barrier;
static volatile int fd0 = -1;
static volatile int fd1 = -1;
static volatile int connect_err0;
static volatile int connect_err2;

static void fill_addr(struct sockaddr_l2 *sa)
{
	memset(sa, 0, sizeof(*sa));
	sa->l2_family = AF_BLUETOOTH;
	sa->l2_psm = 0x0021;
	memset(&sa->l2_bdaddr, 0xaa, 6);
	sa->l2_bdaddr.b[5] = 0x10;
	sa->l2_cid = 0;
	sa->l2_bdaddr_type = 0;
}

static void *thread0(void *arg)
{
	struct sockaddr_l2 sa;

	(void)arg;
	prctl(PR_SET_NAME, "syzrepro0", 0, 0, 0);
	fill_addr(&sa);
	pthread_barrier_wait(&barrier);

	usleep(20000);
	errno = 0;
	if (connect(fd0, (struct sockaddr *)&sa, 14) < 0)
		connect_err0 = errno;
	else
		connect_err0 = 0;
	return NULL;
}

static void *thread1(void *arg)
{
	(void)arg;
	prctl(PR_SET_NAME, "syzrepro1", 0, 0, 0);
	pthread_barrier_wait(&barrier);
	shutdown(fd0, SHUT_RDWR);
	return NULL;
}

static void *thread2(void *arg)
{
	struct sockaddr_l2 sa;

	(void)arg;
	prctl(PR_SET_NAME, "syzrepro2", 0, 0, 0);
	fill_addr(&sa);
	pthread_barrier_wait(&barrier);

	usleep(100000);
	errno = 0;
	if (connect(fd1, (struct sockaddr *)&sa, 14) < 0)
		connect_err2 = errno;
	else
		connect_err2 = 0;
	return NULL;
}

static int link_is_gone(int err)
{
	return err == EHOSTUNREACH || err == ECONNREFUSED ||
	       err == EOPNOTSUPP || err == ETIMEDOUT || err == ENOTCONN ||
	       err == EIO;
}

int main(void)
{
	int iters = 40;
	int i;

	setvbuf(stdout, NULL, _IOLBF, 0);

	if (setup_vhci() < 0) {
		return 1;
	}

	for (i = 0; i < iters; i++) {
		pthread_t t0, t1, t2;

		fd0 = socket(AF_BLUETOOTH, SOCK_SEQPACKET | SOCK_NONBLOCK,
			     BTPROTO_L2CAP);
		if (fd0 < 0) {
			return 1;
		}
		fd1 = socket(AF_BLUETOOTH, SOCK_SEQPACKET | SOCK_NONBLOCK,
			     BTPROTO_L2CAP);
		if (fd1 < 0) {
			close(fd0);
			return 1;
		}

		connect_err0 = -1;
		connect_err2 = -1;

		if (pthread_barrier_init(&barrier, NULL, 3)) {
			return 1;
		}
		if (pthread_create(&t0, NULL, thread0, NULL) ||
		    pthread_create(&t1, NULL, thread1, NULL) ||
		    pthread_create(&t2, NULL, thread2, NULL)) {
			return 1;
		}
		pthread_join(t0, NULL);
		pthread_join(t1, NULL);
		pthread_join(t2, NULL);
		pthread_barrier_destroy(&barrier);

		close(fd0);
		close(fd1);

		if (i == 0 || (i % 5) == 0)
			LOG("iter %d: connect0=%d connect2=%d", i,
			    connect_err0, connect_err2);

		if (link_is_gone(connect_err0) || link_is_gone(connect_err2)) {
			inject_fake_acl_link();
			usleep(200000);
		}
	}

	return 0;
}
==================================================================

Crash log:
==================================================================
Oops: general protection fault, probably for non-canonical address 0xfbd59bffffffffcc: 0000 [#1] SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0xdeacfffffffffe60-0xdeacfffffffffe67]
CPU: 3 UID: 0 PID: 404 Comm: syzrepro2 Not tainted 7.2.0-dirty #2 PREEMPT 
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__l2cap_get_chan_by_scid net/bluetooth/l2cap_core.c:112 [inline]
RIP: 0010:l2cap_alloc_cid net/bluetooth/l2cap_core.c:261 [inline]
RIP: 0010:__l2cap_chan_add+0x178/0x770 net/bluetooth/l2cap_core.c:644
Code: e9 64 04 00 00 4d 8b 6d 00 4d 39 e5 0f 84 e7 03 00 00 49 8d ad 66 fd ff ff 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 89 00 00 00 49 8d 85 40 fd ff ff 66 44 39
RSP: 0018:ffff8881094e7c78 EFLAGS: 00010a07
RAX: 1bd59fffffffffcc RBX: ffff888109aae000 RCX: dffffc0000000000
RDX: 0000000000248940 RSI: 000000070eb25f82 RDI: 0000000000248919
RBP: deacfffffffffe66 R08: 0000000000000003 R09: 0000000000000003
R10: dffffc0000000000 R11: ffffffff9baf4880 R12: ffff8881076f3940
R13: dead000000000100 R14: ffff8881076f3800 R15: 0000000009aa0041
FS:  00007c16caf7a6c0(0000) GS:ffff88817b87f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007c16cc8b1ed0 CR3: 0000000106c78000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 l2cap_chan_connect+0x630/0xb90 net/bluetooth/l2cap_core.c:7404
 l2cap_sock_connect+0x324/0x4c0 net/bluetooth/l2cap_sock.c:259
 __sys_connect_file net/socket.c:2135 [inline]
 __sys_connect+0x20e/0x2d0 net/socket.c:2154
 __do_sys_connect net/socket.c:2160 [inline]
 __se_sys_connect net/socket.c:2157 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2157
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7c16cc88b7fb
Code: 83 ec 18 89 54 24 0c 48 89 34 24 89 7c 24 08 e8 3b b0 f7 ff 8b 54 24 0c 48 8b 34 24 41 89 c0 8b 7c 24 08 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 08 e8 91 b0 f7 ff 8b 44
RSP: 002b:00007c16caf79e80 EFLAGS: 00000293 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007c16caf7a640 RCX: 00007c16cc88b7fb
RDX: 000000000000000e RSI: 00007c16caf79eab RDI: 0000000000000006
RBP: 00007c16caf79eab R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000293 R12: ffffffffffffff80
R13: 0000000000000072 R14: 00007ffc0dfae990 R15: 00007c16ca77a000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__l2cap_get_chan_by_scid net/bluetooth/l2cap_core.c:112 [inline]
RIP: 0010:l2cap_alloc_cid net/bluetooth/l2cap_core.c:261 [inline]
RIP: 0010:__l2cap_chan_add+0x178/0x770 net/bluetooth/l2cap_core.c:644
Code: e9 64 04 00 00 4d 8b 6d 00 4d 39 e5 0f 84 e7 03 00 00 49 8d ad 66 fd ff ff 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 89 00 00 00 49 8d 85 40 fd ff ff 66 44 39
RSP: 0018:ffff8881094e7c78 EFLAGS: 00010a07
RAX: 1bd59fffffffffcc RBX: ffff888109aae000 RCX: dffffc0000000000
RDX: 0000000000248940 RSI: 000000070eb25f82 RDI: 0000000000248919
RBP: deacfffffffffe66 R08: 0000000000000003 R09: 0000000000000003
R10: dffffc0000000000 R11: ffffffff9baf4880 R12: ffff8881076f3940
R13: dead000000000100 R14: ffff8881076f3800 R15: 0000000009aa0041
FS:  00007c16caf7a6c0(0000) GS:ffff88817b87f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007c16cc8b1ed0 CR3: 0000000106c78000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	e9 64 04 00 00       	jmpq   0x469
   5:	4d 8b 6d 00          	mov    0x0(%r13),%r13
   9:	4d 39 e5             	cmp    %r12,%r13
   c:	0f 84 e7 03 00 00    	je     0x3f9
  12:	49 8d ad 66 fd ff ff 	lea    -0x29a(%r13),%rbp
  19:	48 89 e8             	mov    %rbp,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 89 00 00 00    	jne    0xbf
  36:	49 8d 85 40 fd ff ff 	lea    -0x2c0(%r13),%rax
  3d:	66                   	data16
  3e:	44                   	rex.R
  3f:	39                   	.byte 0x39
==================================================================
