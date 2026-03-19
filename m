Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670672622
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933171; cv=none; b=FDr4wTK0q+6NRpvxR8TLF79h4VzwBz7Dje0sYi9ebDY9qGOWHQdhlaEendDoSLvdrDaNUhjkdfAmyLWtH/NQjEuZYZjyPsCz59QeX9X0mEyqX4unfPeWcdHVs2COURDWsMmr4SsabKlOWe3JWKy660tV2fywBuwgeTv3yifaHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933171; c=relaxed/simple;
	bh=0GjM+g7CpReASecGAw26lbYSZX5Ro+FKCcEI9ZS7csU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G5QjpjFaICTio/lJHYbPft201PgcH1dDRhcUe6s1ZJhN7RMc+oN5bjP3TK9IdzhZmTfOT3S3KWAlZDtdC5r193y3YgnFhgKCnBQinY4RNtJU4sCpr0m2t0VBG1GvpwNlHBwMStyLTqgbynvinEpMU0kvAcv2VVpvMq72/t73Hdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ds9mqyIx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds9mqyIx"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35a04d6aeb0so829047a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773933169; x=1774537969; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cqj2UQecW4ohS4IqZcq3Ui5Hw5+TDfI9JCj0UIGVFrw=;
        b=Ds9mqyIxLDMs3tOoBEV90eeV+IiA08oycIOoa/Z61W/RUWRDeoE/9GTbtj/614+2Bq
         DMvYfbueOuKWo6tSPFqyJmm3bF4ZZ6UTD88rVHSQpFSEEExadWBxuawmv6VdqFca8lby
         AEyYcbHWsHF3WIeOGMJjin93Iu6eMtlFv4q8SwXH8gyhsrH+o5pgjHP9RvTaGAUx2oAO
         GibKIrvv7/q47aK8GBuJimZa+EfGYkuzzX79IP9MyaBu7dIH6Zt6cmFeHl/EleBajd+4
         hbJxIQtFQD9la4Tae1W6x/snW6mvqaTHg3rgVJQiB1I6/6a3pVUqeUDRyrplSzpJE15U
         3big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933169; x=1774537969;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cqj2UQecW4ohS4IqZcq3Ui5Hw5+TDfI9JCj0UIGVFrw=;
        b=BQbcirNsbdEdEbasF8leT+0uB1JD0jqFVfmMfV1+K2Yl09vhp3mSVgA8DePXXzic3H
         VtmZ9ycPB0SqCM2bRuICLZljIS3h1S4v6yLpYOVyC1h1enToEDnncd/YN2cN95t1c3fU
         skENOJGwAqNR/rksrJ0rLz17VDzKi0fzUbdK1g/rulzErkeX3OdGcohtWYKyQ/RwrPhD
         Vm8p3DxW76Cx7Hm3JquJ0lopKadHSttHB6kXc3cK4ShSQ/zj7K5eoUBMAjIxURXyn3YE
         uWkI6fO/X4HPwjoOg1wyYcHSVEiOXDXwjrUirg7Kq0HGlbtHH9yQDlM+kArzE+OZHQJv
         49MQ==
X-Gm-Message-State: AOJu0YxuUrt7i7PqeH/bV3Qx5x14yltgZ3w+X7QNj/bqRHSu81kytKff
	a4vxOQmRCL2rHJ141beHub0eVWcv1NmATJx1fXomnCyrht850jsDMSdm
X-Gm-Gg: ATEYQzyBs+UQMDPF06zBJOlvWVbJ91E0GHVJAEz9qXwNrxHk3+BDSp1dgwGTWLuHU67
	ubs1za1cVzMzOvNBpEGj3t6Umg5CG7Q8DUYefsgoRPcXycc0t2gdEWHKVsyEq++xEIU+1tO+uva
	hqRzqRoro9chcLl0rMRz/u8o93q0UU8TvfmedCFWiqNepMv/3fbA1y1apie08yYfJkrhSLkEWy7
	OUp91ec3pOHXWHEGjrtbstMDPCDPKhZyucLgsSOa1Aw6XyQqxgjgJOD3hCOCYZbmzDY0KVweQDO
	/gUilVoWz1DabNnQh1IxfiiKFBqzee/MmMeHXE+ekwCRsVmrctEkXYCZA406rZ3VSAfIM8jsnVb
	s/wxZwDc09cjkF7cvxyb+9EWpFsQ3F221SvUGhFtLJcqXx1MWSGyUa75igzgmdq2U9vUbhKrgEv
	J6GgyIIfL9dtrec1IOqLzioSqv+lXMnlToHfiJyppe0g==
X-Received: by 2002:a17:90b:4e90:b0:34c:904a:d92 with SMTP id 98e67ed59e1d1-35bb9f123e3mr6397243a91.26.1773933168792;
        Thu, 19 Mar 2026 08:12:48 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc62b5156sm3071018a91.4.2026.03.19.08.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:12:48 -0700 (PDT)
Date: Fri, 20 Mar 2026 00:12:45 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] Bluetooth: SCO: Fix use-after-free in sco_conn_ready() due
 to missing sock_hold
Message-ID: <abwSbezp8_z0K_eY@v4bel>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

sco_get_sock_listen() returns a pointer to a listening socket without
incrementing its reference count. If the listening socket is concurrently
closed and freed before sco_conn_ready() calls lock_sock(parent), a
use-after-free occurs. The listening socket has no sco_conn association
(sco_pi(sk)->conn == NULL), so sco_conn_lock does not prevent it.

Fix by adding sock_hold()/sock_put() in sco_get_sock_listen() following
the iso_get_sock() pattern.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/bluetooth/sco.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index e7db50165879..7ad6d9208de5 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -449,14 +449,23 @@ static struct sock *sco_get_sock_listen(bdaddr_t *src)
 			continue;
 
 		/* Exact match. */
-		if (!bacmp(&sco_pi(sk)->src, src))
+		if (!bacmp(&sco_pi(sk)->src, src)) {
+			sock_hold(sk);
 			break;
+		}
 
 		/* Closest match */
-		if (!bacmp(&sco_pi(sk)->src, BDADDR_ANY))
+		if (!bacmp(&sco_pi(sk)->src, BDADDR_ANY)) {
+			if (sk1)
+				sock_put(sk1);
 			sk1 = sk;
+			sock_hold(sk1);
+		}
 	}
 
+	if (sk && sk1)
+		sock_put(sk1);
+
 	read_unlock(&sco_sk_list.lock);
 
 	return sk ? sk : sk1;
@@ -1376,6 +1385,7 @@ static void sco_conn_ready(struct sco_conn *conn)
 		if (!sk) {
 			release_sock(parent);
 			sco_conn_unlock(conn);
+			sock_put(parent);
 			return;
 		}
 
@@ -1399,6 +1409,7 @@ static void sco_conn_ready(struct sco_conn *conn)
 		release_sock(parent);
 
 		sco_conn_unlock(conn);
+		sock_put(parent);
 	}
 }
 
-- 
2.43.0

