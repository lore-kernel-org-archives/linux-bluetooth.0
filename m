Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F523B628
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390395; cv=none; b=X2TFieGPXIVDWWgxuLmWEJJeX3rIrlhDxCfJqqRO4cxgkz3CUcmj5XxyJfSSXAIe2oqHRf15whF40rKkTuyNdWNRCJcuw6VU7NRhGC10LuU2ysapUrqClqbtNmmX+n/iXEvWiNDOe+aGDunckbcxQFHmEG1pSUUhYtmBoyQNGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390395; c=relaxed/simple;
	bh=NEd2Tf7H49pgHdO7rdrsVzn2xK7WxrmVg/NGQzOuJu8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWlrB+QdsIk4jiBHN7nyk1R9/Y7AdSH0hGlcLjfEGQFVvlyfOaUTn+0lmKgqH7oAqw9nGJjIUTndH9sMG60+HnKTgcv4HizHTV3nTbktfwqRoCVLVlsKUmcu1HHdsdJL7JxzCLiedLptTgjWsBtGMPIWCJ/51tzquDx+NCmdQCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSDSLiFh; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSDSLiFh"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5313ea766d8so524933e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 13:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753390392; x=1753995192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66s/I0IDDRgdBaXz+fBQqyoKsm1eef0GEc1hdRHWyzY=;
        b=NSDSLiFhwcCta0Cn8upEzvV3H4lrDsd3Y6Gu9T5zxoo/Q1I2OtKV5clDbly5CbgynK
         uqD51If1ZXw4FMzjXFBHKv/UaQ6z+296tZL85xZFpO04O1kwsqZotsW9PC2JF4vxGieZ
         ChCLvoFVTUI5KVJdvBNnY0TQFlyUONMsUKwGjTh3e3aRb612qz8gbUHgQuvBc05rsv7N
         +n/pabRq82fFW6hhBGSctCBUZ1zRqb8Yx7oV7c7jCcnXIQj2fKeIpuJk3nB9xLUKGT/H
         107pfhMC1L+WWajHzwHUwmNYNlYPOCEWHYJ1HIdoWDHXFcLyLyCMZf6XpWRXGF9cvhek
         fSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753390392; x=1753995192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66s/I0IDDRgdBaXz+fBQqyoKsm1eef0GEc1hdRHWyzY=;
        b=Sn31AthPRoxM0B4UethdoOC+TDrlRr/vLAjMnT9ov60tZxeo5D2v1J4yod7UOvh7BI
         IHTW+oquTXIPkRwTFDz5awKTFlYHfkNdTLpbfs/lfpNtvcxzImOf6IvACxxsBBgQewLv
         ba7CHxaSbaEcRK4482xBzmRqeE8eBW9q57Fza4WY08Hij7/PdMBB3mJaJ/GD6MbX55fC
         r4MCbeaA3zNteL9h7B26UcpPc6ess2NfVVBlc2MM0O1/11ebs3YpSQ+lHpNtvzurYTTJ
         P1H22dE0oxKH2tAwW4ID3fvjQFM6ky0O36jIwibLVyx4kFJQft5rcJo2uNRoqXNfERWv
         Tzqw==
X-Gm-Message-State: AOJu0YwT9b04WSk8auVRzOw6zFpqoVbaWPUys5t9tDCsdS2L0ZJupKVJ
	2dg3CS9H5Xqquo3zQnqCV3XcLnqqibWM3gjdKZ9aMN48MwxT1iYcBP7c9XEr8w==
X-Gm-Gg: ASbGnctMb0TFlKkjoxZpyhyrSW3r7ehp2Auw37bfE9I5Iztxw2U5Ly4yGN0sRpPkFdc
	0l93VGRyBNooWhCCjxW6OsQ3NuQEl9R9re7Z+yWem8JOrzFgZdfXfAiJ65OBlY0C4AUxYifsa50
	d8LzgHxDTy98gcsbCDuIarhFKzBKiw9Nj7Q0DJ0vBpl64/dwPOQxUqyVk+oJmPgEci99AKR6xpd
	3owkNotre8zNhwjpyXpi3U6oB6q3kg0PQFKt2JoC9fF6ceDcT9plarENcXzAm5Jey5yWiCdkt0k
	jzuZERCK5OIY64aSPUrqTBc0BK17FBhXRglmsAk5p0x8y/wXSPYVn6etX/dVqFlC/NECWrbuS+9
	rSHov9fWuhqzbTo6Y9/hDOH4IclW1stwLKN7qqHA+cu8tz9NoiYPz5RAqv+X4TrsBFpuM+2n8Zv
	s=
X-Google-Smtp-Source: AGHT+IGYy37uVPwXyAc9YXFrPUpR/C4Li+p2/rl/k2qeQ7Eu9VoOXLMCAOnd5natjU1w3AU7QVZYLw==
X-Received: by 2002:a05:6122:1809:b0:530:7a17:88ce with SMTP id 71dfb90a1353d-537af5bf5e9mr4410940e0c.9.1753390391568;
        Thu, 24 Jul 2025 13:53:11 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-537bf66adb7sm612774e0c.19.2025.07.24.13.53.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 13:53:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: ISO: Fix getname not returning broadcast fields
Date: Thu, 24 Jul 2025 16:52:59 -0400
Message-ID: <20250724205259.13273-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724205259.13273-1-luiz.dentz@gmail.com>
References: <20250724205259.13273-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

getname shall return iso_bc fields for both BIS_LINK and PA_LINK since
the likes of bluetoothd do use the getpeername to retrieve the SID both
when enumerating the broadcasters and when synchronizing.

Fixes: a7bcffc673de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7bd3aa0a6db9..eaffd25570e3 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1347,7 +1347,7 @@ static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
 		bacpy(&sa->iso_bdaddr, &iso_pi(sk)->dst);
 		sa->iso_bdaddr_type = iso_pi(sk)->dst_type;
 
-		if (hcon && hcon->type == BIS_LINK) {
+		if (hcon && (hcon->type == BIS_LINK || hcon->type == PA_LINK)) {
 			sa->iso_bc->bc_sid = iso_pi(sk)->bc_sid;
 			sa->iso_bc->bc_num_bis = iso_pi(sk)->bc_num_bis;
 			memcpy(sa->iso_bc->bc_bis, iso_pi(sk)->bc_bis,
-- 
2.50.1

