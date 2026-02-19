Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC329B79B
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771526035; cv=none; b=aLiMxTqUQOKW/+Ppbve3ibDwWCR/d8ACxGu7kx5IgG+VhU2AjuygnvhxTcf7+Ayb3e3M7bHnOu3xtzKtq4kF5Rdym7vf0Y2OB5ycYU4WaSL3KoMfKQjdKRD+tIRWujj9z3S/H6WDoHYPeo8IZcSyIgQokFYK+oQ35lK7SmS4ZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771526035; c=relaxed/simple;
	bh=kKvbQr1hAVCuvCLzgMJT6qjNtG/9NPEdFN9y2Q683x0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hetm6jILDmSOE5WJdDFWYITrRuc/Qy8QhrkJ6GwEZir5KujWjsPFngcYA1hbKPaTrQSBJs4pz4CT6F8Y2Zq67ecy9FbWS3vw0DQXeFGqeXhp3ykhqzVL5YosTlrTTsk63ml6uT44hh+XPp91O27CJxkh2phK8epy7+Bd7eSEpFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0bznF3X; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0bznF3X"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-94aaa5d3bfcso630259241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 10:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771526032; x=1772130832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ug3c0VHxmztQ+yIouTHxPO9pqVKvLTw1cgH78dB/IqA=;
        b=Q0bznF3XQVq4rgCNOXQclRE4d0mYxtchHmEbKym1uEQoSbpYAwO0ys3XJYD55JYsqz
         AIUlEGF3oogYDPyZK5zMmpiKJoxQjq6EhFn4cAwanhRskOsxFvdP34pwF//i/eNjKhCt
         IZ6sZEV2J6l9RFEdRk7EIot6T7HXG9x4mCaWjp+jQrT8AdqlrpXeANUAeflb5DeGBa4w
         8XWYCRmxxUAgy8MkkFJzBNIwVGj/9+FoMCVUWCakIV/lNpzOoQMb92DQB4pDLyzszfyA
         //7ELIzSftpbJQktk01ICfeJj/kAx8aKyUtRERHD/azq/4gCGB8Wv3+qFxLh5cVMbfe6
         IYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771526032; x=1772130832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ug3c0VHxmztQ+yIouTHxPO9pqVKvLTw1cgH78dB/IqA=;
        b=IwwFjJn0P/vl0m0Vhm2Uts8n5fAxmEg0opR7zHY02fCuWGQxUeb2pU2Kcyt7jBCv6p
         pAdP9vD6rlqKRnJQuaH1404w+qdVamp6rv5P4ZzuFvXDeDGcwzsunfQHzveNxvrg/Rpy
         ylQrYEjGAHo5K0GmnUx7kvk3D29K8dQr1Tfw35mdQXImHMpHcQlDKQLUOF5T+t7RrdK+
         488IJSP0vs0cd6SrfGSu1wkAwKH5H7Cx0kQYjXsKwKebvcfK6m6cvKcPC2xPmUMl2GlR
         fVlMXhXVsV8vhUSizLXNxK+o8owtcHsOILQcpH1GAOVB17Uu2tKSd6GtHZOeM4Ponbsg
         jYMw==
X-Gm-Message-State: AOJu0YzC64xeEiT38OgW8iOKBEwx/MjAC8EKaDffy0j+1Aers/k5Sido
	YbNJogQeo3svLPMNRgf0QgFKAUv2j9KPANJOYi4DLbovi7f1qy4BZZsAJvDBVw==
X-Gm-Gg: AZuq6aKGwGZCWnYvpyahxoSXcK85EEEk901hAQ6gfb/VmHRPJGPiAin1EnkLxBrWe4N
	lHkZsh5rtzSAHITcATcCP5eGR72AFeySp6sWB7H/vh+/tB9b7vUgOi9QE/hs/89Kq3PSlxSLaL0
	EMwmG/fw0zbDOq/qrglDsJuB2wyM287r1vtLBd7+ynMsP2mbToad5AwfD0R4Jnk9Eny/GVZ/T+b
	wGMuw5LfqyhXnLdyJwo9tKSb1IpEZte2Nwv9g08HRAaio8gPve9SyyiieWUmyEIv+e9iZtIE3ej
	+HK8aXr0BKMrpragyf2Txv5/gfKBFUUGl7JXtsw8kh98StrGuxkMTxhT8WOtJnBvo0YKKaLBOyh
	82zXO9AmkSWrl2UsirUiW3GnKqdMPbtaTm+w/Z5FYxpLguGqv1HeFr1igTqsZ9WCDzID1wUcWYj
	FCmGB/F3B3G+bGJl6Qh4vndTQeBsBJk1fNRYz16ZacdIabrlkNGbbLm721N4nxFGKwUXUkjnyml
	BjVWhnz8hdW56o+GQ==
X-Received: by 2002:a05:6102:dcf:b0:5e5:6360:1f60 with SMTP id ada2fe7eead31-5fe2b02096fmr8838451137.41.1771526032309;
        Thu, 19 Feb 2026 10:33:52 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5fde8ae2c86sm14017560137.11.2026.02.19.10.33.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 10:33:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix not checking output MTU is acceptable on L2CAP_ECRED_CONN_REQ
Date: Thu, 19 Feb 2026 13:33:43 -0500
Message-ID: <20260219183343.3167089-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In order for L2CAP_ECRED_CONN_REQ the given MTU shall be checked
against the suggested MTU of the listening socket as that is required
by the likes of PTS L2CAP/ECFC/BV-27-C test which expects
L2CAP_CR_LE_UNACCEPT_PARAMS if the MTU is lowers than socket omtu.

In order to be able to set chan->omtu the code now allows setting
setsockopt(BT_SNDMTU), but it is only allowed when connection has not
been stablished.

Link: https://github.com/bluez/bluez/issues/1895
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c |  8 ++++++++
 net/bluetooth/l2cap_sock.c | 11 +++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9452c6179acb..90676ca0e92b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5117,6 +5117,14 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
+	/* Check if the listening channel has set an output MTU then the
+	 * requested MTU shall be less than or equal to that value.
+	 */
+	if (pchan->omtu && mtu < pchan->omtu) {
+		result = L2CAP_CR_LE_UNACCEPT_PARAMS;
+		goto unlock;
+	}
+
 	result = L2CAP_CR_LE_SUCCESS;
 
 	for (i = 0; i < num_scid; i++) {
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 62ceda979f39..04afc92561cb 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1029,10 +1029,13 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		/* Setting is not supported as it's the remote side that
-		 * decides this.
-		 */
-		err = -EPERM;
+		/* Only allow setting output MTU when not connected */
+		if (sk->sk_state == BT_CONNECTED) {
+			err = -EISCONN;
+			break;
+		}
+
+		chan->omtu = mtu;
 		break;
 
 	case BT_RCVMTU:
-- 
2.52.0

