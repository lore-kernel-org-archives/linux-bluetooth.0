Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119815;
	b=dt1vBEANoYPE1YuLPTqAL6hQ8MVmoOJV2J5LAGRFLc0noPOmh2IzykC7ts7Ez6BWHunU
	 3ywYZ5rScw0smgB0sabgFPH78upNWaP6fJKDgq7vwtMg4nTdIsBfWM32geqHkPts3t67/
	 JIoP/Y4nWXNnrGwdpUTUxCiDw9ImL+Tx5XSsl0PY1lNBNfrG45UUh4ZTXyO0ZSCPEKaqQ
	 AQQvfTMpqdK3Smh32s1dM2gMF6nd1vQjMMqBpdZPuxuOkYl3WDQ0I8Wfu12QplQ7jyCpp
	 6tKa8UhbVh8U+NwXnWmlpRGSsEPELn7Cb32MWGtnbVoy7rZtVU5Huzj7lQTjcQTJSqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Kt8xctJObRMYGsVaiB32AMjRbSb2Ml/DQO8cDDWMP2g=;
	b=BbHS1SY2VpkswFgJps4kDw7MgAFIYJzrVtosAezr+VM/MgVmngfDvA+nxBxFDoqMigS8
	 VD1wH+76VRxqw8FRBlV9gNfy0zFnis2YiQI7EnJRtlq8xthDcQHVIyYdo7m8tg3wLEqYq
	 NKre0blfVnMLt9yX8Jm6QAuTCjFdqb0f4wvADeuOvvkUIzEj3AUwllibwTxl5EazdEMaQ
	 zKf6LwFnxQGjS8UbqC2r/fxxvrqczaxHR8Tk1UvSHYFDaXS8kb3IHpkpn0116P6IGjkTb
	 z3FGYBcQFkbqIJZKWmH8csZr2wT52SiaQaxTgXsLNjoodn/9flJg6+Zxb+QyGml6vBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d91dC0vk;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7C606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 16:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28F7C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d91dC0vk
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8459fdb1e17so7503a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119814; x=1793724614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kt8xctJObRMYGsVaiB32AMjRbSb2Ml/DQO8cDDWMP2g=;
        b=d91dC0vkZ5D3Pa/mNLxlpxqFhQQa6HWkpC2tuG1XmIm6zNbw26BXtwhx5/vApwbNmh
         EPONz5KSEySDOMz5310y4T2CHHAY5mQaiaMeFJPV9/bAuxEaQTOOrpH5JW0/LM1zdqWl
         Pixkd9QXlEYLVtIxwM0vgZ/bJ/psptyxStReo1aKPCONIPxzV3YaGXbPLtEI4gz2446j
         Vh4DjKiauCbDhWansOr2ThNEMQUqdEILnjJETu221DijrtLWm9jYUORMfkaIwEWeGKhE
         h9+xsl0RdwR89ve6oSW6HTpFtUQjle+dV3fZCMKxkK4EtXf38Kdf87KpF10EHAszK0fr
         Q7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119814; x=1793724614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kt8xctJObRMYGsVaiB32AMjRbSb2Ml/DQO8cDDWMP2g=;
        b=qfy0ofHDW0xWknAQRqQjF7DGK7/qfSjUyJDoAQcvNR668zNDNEys+ztzfRdMzmuO0h
         3tsrsxClVaANqf0jJD98zE05SLElXZPkrrSR1CuaDoF1XpFzZpIFA5k+5kyHZ49up7Ti
         VWirEghIqaWdGwAzKiniYC8/eRf/epXtg7bDa6XjN89ACDfczL/KpdjDAMAlb2U67hTM
         eQUzCfKvZWUs55MNBHAxPnQv0R9+cKokKTzaeDOMv5P5FeS+xjh0ZN0HS1DvaCKeBLUK
         lqcfTbQnRhO0bfaDYIlcwEqD47HPxebwBO6aAVkko3RMuAxzycAWqfTUT3Qf5gOs9mTV
         zWOQ==
X-Gm-Message-State: AFq9FYIEDkK/BpJ+m6SFhqc34W8AKykaRe8BeaOCRSOIRPXZADAFTkt2
	xN6Um4QNWghMF7oKyEDTLOSITTlRx1XIYzGZOPNXFny5oaAI5iNRXDwYWxxJz3hjeZXpTA==
X-Gm-Gg: AYBFou2L0950j4aIX4aJC6//RmYJPZW6ySJIlbd2dcW20pWJn2Wp0uuDe0/yb77zHcX
	Ks3J5LgwXzQQeBzfDliOZnDcm99FDBEt4H8Zh4G2rNtex300WMn8sJOIownnNazRHOCESFnqPmk
	JCa8bKif2MTnUWd5vccFtc/K14l6rCkHeop6wUiP678jKWeVAu1JsIQJ1GPCI53rUyvEcikwy28
	DwFNEtRUX0ndnafaeSoqT9baeRl9DrX0OtscyYxbuzMOD7vqVaS1koR4DwwIuMfM0bu7hHLiE5q
	L69sjnMy2mj+PapOvbWhG60JHHN8XvGikoEyJj4JcFnG41rFA4jhc2z2P8ty3Bc7wNeJc7n6VEt
	qsY6KFPOA1IUTFhCa4fJ3SsQffKTCQ7KReMQDfcyq6mms6fRDwvgnj9GMuSte6P5v+rtuVM1MGG
	Nk9iMvoc3adq0AlWehNpjJ5A6MLWIfHGKlml8uASqNrrz7df18BK5iZixlrSQTOUfIc1CG8gc1g
	b34iGCvHpYZ8ibngwOPpcehMljozCjg6sdx2vlOTX9CqYw6x98gAajvQTCxpZIl2ISg6y427y2v
	Mfa/XaYHqOOli0MZXfpCsKOYuYVBRp1AaJo=
X-Received: by 2002:a05:6830:6382:b0:845:3cfe:5f2 with SMTP id 46e09a7af769-85ab32c1126mr280469a34.0.1793119814062;
        Tue, 27 Oct 2026 09:50:14 -0700 (PDT)
Received: from localhost.localdomain ([37.19.221.77])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb0749dcsm10927058a34.11.2026.10.27.09.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:50:13 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Cen Zhang <zzzccc427@gmail.com>,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Hitalo Souza <enghitalo@gmail.com>,
	Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 0/3] Bluetooth: hci_conn: fix SCO connection reuse
Date: Tue, 27 Oct 2026 17:50:06 +0100
Message-ID: <20261027165009.2401154-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An HFP codec change can leave a headset silent. The new SCO socket
reports a successful connect(), but no new SCO link is established.

PipeWire closes the old SCO socket and immediately connects another
to the same headset. If the headset replies to AT+BCS before the old
link's Disconnection Complete arrives, hci_connect_sco() reuses the
connection being torn down.

That connection remains BT_CONNECTED while its Disconnect is pending.
No Setup Synchronous Connection is sent, yet the new socket reports
success. When the old link's Disconnection Complete arrives, the new
socket is closed with ECONNABORTED.

This series fixes three related problems.

Patch 1 corrects hold ownership when reusing a SCO connection whose
link is still up. A second connect() correctly returns EBUSY, but
also drops the first socket's hold and disconnects its working link.
Give the second caller its own hold and release the extra ACL hold,
following the CIS fix e06d549fcd4a. EBUSY remains the result, but
the existing link survives.

Patch 2 prevents reuse of a connection already committed to
teardown. If abort_reason is set, return -ECONNABORTED immediately
instead of handing the dying connection to a new socket.

Patch 3 closes the remaining race before abort_reason is set. A
running hci_conn_timeout() may already have observed that no holder
remains when a new connect() takes a hold. Wait for that worker and
check abort_reason again before using the connection.

A connect() arriving before the worker starts cancels the pending
disconnect with the hold patch 1 gives it, and keeps the live link.
Patches 2 and 3 leave that case unchanged.

Testing

The series was tested on bluetooth-next 27731ba09195 in QEMU with
BlueZ's emulator, on uniprocessor, SMP and KCSAN kernels, with
lockdep enabled. The accompanying BlueZ patch adds three sco-tester
cases:

  "Reconnect After Disconnect"
  "Reconnect During Disconnect"
  "Connect Twice"

"Reconnect During Disconnect" and "Connect Twice" fail without the
series on the uniprocessor and SMP kernels, and pass with it in three
runs each on the uniprocessor, SMP and KCSAN kernels. "Reconnect
After Disconnect" passes with and without the series. In the full
sco-tester, iso-tester, l2cap-tester and mgmt-tester runs, the only
other differences were two mgmt-tester cases that timed out
intermittently on SMP. Neither involves SCO, and one also timed out
without the series.

Patch 3's race was reproduced by a debug-only change that pauses
hci_conn_timeout() after it observes no holder; the change widens
the window and is not part of this series. Both host-initiated and
remote-initiated SCO links were tested. With patches 1 and 2 alone,
the new socket is still reported connected and then aborted. With
patch 3, connect() returns -ECONNABORTED.

The series also applies unchanged to bluetooth-next 47d4d9f67e92,
the base of this posting. On that base, sco-tester passes all 33
cases with the series; without it, only "Reconnect During
Disconnect" and "Connect Twice" fail. The other testers were not
rerun on this base.

Hardware testing

The series was also run on the QCA9377 laptop where the bug was
found, with PipeWire 1.0.5 and three headsets. The laptop ran
Ubuntu 24.04's 7.0.0-38 kernel with its Bluetooth module rebuilt
with abd93c85c8667, 816fb1590a4c and this series; the two
prerequisites are explained below.

Over more than a day and a half of ordinary use, from 23 to 25
October, three codec changes on earbuds that reply to AT+BCS before
the old link's Disconnection Complete returned ECONNABORTED instead
of reporting a connected socket without a link. On two other
headsets, which reply after that event, all eight codec changes
established a new link.

All 36 SCO links in the HCI capture of those days ended with a
successful Disconnection Complete for their handle, and no HCI
command timeout was logged. A search of the boot's kernel log found
no WARNING, BUG, Oops, Call Trace, refcount or use-after-free
report. Its only error-level lines are "SCO packet for unknown
connection handle" and "corrupted SCO packet", which this
controller also logs without the series.

Patch 1's case was tested separately on 26 October. While a
headset's eSCO link carried audio, three attempts to connect a
second SCO socket to the same headset each returned EBUSY at once.
The HCI capture shows no new setup or disconnect during the
attempts, and SCO packets kept flowing in both directions.

Patch 3's race was not reproduced on hardware; it is covered by the
emulator test described above.

Remaining codec-switch delay

The series stops connect() from succeeding on a connection already
being torn down. It does not, by itself, make PipeWire's codec
change seamless.

PipeWire 1.0.5 retries ECONNABORTED at once, while the old link is
still being disconnected, so those retries fail too. With a stream
playing on the laptop, audio returned about five seconds later,
when WirePlumber suspended the failed nodes and the next connect
established a new link.

In an earlier reproduction without the series, on Ubuntu 7.0.0-34,
the same codec change produced no Setup Synchronous Connection, and
sounds started 2 to 26 seconds later were still silent. That was a
historical observation, not a same-build control.

A separate prototype defers the new connect until the old link has
been torn down. It lets the retry succeed in the emulator tests but
has not been run on hardware. It builds on this series and changes
connect() semantics, so I can post it as an RFC if that approach is
preferred.

Related work

The series is independent of Hitalo Souza's pending SCO setup
series and applies with or without it:
https://patchwork.kernel.org/project/bluetooth/list/?series=1181908

Jeremy Dean Clifton's pending "hci_core: Fix queuing disc_work while
workqueue is drained" (syzbot's "WARNING in hci_connect_sco") is on
the same path but does not overlap: it changes hci_conn_drop() in
hci_core.h.

Stable and downstream kernels

For stable, patch 1 applies alone on 6.6.y and 6.12.y, which have
the 8a5b0135d4a5 backport and the reuse path but not e6720779ae61.
Patches 2 and 3 apply on top of it on 6.18.y and 7.2.y. Each of
those heads was built and run with sco-tester without and with the
patches it needs: the cases for its bugs fail without them and pass
with them. 6.1.y has no reuse path, hence the "# 6.6.x" on patch 1.

Trees with e6720779ae61 but without 816fb1590a4c, such as Ubuntu
24.04's 7.0 kernel, need these two commits first:

  abd93c85c8667 ("Bluetooth: SCO: give the socket its own sco_conn
                 reference")
  816fb1590a4c ("Bluetooth: SCO: serialise sco_conn lifetime against
                sco_recv_scodata()")

Without them, sco_connect() does not put the sco_conn reference that
sco_conn_add() took when sco_chan_add() fails with EBUSY, and that
reference holds the hci_conn: once patch 1 stops the disconnect, the
SCO link stays up after both sockets are closed. On Ubuntu
7.0.0-38's Bluetooth sources with those two commits, "Reconnect
During Disconnect" and "Connect Twice" fail without the series and
pass with it, uniprocessor and SMP.

Iaroslav Voitovych (3):
  Bluetooth: hci_conn: hold a reused SCO connection for its caller
  Bluetooth: hci_conn: don't reuse an aborting SCO connection
  Bluetooth: hci_conn: synchronize with SCO disconnect work before reuse

 net/bluetooth/hci_conn.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)


base-commit: 47d4d9f67e92d56ef3965f2727f9c98a5a611368
-- 
2.43.0

