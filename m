Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83828686
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 00:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779064098; cv=none; b=BZ8thv1nlGhvhl23cAtO+lLtZDNaYNu/4OO6FzqF47slBX8JlLgURG4mSbkBelcqtklPHjKaWEs70ginXR/MENX1LmQeNHEcBJyzlXb0YlPxsc2N4oLB8obpLpq1F1JVt33SZkanEhpJBfX2UrXYKX9yUC9Di89o+0aaX2Xt67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779064098; c=relaxed/simple;
	bh=Y0LxEBhsMr4gNxeNyXGpziEzfGFTgI7ItLbjmKjA4nY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROAkdle4ZpfaaS6afM+trw2xKtdJE9tWp4N6Bzm15UfILkpzL6LU5OzmLNMnYek5qWgEZmf6rtXWw70R2q6sflFcoZk2UjW1jGux7wdWFn7udaNEBmI2ti7g3sibJKiyVaVqChaSAgoEiO2ttTc3Gf31SuazoyOgE4hr8plfOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfd+zD//; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfd+zD//"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e5c7eb565so22846501cf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 17:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779064096; x=1779668896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Dj+Yd73bYH9NPALmuOPqYKQcj6z/TCA/BVWI2XWYRk=;
        b=kfd+zD//OGbkNygm6MdwT6e5jZpKihCdfd7Q5kDlltCxz0W7w4jHOwRXdToJU4wDPV
         PB+Vs9LFwNRY958zq+dvQWtGJjtGTB9dfT3vLg6MkQX687CZSlUYBwviol7ES7ScpSs8
         ekZbyWHW0ls1f5oY5vcsrDu2cLjVX1mzXAP9te0nQgS72INtiEDXbuAhjb9KcSp3VU4s
         FfgU3Z6mhoL/+21+FUFHxpIzGUZErv/TyXckFIHyr5zpqt4WlyeU7iP35PfwwXwV1AMN
         nyYAxHAVXWcIBkDPutTCmOSccG9Jj/LmfS5woipnlXzNxB6YgEeGFJeIRd4ualEt/vqC
         Gcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779064096; x=1779668896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Dj+Yd73bYH9NPALmuOPqYKQcj6z/TCA/BVWI2XWYRk=;
        b=KEQUduEIGcthjmkz/Eg/k2HNf5YdAVEqziHnQXi2qluyXfBt9ZPwzQS8Mfb0UToXcm
         nNGJAsXX8iFo5O0e7mT7o6Z51d6O/igb71/KOp9fJPhAz7jnpionBbf0LZrAIwIgxGBG
         2XZKetlEF7zk43FFLmEtS/bqM4U7h5ooKJ5UWrLEzDDzyYJjsxlN4oBfgWwnw0L+dVSu
         WoVp6ba0R0mQvj9nbxal3zPXhyJpgMjndrdhdGtgBk8iwRgROXO1VmLzAng8uqoAVTRm
         PVASn2Yp0ifNlaQ2VKDDiPXewXe6ZAHyrapXquMq6gfYSXGOG3Sy00boDwFvMGd+ikC7
         wibw==
X-Gm-Message-State: AOJu0Yxa6lIwxZQxYbgwsQMhZkoIAfzX97yaIBp8ooLYCc+yO2veYV4m
	p+BDNywhtWoW2ZtL+y2Tbdf/9hIbinidJmGOXIgjoGte3sf2U2hnMhDq
X-Gm-Gg: Acq92OHnRHlDNP5+Z2mho+u+bmuQTOOWDYaUMeEPS0iack1aEA859RQdZ7fODpOTH7e
	DxYnofNG8fe+qATEWrpSjvCcvjD0bJGwemP3NjdJ4/rGuXWavA2iZ/AfnQFGN0XGl8FwE4yA+AD
	Y2w1122u7o2l5HcfvqurzqZINoSilnghac9088ONqsYkQvMt33ZR0QYJn49CriaudxFOFgkGRqg
	B+E34T2vnC5CgbWX7ZT33q0NlH9HrbmOwuu+RbJOFFZNBE3+ddcCYRZefbEXYNm12bUmlQzVPzb
	2hxwEFhY1S5Sqz28jFDStzxIi9GaPU5zRtddiGDRYOepAo98R3cubE93pjIHSgVki3JxksQ5XkW
	pkNoO1Y2mm+uMZYIFSjPyA09lzPUpoW0rWUmGIM8ZZepRMkAPyt+181gQ98tZl7N6OjPk2HceTL
	+WfLjH+1p+g4YwESInj/vLmqcNwIKgGF6colz7GE5JQ3rham2aNhnCVBCZpf6OS70WibUz8SDSR
	FZgJ0d8gcAjs/Sy72ctqSyDS3pEs5SbFH6fNrhq/po=
X-Received: by 2002:a05:622a:54a:b0:50e:490c:7432 with SMTP id d75a77b69052e-5165a2ca13cmr182033201cf.48.1779064095658;
        Sun, 17 May 2026 17:28:15 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3619b03fsm37308476d6.37.2026.05.17.17.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 17:28:14 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: rate-limit ECHO_RSP per signaling PDU
Date: Sun, 17 May 2026 20:28:00 -0400
Message-ID: <20260518002800.1361430-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

l2cap_sig_channel() walks every L2CAP signaling command packed in
one inbound ACL frame and dispatches each to l2cap_bredr_sig_cmd().
The L2CAP_ECHO_REQ handler unconditionally calls

  l2cap_send_cmd(conn, ident, L2CAP_ECHO_RSP, cmd_len, data);

per request, with no per-PDU cap and no per-connection rate limit
anywhere in the path (HCI -> hci_conn -> l2cap_sig_channel ->
l2cap_bredr_sig_cmd).

A peer that packs N L2CAP_ECHO_REQ commands (4 bytes each) into a
single inbound signaling PDU forces the kernel to emit N separate
ACL frames carrying L2CAP_ECHO_RSP.  Measured between two
unmodified upstream kernels over real radio (Intel AX210 attacker,
Intel BE200 target):

  N=1   :    13 B in,    13 B out,  1 ACL frame back,  23 ms wall
  N=4   :    25 B in,    52 B out,  4 ACL frames back, 12 ms wall
  N=16  :    73 B in,   208 B out, 16 ACL frames back, 28 ms wall
  N=48  :   201 B in,   624 B out, 48 ACL frames back, 67 ms wall
  N=168 :   681 B in,  2184 B out, 168 ACL frames back, 220 ms wall

The 10x latency growth at N=168 vs N=1 (220ms vs 23ms) is the
target's signaling work-queue and radio TX queue saturating on the
burst.  A sustained flood (50 inbound PDUs of 168 packed echoes
each) drives ~840 ECHO_RSPs/sec from the target until the kernel's
input ACL queue back-pressures the attacker; during the attack
window the target's BT radio is fully occupied answering echoes
and any other ongoing BT traffic (audio, HID, file transfer) is
starved.  bluetoothd CPU stays at 0% throughout -- the entire path
is kernel-side.

L2CAP signaling channel CID 0x0001 is pre-auth, so no pairing is
required to reach the bug.  Reproducible from any device with a
programmable Bluetooth radio within range of a target running an
unpatched kernel with CONFIG_BT_BREDR=y (effectively every
Linux distribution that ships Bluetooth).

Cap the number of echoes answered per inbound signaling PDU to
L2CAP_SIG_ECHO_BURST (4).  Subsequent ECHO_REQs in the same PDU
are silently dropped.  Legitimate clients (l2ping, BlueZ test
suite, specification-compliant L2CAP) send one ECHO_REQ per PDU
and are unaffected.  Worst-case amplification ratio is now 4:1
per PDU, bounded.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
---
 net/bluetooth/l2cap_core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 77dec104a9c36..1c1179fddb8ba 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5626,11 +5626,25 @@ static inline void l2cap_sig_send_rej(struct l2cap_conn *conn, u16 ident)
 	l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
 }
 
+/*
+ * Maximum L2CAP_ECHO_REQ commands handled in a single inbound
+ * signaling PDU.  An inbound PDU may legitimately pack multiple
+ * commands, but a peer that packs many L2CAP_ECHO_REQs into one
+ * PDU triggers an N:1 outbound ECHO_RSP storm that saturates the
+ * link's signaling and ACL TX paths.  Cap the number of echoes
+ * answered per inbound PDU to a small burst.  Subsequent ECHO_REQs
+ * in the same PDU are silently dropped; the peer can pace itself
+ * with one ECHO_REQ per PDU (the l2ping shape and the only legit
+ * use that has ever been observed in the wild).
+ */
+#define L2CAP_SIG_ECHO_BURST	4
+
 static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 				     struct sk_buff *skb)
 {
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_cmd_hdr *cmd;
+	unsigned int echo_count = 0;
 	int err;
 
 	l2cap_raw_recv(conn, skb);
@@ -5656,6 +5670,13 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 			continue;
 		}
 
+		if (cmd->code == L2CAP_ECHO_REQ &&
+		    ++echo_count > L2CAP_SIG_ECHO_BURST) {
+			/* Drop excess echoes packed into one PDU. */
+			skb_pull(skb, len);
+			continue;
+		}
+
 		err = l2cap_bredr_sig_cmd(conn, cmd, len, skb->data);
 		if (err) {
 			BT_ERR("Wrong link type (%d)", err);
-- 
2.53.0

