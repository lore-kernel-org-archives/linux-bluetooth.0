Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177117;
	b=dTaSKsSp9oLFBIeVTY0pqBnjpm8At83rW6p/LfQqsQHL/nd3fowb/+siDbWNVqTQj7kU
	 nO+pY9vW6g4Lu7sAX4z2BoPSs/qUfOzDQmehnX1OmPlh6c8MwIsgFbIM106o9jmj7giJK
	 3LlR2bLS/50Ix6K9IP1xJr45LHhK7dpyZZ3BBSLTUFMfhl0dFOS1g9Jrh6teqbTxRw0K0
	 G2J7DH2NXCgbkYstKF8z+UDgA86mMZTiMSPF0YyuHGIBT+YIsCo0dyuozJe2T64C0ZtsS
	 m92J3NfCSiidkYaPWIXKdHVMdkEL1nfr0Lhdpuja6n9ZcxnWvVi/14xRk1bca0h8Ykw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177117;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=2TTxOFq4Pub6w0Xdfhy0iHfIcvLfAqDH3Ouns/aG0ZE=;
	b=bBhFc07ZAe8eEnneTEGMysPdJw2jag+DOMrLwySoybfwf4vVqN01x98hixyd61D7hyJA
	 8PaMtWlIak67IHXAXpUCObogfpxKCqUv6FAmEvPAQm5RHcF+/OmPmzBEwTlPGmJIx7dti
	 Z0Ym73DYfDdDz9w9Ab68H5+6K49CzAylkbjOP/xSzQEF/lRg7wKpR82LiKcZX1YMMT6TJ
	 FU6foDhHKsbgaMeVtcTj/Ixsn7I95XJzyf6tXiL+FAJ2ggFOQPnydQu3CvVdPmw6fxgLM
	 RaXOY4LrDKqeaK2tythzspWpqPO3LJ+NVaBzFFfvxsBSLrLbZ7uCdta6SjDp0fZxKNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ksBYHcoh;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB0606A33F
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 12:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FBB0606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ksBYHcoh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795177109; bh=2TTxOFq4Pub6w0Xdfhy0iHfIcvLfAqDH3Ouns/aG0ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ksBYHcohPO7ez6ED7a9f9Eumlrcz7XrdMqfp3EfbV9vO8NZbINX23BfNngVuvPbHf
	 EeA+CE/XC19F1JU6RHefyJAZOXmqLo9Ghqe/6PyArKT3WLypQFC95jcu3aG4+WnWwJ
	 SNnU0lljw7TdkAjfHH4L13GZFsrs1pc9pzikrYdA=
Received: from [127.0.0.1] ([2409:8d5c:8f0:65e5:65c9:1ea4:b234:d5d4])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 49A8ECDC; Fri, 20 Nov 2026 20:18:26 +0800
X-QQ-mid: xmsmtpt1795177106ty6ci0nng
Message-ID: <tencent_5C090D89F54B3F9DA10CEFA2CA9E8AD8EC05@qq.com>
X-QQ-XMAILINFO: MBHEkxMsYPCYiBLApqtYKT+xWYFK+WuwUjO3XzVFWD5sA8PyN7UQDkbE6G8ng9
	 Wn6m0X32RzhNN7mmWgMeNzAiueJmVxT3DK5ECNAZWL0Uj+DQTC3rM4DQeZkJcyLG/TkEv53zQUFc
	 3pL7G1VZ6IEPQ33p3awDMneHm5RdIHQ6Q+C+1FlBANS5mr5NJaTuj2YuoTdqdLghoPPbp4qv/UTK
	 tzZUBqXNCiuHxnqTA3Si3+hEuKvvRT7tz/lH1t/ukRRMXTgWs0A5AoFUpXKy0prvWFFZ/03IlOxh
	 zTKF/b73QrZmskCQFMzVmdozq2N6vEwu2ja0QIhpI2uS3sDjslnxU7qmqp/797R2BcNPQrRQPx/H
	 2IR7jujf1HhZhhSs+12xsKBuFEv2ISz1t9xOK+fMMq6eNwlaUxiqaUvf6c8OBTaZR0Nc3eFQfpV4
	 pwgeNfmPxLoKiwHrR3r23Jnk/BCWKjdgL1OGX2LBFnEwbSrYHInimWHbdRg8qxXMiM1J6/dDL5yt
	 89HGry5JELvxLvZJtP8T+8I/o9ILwzlk4jvfHptx2g5t5Evj9WkppExlWRUkpX6a1zouG8j9K0c7
	 RmBcgGp/NFwxrL7dP2Qeu8jjFX/zTEhaO1HpAmWxqBijbShKGQLpu/VRt42qVyDQU/j86A5aWo1/
	 R5IlkROn3gWn3GDomC4524ko8eWg+lRvNuA7C5c56jI9cj19WQmJr0LT7DnvB/r7OqpL0TP8S3IA
	 lNMAC+scKKgvGhJYr6koo+pcFaZxct+d+tsDPdi5TJYycHkXEI6VUlOGYeWxk3ZghT2Q6iMFiAUo
	 t8JIi7oNDFiMImCHluQ5s2BHhYtCDp6KFyhsjCyLCxYAyo+6WdrqxZdD10Q0ICGl9Hu0f4oDkhxm
	 lrhyqHKnPSu+JD6RQ1iWOVsJNF+Wx43MQ2PvIxfLpsPNEPIz5XfaQ9jlyLK+LeujdP8IBCpaqE4Z
	 ylskSvgsCsrJjFRl7HmAM+zp+pGPVrVHfaIFdYovaJcVJze4V7KJKwRgs0UW8a09opOf0uRErnwi
	 5wkNmsbVEQYas36CSlVSHjYYGXS6dbLdt1ag5suxTAl8rm+LAcLXEPp6xiVKzl3eERcpgM1g==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Hang Nan <2122295973@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
 pav@iki.fi, zzzccc427@gmail.com, enderaoelyther@gmail.com
Subject: [PATCH v3] Bluetooth: RFCOMM: hold the listener across child teardown
Date: Fri, 20 Nov 2026 20:18:26 +0800
X-OQ-MSGID: <179517710658.56988.15563657158904954302@qq.com>
In-Reply-To: <20261115191908.3646-enderaoelyther@gmail.com>
References: <20261115191908.3646-enderaoelyther@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

---
 net/bluetooth/rfcomm/sock.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 3fb8b5474948..94a495e86057 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -66,6 +66,7 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 	__must_hold(&d->lock)
 {
 	struct sock *sk = d->owner, *parent;
+	bool held = false;
 
 	if (!sk)
 		return;
@@ -83,6 +84,12 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 	if (parent) {
 		if (d->state == BT_CLOSED) {
 			sock_set_flag(sk, SOCK_ZAPPED);
+			/* close() may already have dropped its reference and the
+			 * queue holds none, so keep the listener alive across the
+			 * unlink and the notification.
+			 */
+			sock_hold(parent);
+			held = true;
 			bt_accept_unlink(sk);
 		}
 		parent->sk_data_ready(parent);
@@ -100,6 +107,12 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 		 * rfcomm_sock_destruct() will dead lock. */
 		rfcomm_dlc_unlock(d);
 		rfcomm_sock_kill(sk);
+		/* Drop the listener reference with neither the child's socket
+		 * lock nor its DLC lock held: this put can be the final one and
+		 * rfcomm_sock_destruct() takes the listener's own DLC mutex.
+		 */
+		if (held)
+			sock_put(parent);
 		rfcomm_dlc_lock(d);
 	}
 }
-- 
2.47.3

