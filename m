Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017564;
	b=zLy0XuYMYkkoEwZBheLcIpH+k0gA9KhGB++O+qeWSbrNi8mLjSXJ4KdgkiG9rDxN8EeF
	 /c1PK75u1PiU7ufIUOe5Js8V9KFSdcymjWWlsx3NL0cJhR1cIEu4B6jcfmcQQo8/xBt7c
	 7pRyrNJsbFcUEK9s8bp8wXjxWg7yFWwxn1Kg1/TQpqVCiPuil/qK5bQK69BWw0Fr4erJU
	 TQjn7jRclBZR2b88R/eNGPj4hzLeoEorhTYtxhSRiRqH7p4AkFRl2aTEWnF9AnkfgX3AG
	 qjc6og6ycoCwASun31szolCZlod7xN+rr3NTrd4oqg7K6UlMyQjAel/iq6ISd5cMiyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7dpmPpZSz2RHH8e6hO3C7W4vF7/inKqUq/GXpVelWQY=;
	b=pTU1eEAlNLHGdPEIN1hy/MOyQwUa9gna3lEM/eUKKegfUxQLVBNzEWrmbzaOCNOqKjEw
	 NOsfElJwDEREZKBbFTCVgMFXm+5O3xBjN/83nVl6wwcVI7rLbPjT/tnOzjV3ntF6+9Hho
	 7Ie0NUadP4WVQsknXJOaTbG/cS3ZtR7p2ykM754rFtyKNvIt4LvvqlcXjJOMUjfaPuYNY
	 hW1/6e0wQ9RfZyfsbHX12E4ZzK8NcMO2mnXrIGkqAPykUidWfZMkdx9/NW2QeZ9sTwLIe
	 9ZVzOTMKNg7hr5MXJ66oPjk9B5H/E0QtCxV8zaVQKHf20KScywhPI1DOrUZuKdfMECQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cdm3JQrW;
	arc=none smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76881606A325
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76881606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cdm3JQrW
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5ec6f271883so707380e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017563; x=1795622363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7dpmPpZSz2RHH8e6hO3C7W4vF7/inKqUq/GXpVelWQY=;
        b=cdm3JQrWCF66ttQW9nFe2l+K3kPAqTb6zVJAxk7lV7zQ6ESBgKGhI7JHZvrfweHGKc
         kreCUeLFpnfNJGAUVQ+4c5NoJfQw8Kbd2xxLW1C2QYFfQlFBcNMNurYpYLuu7Y7PbuKA
         X0dIOX1ux3YbsvhE7N3DXUZ8USg5rQoRSWfA5AKW5E5Oklj61phL3vEAEF/bPGZNf3gR
         pT+ZIElTrCcuGJaxhfpBozPpqH4hZ6ACqO4yzAca09is/Iu1VZLM64phOfPi4Ml/60Tz
         j/kqALZM4L5wFDDm1fqzQmHmarNMhwaKlZkWB1a3y0OsYj8+SYPjc3BA2gQVuTnuhczd
         j5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017563; x=1795622363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7dpmPpZSz2RHH8e6hO3C7W4vF7/inKqUq/GXpVelWQY=;
        b=cqGpzo/sOlTKOiwVlR5q/kI3XroQd9dGZhbOk45cTZyf/I4kkxrm83nwL+ZLqlIvVG
         TGrASFAvUkcuh9BDShXCuKIOr65UOdzO6Sv6dv9T/fDL/Txa6c88GOEH2gPqWGE4QIZG
         SsIiDl5lsJlfmfXE5VtiUdRFvByUa3Far56C2uXkbJi+YVuizFOwhPfJkxUHAwaKeo+R
         richnsSZcqDr1QAgV5wGmAiwhp2CxYri+2SXjCldFYzsVMj0D/4q62/lY9bTb/NzZxAL
         9Qq6GnmP5spE2tJaKhyTA4fIhjSsFWUyroLM78vszFUfqcqsHyVSTgbnUksQU7gyLZip
         pm+g==
X-Gm-Message-State: APuU4Z8yxhRff7InbmwFRludHxjlcoJGqBjSUa6PbtE4hiTmjVYRtx7A
	MkTVu8+uE4qx2mU7sFGYj5toUXr9Oc0DXexUhedVG54yGFrqwf2hiuBJsAi5x4vM
X-Gm-Gg: AYBFou2e2qCHgvhhZZ0nvTv5o8ImHyZrNSldgiKUlg3i62TZZMJ16YRTKhrPZ4v5d8G
	wypDOqn3R4unWPpH3Zz2n/1Z7D81U9xdpnZPHPpjRzdxap860Rv0h9grcZa/LR8tFSaKP3Pf5uw
	yALaGJkIjx32AszddTKm8yE6y5wHi6qRoGyYB9RsLxLOj1AB7DX6hH2eKiE54RdrR/yv9qAs7ze
	/QvQOYh5HSHWjpDv9yHrboZD9AdlTRHJftaF7hLixCPMSghvHurAQqhnHe5OoXyealYafaJwA6N
	b39hzk0Za11NFqs0KG0hOB9weOletagXH1654q53QS7dfo95RDRfDcsH6HmHeLE1pt9Hy9Ry9B0
	ItSk8Q6HJg3Q7gNIIt+szlv6QwEooEWTVLH1mJ5hK0CD7IpMudHG1jLkf2tWA6d8dDcJELBSpCO
	mfXu+0vaz7rlQqvLjHJPlT7kMy42Wmm+tn7qF9H3P/7XksIyg7BEKjPzDu55lIlcLZyadkQFKYb
	wooLRAnYql89o1qnbOwlKkLk7/jIWhVb90AQiu8qO9EeE30yoGHrcEJz3B9Hpplc2uu6Gbe0nvg
	h/NodwLa88ScGJlmeq7s54cLZT+gvLey8tcr8SiT5v8cHd5QopWz+CZxJUHqR0d8bmRzggp9xgD
	7+EehbypNwnZu6Xa7ajt+h/mdep0g8wFefzNL0HZ+737KjKPYF1kT/q5KyrkjRVdaFMZYjk3TrO
	o2Kdw=
X-Received: by 2002:a05:6122:d20:b0:5e6:82ca:c551 with SMTP id 71dfb90a1353d-5ee647516abmr1574879e0c.22.1795017563474;
        Wed, 18 Nov 2026 07:59:23 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 09/17] Bluetooth: mgmt: Reject zero multi advertising rotation duration
Date: Wed, 18 Nov 2026 10:59:06 -0500
Message-ID: <20261118155914.178050-10-luiz.dentz@gmail.com>
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

A zero def_multi_adv_rotation_duration makes
hci_schedule_adv_instance_sync() requeue itself with no delay, spinning
the request workqueue. Reject it in Set Default System Configuration.

Reported-by: sashiko.dev (linux-24ecb695-0c5c-408a-a016-a980c3115e95)
Fixes: 17896406ff35 ("Bluetooth: implement read/set default system parameters mgmt")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt_config.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index 7a2cf893a515..51da6a7ac0de 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -281,6 +281,12 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		 * (32 bits), the one of the GFSK PHYs.
 		 */
 		switch (type) {
+		case 0x000c:
+			/* A zero rotation duration would make the advertising
+			 * instance scheduler requeue itself with no delay.
+			 */
+			invalid = !TLV_GET_LE16(buffer);
+			break;
 		case 0x0021:
 			invalid = TLV_GET_U8(buffer) != 0x01 &&
 				  TLV_GET_U8(buffer) != 0x02;
-- 
2.56.0

