Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623689;
	b=2PxDLkb9apCiz6fjf/6jLqNrEJ/PrrVyZO2zhawoTz5bkiwMuffkrvh96QZ737vdThQe
	 l98SU/s+C/jkNwpwMr4VRerxP9TLrewZW5DOQDCQQjrukMOve+dzY/chSdB7N+CCG4EKP
	 zkqmRVxFW7mYGw8U3AiFb9ZWUbznkShHJZd4M1XNTPPI0IAy0kl493KxnrWEHt5EP7vw+
	 /DnagPH9IeH37h4+228J+yh9E+PdV5zzYwoldJTTCdBjWXRpqApz4FPY92b+dTlQb+W40
	 WiLJSff3ALfr76WIUoVltOFhFioDGPBTiMDgIUJP0QNTlSxMmFTqVbCZcW8/ER9rg9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=W7XQ1lK2AkpuxOdKXFw0fuyYbrzIB2iq8ekUYi5fmdg=;
	b=LMeGJW3tU7dyZr+gu2Azk4Aw/KVskUZ2DwZlpROmiiF4/bx/ZoWzeKSapxKPlZ/iVPrq
	 Go3g1ykVs9z2f8vexJs7hD4c3oxNoQsM48gHthbhwHvQ7yzsvh81u4QZWJ3V7sjjDhQD/
	 wSgb4TxPQuxGywKuzvEjEPBi3dg55I1X5IQu4IIVuAyhro1vs/WiRulfyF6pEPzYZEKj2
	 /1yS3p02fHjP3GmJ6BQj2cYtW3LnPYcLy0bhX7WJK/aM+IyrjoV6uj1pAV81ofR/itDVS
	 KKP0yeUxV+nqBsyZhfjvKSjfdIBL5paHG1N72hDqfpjS7Db46wHEZFntHYhEtHonvzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qTt9Xst1;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A08F606A32E
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 12:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A08F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qTt9Xst1
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd623dfe420so2253292a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 04:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623688; x=1794228488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7XQ1lK2AkpuxOdKXFw0fuyYbrzIB2iq8ekUYi5fmdg=;
        b=qTt9Xst1C58chpctgKd3jl+TF9Fi6f5PMLz2RmIwzJ72YxjN7Jd0t4kKsHuNdgvhrX
         Rraisq6v3aEMycbIHMs7sR4sw8V9Lh9gfm+JxmopydJ2WOcclwgP4Qzn+HtDPtWDk98U
         iVMNCYGVRzc7CJT832B6HhEhAGbHXelXHhZBwpbH0nux96HLmOLz/7MJbzMHh5CQARxI
         K0USDJu5+E14v3sAebM7OLFDj+7ejpQPkRbxo32UfhCHWvGPASO1NWAfs1X4CXSWZVfH
         z+Xu3N3yjOJ6GhCGoYpxf690BpxGNI2NNf3PZBXAT6V4CVo4LW2O8BmoiQai42LMNJcI
         tJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623688; x=1794228488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7XQ1lK2AkpuxOdKXFw0fuyYbrzIB2iq8ekUYi5fmdg=;
        b=ZdhpkF+3QW3drT3IL6StZ1I51LS6z7FAngAzRYhfSEFzjDlX92ZS9nUDYzdsxfmkXU
         H42vVkJMy7l380IXEu5uy2MJV7Fcb66RwG0psNLDZ9gFZ96zJZfRESoVNsqVgtznKdK6
         n7ET9KQjyDrl7ZfZhzKP9mayoP+O8S62Pi0/Dw7wliRyOnAadEKhQgf0o8OdP91Wr4PH
         pPiHDKM6Ao3mjC2M/BJaG2gskqzZajeEH2+SnJ8rXvoF8AM0SpwFO6cE29g1Ba60Ok9f
         ZIAP6ym79TjpDZA7B0QRwWFhYbmYJTYftvpPxDsdQpwaPVtmuF1OgyeulfTElRPnoGcW
         dwdg==
X-Forwarded-Encrypted: i=1; AKwUvBwNdMbMAvyIkAXdxEi02jfNfMdt3mqIbshZwg3YxmNGKod7wtX09hBQ72rJawMi7EfGCQ46x3O5gwU1bQg4UPA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuGU0VnuHb8IfcNLm9dPVVKjDwGaN/XxmifSndE3ox2RDu4du/
	T2R9xG7a1j/tB8Yj+RoSvVmI25h/ZyPZXmt5G1H4gWo2GSbcwpTO0uSt
X-Gm-Gg: AYBFou1KfT4lgVr8BwsiYOM1KJNYcqXdfz8VL4CO2VonSUbEtN7OxB4ZjGvpdZFmAIx
	RgPyT6vdDZm9aBvRL3kehc6ecwYShq7gddBJXSW7VSr/Ikcy+uG+1RlIA9vtxiTGQpy1kBzMSdG
	fOxGGWOxZpvQKaW1pY0Kh7yc788BbdesSA7oM/ogvcUZxt2YYRhGYlPpqDnQpgMPmvHZbMC94CR
	Z7P6meF+C08oftpaV+74PZ3RqbOlTQZsZGBOADInvXhyMrnpiV8It46rqAS2jN0r61vMpg4QFGq
	/BNBcjISaKdcNhGEP3ssdVot2WYsaFTi4OlvqiMHjtYKU5Ot2C0DMC/b9GaRVOI1zwaVWCVDWEV
	N67MkZscd+3kX7CdWVLNhXkxVG2l1lqtpEljoC+nN53OYkrEZGa2h10V40AJYwApzchxLN6Nx0p
	1bp3vSgsmE2lgyyQx4WRTTv0/zoL/gmeUNccnDjd1kLLELZQ41/TBhGfzxkjdUsmL/k+qW3q4Cr
	lMdqTwFJ43RQS2lQUYMtyaq6pMkd+AaITBmLXlEq2Snw/LbNG9crMfvSLWvmwzfeyN573mW6MkC
	OiVUpe9KXpghiULf49ayIqm6Hq7X3IpV7i/qQGMZe84tB4+Fmq95SluOSpj+lNe/a/or0Joh6Oe
	YwkXI2CisZZQfag==
X-Received: by 2002:a05:6a21:3216:b0:3e2:ae03:b2a9 with SMTP id adf61e73a8af0-3e928e47543mr8810220637.70.1793623687301;
        Mon, 02 Nov 2026 04:48:07 -0800 (PST)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fda1asm1908357b3a.6.2026.11.02.04.48.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 04:48:06 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@intel.com>,
	security@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: L2CAP: Clear request identifiers on incoming LE connections
Date: Mon,  2 Nov 2026 20:47:35 +0800
Message-ID: <20261102124735.23199-3-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102124735.23199-1-enderaoelyther@gmail.com>
References: <20261102124735.23199-1-enderaoelyther@gmail.com>
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

Incoming LE and ECRED channels retain the peer's request identifier
after an immediate response. The deferred LE response also leaves the
identifier set, unlike the deferred ECRED response.

A later ECRED request can reuse that identifier and include an unrelated
channel in its shared-response handling. That walk matches on the
identifier alone, so an LE channel is selected too. If the old channel is
closing, the checks can refuse the new connection. The check at request
receipt rejects it with L2CAP_CR_LE_INVALID_PARAMS; the check before a
deferred response returns L2CAP_CR_LE_AUTHORIZATION.

Store the identifier only when deferring the response, and clear it
after sending the deferred LE response. Keep deferred ECRED identifiers
until the shared response is sent, since a partially accepted group
still needs them.

AI assistance was used.

Fixes: 27e2d4c8d28b ("Bluetooth: Add basic LE L2CAP connect request receiving support")
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Built in patch order at W=1 with GCC 12.2 (x86_64 module, x86_64
built-in and i386 module) and Clang 19.1.7 (x86_64 module). The x86_64
module builds with both compilers also linked vmlinux and modules.
Sparse checked l2cap_core.c with C=2 after each patch without
diagnostics. Smatch reported the same pre-existing l2cap_chan_connect()
diagnostic as the base; no cross-function database was used.

Coccinelle 1.3's use_after_iter rule found nothing in the changed
functions. All changed functions were processed; five unchanged parser
gaps also occur in the base. Hardware validation has not been run.

The two-patch QEMU/vhci arm kept all 445 established channels alive.
In runs where new ECRED requests reused the identifier of a closing LE
channel, the base and patch 1 alone refused 18 of 18 at each site:
with L2CAP_CR_LE_INVALID_PARAMS at receipt, or with
L2CAP_CR_LE_AUTHORIZATION in the deferred response. With this patch,
all 18 completed with L2CAP_CR_LE_SUCCESS at both sites. Two further
requests per run were refused identically on every kernel and are not
counted. Partially accepted groups were not tested.

A KCSAN kernel with both patches, built without KASAN, ran the patch 1
close-before workloads without data-race reports.

 net/bluetooth/l2cap_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a21b2d70ad8a..0b6eb082f3f7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3972,6 +3972,7 @@ void __l2cap_le_connect_rsp_defer(struct l2cap_chan *chan)
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CONN_RSP, sizeof(rsp),
 		       &rsp);
+	chan->ident = 0;
 }
 
 static void l2cap_ecred_list_defer(struct l2cap_chan *chan, void *data)
@@ -5311,10 +5312,10 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
 	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 
-	chan->ident = cmd->ident;
 	chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
 	if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
+		chan->ident = cmd->ident;
 		l2cap_state_change(chan, BT_CONNECT2);
 		/* The following result value is actually not defined
 		 * for LE CoC but we use it to let the function know
@@ -5550,10 +5551,10 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 
 		__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 
-		chan->ident = cmd->ident;
 		chan->mode = L2CAP_MODE_EXT_FLOWCTL;
 
 		if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
+			chan->ident = cmd->ident;
 			l2cap_state_change(chan, BT_CONNECT2);
 			defer = true;
 			chan->ops->defer(chan);
-- 
2.56.0

