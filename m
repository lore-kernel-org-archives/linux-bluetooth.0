Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9069B346784
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 03:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784777301; cv=none; b=SqjFKeWmR/AGVqBr1KLctOajfgbQaNitO1NWHOGm0fz/6/A20IxETTmXEYfV7/Qanq6rDMu9WkXEEbrLL7V8prNqTPlhaMpjltRDWsGDogIAtyDiYgrleXvwFD7m/W1gU7o5kjLczfs23j7ptX8Ba+rJveUplh3HkLDbGzJoCz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784777301; c=relaxed/simple;
	bh=r8iYdQWHa9VJS775/4n6zn3PGSHvLkZImtets05yhb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2v27LVwZkUfE60wz7vKdv9Kuek6QDhGW6THqEAqIhGulLR2gvQUq1TL+sRn4GBS/0leVhidQZmwD1YMWJNVD/HXnISOrZdxm6tuFoRi7iknTC5PgqpuHAchOgaqlgFebeCTQ3EDnJTR+ZWXJLlMDkJzNiQwDTay7cVO9l2uJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qF3cM83L; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qF3cM83L"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf41bab353so2418935ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 20:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784777296; x=1785382096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t/Igs/v4fkYLbH3ZnRzuIP4kc2pMGS9giRIUagxHqkY=;
        b=qF3cM83L8CqP/yOI7qRqfqmo6O0zVq2lGzy7tOur1sARKXfJ8yMq7pjepgir8OpGvR
         YvPDg+kdLnOAcFK+LpJ1woxDcbRB2jNdCTEs6N0mfJYf4coPIfqOo1GJbAYqQ+08i45V
         dvuXohs7IxLXgkrnhEvwAuieUc3yAf4qECUuXgBDNXkiZ2YbAawWCfbk9aTXLMTbMHGr
         zDrL092p0SI4UdJONd8sXaB38XBEcNuYG6QGfC9aFpydXmC1hFt/Ec521C0Z1HWSWAnK
         k/KkpXBn2VPDUfaxymXJmWP4IgTAUumbVLsAaOH5Y6IV6kLhB13BQtfZSoETVkaGH6/o
         UR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784777296; x=1785382096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t/Igs/v4fkYLbH3ZnRzuIP4kc2pMGS9giRIUagxHqkY=;
        b=rnqeQxL09nIDczYtWESULDH/JZ50/K42WucYc4ulBz67aMF9+n2xlYfm37rVm3i4yb
         tDuUgMMnQm2NGHLXdWVEaOZSWWZEpwV6kHIpW38MIweZNot9bpNwZN34S6IGt65b6Ylm
         EYOjmWTH9tut+k1Vkg1e9PFnyvjI+FxE4YkAD+zLeyr0TR3AL6f8tHRgYeP1qTIjfrVO
         lEgh08pooTrP7Cv7puEcdOXcysg4VsZqk0a3ypssaJ0Zyfj8sWMeRPRYSf5VPZuR5wid
         BWSIbB4hanenXYMWkmwlVI6pIUtbh2qE0SOdnNZ5HfNG3WswYHLnQ/ajAfsWZZHYSK2F
         11+Q==
X-Forwarded-Encrypted: i=1; AHgh+RoCs+YWMWSboQUmCY37GagVAynrJZvOr0XZHPt8JZM0j4zllW5fedu8nwS2wYWSwl3EoXfMenzGIeKkQ7yKXjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4BaL/gSGTe4WG6YZ2tauU7K/y7/PwzUW0GckDR4XPc2cF1vo/
	gKjZXNBFahhzyIdTRrqWBqfpdIe+Uh5VomrEhwYdg8YaD5gGY9MrRbEJ
X-Gm-Gg: AR+sD11eXrcgSZUtLCadRz7d3vaqt8RhXVegRY0iWw8VvYKLKS8XKWQN+Bx+lBXEZnL
	cEYG04yQAZwNXCxfIH78/CTqGvSbjRpNw/j/6WYScOUMLiC7wLu73cZtQd8FpZF1TdCRc4epUai
	4FEYhOinG9QFXKtcTmGiX3MBMcRZBFoyigKlXjkQ89cPxxJHnrixkPOIMVygr1oMFFG6MpHZoAI
	hllOk4AM8UwfpYwSqCgKXRvT2bthCBHkdjZjnZ1UiGnqO7XDwtSGf/jJIgkixbzP3K3pQxCzPEN
	kFly1bCb/qD05YjZfpeb9Pp6n/9H+08WAS8H7TPmpnaW1Dds07Hh5iywrv+e0YkFKLUSI2QIUxS
	yKrGHVrsyFWvaTT+tHAGAuhMci79hd2JcDntE9+xTB4Jcznga4s8T1nMgsYnoUksBr7mUqZ/doq
	qstXGaK+YOqV9jnIs6apZK4r/S6HhWkEIgMn+Ciu92Jr35tWXKsHNA
X-Received: by 2002:a17:903:3c70:b0:2cc:fe03:dc75 with SMTP id d9443c01a7336-2cfa748cd86mr17871995ad.27.1784777295936;
        Wed, 22 Jul 2026 20:28:15 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd7157sm24538485ad.18.2026.07.22.20.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:28:15 -0700 (PDT)
From: Sangho Lee <kudo3228@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Cc: jikos@kernel.org,
	alan@signal11.us,
	padovan@profusion.mobi,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kudo3228@gmail.com
Subject: [PATCH 2/2] Bluetooth: HIDP: validate numbered report payloads
Date: Thu, 23 Jul 2026 12:28:07 +0900
Message-ID: <20260723032807.1616487-3-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723032807.1616487-1-kudo3228@gmail.com>
References: <20260723032807.1616487-1-kudo3228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hidp_get_raw_report() waits for a numbered report,
hidp_process_data() compares the expected report number with skb->data[0].
A connected HIDP peer can reply with only a DATA transaction header,
leaving the skb empty after the header is removed.

KMSAN reports an uninitialized-value use in hidp_session_run(), with the
value originating in __alloc_skb() through vhci_write(). The transaction
header checks remove the empty-frame reports, but this report remains until
the payload check is added.

The comparison can also consume a peer-controlled byte beyond the declared
L2CAP PDU. A DATA | FEATURE response followed by an extra 0x01 byte made
the current code accept that byte as report ID 1 and complete
HIDIOCGFEATURE with a zero-byte result. With this change the malformed
response is rejected with -EIO, while a subsequent valid response still
succeeds.

Require a payload byte before comparing a numbered report ID. Unnumbered
reports continue to accept an empty payload.

Fixes: 0ff1731a1ae5 ("HID: bt: Add support for hidraw HIDIOCGFEATURE and HIDIOCSFEATURE")
Cc: stable@vger.kernel.org
Signed-off-by: Sangho Lee <kudo3228@gmail.com>
---
 net/bluetooth/hidp/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 194208d03d18..f5bdf9f1ca63 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -543,9 +543,10 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
 	}
 
 	if (test_bit(HIDP_WAITING_FOR_RETURN, &session->flags) &&
-				param == session->waiting_report_type) {
+	    param == session->waiting_report_type) {
 		if (session->waiting_report_number < 0 ||
-		    session->waiting_report_number == skb->data[0]) {
+		    (skb->len &&
+		     session->waiting_report_number == skb->data[0])) {
 			/* hidp_get_raw_report() is waiting on this report. */
 			session->report_return = skb;
 			done_with_skb = 0;
-- 
2.43.0

