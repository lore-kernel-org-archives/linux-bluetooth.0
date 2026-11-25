Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620155;
	b=GBOBnqcorLTXCvdFlMx4dyNRE9+yqPouVjrAiAjpUKtvDGLzMO3E1VzkI0UJnmdBFJD4
	 HqbpS0/m+jfgwZZF5opP5ynhy1qcVjdtApKtSQQ0nvTbYDuXOpncDAIofsY0FwnIwVUAI
	 GQDFWPgNrCDslJyKECvmsve0qWn6a3pmSiMHaLhiTlUkpKQsY1ttueA2IGVQ/M/22Go9m
	 76I0NLV/oUigrjdgfKWZsV1nDxVLv4tjkKHoXRKmbGhfK2iE65xk+x2rRRiGMIzjYdV0O
	 QeEddTeb6Tgn0B3ELgxBIJs2ty1Rn0rvPz9fUbCb7dnvQQW3InfNtmVDJI/OFXrEvbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m/P+s8e9LEiFl0Qu09s+H0T52nV18YVsV7Iu8lShA6E=;
	b=XK+6fulYVBulcDCCaQZh7c5m2fCIkhUgESO6I9ZqWOhGX0SXcftIFLrLzSeOq9yWMZ3J
	 Ry0xSfIT2sVXPEKXHIZ/+SHlI/WunY63eEsJk0Ia4Q8LZHVHdv668VwSIc8GmKskVSUk8
	 oYQu5zSOo2VeXiFsvD3IIAt9CRcQm401vl/vye0q9AuLi4sieZkfYa6tkCELTcUVLRPfZ
	 x7LbzQO8xSS+GYGuGdOCzFsNcapWqOykYz8RYIsYci7gFCAey1Tm1ryyvHP2fqZnwKz6T
	 CTRbR2hA5myx79KnQ22OrQKFSAzCzx5IR/85D8InQRqWE0Zqq4vyNykejq01u/LWYHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="oK11i/6G";
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18328606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 15:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18328606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oK11i/6G
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8cf79c02fb8so570066b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 07:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795620154; x=1796224954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m/P+s8e9LEiFl0Qu09s+H0T52nV18YVsV7Iu8lShA6E=;
        b=oK11i/6GApnRKdA/Ui/DZGKRVTnYi1Zt4xvqNPvWKzZs/8Ee2w8INiN14d7atKsL0c
         xzDu4pv2ZJInhd9mE0DuA90UhSHXmP/329jlbZs8ywz87+6Tpej015n99C6altAA9Brc
         kLshRsz+OZROLRaH7pfDc7nILS9aTAuFknbRoHlm2XQytevlcZZoErtyhDd6kWfZQww6
         74ZDvFHW0zpgZtZTeF4l7nD4NDMZb0VLfEYxSWh3LM4u2lzAd7t4P07gL2oS4qfbI2kl
         1vqJbtzuLQ5YEFRd7zQbHzlvOCFvIUsu1JvFyr9P9ay1yiLEgyo0c4i01vtQQb3AXOMg
         oSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620154; x=1796224954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m/P+s8e9LEiFl0Qu09s+H0T52nV18YVsV7Iu8lShA6E=;
        b=DzMbhJ0aGEvt79IIqM6HqPfGmtu1VCGe4pfyIRTTorwRXP9Puzk+LhBRhooBUToLuD
         r4/iwNwe5eqesgLn9VGkQFSeoy00jx9LKOvPgibC7RkfKSN2sjscVyJte5XeOcF/0zKe
         1jxmt3zy0EDEIJypCmqKhJMYf9o5K9HVU5bUe7KK0RDvzqaA7ucmizxhU46OnhiU3Gps
         MiuCK43kFsrdMMlFCXdz4YJAdv+8VL7kiapmbp2ZEdoUkDj4D+gxXuNKJxT6A5qt9qQq
         rYmDxtqX9DVhiSoBSmbNsSIIJN0JRU9frnj9RVhcCMLoGo5/GiHsej/3JRBoU63fjzim
         39pQ==
X-Gm-Message-State: APuU4Z+2035p5zSJu1RiYgZrMVHKYbpPK0n+SjgMgQ5Z+nfBf9kPWjoc
	my1DlPM5s3GYVBNRoakZEwR6G51tM4Od4c/enMJUaGGVNtO8VVQz/ulk
X-Gm-Gg: AZFdTZeQSMNt0yPB3XDf5SPDWSNRQMl9SXPWVgr7hzw88utL0L21lqJdpeLUhlLeeQr
	+GOXvs9qs6dK9Sw7bZwk7wNwbSO+W1bDRxgjMRG6c0nYCtLcr/crZ1odv6ZZKX9C5lGG0yxGcCL
	jhwDBAP/c1pQdkkqgxLCzwno7KHdavZH7YgCRxKBRODYJpP/74qJAFZ3icRIguBSJZdXDtxlzp+
	Klv23FT01XmOV81tcb7KgtSWRCfd/AvsSvGEZ/AKuYPLgPVhAtVZV+y0Rohwqdb79USbagZCVpe
	xmkGJ11fzk/RuI69ea5/G+mu36ZhVJfbjdLahjgsp5Lsms3mj7dU49q7arV8VRmPk+RdiU1FQd4
	NTVQUl3YSiZVphPOcVQHBfdde3AbxiOfpCynonQbE96dUsr0m+8AWJ7wV8CzLkSAF2GKFI/bcGF
	Nwtl3Ommq94tPa9ahxPZl3gP23H+h8dMBAmPg2QOp8mArMb+63rg/5q5luFJOrc8hYL3Tps1fge
	jwJl0/P1IkjDHcalBMEwZAItv0DkGvE/VmlK/pglQnZ1ztqbhTlV5TSmzHeDS7LcMO8+UH75Ksn
	bI0HN2jUNdfUD53yYcmqbxeK
X-Received: by 2002:a05:6a00:a01:b0:893:4980:630e with SMTP id d2e1a72fcca58-8c87c38b5d7mr14799436b3a.31.1795620153916;
        Wed, 25 Nov 2026 07:22:33 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077a058sm9221775b3a.8.2026.11.25.07.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:22:33 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 1/2] Bluetooth: RFCOMM: Reject listen after socket shutdown
Date: Wed, 25 Nov 2026 23:22:17 +0800
Message-Id: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-0@gmail.com>
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

RFCOMM drains a listener's accept queue on its first shutdown. A bound
socket can retain BT_BOUND after shutdown, however, and the listen
state check can admit it as a listener. Release then skips the accept
queue cleanup because sk_shutdown is already set. Queued children can
retain a pointer to the listener after it is freed.

Check sk_shutdown before entering BT_LISTEN. The socket lock serializes
this check with rfcomm_sock_shutdown() setting the flag.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lkml.iu.edu/hypermail/linux/kernel/2611.2/24606.html
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
This patch was written with assistance from Codex (OpenAI).

 net/bluetooth/rfcomm/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 889e45dd5d04e..86a43dc0ab5e3 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -448,7 +448,7 @@ static int rfcomm_sock_listen(struct socket *sock, int backlog)
 
 	lock_sock(sk);
 
-	if (sk->sk_state != BT_BOUND) {
+	if (sk->sk_state != BT_BOUND || sk->sk_shutdown) {
 		err = -EBADFD;
 		goto done;
 	}

