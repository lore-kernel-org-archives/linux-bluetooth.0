Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512523;
	b=EiHj+N/XKEHggfLZ3uQcOZ0T+0OiDiWPAgznu/49jyj1B77RencaYzscfrE+RhbHO7Bp
	 /FZS2buDFj/mOJ66YeLJ6FXQ1vMywsLLysMIOIl79Z2FwRFpuu5U69F+b228nh7E1uisg
	 BkLUBAbhfwIsj0/4kJFla6x/IlS3g1BlHsW0NMswPiTjQT+2ZKY+zw5ymfgLR8uhEaRWn
	 NaFk9bLpFgeYo44ZyI3vp5vj8rBNWFOhNGVThP44pH0W4Ff4F3u8EBJ3iBZF3o+FyHsHk
	 9jRX2BgKjW9tK2kX4mv1EiOJ39htCqBF3VzzRayxarkYn7dpgn2Ljt77dKYM4sfco9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7rLnUAVQjLkYkBs7fQbXnC/Xjs3Y2KkO+ljsVA+ovTs=;
	b=rzP9kB2mKou0KB0doh/ALdkC8laZV6bvj2ispKszFRCMvXlts09cPxFcIoJfmIXfovHb
	 ExEN03wxexVmlNBWbLhobTTIhZcD8B3NMelLaDKqbexT0gi4Bx2RU4klC+W/Ir4IHeT7C
	 NssM/phTws76QYTtDaGIMeXYdxPRF0m3IZFIWHo1Tju2AwTjRapFn8oh1GcDEJb2Jyxm1
	 YwrRDXB5jwTGaAHNfSYz9Vl655yP5eq/39BMgebXlwAD0QCUtMDsB8bTvmzfEucMsylPs
	 kD1Q2lIgCVa1UzqT0ITmt0d3fzG82nM6lEmz8ST75e0P9xxaS0Z2iPpreHYDioA1GLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=mBu2iAGV;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCF3606A32A
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 09:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BCF3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=mBu2iAGV
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e47347279so2492571f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 01:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795512521; x=1796117321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7rLnUAVQjLkYkBs7fQbXnC/Xjs3Y2KkO+ljsVA+ovTs=;
        b=mBu2iAGVJbONsR9PLluHRgcDJxe3I0yt8E5D9KjvBu117edUn6vDgQDES2eENgRC2h
         MmuPoNYhkvnO2NdWlUrqvQ1KF323YCPhktj0NSPbD3NUUrw4RmAO93InhZlyVkan/+lD
         0J+ncFg+W2gSPplrLB4VmoPHaGrzi2A/kOO58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512521; x=1796117321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7rLnUAVQjLkYkBs7fQbXnC/Xjs3Y2KkO+ljsVA+ovTs=;
        b=FVM8ke8jqivC6JYnB7ZPkXvdN/eEXt5zk1M7vHj+1maYvmKPp2BEX94MwZEz2Fch/g
         ENkaemFGWlpQvITCukplnxMX9DyAMTD0LAE3xlqbIkj76qs9cbMZlAkY2MIJFXJGFCLz
         8Uzw2yv9eW+BePNZqxFHfnFT8InF+6qkadpWoDQ94RHJkx30zhwugQqjTEoWOB3h7Qdd
         fCILrhCORGLUiV7kRXYHH1nOyIkm8hl165Ug8GlK/eNy7XPZJaShhxMhAnIP3OCwJZpA
         z2feU2CiW8p33IE0N2ZZekuzqcrNweRVsfQ9+MV7wmmFNPUHvhID+6+ihfXs/tvU84s0
         os7A==
X-Gm-Message-State: APuU4Z/HuVbLc2aVRGuCovLiZneu08i/s3ZB06n6tNlTaftjIlB8kZNR
	TgWDQxedw13gUgjG/23efYqSeSPd+gpajxjb3lpJNdXqawOdOHubmEZQn+JrToXiFKuHYsX/9Nt
	2jJlW
X-Gm-Gg: AZFdTZesektKYaoxxlr1UgIHdwWnTYOJjCnsEfL6LfLXa2mJjw5HZvpfyUTwbrKoFXI
	jOmeX4ZAh8CTC99WwID4zQdzeF3KSj35trc4gKlTrmZHKKZRqg1qFgce0Ea+5z+T+7xwevmv4Na
	/WoamjBtLbHpNczYP/KM0QnpOgZz9KznvsUJ+n7p7h/Dks6YxBU/LfuwNmSth0aCrM9gfyWzUuj
	EHa5+CMHpKoTZ9PkvLY1i5iSzOdh5NMUD5jDxaTRkuQoGl8KyIdHCt7AZDEPe/goA5RKRw1SvLc
	uF31rLVrEW8Xwx9CwfGBalWbzjHG/ZZ8a2kBU75Bl1oqUz2fGfJNJ/5TZwbbw5LExTvyH/mM2pL
	B8r4/otp8ibBE95dr4x2VKarbrsL0j9lNG7io6UPzrkUjHBR6n8ILe+LqV2JtaWe85A+jgI11p6
	KANf5slaUefQAkU65w9XzDzpKxBqN/pq0WVgllhi1159T7p11YZy7n2dHbMPB5pprrwPGjmurWS
	+rHmXStGbP9JrUljVXwJULt+y6n+UlbNGsyhIliS8HyeUKPpHl4XonuPYXIO4ARIIlIcv0xJDVS
	kAAPnw24RJpycHqF1eoz+mSzfWtDG5k4wyNaUEUNDS5soZ0Kag==
X-Received: by 2002:a05:6000:4813:b0:490:2033:1477 with SMTP id ffacd0b85a97d-4abb917a9eemr25126402f8f.56.1795512521338;
        Tue, 24 Nov 2026 01:28:41 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm27870362f8f.59.2026.11.24.01.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:28:41 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 01/10] avrcp: Fix not checking browsing PDU parameter length
Date: Tue, 24 Nov 2026 10:28:24 +0100
Message-ID: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

The parameter length of a browsing PDU is not checked against the
number of bytes received, so a handler takes the parameters missing
from a short PDU from whatever the buffer held before.

To reproduce, send to the target a GetFolderItems with a parameter
length of 10 but no parameters. It is answered from the zeroed buffer
as a request for the media players 0 to 0:

  btmon: AVRCP: GetFolderItems: len 0x000a
  handle_browsing_pdu() AVRCP Browsing PDU 0x71, len 0x000A
  avrcp_handle_get_folder_items() scope 0x00 start_item 0x00000000
      end_item 0x00000000
  btmon: AVRCP: GetFolderItems: len 0x002c
  btmon: Status: 0x04 (Success)
  btmon: NumOfItems: 0x0001 (1)
  btmon: Name: Player A

Reject a PDU whose parameter length does not match, as the control
channel does since commit e2b0f0d8d63e ("avrcp: Fix not checking if
params_len match number of received bytes").

Fixes: 731aec9cae63 ("AVRCP: Add handler for browsing PDUs")
Assisted-by: Claude:claude-opus-5-5
---
Changes in v3:
- Patch 5: SetBrowsedPlayer is not sent again while one is in flight.
- Patch 6: the folder path is made valid with g_strcanon().
- Patches 8 and 10: the NumberOfItems patch is split in two, one per fix.
- New patch 9: a unit test for a stale NumberOfItems reply. 

 profiles/audio/avrcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2f214e982..95b1d8c47 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2164,9 +2164,20 @@ static size_t handle_browsing_pdu(struct avctp *conn,
 	const struct browsing_pdu_handler *handler;
 	struct avrcp_browsing_header *pdu = (void *) operands;
 
+	if (operand_count < AVRCP_BROWSING_HEADER_LENGTH)
+		return avrcp_browsing_general_reject(operands);
+
 	DBG("AVRCP Browsing PDU 0x%02X, len 0x%04X", pdu->pdu_id,
 						be16_to_cpu(pdu->param_len));
 
+	if (be16_to_cpu(pdu->param_len) !=
+			operand_count - AVRCP_BROWSING_HEADER_LENGTH) {
+		DBG("AVRCP Browsing PDU parameters length don't match");
+		pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
+		pdu->param_len = cpu_to_be16(1);
+		return AVRCP_BROWSING_HEADER_LENGTH + 1;
+	}
+
 	for (handler = browsing_handlers; handler->pdu_id; handler++) {
 		if (handler->pdu_id == pdu->pdu_id)
 			goto done;

base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0

