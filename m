Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317A3188A3A
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 01:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760405619; cv=none; b=NjfZiNxsKQxcMc9eJC7a67TfBrWkA+PfF9aBnQ9zgynxQgDLPe1gFOpUh4mtwsxVsDOmdomsVRH7CGqJY1ciRmUajf1sEYLPBiehhaWxPcICZSLL6nrPdU4ZZ2rxVoY0xmK5n/Xo5iYN0cm9sJjLs0sUdqXzS5y1D21hz3QRb5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760405619; c=relaxed/simple;
	bh=g8sNSQxryq2hJUlXdizFSJqY5TXzaVCdITSHfAnssLM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hujfaliQ2pJU1uVDDuKxZnnBQ8XxIUrQtqvDhgxBnK6YQETPeb48OZhWPx+0+b0zHSYJq3Knl3kr9lp4z+dTDv1VJXqjwo9b1seeTukwUcCAhHTowkiDpujb9HYNrP34xjQL4jUv9lOG86SVf9BguyDFPPrR+xf5zqnCqbXsuMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMvzKoPF; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMvzKoPF"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5a0d17db499so4345723137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 18:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760405616; x=1761010416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdBUCeOyamT+Jwujs2x0Dc2qBDvyt/v7Ic5JME90dTI=;
        b=SMvzKoPFBOqQH4snq/KdsqF8teSMf4VjORTXw30HO0qy34Au4jv/zQLvcDL73ETXAy
         i5PeatyCv/1jiyR/AMcHXq0uuFWcCapLyUVGgGgCEXo217jDkNg/BtpMmy0v6C2+6I+t
         0kCwprlr2HSrcIj1Z2xNQfr9c57zaUaHtuUzYkYif49YwNJb8hOgbGbgk6eEXSf6WokB
         3ms4XJT+OrESdtvy3CTIvnp7I0hwGTKksaMZ/uZalkN+c/wWuDmB/TACAdz9zl2F5jMl
         dYpKd5UjOcATYp2WWSUptQ1KBWHnipuVCBAx2f7+UoNxV3pakk+iJp9zXP5mPxGHi2kf
         oAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760405616; x=1761010416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdBUCeOyamT+Jwujs2x0Dc2qBDvyt/v7Ic5JME90dTI=;
        b=BkwwP/6OCOt6IvzO9N8ZJT6t4+nIT5nNBNCxrsXNrWnaf4uJo4iKNoldbLy86793Rr
         D0ZTGbr1j6j+VKv+gaVmQoMUwCm66TyXR9yUr27LPNTT9fYX2vYSDRspJhfc93QqA5pp
         p2kMQmfcbwAuKC19sAuxioNMmj/9bTXQ5MhCbL7aJHz6NyNab9czf46NPYXeG0wFgHGb
         HmC7N0OECDidWMpuTLeOIjbzI9tIh52buWW7/vp2iskrPGJLJFuKscF7BEUTQMLEQY/l
         kbxAKDFzfuim0Jn5Na3nEZJo4A6zPcTsDv9JodPtEHB4UvYGcw7qqEOIBmyzk571IrRo
         pgxQ==
X-Gm-Message-State: AOJu0YzrA1qQymVVOxi16NnQUoIc9dJZZdW5pX2ICMJJ2jSMA3EqhRzp
	9+ATVvZCRkaQGmPc4Fm+IBozK3CglJvi7qI8yA7T7rXD17RDhaDs5rJUgnC1Z9SD
X-Gm-Gg: ASbGncuIgbIAVjf0ACjDj0/MxliTRMtnOOis2oWNgTVU0keBcia1QJjTTYabUkfpfQB
	5se3fHi7526UQ7qpT2lR+pZRWRo+1tMuqecAj6/zxXA21qbVjWt4b42dmVBNg2EKjRHPJkMgKdG
	FV7/GP5kmYof0gywN1bkg4zxX5KCxrpQdd0vSAboSUG3KL6M37IMho6oSoU9UdjEyvRxAKOz4C8
	DTzgTXm6OM/Kqy+uuzO4S5AyondqIbAHMncSLLfmtStJtR0r4JKe9D7kRT0VEmc1gDfHGZEQa+M
	1BCQs1W+KJ7Oqn8FQdissJs+d4+AdbzkSuLE7onnB6Pb1vgXm4HsaTBD2wE3Gpce+yBg+uoeqwo
	dlCbAvNGleWXJImKfRKvDkaW4IbAhF7vSGqNdHg0GjtYmL0VuE8EQ7Wu82u9vlUpdxH0WWxyBv8
	d0YbtUCpG6b9gvy9Sqxb8=
X-Google-Smtp-Source: AGHT+IGbk0Eq7iNJ/aBFM34+AmzqR1DmhGpVm4Cc7JjT5srX3e+RSR6sSqJAzfLlqFSMm53LDIusrA==
X-Received: by 2002:a05:6102:6cf:b0:520:ca2b:4591 with SMTP id ada2fe7eead31-5d5e2322d0bmr10430774137.20.1760405616356;
        Mon, 13 Oct 2025 18:33:36 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc7126c7sm3985806137.5.2025.10.13.18.33.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 18:33:35 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 7/8] Bluetooth: ISO: Fix not updating BIS sender source address
Date: Mon, 13 Oct 2025 21:33:07 -0400
Message-ID: <20251014013308.174151-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014013308.174151-1-luiz.dentz@gmail.com>
References: <20251014013308.174151-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The source address for a BIS sender/Broadcast Source shall be updated
with the advertisement address since in case privacy is enabled it may
use an RPA rather than an identity address.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index bef3136f575f..8f46a5cf22d2 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2034,6 +2034,25 @@ static void iso_conn_ready(struct iso_conn *conn)
 	BT_DBG("conn %p", conn);
 
 	if (sk) {
+		/* Attempt to update source address in case of BIS Sender if
+		 * the advertisement is using a random address.
+		 */
+		if (conn->hcon->type == BIS_LINK &&
+		    conn->hcon->role == HCI_ROLE_MASTER &&
+		    !bacmp(&conn->hcon->dst, BDADDR_ANY)) {
+			struct hci_conn *bis = conn->hcon;
+			struct adv_info *adv;
+
+			adv = hci_find_adv_instance(bis->hdev,
+						    bis->iso_qos.bcast.bis);
+			if (adv && bacmp(&adv->random_addr, BDADDR_ANY)) {
+				lock_sock(sk);
+				iso_pi(sk)->src_type = BDADDR_LE_RANDOM;
+				bacpy(&iso_pi(sk)->src, &adv->random_addr);
+				release_sock(sk);
+			}
+		}
+
 		iso_sock_ready(conn->sk);
 	} else {
 		hcon = conn->hcon;
-- 
2.51.0

