Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE44B2F6574;
	Sat,  1 Nov 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761998991; cv=pass; b=gFg9balP8S1pHHPssKSME5GdEJ833lesCPiIXUJLXQffLiKniNgWxZfeZ5I6fFGxCrUURzonkdyOrKFjV9i03gUvovDgUMRo/WeStPl2WGTycfz1Z85+zxabQuU/7zOtUXnO4oUq3cWv1PYHTOqMR1rX7rJ/Eg6bE3NPDP/gyiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761998991; c=relaxed/simple;
	bh=bgjBpFESqlRoY0y5y5ZOO9+ps+yNRDUm38ha/mIzId4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3pw9q1hhhWk6WOKcCcMrfpV+7PP/nCwhErGCSBQ67JZSet6nbpy9L1UpFEx81d/Bnl+XgtAP+K9yv9LG8Aw434SZyGyGfzgdx07J+vWM7dkSqUp1fcBXudzhZxDTbiwkkvVWDXxt3l9uLxcknD/srmYL1Sb+f7z8JbvdiEbeVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Lm3EuexX; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vJ/1Avan; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Lm3EuexX";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vJ/1Avan"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4czGqk3rx6z49Q0Z;
	Sat,  1 Nov 2025 14:09:38 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1761998978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ti/88DG7e3K4btpBRe5dXxFzL6kGlxKnpLGIAk+YLqI=;
	b=Lm3EuexXjZ9KzRdkXx76G2+8FPLT59sQp/i/ITyNosvFwY2me5sKRIe1RCf/UnYcSvR9zB
	fcVxNPV/viBa+3Uq69tR5iZBkEY8etW670spDZWxgLYlqVpXLNwNY3Sfl/X67p5gZermC1
	VAn7ZZVLSdCnL2E8siC5PTFpXq5Xy2uGE2AaMpSqpUbPQIs6d3+uEOX7WJIAxKguCGch7w
	Lf3OfkxlHqD5CEfAPnpE9gwG//D4zvhuxbTcjiDFnJNRqtqSQYAZjhyR8UVvPaHXtiDQMx
	Kbfr4syeTP4NB+Lbs0Hhse8Q2jXAAYqyJKETEf5VGtrvLsMjdtbQWps3KdPGqw==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4czGqX5Rd1z103N;
	Sat,  1 Nov 2025 14:09:28 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1761998969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ti/88DG7e3K4btpBRe5dXxFzL6kGlxKnpLGIAk+YLqI=;
	b=vJ/1AvanVNcEDVmeMvgnGOFeiZVEsG6n/7uNSdUSutdrpjhNMegwwEyMLBkii2jq6vL5Gy
	m79desezPJK9ouqczloin7UZS8r1aYXXUiwx/IVnG+EWj/xbuFSQR+5TiIQIZxJnCJkh3I
	pJSak++3talWk/LUerXX87PhD+MDjV4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1761998969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ti/88DG7e3K4btpBRe5dXxFzL6kGlxKnpLGIAk+YLqI=;
	b=ZU+v17nHd/FGyephOFcPJlLuP5GvizrPN9s6F/0b2KSElIZpGzOTPXoJPUbe/Ia/1A8fw8
	6ro2rZfa/d6Q7uCrr0gqpp2OjmN0QaeQwE255xiegc27+Vrx9486jmvwHbeBIb08qWQ0cL
	mWTdyPQL2UVNeMXQuXyQ/J0hbMC6GQA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1761998969; a=rsa-sha256; cv=none;
	b=mILuOmbVhVWTxpC5E2qDVa50Bf3jMzWEzJvyUc9pvh7PsAoWgqHhLvYkjHsQoC4/zWZ2Ja
	9ybVkg6D/Lqm727I8KO6l6+rnVyBAtVrwngWPj0XE8MBF878HZmYLe2CAHAtqyRIiViBn2
	Fm96bKU7dnTi4TrNCnAoyU8DuhbBfck=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	jukka.rissanen@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: 6lowpan: add missing l2cap_chan_lock()
Date: Sat,  1 Nov 2025 14:09:14 +0200
Message-ID: <e37a054cdbae4f6a8d22bec7c27d18801229f55f.1761998763.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <639c5cb6ceb49ffd63952dc69d0d48b022aaec3b.1761998763.git.pav@iki.fi>
References: <639c5cb6ceb49ffd63952dc69d0d48b022aaec3b.1761998763.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_chan_close() needs to be called in l2cap_chan_lock(), otherwise
l2cap_le_sig_cmd() etc. may run concurrently.

Add missing locks around l2cap_chan_close().

Fixes: 6b8d4a6a0314 ("Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed one")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    l2cap_chan_send() has same issue, but harder to fix so leave for later

 net/bluetooth/6lowpan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index f64bc4dc2b54..cdd83f54677a 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -927,7 +927,9 @@ static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
 
 	BT_DBG("peer %p chan %p", peer, peer->chan);
 
+	l2cap_chan_lock(peer->chan);
 	l2cap_chan_close(peer->chan, ENOENT);
+	l2cap_chan_unlock(peer->chan);
 
 	return 0;
 }
@@ -1093,7 +1095,9 @@ static void do_enable_set(struct work_struct *work)
 
 	mutex_lock(&set_lock);
 	if (listen_chan) {
+		l2cap_chan_lock(listen_chan);
 		l2cap_chan_close(listen_chan, 0);
+		l2cap_chan_unlock(listen_chan);
 		l2cap_chan_put(listen_chan);
 	}
 
@@ -1152,7 +1156,9 @@ static ssize_t lowpan_control_write(struct file *fp,
 
 		mutex_lock(&set_lock);
 		if (listen_chan) {
+			l2cap_chan_lock(listen_chan);
 			l2cap_chan_close(listen_chan, 0);
+			l2cap_chan_unlock(listen_chan);
 			l2cap_chan_put(listen_chan);
 			listen_chan = NULL;
 		}
@@ -1314,7 +1320,9 @@ static void __exit bt_6lowpan_exit(void)
 	debugfs_remove(lowpan_control_debugfs);
 
 	if (listen_chan) {
+		l2cap_chan_lock(listen_chan);
 		l2cap_chan_close(listen_chan, 0);
+		l2cap_chan_unlock(listen_chan);
 		l2cap_chan_put(listen_chan);
 	}
 
-- 
2.51.1

