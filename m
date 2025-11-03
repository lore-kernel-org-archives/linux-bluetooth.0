Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C3331B130;
	Mon,  3 Nov 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194612; cv=pass; b=aeFOzhygyjbyMoyQmHfFF2zh/1yl6HOWQNC0otWkriCb9DL8JNAs2u5+z1/0IqVx7ASA4GAB8Mbu7DIjFS2eAN+Bw2Fd2LcCMlNHOs7sN04u2IZ9Cs4Ougm7qPb+oN51tW/GXgiO5Lwb+zYGi1XRS/BJFFtEVOl8YSpTFb6uyzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194612; c=relaxed/simple;
	bh=atvZJ8CkCzW97NKy8pOlNZusVm+AhUwVn0j2cmZ+cKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0POL+CsZ0C7bzq6Gt7vAAgXRlhrPCVxz39AWOECulT47RNh/H21FgjKAo3EDJjyEIqHlmZeLfnsEHb1fLhfzf6gN9qGB6FA8nyKwjmADsHgqgaNLA3nPRhYxH+5tK3Zv2cBkrdmvD/Ga/lgrVep8yDDLY9f0xjBHYiyCzVPj0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=kbGU1G0h; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="kbGU1G0h"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d0g9j24D6z104b;
	Mon,  3 Nov 2025 20:30:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762194602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SvZ5AiVPOBPxjqtAUTKJ6M1RJfARMunzyvtjLpk4QSU=;
	b=kbGU1G0heR2XyEqwWN57Oe0p/hH4XujmyEK6TcWzpy1iXdxP5eaBdQ7r5XjK0b36KLDDAd
	tdjEb2cu8c4kxRZyrYH6x832q035VsTZDMOw048GGKWNOAAMyGG89ibTD9DxmU1uHmFnff
	9GdpWscF2Ky3N2YaPlgGp7BJZXiJUgA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762194602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SvZ5AiVPOBPxjqtAUTKJ6M1RJfARMunzyvtjLpk4QSU=;
	b=T0OWvLJIEy0BZSoXDg9fMVvBem3wpMW+ls8FpCyoqulxQlWqoWUZ782e0o4JYNNYChR7f8
	07kCc8py4WqU3OGbi7unH17mEd+ohZkLIe6wOG9Ekzcp1Wpxi0OmzJK96o1xistr8Yvc86
	YvJHQMdLv1bYGqSzQrWx5NOHfXL0Xqk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762194602; a=rsa-sha256; cv=none;
	b=fLc1il+HoAZOOJZ8b094ddj+6NGQcoAIu31zfkVaASUn1lthT2WpMk9U7gowq9aSPmVI8y
	47izCdl0/tPpy8Ua7ZCtI8w3Zc79cE5GWLIxdvYFBd87fSBMutkmoo/l4tvsUF/HRa+xcs
	NaAsd4jVALMNLkVDrhQdlL+V82t/MRE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] Bluetooth: 6lowpan: add missing l2cap_chan_lock()
Date: Mon,  3 Nov 2025 20:29:50 +0200
Message-ID: <d9cdd58f4ff5b26f0c501f1b2b8636bff6839f61.1762194056.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <467024bf1ba60184bff304d23de33abb0ed2384f.1762194056.git.pav@iki.fi>
References: <467024bf1ba60184bff304d23de33abb0ed2384f.1762194056.git.pav@iki.fi>
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
    v2:
    - no changes
    
    l2cap_chan_send() has same issue, but harder to fix so leave for later

 net/bluetooth/6lowpan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 588d7e94e606..2c21ae8abadc 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -927,7 +927,9 @@ static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
 
 	BT_DBG("peer %p chan %p", peer, peer->chan);
 
+	l2cap_chan_lock(peer->chan);
 	l2cap_chan_close(peer->chan, ENOENT);
+	l2cap_chan_unlock(peer->chan);
 
 	return 0;
 }
@@ -1089,7 +1091,9 @@ static void do_enable_set(struct work_struct *work)
 
 	mutex_lock(&set_lock);
 	if (listen_chan) {
+		l2cap_chan_lock(listen_chan);
 		l2cap_chan_close(listen_chan, 0);
+		l2cap_chan_unlock(listen_chan);
 		l2cap_chan_put(listen_chan);
 	}
 
@@ -1148,7 +1152,9 @@ static ssize_t lowpan_control_write(struct file *fp,
 
 		mutex_lock(&set_lock);
 		if (listen_chan) {
+			l2cap_chan_lock(listen_chan);
 			l2cap_chan_close(listen_chan, 0);
+			l2cap_chan_unlock(listen_chan);
 			l2cap_chan_put(listen_chan);
 			listen_chan = NULL;
 		}
@@ -1310,7 +1316,9 @@ static void __exit bt_6lowpan_exit(void)
 	debugfs_remove(lowpan_control_debugfs);
 
 	if (listen_chan) {
+		l2cap_chan_lock(listen_chan);
 		l2cap_chan_close(listen_chan, 0);
+		l2cap_chan_unlock(listen_chan);
 		l2cap_chan_put(listen_chan);
 	}
 
-- 
2.51.1

