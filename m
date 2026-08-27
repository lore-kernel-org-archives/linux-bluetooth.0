Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECC368D4C
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853724; cv=none; b=BZtbvmcuZ7JgW/Bv26ufrEo/ThnpFSufbK4OpIrCp0szRFTgqKWcqafr4e+Uwir+N6WXMyJe3bE27mIAeZGkm+PbulEZ6++Oh/gOBBGNDz3p/fW9rOHsWQGSDTNUncSA4oznAFKLKifVFzYDkcQmDtJcAZ3ldBZCyko7JXe9Nls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853724; c=relaxed/simple;
	bh=rZ/ofQjvAm84VVXQzuHFa8iI0bPzyIKQL1PHN5Pyykw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+Er1L+Coe1dCW+VT3wv66WxoS2LZCB85zA60JJBj7LosozN3sXg9EjiJ4GucLqLcHWAshDvBNjLoW4eXgAptl2IVrrkZKF6d5ymxPq0dkJvTxSoWe34wj+RpDacNJlVydG3WCImX5KZauPthGm07YpAQ/J/apv7PPiQNmi2SuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWmO8Lx8; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWmO8Lx8"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-77bf892b496so39694137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 11:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787853721; x=1788458521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6E/V4rbi0UvuTkML5RFC7iXSVwF8/YA7F5w88CJxgTk=;
        b=fWmO8Lx8/mZvj/Nl0CrZXXpHmrL3LzAHnmr80Z3BHsSuA/aFlqyIYc7JD02V0PTbLM
         Tir0VKl/af34rQqtENcAwW6fMD1Lo25ueIZ133MB1/zhD03xyDBA8O0HNU3X8JFP9luY
         EFZ7+tHtuMJqvVukcafPzqW1jVdwFHhkUwtFYBLWKh1wvjlCv89Et0Yc6TzBPnxE+XPf
         /Azfvq0MxiBZ3APTBoHGd/6zdzpOxqnwmCAMUv5e08O4LDOouMb0hGF2FA4AVcprC11k
         MGOvZcqLrNQk/Wa6uE7P9XpLpNILqwsXntgTELFDHmLdbjwDJP2IxO22EiynpO77n751
         kyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853721; x=1788458521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6E/V4rbi0UvuTkML5RFC7iXSVwF8/YA7F5w88CJxgTk=;
        b=BeXpmXD89FGLlT6QIvpuPK+TROmTcI3fhNoZ1lW72JvRg9KtOzN+lEXy6tLFkzRBjN
         ws1dAe8XBGd6AOETa92F6nBtl1kSi7QCu3lJrkoeRuReOe1rM9UlX8/1BtpRfj8oSPY9
         E4bD+xRZnKGDtgZltFQhB/aEvUNxoyh46AJY9iAYmBSRV2EH/Zbq/nKLKP5OUk3FKnbb
         6sgNN699cb21hAnI1BChmUfkZQBkoqZcmX1kR9Ls0lld0Fr4muPCpw549cs+kTlxMJ4K
         51a9Pyyu9qZTy+qO9PxZ6djHm2uzzO5U4oDfd+ynchKw3cHW8jDFToctmtsgANlCGums
         lvKg==
X-Gm-Message-State: AFuF++nTVz+7U6/X8PP2gdzcHmOtn+7EUIMdAEuOW8Hig7qon5jcbLVH
	hzZpZSPzcd/VrDO/eiEG9Hqe8kSdu6/Y244s+lgtlqWnPlbi8ASiK6v/yT2ZBuDP
X-Gm-Gg: AR+sD11IwXYqjuOy5lv2rGttxKiRLLtQ3/gHGOrp0RyeHLPa9MnHoDmiRpJ8GLlMIal
	Lm2KfbZ2fZj19sHXqdBX4luMiSDjosSMmvaCOJPeKbCHtBsI1pM6j4RZ93qn8gnbD28bFdHAj2d
	yuQTP35nOq5pwk5rCVT/LWryt8xnLTJME/T11Tnb5Ogd7UB6RMTwnWcplqZkPHBE7LqPogcL1gW
	fkbLHxJt0tGJh/wzzFv6e8JJ2Ry4klhBjxFOvhGXazplYqP9/RWL8LFI0LyIYOeNLemkCNsZnZl
	wCRETOXZHFLeRfL2LfjtPLkXcRjF1gP/b+TBWYwQ7RcLZe/SFhvD1T27sxR77/zm/0c8bXeY24U
	hskLt3Ar19Y3/hY811vRIUatiy/tZo9fzZBboLFkrpPUHX/AGnkehiykkGCinty949IthYufKm1
	zxCDAznPB6dZfhb42THAcZdibrWEytQcFOAwDuWU2pBf43C0TnljeiDpb0/biJrHynmJd5TD7Vg
	pLh+rc1/Mbk/PfbUwd5/2r+dyQlKCK1CVVhNNQYLXnGCTLDIurNBx0=
X-Received: by 2002:a05:6102:5806:b0:783:c374:3d96 with SMTP id ada2fe7eead31-785982213c5mr39319137.2.1787853721089;
        Thu, 27 Aug 2026 11:02:01 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97ccc0f4963sm3695458241.12.2026.08.27.11.02.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:02:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/2] Bluetooth: ISO: require CAP_NET_BIND_SERVICE to bind
Date: Thu, 27 Aug 2026 14:01:49 -0400
Message-ID: <20260827180149.415744-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827180149.415744-1-luiz.dentz@gmail.com>
References: <20260827180149.415744-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ISO sockets have no PSM or port namespace: binding one reserves the
ability to accept any incoming CIS or to sync to broadcast streams on
the adapter. That is equivalent to listening on a well-known service,
which L2CAP already restricts to CAP_NET_BIND_SERVICE in
l2cap_validate_bredr_psm()/l2cap_validate_le_psm().

Apply the same restriction to iso_sock_bind() so unprivileged processes
can no longer hijack incoming ISO links.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 75bfd5938b2e..4e1e34ffc294 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1200,6 +1200,13 @@ static int iso_sock_bind(struct socket *sock, struct sockaddr_unsized *addr,
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
+	/* Binding an ISO socket reserves the ability to accept any incoming
+	 * CIS/BIS on the adapter, so restrict it in the same way L2CAP
+	 * restricts well-known PSMs.
+	 */
+	if (!capable(CAP_NET_BIND_SERVICE))
+		return -EACCES;
+
 	lock_sock(sk);
 
 	if ((sk->sk_state == BT_CONNECT2 || sk->sk_state == BT_CONNECTED) &&
-- 
2.54.0

