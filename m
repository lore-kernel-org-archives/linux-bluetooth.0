Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076200;
	b=Re3TL5C9tM19vXMYp+XOL7uzfK11vORh5SnUZSgDe5diSNCWj1QzkrbmM2DMTL1Jlc/q
	 C1m3MJa2mQsd+jsWhSRo+aoqjp4HQL6NZkgDe26AUwVCObRtl06LxajkGlVHZAGK8L17c
	 KC4QiKU94n+/UELRSAPp9oAwm2QhyFjjOEAD4y3pIfQZ/smpdj266ZYyHbLiXCM1DA5Sm
	 Pvk1fevypEcU++1Xlfx4uq01um1i9ovEkVZciR+84lY+NYvnzFLgtlHpdeS34PO9bo/wP
	 h1R7H9FnwYgEq4oYUq73YwudhOHReXgo9m+XMAkz0EIhKSy87cAFuoWt0WAbTmCWxqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pA/kWTIDjteLr7b0iJKKhRxfEurQADK15UnD/eDDFR8=;
	b=xjgGeBUT34krAbd4LLuYY3XMVWHHW2O9UpBr/i0BfDyyR7eQ50NYTBnfWRBTbRA5Qjs9
	 hEDn+YHCkCCrCRbV5nv9F20e7vGb822EtuvG0eUUnPpRRu+3rR6fjRW9ABvcews+aM7Kq
	 AS5BN2KM2pFmIdYsSO46oIWHTKl1D3E15F7zHRHQNO9/rnffMwjAKNDh0SWHB+jjzimFD
	 hqGqIiW/fIlZ1E9CBbIDQMrGNrf7yj9A7iRAN+pQdzHJvDUTXIiyAYWTN/x2j+MkYA/x6
	 zIpElwhwm4dPLjfYuSHO+dcToaNh0ZhLcEOdVRd4nikOKgUhllz8hWaXUS9yhQ2koqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f4p8x4KV;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95990606A816
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 08:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95990606A816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f4p8x4KV
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b88aab58fdso238412a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795076199; x=1795680999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pA/kWTIDjteLr7b0iJKKhRxfEurQADK15UnD/eDDFR8=;
        b=f4p8x4KV/zrVyLYjA6lidWYg1uFs3dYzlJfipBU6K/eT1o1SH0enWFCItCn2hXenMP
         zl7twQd8Fj1HS9sSDgXaN0Oen93Zlhb7m3VPp6Ft6PCdXpc24t0kZDhJpFqXzDUiFMHt
         rv+V+GtRZOb0QZiABLvE2KxVY3ilAZqK69quX3eu28t/G0t1F1DYaS27W0RgkCSJCYMs
         k6t1oB/vCjPTcecPlHYnW7RZoE7+ZSopPQiejWPRv8ywHPzgRC+K54YFXOv7fm1hT7SL
         dfgcoSfZLHmV1vxihIOde/5IxYF7+QKW7FC0fOZjKBgBhnR4W1elws6ctjgJ1yJ+RcOu
         5JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076199; x=1795680999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pA/kWTIDjteLr7b0iJKKhRxfEurQADK15UnD/eDDFR8=;
        b=1IfxZrxLYQ/Rj1AgBbKwWfv3Msa7HLtz0jI/G0IDNk6jlQWrYz/RxSmPwy6a0aCg+K
         CxZY7hcqq1PLieI9hS6TMDUQCajL7xVtXbkw8VBLEE7/RmPg/4ZoF3gr2AlH2xpLtfMy
         x1k7AmzxJOaim6AhCgu31HfhxP3r9L1IHak5seFJFNkJbTbRBXLj8QnANiuc2l0XUE7a
         HJhozjme3lbWjHhECLWibdBbnzAzyTCCTF43nvZB/FF1uaVn/NqvJahZxE8b3ld9iT3l
         zzzPlH27gNWV5HEYKAEa4VzVDYri2hzbdKqkqLqBsc1Rw/Emk2OnH/iW69SAAd37lB7F
         qwiw==
X-Gm-Message-State: APuU4Z/NkyRvWzDVPnOU3lBFXrHB7qlunexCnPzD3J3izoSO0OG+42ak
	ANwvmEgor9y9ziG5ZB7hb7ONcPo549kXq8fOJfyJMBdHs3apmkwxiaOq64Oeq8yW
X-Gm-Gg: AYBFou2Y31bL66wzw6nTyfaprduw7vxVoT16jLEEOtwK02I8AiXMMWA525hANG/aBgD
	bOB/VjCswf0P6d6QgxnL8/1Nx7ziHLquaatZWqehbL+uINXwOIXZIcZWdeHsDCYxUkKgUdPi00a
	ADuwjq04HjQY+NGuRTYfR6vA0unj5RhzEYnu8eBscpAmHslmpLfCbya5e2Xhdu8q0ylJvVFIcbD
	YBHH0ECZKDu6oFp5XDfKXGzHM1j9K/6aNjy8Dd756I9tOn1SppAq6+zmpkyi+AA9m1/tepn+MYm
	/n7BMthgjnH6jH0SqOEIR5sxuarSMbP8gHNO3zyYn1/k/JbkM1C/vlzPsqT9CZbej8905IvLR9P
	2JzIG6jLPx4FMabwPqgE1ZaAH+gB+fW9Ti9nxjQtXjwHI+I+fobxMKcxt+98jmQ//etsn+EHNrP
	q7pMc6JACtGOSPBaBCoOfHhMgtrOaoPOWaKyiHLPkWQLnrIlZj5Z4fbmQhVn6d0HXBF63pPsBTU
	JCquaKTn17fbAUcitHKsduokz24QASmTyydgtMVYiWDgw0HJGlfUNYdkElltTEcoEj4/aInMwb/
	stVOK/ajVmOD47Pu+Vu8Vny7kLAYrZJQIa8qd+rpbvwXYfAz0jsx8HmF
X-Received: by 2002:a05:6402:446:b0:6b4:2960:d381 with SMTP id 4fb4d7f45d1cf-6b887a7ca45mr4116521a12.1.1795076198896;
        Thu, 19 Nov 2026 00:16:38 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a22e143sm2229580a12.29.2026.11.19.00.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:16:38 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v3 6/9] monitor: Fix LE PAST Received decoding
Date: Thu, 19 Nov 2026 09:16:18 +0100
Message-ID: <20261119081621.112623-7-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119081621.112623-1-rolandschober1968@gmail.com>
References: <20261119081621.112623-1-rolandschober1968@gmail.com>
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

The LE Periodic Advertising Sync Transfer Received decoder prints the
connection handle twice, doubles the colon of three labels, prints the
interval without a unit and decodes the 1 octet Advertiser_Clock_Accuracy
as a BR/EDR clock accuracy in units of 0.3125 ms:

        Handle: 3585
        Connection handle: 3585
        ...
        Address type:: Random (0x01)
        Address:: C0:11:22:33:44:55 (Static)
        PHY:: LE 2M (0x02)
        Periodic advertising Interval: 1000.000
        Accuracy: 1.5625 msec (0x0005)

Decode it the way LE Periodic Advertising Sync Established is decoded:

        Handle: 3585 (LE-ACL) Address: C0:11:22:33:44:55 (Static)
        ...
        Address type: Random (0x01)
        Address: C0:11:22:33:44:55 (Static)
        PHY: LE 2M (0x02)
        Periodic advertising interval: 1000.00 msec (0x0320)
        Advertiser clock accuracy: 0x05

Fixes: 228c945a93a4 ("monitor: Decode LE Periodic Advertising Sync Transfer Received Event")
Assisted-by: Claude:claude-opus-5-5
---
 monitor/packet.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index d926efe28..015392713 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14058,17 +14058,15 @@ static void le_past_received_evt(struct timeval *tv, uint16_t index,
 	const struct bt_hci_evt_le_past_recv *evt = data;
 
 	print_status(evt->status);
-	print_field("Handle: %d", evt->handle);
-	print_field("Connection handle: %d", evt->handle);
-	print_field("Service data: 0x%4.4x", evt->service_data);
-	print_field("Sync handle: %d", evt->sync_handle);
+	print_handle(evt->handle);
+	print_field("Service data: 0x%4.4x", le16_to_cpu(evt->service_data));
+	print_field("Sync handle: %d", le16_to_cpu(evt->sync_handle));
 	print_field("SID: 0x%2.2x", evt->sid);
-	print_peer_addr_type("Address type:", evt->addr_type);
-	print_addr("Address:", evt->addr, evt->addr_type);
-	print_le_phy("PHY:", evt->phy);
-	print_field("Periodic advertising Interval: %.3f",
-							1.25 * evt->interval);
-	print_clock_accuracy(evt->clock_accuracy);
+	print_peer_addr_type("Address type", evt->addr_type);
+	print_addr("Address", evt->addr, evt->addr_type);
+	print_le_phy("PHY", evt->phy);
+	print_slot_125("Periodic advertising interval", evt->interval);
+	print_field("Advertiser clock accuracy: 0x%2.2x", evt->clock_accuracy);
 }
 
 static void le_cis_established_evt(struct timeval *tv, uint16_t index,
-- 
2.47.3

