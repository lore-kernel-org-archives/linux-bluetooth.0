Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B1248193
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749578645; cv=none; b=M0kvP4+IDU2qLz1Gq5Wu7bkLIpZXsAGMa4nsO1dbTwwjsAipMaiZyORcIZuzBkrYFWaKS+IWM10sMqkLJTd+go5wtfYRkVYkDNBDH+B2q50tg3I4J+r9GuNc3fle1ea1ZgIhVrnTxDSwsDcRqHDYLbwxtFzJZwadM2zi/959X7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749578645; c=relaxed/simple;
	bh=4x8ewPe1nKaAZhhSCqbTE3LlFxgUgY29ASc9lHxSp2I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DC3ucrrIPUHZLUjyOmFAc+gq9bc/YBbcB16V+Kxx4e0VNQUNMbkTeVYLBD/iIoxYSJ6DkX0zBMQPnZcBh5bmp1zCVMMV83CVEOq3VZnMaWXxdi1jM30PB4HHs4T/wjhSnEWZqYopjGlgnLOSpQ8jwMdZ4gj5TCGqW0oMvrYShYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xob0SLlh; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xob0SLlh"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7caeeef95d4so567328685a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749578641; x=1750183441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WfP9sVp946zPeCcPHEQe5yc+PEwKAWCPOKfhG/HYPRM=;
        b=Xob0SLlhzNW7plgICND7ZxeEnkNStQwvJxRrwRGedltrfUn7J+3+Mpwt6DV15crMOm
         x5P+5oks8JCG7aBkppYqY0Vk0OZuxvDw2t+q8BYdqI35sQtrA0RJfYy83siFCSeQL8te
         PTy9VJs55YkG6mg3bKZkbf7U2CjAgErHvAVAKGGC+OvpHC4yE8pChnNLMNz4rAoA92Ac
         E6FegBO8/x0WCWivvz2VKh3amwJLbbglAUveeMhuWGYiE2ZsPBLy4ak3ZZsFxHi3Ykco
         S45mlMhh1PnFmZW0VFoqlBI8wu76EKpZIgYRBQ3owsSF/sPkUk5QyvLbDWheZ6myLHzc
         t/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749578641; x=1750183441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfP9sVp946zPeCcPHEQe5yc+PEwKAWCPOKfhG/HYPRM=;
        b=Z1tlHJSzA2Ds/xaywYdvP14S+3mz8QA3MHsscgMVSpwae6NTHDHyoqzqhtdqxy0XFq
         z2KQwnlXQL8eVQXCLD7PnN0VpKXzbeauCfKRUkvDpt/Q4wCoX7RIwUUpLKEqN2J+xeAy
         OMflTrypOgMrTrxYnFLM4KmbMy3TGYcg0srzIIV3Gnks6J9pcuhlVWYHfZ7rgipjIBcw
         HBdS9GpWpC25V+WElx7DqWjKPsXJisj7C7G3yzXhoun69NXru5u46vKKJMTvuaJnwIWT
         mNTdVImC6AX31BqdkrHAzAWmwkDan0hvtBsn6vFPM3qKcZXcMfttpGaZLl2s72wbF9+c
         UtnA==
X-Gm-Message-State: AOJu0Yz5b9D+GXmT2qTgHTboFLYnmxmIqp4kjXheG0b8ZFz2MwThpiPX
	4BhLnckmwY1jGYZ43mNs7bOVwSaCGVXtsXrLPncjaIbiLdx7NjHad8h23IuRyA==
X-Gm-Gg: ASbGnctQ3AAyMsYnEUOD+838kY3pxe/UEm9L1i1Ra6TCjMgPfh7PBrJncrgdTj00r1l
	ArMucJZdzL7KX/95jqcQDGNiMswWMNFdGcmIsgV/YKx3qufpXQT+2E4gSQZTGUAOurJqDfiydv3
	0hcupdGrMUgt5+5lw5j36jpdr1KBDczIgAuuB8iOs7kEAoM756b54PqgoN7MIwU5EvSbAcC2Ovg
	Yn9F+N5GKwwBQclOc8OeNTz7hlOuWtoU2++mApfdy1eD7D4C6Z2OdK1i2gApjMAzUGUgdK3mOnx
	kfuAZgHS44CBSgV71ExqZHb16RI6oHAOyPwHIFohuFiYlUapc3nTnh6T9P5YRjxG5+zJT8xJaVm
	KmrzxEwlnJgzehoOFa5sE9yALx3kLKTg=
X-Google-Smtp-Source: AGHT+IEfMj+USLtOqr9VTbQhaa8TyjbOaPDpWFa0BnJTt47E5gqpZXmVia6DLe1PGHk7o5G78d82Yw==
X-Received: by 2002:a05:620a:2411:b0:7d3:a697:b68e with SMTP id af79cd13be357-7d3a8806339mr38945985a.11.1749578641321;
        Tue, 10 Jun 2025 11:04:01 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeaf9612asm1593777241.30.2025.06.10.11.03.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 11:04:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/2] Bluetooth: ISO: Fix using BT_SK_PA_SYNC to detect BIS sockets
Date: Tue, 10 Jun 2025 14:03:58 -0400
Message-ID: <20250610180359.1133739-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BT_SK_PA_SYNC is only valid for Broadcast Sinks which means socket used
for Broadcast Sources wouldn't be able to use the likes of getpeername
to read out the sockaddr_iso_bc fields which may have been update (e.g.
bc_sid).

Fixes: 0a766a0affb5 ("Bluetooth: ISO: Fix getpeername not returning sockaddr_iso_bc fields")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 6e2c752aaa8f..affa2077e3a2 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1337,10 +1337,13 @@ static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
 	addr->sa_family = AF_BLUETOOTH;
 
 	if (peer) {
+		struct hci_conn *hcon = iso_pi(sk)->conn ?
+					iso_pi(sk)->conn->hcon : NULL;
+
 		bacpy(&sa->iso_bdaddr, &iso_pi(sk)->dst);
 		sa->iso_bdaddr_type = iso_pi(sk)->dst_type;
 
-		if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
+		if (hcon && hcon->type == BIS_LINK) {
 			sa->iso_bc->bc_sid = iso_pi(sk)->bc_sid;
 			sa->iso_bc->bc_num_bis = iso_pi(sk)->bc_num_bis;
 			memcpy(sa->iso_bc->bc_bis, iso_pi(sk)->bc_bis,
-- 
2.49.0

