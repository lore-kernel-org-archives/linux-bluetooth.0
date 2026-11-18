Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017565;
	b=zsYzh15XzekIq75hSj6K1TmAzwM+cLMpXJRMdeNRCdyUYy94BuVW/BgkWxS0AO4wppJj
	 D7jZqYu6x9PR76vKJxLDg3pCt6yCvQacrBafCJ0qYi0aS/PkUVMOXgJP6EfSBJ6K3I5LB
	 ShXXtZXC7UMBlP5iyGZtW6jKro7QmjqnWALvHIF3wR2rRnCoALF/p55MQjdNwxSwVrCSz
	 Ivlm6TtBNgkhzEzX2e5b2u+ToTLxxe/JJ1SDapQscQm7oNIySZprDvdUGZp3QsQghJKsD
	 a2hvW19uClu5Oo9d7ykhJSvzpUJxQKnSxEQqjVJ2vkbtfmsMdjaYsXfOmrtWqOirnOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t+JeSLhbAjJ4UKH69xAf4pF1rbRDYbY69wlecPbzVlY=;
	b=R9CFeqHSP+R21N6TcEAj0n2Qzlyw01H+FS2jrlBjEaSWFRSbs+AIFgZaZwn8xO13fm4t
	 Tvfhv49bzLNzJOCGZEOpFLwRvxioPLKb7s50GZ1xCFRCviBCbwFuyMfwVZFNwUVYSV324
	 Ys8eGNMAGQd4z47aRTSvuKiyNL98oEdGiLE/UILJ1aDUQyZ11ArQzt3iEsv7GQa7sE0Mc
	 UoSLGrmZY+zZwGox5ZivdsCWkropkBNrNZDr9qNs3fRup40e6cdSyUfq0bgUwR1A1tJHp
	 v0ibdzGUCb5Bww6crD5qF6scHIgoIsqXi2rQzdSxUvVxtG4VlUVOPAfXemYYerpo3PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pKIpMfnC;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6F606A32F
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46D6F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pKIpMfnC
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eae12762c9so419875e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017564; x=1795622364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t+JeSLhbAjJ4UKH69xAf4pF1rbRDYbY69wlecPbzVlY=;
        b=pKIpMfnCU42ZPifiBEs9S630YZd0//h+d9Ib9QVZommIOZL5i1DSEvb2XCFZVJgmmL
         PfMDoVRbyyYGWTrWVkD2I9L8YZflGBbDQq0HY7p+APj/QA4DyR7FifGRdMneHinqAPj3
         wzPr1Sddxlq7FsJN18gdkpX62a9HNi9OW/mfokZZ3Xrz1r1AylFYFJU8SN8w6edRp9mz
         xslgYebz0gdk/mf0DeHE5h7+3+Pr1DYyioIU1I3HF8NJoReCuWk2fJ6xTBqo0UWFkwHT
         zxl6m188JVFiqdQ4xkQWDgQsjQthVqP62YE52nrewHK+cQ/JLHD+imz5fnoTNlHQF0Zb
         S67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017564; x=1795622364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=t+JeSLhbAjJ4UKH69xAf4pF1rbRDYbY69wlecPbzVlY=;
        b=PQGnVjTLgg4L1bkTpfGy5HQoR90IYbj26qktErfOT5bgyM6lJ9fpJhldvkorpeyP3z
         Gdm2CaozmEfz+esJlWbhrQH4Hy00JaqhNXlG1UrdrYNV+A+UggXEk/U+0QRnOnVpHo86
         /Ywf58SWmjRvrAUNaEnai0nxL4Y4daiPfSNGNXBv2wFpdy26p0Gw+K1BWpcialGeE3UT
         LuZzb3cHIv3XhxOjvsw2c1N2jFoJEQ22GHfaSKT4KCMOz9dx7jhUhwX29pyv4P/DKIiy
         5vpWnyIhfyxfMXpnYgXmqL6+cuMUrKDdMqh8b9tJJnsBuzI8vz82bjuJxrw4YB222i5k
         ai9w==
X-Gm-Message-State: APuU4Z/+ocgj2OY9pA4Ysl2g972CTKT2C8KjaehcH3KwZh0Sg9rKNLT0
	AV6g97FHGg2fq+YKfwaKCVLg09nXKz3BHJpNMh/8CapWKfXX21gMyE3A588IJxil
X-Gm-Gg: AYBFou1yfQJubVu6vErc/L8N0Awv1q0Ku3eLdvG0OnV0p2Rg1ZpP+hkQYclyhHbScNF
	8FdpSkbOzOzLABMI2BYlJl6j3h9xmS/T2qaWks0kN5zvUhxNQYPVI13dUT9yfcZ9lfcqf6s+BEG
	i/vdUqJo058VEu3ncw83m8gitw3GEJocHvjntbA8LlBVN2yU63jF5K8FXU2vCe37iMgKjYVDoVe
	qYJG/XrRo8YkmjlCDEYw6LyEGTVZ+U9SGeYlCmQ87On0MaoiHEpqTTklgYl7jzYzASIkoPFuQ9Q
	TOnqq8sVkwVDLz/4XNwN7jFRzFcIfFHstHnQS+0ZjPq+liaHBdT/aWcZxvEIs9JPxUXvk14t/3V
	9C2SkEtOVatxz+KADkykMBg7VftVXgTXfvcXjhKY5jw3IekKS5HRb9FX303MXwgdn1I9ZAWNkGY
	Ull57pr5t6S9Yzo2iLXghSnCF9KL8opxJfJxgVT1wz0xtPC+jnDhgN8rlrnARbf/ord2ryTo243
	B9UldwWMBKF7iObtoyVx+l+FhuWBT/3cVsPDRtscYmJDZvJ+lmK8U3AiHnoAP9aX1C7EoPViPwO
	Qlfot/kbQHb+dk03LnFAp3Ce6VHTqVsRg1E+O4MwSS4VeGxhSHrqgMQOGdmDvIjy2EcK7qcpt3m
	rFapLwq6UbHseh5dLt+4Bk9BO8VZtkSoMTaO8fH8hbzObgaZqRdWeRpfadNHhY+dSzCBFNHfJvK
	EfhwM=
X-Received: by 2002:a05:6122:32c7:b0:5ee:1ade:ba3c with SMTP id 71dfb90a1353d-5ee64c8ccbamr1299450e0c.18.1795017564123;
        Wed, 18 Nov 2026 07:59:24 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 10/17] Bluetooth: L2CAP: Don't use uninitialized EFS in l2cap_parse_conf_rsp()
Date: Wed, 18 Nov 2026 10:59:07 -0500
Message-ID: <20261118155914.178050-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118155914.178050-1-luiz.dentz@gmail.com>
References: <20261118155914.178050-1-luiz.dentz@gmail.com>
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

The local EFS values were copied from an on-stack struct even when the
response carried no EFS option. Track whether it was received.

Reported-by: sashiko.dev (linux-089f015e-6251-4fea-85ef-7d6761e8c457)
Fixes: 66af7aaf9edf ("Bluetooth: EFS: parse L2CAP config response")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 977b41229a7f..6780af1fd4e9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3892,6 +3892,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 	unsigned long val;
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	struct l2cap_conf_efs efs;
+	bool remote_efs = false;
 
 	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
 
@@ -3947,6 +3948,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 			if (olen != sizeof(efs))
 				break;
 			memcpy(&efs, (void *)val, olen);
+			remote_efs = true;
 			if (chan->local_stype != L2CAP_SERV_NOTRAFIC &&
 			    efs.stype != L2CAP_SERV_NOTRAFIC &&
 			    efs.stype != chan->local_stype)
@@ -3985,7 +3987,8 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 				chan->ack_win = min_t(u16, chan->ack_win,
 						      rfc.txwin_size);
 
-			if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
+			if (remote_efs &&
+			    test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
 				chan->local_msdu = le16_to_cpu(efs.msdu);
 				chan->local_sdu_itime =
 					le32_to_cpu(efs.sdu_itime);
-- 
2.56.0

