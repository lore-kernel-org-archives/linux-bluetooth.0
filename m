Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010723;
	b=RbDcN5R8PIkee6D/j73IuA0nW5Yfd6kPe2uTXEUnelAUdcAeHlEHOcOLAmBe1U7O6wb1
	 KX7OEvPr6Ge3MdvTHrsuF9DQ1YD0TTzMryvYsUeu4L8m0GO/lbNWUPdgDfPghf8YNUL+1
	 fFFOs9O9sBmNjwSzrEC9m1Ol46O5G654takwH2iVbBeTMNc+rksjYtRrBQp9Z1tI1uQAT
	 AR6eXkgF1gX0SCC9TgGX/Rt2ljhg4Tdn0SjtO3jh3Dkjo/rSUsNrUnPqx1XWhMiuRU60P
	 xWfOlLGOZDTjGogeOrdvvO47scFYbNumUGZoFyrmb2bd9gxA9DHLdnIvAdokVYtg+ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xKgb9ZS2KNfuSDJtqHp4Vi833hjt+EUPqL7Hov729wk=;
	b=D3w2gP9gkIo9egcMNDPI/i0j9ecHCRNUdOxPgVHjkxuP2hfBa1g6TVggCrep6nygysdb
	 tLz0QhpuV5ejG1fXVOqFhzUADFgS+L5gFLKCkrTU4awQ1UHxWJ4ZlzW75uVV5k5HpNKcG
	 HqNNt/ExOmUpXzRUkDrK28aDAPiwWO/CVHGnUzLeoUERVsYW9F2Coq4ZTpjDEjIr3hRHe
	 vqowBvUq9dOVgv/b4IIMdKVxZpf55YWW9hrLpoFG63gRCmVU2sGt+mNqIp1OsKfpTPpgw
	 CVskFGlAi1Is++CNk5vbfKHnBtSP0AEwho03H/1o8/0nAvwRhFs0JJyeaYlg1XylXIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="J/5qr/1X";
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C6606A338
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 002C6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J/5qr/1X
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7d2eba2b74aso502196137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010721; x=1795615521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xKgb9ZS2KNfuSDJtqHp4Vi833hjt+EUPqL7Hov729wk=;
        b=J/5qr/1X+9WbiB7QDiNZt492WQEMEp8vvIC8m8Q0sbD9XpTgdX6V9L2N7t1qe27mDP
         kRkZXQnYAqQOfqegRtxLRIDY0ZD1zBnXo0NB41TzqMfBi6/VRAHsuC4S4VavLQXuwefy
         5nnM4gTZ/IJJC3zPVx3+wBKI4Hhg94/jit+vkC5WYbdIj1Trr2Yc0hZMgin3WAInNgip
         pAyK4fxGZAHakl4//uNEUyD3nDQXs/ErpgW5qWLZXLhnELnvCn6+HUfs7sgzk8UdGCE5
         1EuV0HG0Ji3IpkOvrqirrfY3pt95jl821Z2ih2TpiT3CMs6Zg2Kt3POJWhAh84dsXVB+
         ECrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010721; x=1795615521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xKgb9ZS2KNfuSDJtqHp4Vi833hjt+EUPqL7Hov729wk=;
        b=VBerFEIhuGs65obVU2yZ9iG7EKGHSoF0kRROTZ8NIjayiZaDTHT4V+S7JPaqHOlaF1
         xpI2qTgxCrGcE1m7SUrDK5Ac/gtWDDxtP12/ojIYI2g+d1NJmSAn25W7Y385Y54+ToHo
         buqNTSAGExlG9Y1dRfxoqU+B+fJ7Soov1c9PX68yAuPfn81/OorhgSmPU6ae79wCle1W
         rK6a6mb9fEJIzyIkxW+0UG/uJu/Gbs+HeHGedj6/G0sYnpCMh3gJDdRzrKJoLOl6VX/Q
         eI4lOZ6fn0e4tUFFpwTJpVvLUEN4NJLN5T8PuDVlnWsriFIwQUGvbAj2b3xcQp2INwWu
         87eQ==
X-Gm-Message-State: APuU4Z8OgXeb/vK1MmIR7LvQU7NdgqqvJ2Zkv/XKA+V6kM6fLXVmyS1r
	4C2sLKvgH33+/krua6Z3cOZ+1iVbXkin/UUNPI3LJe6oxum6uKpriHAM9XkxHTIS
X-Gm-Gg: AYBFou1uk4kzXs9X2wGPUmrcWJjMEO/IpDGRnqLq6IYqONnb1DaEVvcnCM8+7o9gn6J
	zwEUk/1JSwMC+fXpz7PvJboVHNIuHZgX+FNUsfxLpjg5ErRwSzNqIBZZakoi1jEgHmPfAaJk2pe
	hVS4ibTzTbmG9GedlbDc5XFCtxYMvCRT91Ksmor10zU6AW6VF2/Cf1n7Sf5x/POnsPlsIR3kYfN
	KQIhh7OAJ90d0IvZfkskWe1WB4pL/TY1NN7yxNnLFN7BTttF2NhlFANyoMcq8QMq4eutpfaTkEP
	7pZR+RQnAHTWsd0cbzHIm8Xu/GA3KeHvj3PH6H//BRkOv7uFTlRU8TJsWWgbZb5h3ukM3ujx6ys
	nqmuLJ0hk6H7yYL0fBgYF6FoXMvPjq/8xXXMUaqdziwXKtmuk1oR2WirWzcTA2Qypd3ZQb9iX+W
	Dt9/6u17J8FQhO7/Q53j4uc+fj7dKCuQB7Kn00J1KX7UTyrdgfs1cf4WRRS2aJvArKtgkFfpn4b
	UkyUd9iHnjf7Ox3vy5BysEBgIgtpJIU9upBVqVLYXmm+hbV/9Qgbqd6ghEb4Ytw1vpXP6j+beqA
	edI7TIiLxkqiwe/IYT0uKTbq3WFFQs39fg7IXOIReaDIGizwt53WkcQcVr/Cr8oRvKjCBzw77WX
	o/rYGuAFqYvVB3/FApI3LImKzpjf5z6hz/3c9Ro8zFkcMPu0sdI59++t1i6Hlsjj0qGf0uNfIiK
	8BR/A=
X-Received: by 2002:a67:e111:0:b0:7d6:3d9a:4da2 with SMTP id ada2fe7eead31-7d6ba49c2f7mr829618137.26.1795010721526;
        Wed, 18 Nov 2026 06:05:21 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 01/17] Bluetooth: mgmt: Fix read_index_list() buffer overflow
Date: Wed, 18 Nov 2026 09:05:02 -0500
Message-ID: <20261118140518.59878-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118140518.59878-1-luiz.dentz@gmail.com>
References: <20261118140518.59878-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The first pass counts only configured controllers, but HCI_UNCONFIGURED
can change before the second pass, which may then write more entries than
were allocated. Size the buffer from the total number of controllers as
read_unconf_index_list() already does.

Reported-by: sashiko.dev (linux-7841362e-9b8f-465f-aa22-e99c315231e2)
Fixes: 73d1df2a7a10 ("Bluetooth: Add support for Read Unconfigured Index List command")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6ed3bf6f1738..fc0be4ca033f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -444,10 +444,8 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 	read_lock(&hci_dev_list_lock);
 
 	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
-		if (!hci_dev_test_flag(d, HCI_UNCONFIGURED))
-			count++;
-	}
+	list_for_each_entry(d, &hci_dev_list, list)
+		count++;
 
 	rp_len = sizeof(*rp) + (2 * count);
 	rp = kmalloc(rp_len, GFP_ATOMIC);
-- 
2.56.0

