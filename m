Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126570;
	b=fKGI/N7J0yUNMelhxLcTY/zOJ+pZRkCO5Corya98vDYtltiw7OatoiP6G9gAo1zASCYJ
	 bsH5L80ugSJd8rfczH45VQ+0w6+DWJSh2F7ZRX84APWJoLRyDmiKpx7ZMriXAtFKNcAQk
	 7TvUn1nnDmRDd+jP+igMYo3RBRhZCjKBRyWp/mjyi65SYNVyXC2Y3VKvzdCQC8z2VK4IS
	 PwyJiBjHUDGM/9QMPMU0z2kzdlN8GTHBpDeotIHr/e4EhdzxWVOtKTaucrgcS5sE2c9mr
	 2mtjxltL/up8upp95BhkUpcmCH0lxBFpD8+jorIFCqpqajDD25Vst8it5eF9+w9FdSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LxZ9Q0QIUJi+J2mv0XbiwnXhtM5337DGXmJsO3wsYHg=;
	b=HYZYelZK0YsmRaIWG0FVLYqP8IcdyImjgZZhDUp1dzEhJUstZOhJVviG1bKbdX/q8kLX
	 Ce/KxLXMElCIAXO0c4J3tSvk4JTIfM3NNtIbN99gUPqfIoFYHwb+UiF0hSL/SLIEoafRQ
	 NDuVRs0A7ZOUC5GC9s3EfS0YuTFastS+lkdMfWsPclDni7QuR2y9ashG9HIYhRDB4dqZj
	 RjLyunLkYoNj1ZP/jy6k7lqlpMZnNZCDxJghY2ahWUkHz3+ciQc3OV9NAqHwt0IC7lIgK
	 bkSNrTtzN1l3yMXrBxk7T/r9+zY8ir7WhcaZhLBzB+mU8zh0vPHAdtYG+w4F8iX3oww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VELw+wvK;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63247606A32C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63247606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VELw+wvK
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7d2db6408cfso179390137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 14:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795126569; x=1795731369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LxZ9Q0QIUJi+J2mv0XbiwnXhtM5337DGXmJsO3wsYHg=;
        b=VELw+wvKLdS7JepSd4EKCs9ILU9UNKgY1y0CSZTIq+RyX5rWh5E/rzjsAmxounrzTS
         RLTRVOSCppdnXJbdnUN4FKKi7TIMPVdbo0b/rcLlE4pszMs/c+P5+X5xEx/oc1Vj8kpb
         xPB6wikYPDOeuoRxRjem8fQnD1OIIqs3OE7ST/7a7MA/3hiyJlJ7iO6aNjcYWZPkaUZM
         BmY/Kbdc+3VdHZkdp4NtEv3LDgXGLeIlIXbe5Rhxg6yAE4d6SrsqiYl9TIR5TbiYgjan
         KBiHupw6+i0l32JOxOD7lHn8qdfMqgamcaPXTUZ1hmU0Z5ZBryRut2CbHmR0M7s8q3As
         4agA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795126569; x=1795731369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LxZ9Q0QIUJi+J2mv0XbiwnXhtM5337DGXmJsO3wsYHg=;
        b=zUNSg6nGIoQbIFTIvnMWs+Hf504QshyuX/MhrUS0ss03bTau4w/uh5qwePtLw+Xc/x
         veF53p+MvoItycyRkpbvRFD9RHbsQgHX+2BIbxBgA7kpxMKVeOj9WLVgtPQakskmflAq
         VdXJtTtJ7NzrHvDW0+EjAJ5LenfJmoaOvVd6FP7RaNAr0jVkybUuGnwTgL1TQRoy6PuY
         YEa2nLFYyGWT3sQJm7zjXvjClfEMBnQHtIWFtICmZmNmm+SufYLC7t28KS9JLhXHrmBL
         lghjC+NgvLbFxpzv7CXl0Syygpriz+scPla2G392w4Vs54RICRFWP+xoP1SREFY3WVWo
         iJfg==
X-Gm-Message-State: APuU4Z+Rd95yIKDCGRtA7jzblEok42qhHN1ro66Ar4w47tVFq+UoSHEP
	F9t+C+gD/LFWv5OpbJpx28DrvSPb+q+HbTNN8Yz67CYv44u0S1xBuD62WQmRaf/T
X-Gm-Gg: AYBFou2MROx99ADK1Vp+sCN6CTPG94ctxtF4m1RPdAG0vJuIN1ARLJzws02/DysxHOK
	5lk32OLcQ0nLKWT4rtgTefLTxvm+e57UFaAAzbMJUCzpIMu3LMB3Hx5c5wZOsbVrlbuHR6yTCVC
	JYFYVWbNG2Gv92jZcPRVvC5mlt25/YYKgEr+xIIofWNTfn7RWQgSuqyNkcK2WnFeuVT/C67B7oC
	O4cqjDabeWmb84a+1jj3BgmsSae0eflyCfym6ynmvJvXGcNKSJMOxN9g4MHrUaO+zn41z4AfAGf
	cXx3AtZd8j1cDuuRAlAPVJJIehtfEP+RVpMvKbAAfwHaWgvGjTR6MXYzqRUtWP61pcL8fwLGcp8
	imow6fhUY8JLvtiqxeKIrzv8DKm2Jhok0xSK72JDanfiJMiwkuyI02apc3n3zXVrrCVjK4mMeHc
	vpvbxPeiybAD1GSjh3oL+DXM4UAAQsU+dFspftzzhVJk9lOReR0Uu129WddXHDDxMLi37OThvf8
	WFgvN6XQYzsIVfVx/UhKzjam029nzJ6RLDl9CYl1+SOqvO/Z5IlTpIy8y7SmcrQT9p1GNOdUMvZ
	JJj+SDWT0mTHxUsxPNeoKxP8FCTO9FremsCSMfaBpFTwkuSTzohARob91u41qlkIk11UE7HUV0A
	BvxfHpaNHVyn0Mpu+CqSgpNLMwIRnQO+pEL6C36NszVEnD0YWHPZmrY0nVGpVMx59PbHSfWpENb
	Un4iY=
X-Received: by 2002:a05:6102:b04:b0:7cc:2fd1:7122 with SMTP id ada2fe7eead31-7d739462ae8mr458427137.18.1795126569194;
        Thu, 19 Nov 2026 14:16:09 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm1135355137.5.2026.11.19.14.16.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 14:16:08 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: L2CAP: check security before completing a BR/EDR connection
Date: Thu, 19 Nov 2026 17:16:06 -0500
Message-ID: <20261119221607.1311815-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>

A BR/EDR L2CAP service that listens with BT_DEFER_SETUP asks the kernel
to enforce its BT_SECURITY level and only decides which peer to admit.
l2cap_security_cfm() does not honour that for a channel in BT_CONNECT2.

When the security procedure reports success, the BT_CONNECT2 branch only
verifies the encryption key size before answering the pending connection
request with L2CAP_CR_PEND (deferred setup) or L2CAP_CR_SUCCESS. A
successful status doesn't mean the channel's security level is met
though, e.g. if the peer disables encryption while the channel is
waiting for userspace to authorize it, the channel is offered to the
listener again and, once authorized, it is established over an
unencrypted link.

The non-deferred incoming path already checks
l2cap_chan_check_security() before answering, and l2cap_conn_start()
does the same for BT_CONNECT2 channels; only the l2cap_security_cfm()
path was missed. This is the BR/EDR counterpart of commit 522e9ed157e3
("Bluetooth: l2cap: Check encryption key size on incoming connection").

Also require l2cap_chan_check_security() next to
l2cap_check_enc_key_size() in the BT_CONNECT2 branch of
l2cap_security_cfm(), so the channel is only accepted or deferred once
the link meets the required security level and encryption key size, and
is otherwise denied with L2CAP_CR_SEC_BLOCK.

AI assistance was used in finding and preparing this patch.

Fixes: f66dc81f44d9 ("Bluetooth: Add support for deferring L2CAP connection setup")
Signed-off-by: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Drop BT_SK_ACCEPTED and the changes to l2cap_sock_defer(), only check
    l2cap_chan_check_security() in the BT_CONNECT2 branch of
    l2cap_security_cfm(). The early accept is handled by patch 2/2.
---
 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 943effc86740..6bf3a162f865 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -8143,7 +8143,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
 
-			if (!status && l2cap_check_enc_key_size(hcon, chan)) {
+			if (!status && l2cap_check_enc_key_size(hcon, chan) &&
+			    l2cap_chan_check_security(chan, false)) {
 				if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
-- 
2.56.0

