Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119823;
	b=V5XbwJ3s76U1By0qUWREshlLj9TKbKXUlh51hJeuFFo5ejxEjyq9y86I+Dno1i51/Djf
	 dKfzl9kCnqPVejNVWivZac4sY78/m+Hm2kp++Vzuz9TCI0bLwMQEDrc0l64xA8Vp+7FoX
	 fwxQ2Jp2L3YuFIWt3Qm1IDOb96wC/h40EK6PNz91WUKuLmI4KsX0drt+tX2K2rTlS0obC
	 5kSq2Hsy4vzgOiZUTdLWodk5oW3NVdADrBJCF76RyqJ716uAu25XSDAa0LgEEOcr5TXOO
	 ldoPOLsNu2PlZe9X5CFnPdYYtN+/umAYUcWnhz2vWiMwy343b6TVIbRIv2JD/YakqJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JwYZ8K/HWhh69ZRwdx8vD+GcbFUXkgT4Nh+DRyTzZvc=;
	b=uQy0XjODXD3NVtPvewgtADeAUe1cu9/ROchoxgu4lf+u587GqhGJJYblNakUxi015BWx
	 9lGxssK6Ac6gKuTl/NXWgjDb+3WVU3OYk7A34pSPZQiuCrWBVb44Jm7AOti61K4Wp5MJr
	 q8AnGLS4saUk5DP4r7CV5iaeqhmfUdUTmynA+yQkM5PYZ+2WKRTKd0ubXN4bc0MEgIf6W
	 XYZK8yFgWJWgjgwtYDAUFxv57qnjmlwx2He2QJK35BcD+wDACXHmVp9AfXXSfStV8sCuR
	 2Ed7BcJMcaU/0lCJqJRas6tK6vy1K9tx6P5fSFkeKde9yOxMT41gDd6HAsLxWuFd/bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VCh+/ckQ";
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD6606A327
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 16:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FFD6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VCh+/ckQ
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-83c1a9bd428so3563a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 09:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119822; x=1793724622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JwYZ8K/HWhh69ZRwdx8vD+GcbFUXkgT4Nh+DRyTzZvc=;
        b=VCh+/ckQY/TOpJsVYCO2OGK2DoHv3xhYuWxnwbY41ySZzRUjTMsWpo1M/C4l/Sv8+L
         KDazH3Y0gd3/12WlgfVgkH1Otdg7uE0voIvPIFpK5raI+YX32DBQUq3o5q+5I5ZsxzWb
         2o09QB2sHbjjBOZJy5RUhleefJtNRPHBBPAVOchIj47UocWY/dFGNIziD0Nnu82HePJ6
         VuxIcTHaooTJkndMYK2t0kYAsJxsH20ij4ibP6Lhgj5uTzDyPn4dMdPuXLqskX9IvPbw
         wa0O5t8+WoT06yPH7wWSWjUQqFVTZVQ6TpVgc6fJEBLpxt0aUlCvFN7jRY11NILJZwkI
         RKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119822; x=1793724622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JwYZ8K/HWhh69ZRwdx8vD+GcbFUXkgT4Nh+DRyTzZvc=;
        b=tYbNS9ECG9LQHY9j2/qSms+JXOzK+7asnsH7iEHJlOF4Yysqz0UFwVKHQMOid6Yr+Z
         7235nYHlnA2IenKUqJDzk0Sa3VuZUeYYuQANfut+IjWzTQ1n5tgU2p3uXWcfgt9HDUwa
         RBn4+zbxIXguMGddyKp4YChzG5M8VaiYYBsaWT+RhOw7JjkekwVg4xfd2KRYmN/keNal
         9w7jl57qlOCAjxfOLICZW+QtsiZ1tQx2zLFZmNh4kOY9FAKQ0htEPFOU1IV5zF25yJRi
         tIJ9FBZZDAXQTCwncaIkIGriGcorRzpR8r4+LyVvhvlQOL6hjmNVWAu0pUgW9e9dXZAT
         T7QA==
X-Gm-Message-State: AFq9FYLKNYDbxZQb63kDiwa7FocZ9eIkCecKIt76ewtF5qcGIB4cYfcy
	qzeRc+Mu15JHLXs3H/jqje4XlNnCLn56/NlPCOEY9xG9ediymDx2h4FyFF8PQmxytdq9MA==
X-Gm-Gg: AYBFou1UjCDuXsxYd8Grc8TiLbhF33N6GANLhdCazrGWY7lq43hDVLJIWc2YFpr1Mr9
	IasebB5xKB4qL8YtxO5g0p2h110aRHcyHuv05Nb0v5hlyPgh684KO7JfiNORUbqILFCPWg0atNa
	s8L3UfE3xVLb5dzE8fsV2PuHl6Pyx//1qLPTDM+FppQ0Djod7u3EXS2FPJLMkQ9aF0xpfitLoFe
	f+w5fgMC0tqzFFo0r2LykxQ/xc5kCaBYCl3M0bLSSm5E5cAR4l93h6PnVvxUFEXMfi3+bLyF8Tz
	3nLeH/QVyeTtwdt/27CKaxTg5hXBd3wdBg7o9fARe2kfkaQEzHSNFb6FgczG4oHvWzgnEpNolwp
	dR1kP3U7IoPRbvNiu01vwL630zo66ZWnvZSZf6FSCY66txBoiWMI/qARUUTpE24DxAKdNy6OY8h
	Y73xjIguxmzvB/nsjygURkk0+lMkivI+xaZN8m45EAnxSzjIvCo6dimQfCtDGN7vpth5NoXW1Y3
	puG+DWT5GYLWZNPFiuVDRbxsH8eLz62ygxyCX4NFQrSD/unTqMexYwHT9W+nOZrMB9Czab3cmX7
	fYm1Uf8COUfZ02eaod9Yj6+zxMtgzBG3JyQ=
X-Received: by 2002:a05:6830:658b:b0:7e9:d593:896f with SMTP id 46e09a7af769-85abd31a84cmr44201a34.1.1793119822267;
        Tue, 27 Oct 2026 09:50:22 -0700 (PDT)
Received: from localhost.localdomain ([37.19.221.77])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb0749dcsm10927058a34.11.2026.10.27.09.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:50:21 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Cen Zhang <zzzccc427@gmail.com>,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Hitalo Souza <enghitalo@gmail.com>,
	Pauli Virtanen <pav@iki.fi>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: hci_conn: synchronize with SCO disconnect work before reuse
Date: Tue, 27 Oct 2026 17:50:09 +0100
Message-ID: <20261027165009.2401154-4-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027165009.2401154-1-yaroslav.voytovych@gmail.com>
References: <20261027165009.2401154-1-yaroslav.voytovych@gmail.com>
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

Checking abort_reason before reusing a SCO connection does not
close the race with a disconnect worker that is already running:
connect() can still report success just before that worker aborts
the connection.

hci_conn_hold() uses cancel_delayed_work(), which cancels pending
work but does not wait for work already running.
hci_conn_timeout() reads refcnt without hdev->lock and, after
seeing no holder, calls hci_abort_conn(), which sets abort_reason.

A new connect() can check abort_reason and take its hold between
those two steps. It then gets a connection that the worker is
about to abort, and the Disconnection Complete closes the new
socket with ECONNABORTED. This applies both to a connection whose
link exists and to one the remote device set up, which gets its
link from hci_conn_link() here.

After taking the hold, wait for a running hci_conn_timeout() with
cancel_delayed_work_sync() and check abort_reason again. If the
worker has aborted the connection, drop the caller's hold and
return -ECONNABORTED.

The wait is safe under hdev->lock. For a SCO connection,
hci_conn_timeout() does not take that lock: hci_proto_disconn_ind()
returns a constant, and hci_abort_conn() only queues the
Disconnect. hci_conn_del() already waits for disc_work with
hdev->lock held. For a new connection the work has never been
queued, so nothing is waited for.

Once the wait returns, the work has finished and cannot be queued
again while the caller's hold is taken, so the second check does
not race with it. If the connection had no link before, the link
hci_conn_link() just made stays with the aborting connection and
is released with its ACL hold by hci_conn_del(), as for any linked
SCO connection.

A connect() that comes before the work has started at all still
cancels it with its hold and keeps the live link, as it does
without this patch; that case is not changed here.

Reproduced by delaying hci_conn_timeout() after it has seen no
holder (a debug-only change, not part of this patch), for a link
set up by the host and for one set up by the remote device:
without this patch connect() returns 0 and the socket is then
closed with ECONNABORTED; with it, connect() fails with
-ECONNABORTED.

Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
Cc: stable@vger.kernel.org
Signed-off-by: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
---
 net/bluetooth/hci_conn.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6b92fd0177857..c1c8d2b29e3c0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1935,6 +1935,17 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		}
 	}
 
+	/* Taking the hold cannot stop a hci_conn_timeout() that is already
+	 * running: it may have seen no holder and be about to abort the
+	 * connection. It does not take hdev->lock, so wait for it and check
+	 * abort_reason again.
+	 */
+	cancel_delayed_work_sync(&sco->disc_work);
+	if (sco->abort_reason) {
+		hci_conn_drop(sco);
+		return ERR_PTR(-ECONNABORTED);
+	}
+
 	sco->setting = setting;
 	sco->codec = *codec;
 
-- 
2.43.0

