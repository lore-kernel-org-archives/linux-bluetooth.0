Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B103AE190
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 20:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616948; cv=none; b=TlMJwKE//mXnDCBTg0LzTtvV61prxdbZKMZACtqRB396ETKXECA1rqsCT99kewk+1s8YWlSwhgl9TZHnX/+eL+La2Gs8ZrUEe2nrCko5tAbarQLMu3Kme/DY/O1/Jlz+TqjvUL/Z0b+imOth1EMMpJ0MIZZ+NfaJIqBxIKmeBI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616948; c=relaxed/simple;
	bh=WNm8KtkMynSXJn8zMi3evEVkOyq9VdKE4QPBfYRIxPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lH0GPWSnAYRw+maRNy7h/SMmr/cWuDQpU8+jgVB++6dyJoAR27ZzyPXgbYPbqpGWqqF0EL6qB11yePhwZzuf64sINFTpU/Pqnh/uYYzlZ8Ua+A9enjuNezJ7PkbTKDeVoFvJZ+CATBrO2nNgf1gOu11Gmp7NLtEJgmj4dQmEkHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZmC/t8d; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZmC/t8d"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso55e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 13:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778616946; x=1779221746; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CIupbo51IGhN60EFnqfQU2Ebmv8B4YfVP5HZZ1GR0CI=;
        b=GZmC/t8dWLjNF6GyGgg2zeoCrSC53OGVbKi06XXkxtjRG/AeYkKJmo3CNtHArcrSfO
         p6urN9homQOJBjJQ/KI5x3Rdfe0XydaO64ldZH3C3MB4WJeVqjqmnVZtr3T3fc1Ns1Oi
         LLwjPtfCnPeel0tmiuUEGpAlT9NSJjLWH26tk3AUy73gPTMpOmDmPujD5th4yVrHtjit
         Lvnekz2awCs3il+RgUQtnkowyiVda1LCO67MINb/mWNBFK0+y3PnwkxNJcvSCpaiX4rc
         6fEn6t/IG0m/Wza0Lj6hJvBw23L5pUcH0fhSbYj7DjEyq3IEyfepsVEwDkAVtPQSZ7MY
         dGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616946; x=1779221746;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIupbo51IGhN60EFnqfQU2Ebmv8B4YfVP5HZZ1GR0CI=;
        b=R2EkWpLIst0QN22nUMIzYONaRhUUOB9tSMo68JBuRHOMcBW9JovHMa8dfv+Mla+69d
         7hmz1S2NCza+Cc3/qBbGg7EtZ5b1BzabBZUeZezCCug9T4Xf9myNCzOSamrSNuTc5PTM
         ZipkB9GH/LtG6bVG/ks8CyprR/5WXw4Yr5QOCwW6IVg8+LEpzJtlEVhI0gJ8h3ksmFN4
         VfqI12Ifj5y2ewUQb3h5/pHG21htAaV8Vny6Ey8XjRCNgY8g+RMYijqJlJsm75S/Q4pl
         h99+hiyQsRad/RJlwWf/gspZ6enmpBHRmNeIzvUORPnF6PmN6pH5McF+J5mXxouHgq/U
         oMFA==
X-Gm-Message-State: AOJu0Yx6KUURevMoIiQSy8loR8PbRsuVEhOwKK3EDTVOXVTrlwoCP+Jd
	Vq6g4jmULDF2QycZ1/LaEjjJIiiq5YNDv7R7LGx6dIobQmnuDAPk4nxUMtVGPgq4LQ==
X-Gm-Gg: Acq92OH+GYv4XvFLZkswhN+PKb1q/LXjH7Nh0RpQTmG1jCkQ0QhpHJtOtTEECAJ/qkM
	g42oH0XpFab5VhHdDo5Oz/j5BiYGdIXX/5oqql/xQFgxziZP3/8emLGkG0hv6ijMsiqDoo/tarE
	lFDxmZNEYAuiU8fbmLYpauU8ZjMdug62xjDfpfgfriJoRukIKv1078O8HBmu9B8xsMDi9nazdu2
	dYGMsL7RPpWZB5nse9RMeU8NqYWnNyjp7PPPaNOd0lZxl1gMnSPLnrWdMEPVDg6vkjSUQuQvmud
	iCIyN6e6Xpq+x9oxCpyDjsvzrxYmz5aOVNxe7EmlYiYTw8ZGTOQ5cML6gdDKuhwhStsp1nlTaHx
	wkGoGBUwc2LdIVmOq1bQ2btyLWstpDDCekZx5GcHEcMHVY4fG8A8uC9eFUj59QG1v/TuURo3EKY
	GG77ErTPwQMAQrMqVGfaBXSgp1or6atBeLhnTuIOhJ93t/8AKvuJMZ8Wul3Ty//w==
X-Received: by 2002:a05:600c:8a16:10b0:48a:5618:b4d4 with SMTP id 5b1f17b1804b1-48fcacd0d81mr18565e9.1.1778616945526;
        Tue, 12 May 2026 13:15:45 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:118e:a0ac:896b:9240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ba2aaec3asm5188055f8f.15.2026.05.12.13.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:15:45 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 12 May 2026 22:15:39 +0200
Subject: [PATCH] Bluetooth: bnep: Fix UAF read of dev->name
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-bnep-add-uaf-v1-1-f62ff8f61d50@google.com>
X-B4-Tracking: v=1; b=H4sIAGqKA2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0Mj3aS81ALdxJQU3dLENN00c2OD5MTUZOMkQ2MloJaCotS0zAqwcdG
 xtbUA1+dPl14AAAA=
X-Change-ID: 20260512-bnep-add-uaf-f730caec3b13
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778616941; l=1405;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=WNm8KtkMynSXJn8zMi3evEVkOyq9VdKE4QPBfYRIxPk=;
 b=Jk+CHIi3IXpkUb4fRpkzyOJnaHT7yYuW9WvfKSNUKNat/oU/e1mPsxtYD1CVoNJuGFauAaVW0
 f8489CrDfHvBKBN9Jsm+t63TuTAoKdbnarT7plEbvuKkViiSu/k559/
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

bnep_add_connection() needs to keep holding the bnep_session_sem while
reading dev->name (just like bnep_get_connlist() does); otherwise the
bnep_session() thread can concurrently free the net_device, which can for
example be triggered by a concurrent bnep_del_connection().

(This UAF is fairly uninteresting from a security perspective;
calling bnep_add_connection() requires passing a capable(CAP_NET_ADMIN)
check. It also requires completely tearing down a netdev during a fairly
tight race window.)

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jann Horn <jannh@google.com>
---
I have tested that this bug can lead to UAF by using KASAN and
introducing an artificial delay with mdelay().
---
 net/bluetooth/bnep/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 853c8d7644b5..0de5df690bd0 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -645,8 +645,8 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 		goto failed;
 	}
 
-	up_write(&bnep_session_sem);
 	strcpy(req->device, dev->name);
+	up_write(&bnep_session_sem);
 	return 0;
 
 failed:

---
base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524
change-id: 20260512-bnep-add-uaf-f730caec3b13

--  
Jann Horn <jannh@google.com>

