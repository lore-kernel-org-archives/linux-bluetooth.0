Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9348948EC8F
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023631; cv=none; b=LmxH3azBS+A9SPuJfML3lWkqKoMh7/Q4yeJ4LJO1ip41IEzSwiBEVRUC89nmN+a86KOm2qS2W0hdQPfF2a/zFLclxFSz2qDshIMvN1Fslg5i6pfg3EFpugmVWuDggc8NvcLkfes9uCqx1zFPzxa1viSd6Bq4xi9OPWUi/x5OcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023631; c=relaxed/simple;
	bh=MV7RiR6W0DdvUeaQFawzScELZf5hsaqpR3KqO5TM2Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VghjFJQjx4lriec8crT4PxjCyx/mrN26PgLR/J41PoHtH24FudTnPP9Dr1C05opOWi/j1YxL/Du86b2uaLfrxNZQAGQ2s5cujHJBS1ZC+hGxHCMiPkqE3IdRey5aaLoZfw79Q6/RqRy/caArjgAmgnm+67ua0G7ffzXqG4JmtSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFPnD/Am; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFPnD/Am"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843af75de5so321025f8f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 13:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790023628; x=1790628428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9mOmL9SvVshKYNZ0r/7zlGOsfnLDo6V4iPZoibQd06o=;
        b=nFPnD/AmNvSvrWWvQ7Al1RNsHDvFJDhg5lHhzzTPqGP6uCvFDS+3CdOmHz0OJuMOa4
         waNVawG6+szprK1/vw6WO6akd/PAAXdqK/tkXzyNQnWN3dHFqVFjF/kJ7+2/3muSVMc+
         mt00SlGCjfSNlBbZSZjAs1SwG8uJvCkUrV1EPAVvQj/ZTy4FzSYdxJnlTkFTsFNbaSvm
         eSj8ZjNslzY7GyFHhEaQK0osMUUTsOPBIVDJEbAHgBUtdLXGYCmqrU784cWUrieYi1dh
         sXafBSANvjS6BUDgDCU+O8Q8v2DPAZGVR3KS8Vz+Ml8xOtkTLhEx42YNll3SZUnzhGwL
         KhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790023628; x=1790628428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9mOmL9SvVshKYNZ0r/7zlGOsfnLDo6V4iPZoibQd06o=;
        b=tZVRkodhqMo0T/KgbvmRCXS0UrRdPZCRqi7Sc+GenOPtthQRG3sayA/1vi+Ph8/buN
         g0WbDBgA5+Ah1GQ7O0/WaB0xakeoCVyMoV+ZndG+jNMsaGqh7nmzzYH9lGTi3bL9uAvF
         V29+HcMCdDIjTpmqEZ1M0O5bja7NOVpbD8g3CsldRhmHmpXSTordYiL7IyMTrXw1bgCM
         vJhDCbz2ejb5CC1MywR/SJ6fHxbFquBznF1s5eMyrv/HqHhJNvXbYSIEvU0Ww2OMDl2s
         D/vjvByF0jt9hmq6zhq9+OdP9Q0hASRRsy2zUZYiqjQ1YGFHmKb0bT7MfTfg59ysJzmp
         6hOQ==
X-Gm-Message-State: AFuF++mV5sZoqkJGt33e3WjSmAgZNiGMPOYnye/zvS+U9sjnS+sykbbc
	7Uo5wavnYQh3c5z5Br1YSkCzfwFxU8nmrf9th7Nf6W9x2xYbwHo20wFPrCnjFoef
X-Gm-Gg: AYBFou2SMA3xaUbV9KruZKRX9W6e9x5KoXDg/fNKtbxupaPWYS2lmwcTQFbY2ZA7UQY
	ZMPk61S4dh0odEDF9bAthaL+ao8GZfhmnePKVWiEgFpNB0G7XM7ag2yuy2Beg3zkLxD347snQ72
	ckecqBJJVAVkEYSX1Jy/SsR1Yf0B7k20UpQwK1PSz5gUGCSdFYyuqjN47oHW//8hLJMQXaisMQG
	PCKvgRyUSO9oFvXphZVeXHoksu7wbiVf26CW59CHlnt0i19GPaHcG8GZFjzExGin6PZvUMHc+/S
	+GnHKwxM4WpxkKxgpph4GOYsCNpYYKKvffqTZz/FG6oGdAOYe9CxxxeiplwcP118az334NpJ58A
	+B118cg771zofRKPefePTGb6PHI+Fozk1Qd3gsDpgMsjRp2TuWm/5Jp/3yIC65TvDrse8dXHGzi
	CpY7shFCrjX5uHPdrcE2aHUjn4ai4HYsTU82jYZHFFFM0AYf5Y5tglilumWXTbukHj/gUzXHoQ+
	zsJZ3J6rx8+QPb7sopth+vsPBO/D3CJa2p+5nITeeyi1aCI97hkRBOg61wih2OJKw==
X-Received: by 2002:a05:600c:354e:b0:49e:479b:c13b with SMTP id 5b1f17b1804b1-49fc7dff668mr151005025e9.1.1790023627400;
        Mon, 21 Sep 2026 13:47:07 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc5755c40sm328142435e9.3.2026.09.21.13.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:47:07 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Subject: [PATCH BlueZ v2] adapter: Fix crash on short start discovery reply
Date: Mon, 21 Sep 2026 22:47:06 +0200
Message-ID: <20260921204706.211385-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

start_discovery_complete() validates the reply length before using the
returned parameters:

    if (length < sizeof(*rp)) {
        btd_error(adapter->dev_id,
            "Wrong size of start discovery return parameters");
        discovery_complete(adapter, MGMT_STATUS_FAILED);
        return;
    }

but that check sits below the branch taken when the discovery client
list has emptied while the command was pending, and that branch has
already dereferenced the reply:

    if (!adapter->discovery_list) {
        struct mgmt_cp_stop_discovery cp;

        if (status != MGMT_STATUS_SUCCESS)
            return;

        /* Stop discovering as there are no clients left */
        cp.type = rp->type;      <-- rp may be NULL here

mgmt_cp_start_discovery is a single uint8_t, so rp->type is a one-byte
read at offset 0 and a NULL rp faults immediately.

The mgmt layer can invoke a command callback with no reply parameters:
src/shared/mgmt.c passes length 0 and a NULL param on the Command
Status path:

    case MGMT_EV_CMD_STATUS:
        ...
        DBG(mgmt, "[0x%04x] command 0x%02x status: 0x%02x", ...);
        request_complete(mgmt, cs->status, opcode, index, 0, NULL);

Observed as a crash on a QCA9377 (13d3:3503) whose controller stops
answering HCI during audio use. The archived session logs show exactly
that sequence: the daemon's debug log (bluez 5.72) ends with the
Command Status delivery and the callback entry, for the Start Discovery
it had sent 2.05 s earlier, ten seconds after its last discovery client
had gone; the contemporaneous kernel log records the resulting fault:

  bluetoothd:
  21:03:16.750  discovery_remove() owner :1.125
  21:03:24.943  send_request() [0x0000] command 0x0023
  21:03:26.994  can_read_data() [0x0000] command 0x23 status: 0x00
  21:03:26.994  start_discovery_complete() status 0x00
  kernel:
  21:03:26.995  bluetoothd[2821]: segfault at 0 ...

"command ... status:" is the Command Status branch (Command Complete
logs "complete:"), so the callback ran with status 0, length 0 and a
NULL param, found discovery_list empty, and faulted on rp->type. The
crash site was resolved from the shipped binary:

  bluetoothd[2821]: segfault at 0 ip 00005d6eb1ad1986 \
      sp 00007ffef8e784b0 error 4 in bluetoothd[a6986,5d6eb1a50000+f3000]

  a6986:  41 0f b6 45 00    movzbl 0x0(%r13),%eax  <-- cp.type = rp->type
  a698b:  0f b7 53 04       movzwl 0x4(%rbx),%edx  <-- adapter->dev_id
  a6992:  4c 8d 45 d7       lea    -0x29(%rbp),%r8 <-- &cp

The same delivery, a Command Status with status 0x00 answering a Start
Discovery just sent, was logged five more times on that machine: four
in the crashing daemon's own lifetime and once on a later day. On each
of those the client list was non-empty, so the existing check below
the branch handled it ("Wrong size of start discovery return
parameters"); when the list is empty the branch above is reached
first.

Why the kernel answers Start Discovery with a successful Command
Status rather than the usual one-byte Command Complete is not
established here. The crashing instance arrived while the controller
was timing out HCI commands; the fix does not depend on the cause.

Perform the same length validation before using the reply in the
no-clients branch. The check is added inside that branch rather than
hoisted above it, so that no other path changes behaviour.

Fixes: 3597d1377723 ("adapter: Fix not waiting for start discovery result")
---
v2: quoted code indented with spaces instead of tabs; the quoted fault
    lines re-wrapped to 75 columns. No change to the code.

Context, not part of the change: the crash was recorded on a QCA9377
(13d3:3503) laptop under Ubuntu 24.04 / bluez 5.72-0ubuntu5.5 and the
site was resolved from the stripped distro binary, then checked against
a retained core; the archived session record (daemon debug log and the
kernel log beside it) independently shows the same sequence: client
removed, Start Discovery sent, Command Status 0x00, fault. This guard
has not fired since it was installed; the delivery it guards against
was logged five more times with clients present, so the pre-existing
check caught those. The record and the crash-site method are public:
https://github.com/ivoitovych/qca9377-bt-hang  (patches/bluez/README.md)

 src/adapter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1863,6 +1863,12 @@
 		if (status != MGMT_STATUS_SUCCESS)
 			return;

+		if (length < sizeof(*rp)) {
+			btd_error(adapter->dev_id,
+				"Wrong size of start discovery return parameters");
+			return;
+		}
+
 		/* Stop discovering as there are no clients left */
 		cp.type = rp->type;
 		mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
--
2.43.0
