Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF98338C;
	Tue, 26 Nov 2024 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579438; cv=none; b=PLMOkA1GYnp4y4yI8EoF2SEvAPHxfvpupvi7MKE0KeCKvWixsMh1ZDEpmvqk/VcNfaO0w8IBQufZK4lZLVF9ZMqDO4vkCN4IXFxpDx8rX1ehNY+4Zyfg/YL8j4B5YNq5619eVG7gOHRQ+sxGhKDHZaHS46Fb3EOA5KLV8LSniLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579438; c=relaxed/simple;
	bh=fUNJ80SuJ8WQzdOAj9efemdaOVcbEBNjwXpgh/9VbFc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Lxjf5VpaeuXJwsbXPhNjiNi2/SgZQ5Ks5sZWiL3Y8JN0Mnj1CQNQgItFzvST40bw7etOtixPT0NEh5sv3MzHkTyeN9pPLf74Wiilo7vFbgfu4eH//mBV74Efqg3tcIwQ6ozj+XAqdVJqaWc24f4iKU2in1kA1i37q7ORnT/3M3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=OFZwcmGG; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="OFZwcmGG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732579124; bh=DdtSH62a/TcfUSUvHD9fIFZE2o4K/mMbePNPRDE+ndQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OFZwcmGGMntkhZClmetzkZnQj0i0U6VAq4qVIU4spxsWuQruXtu4xoDs420bgDty5
	 TNg94jLkQrkZDeoMZLq1OdAHAmSNsqhgnVYTI1UNYxSpc1uHrUP6Sk4Wr+vCTMY2Wb
	 ttrH+YOpizuX9+QSQI1PFsJ/Ze/0vD9SAT/+wCnQ=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id EAAAD8C6; Tue, 26 Nov 2024 07:58:42 +0800
X-QQ-mid: xmsmtpt1732579122t73whe790
Message-ID: <tencent_10C852E0467D89872ECD2EFCCC9C27D68606@qq.com>
X-QQ-XMAILINFO: No7DFzN00JnRS+KonxtdRDDNLY42y33ta+1sq9ysNhI+1MftiWFRKrnKTf8/Pe
	 OTyeyGfCTXwibjScYXaKQ9+xAYbI8+YPARwIH8cjNFNgar9l3m9qScPnrBY52s4AHZsN4hTvwZ9R
	 zbLzVVqNVUk+rykjGo/+CjWVISgPCqkHyFKDegSp/dyJQ9aBTQDjRE0CGbKOGlmZUsMNg9CgD2MZ
	 Cn2AvY9T/7J+/tR20eJg+r81FZT221Vy8C/KJoiFU+gE/Up81QOjiimtSsVr0wqqRXkDdls13TUN
	 /g0MwPILylwgnJxrWnIE8p74p8msSCmBo8BssWU7YsspTZ0lzyRen/JNFj6y1VqTVC+NpDoWwhY4
	 tqc9+V1U856CtLBREeu3k1XBex1oZx81Y2zjZhRquGe8rzxg4Z7+oqEC5fno4qKsE4Xt16XDf77W
	 8Q96D6a8fruGLSEX1n65O+QTQti8sQxoxFdb8WNp13xx5tHWPBqgGQpzonW/lmH8C5+tf6iW+3YB
	 reYSLn9meY6PjxSoCZe7oAaQ9yN56udmNoazdARoMU4OWwvuv1haVdciQ/s00OAXxUDKAJrsXQiv
	 LOHPDjy7NmvoU1xGENOfZ1XDeZ2amnQ5+mGaUzE//+bxoF+Oza4pq6jmNbeJicevanCm/3zuqkjB
	 7BQDuPGR9MKTK+aLH11B8q0rdWdtp4VltRuY0GNfDPBNDJW/Mx6CVN+vPRdfUE66NcQ8R8oOQpvh
	 1ZEw7FOu+zC67+d5Cm/VNAv0iWtVDMgtqJAJEwZpMmyLDVibQxRrJ35zy3G4gm5VsnVykQZtOZ4r
	 PGnAda3xgsSzzyxYynNO0M2AqTdhM6g6MB/uLSB5C7GcGkzGNlVC2THb0pIxPebL9P1fOiPzOJ7o
	 tyycIRk8ClNa5kddxf+xad+Ad1pp2c1Q==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+489f78df4709ac2bfdd3@syzkaller.appspotmail.com
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] Bluetooth: SCO: remove the redundant sco_conn_put
Date: Tue, 26 Nov 2024 07:58:43 +0800
X-OQ-MSGID: <20241125235842.3918699-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <674478a5.050a0220.1cc393.0080.GAE@google.com>
References: <674478a5.050a0220.1cc393.0080.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding conn, it is necessary to increase and retain the conn reference
count at the same time.

Another problem was fixed along the way, conn_put is missing when hcon is NULL
in the timeout routine.

Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
Reported-and-tested-by: syzbot+489f78df4709ac2bfdd3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=489f78df4709ac2bfdd3
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bluetooth/sco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 1b8e468d24cf..78f7bca24487 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -143,6 +143,7 @@ static void sco_sock_timeout(struct work_struct *work)
 	sco_conn_lock(conn);
 	if (!conn->hcon) {
 		sco_conn_unlock(conn);
+		sco_conn_put(conn);
 		return;
 	}
 	sk = sco_sock_hold(conn);
@@ -192,7 +193,6 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 			conn->hcon = hcon;
 			sco_conn_unlock(conn);
 		}
-		sco_conn_put(conn);
 		return conn;
 	}
 
-- 
2.43.0

