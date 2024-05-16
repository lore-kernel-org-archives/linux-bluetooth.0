Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437B014B978
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871324; cv=none; b=M0yN2AJeVYNC53bOiwAk+AReLgGYOBML5w5s7/FBxZGLqotjkCCqN9/IKxFuoP+pYnnSTOil/cf48ei6vl0vkIpKb5w7y1jbPWiG29KSy+tzHaHG7RzmDI3OzPqyOlGArP//3o5AkLPOI0DTzpM4MaU4eagRc4UP/q4BW6rL3JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871324; c=relaxed/simple;
	bh=DdkB3V8ZGog6weE5ByFmwUWEnknZ/OFQfZ7iKFzZSew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7MvRnhxQwqx8ZvSpZEso3jjr2whdU2jB4nNp8mFMDLciZC1OpU7LZ1Mg/aJeSngel6kYIHxlSJUaasKz9eZtLAcz/5qccqE8wF6KWh71JanHTtZOxIC72ZP/vvMSJnKKXgWiL0ondZ2q81IZCTe2mKiFlTzlb8tJqb72Ip83Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=KWBvDB+U; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="KWBvDB+U"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5210684cee6so1231054e87.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715871321; x=1716476121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNMpiruIVl6YRQIpC270h59+7DyIgPoYQQZoXWQS0T4=;
        b=KWBvDB+Uned1vDetI+Lag+8Q5dbSqh2pUo3snkYDjZse/GzjISAKzLqrGsIr+juUS+
         NA1KIWUhFpmh+aZ4CWHYauiplINo6WPDDkXkuEY4EA6UlEN3kHL3CLyvVHtm3lkvzvPu
         EeqZPYfdwhomg5cq7/mLUi7j81FOsTJptqZ6QsafEPHdny1cHddyQGQ6NXKGY6b7mAcK
         qA9K/LWK0J5nL2Kr84BNMaa3crCVr2mxZ7ekklYm5ub6vHq2I8tVqUDRtJqqyNT3fHr+
         MEjrjPRx9fHKwyXYUdIdyhGZsaPvqnG6kA3M8aQR0jJVeqKVmL751+XGxQ5H7m/94ONG
         5RtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715871321; x=1716476121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNMpiruIVl6YRQIpC270h59+7DyIgPoYQQZoXWQS0T4=;
        b=fiLx6IvK64CClrkA+btpWAo1z2xu8JR39EfsTwD81vG2jTkFDhEBoG3iA4V+wSiIW7
         igsxuRnKOe92EEVRhIOIcWD2pGu2XoA1d18pPsUFLxF+H8atJsYC/JwasJvv2PUPFPby
         rqs2tYcSylmhUNk32p20TxDCSyrxhx14qS08UHeREVSEXx3G12PoCgwmsbU1aVht+0Dc
         xH6Vr2KIHLYDXqPqM9tdMPdohCoDc3lbnNGDUcB2CZt4FI/7YFkBOj5E5T4dy9rHbnQq
         7wZaDNou0rXE7K+QT8v/yN02Ek4caF3Ak2zY0IdFox1JC6z9n2wONqaKaZq4yPixurg4
         LQew==
X-Gm-Message-State: AOJu0YwomLWxXcIp2E21imZJioHtMZV511r0dTYsL+6/176Je65Teieg
	REW3TCyGMSiOgpQXZ5HXbSYvWPnA9IPCHKubjw1KI0e6lS0AaiKgCziHioc4/9Fkhxnpx3tVfBL
	hhcA=
X-Google-Smtp-Source: AGHT+IHRZ2AIfK/C78LepHKKgnJfJgqCG4LX9B9x1KbIBSQbXzp8kT6/+cVG0s5e2xpQB6co1JZbvQ==
X-Received: by 2002:a05:6512:a8a:b0:516:d219:3779 with SMTP id 2adb3069b0e04-5220ff73861mr13847691e87.58.1715871321350;
        Thu, 16 May 2024 07:55:21 -0700 (PDT)
Received: from andromeda.lan ([74.15.47.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574b6f6c53asm7484372a12.16.2024.05.16.07.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 07:55:21 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v4 4/5] gitignore: Add compile_commands.json
Date: Thu, 16 May 2024 10:55:00 -0400
Message-ID: <20240516145501.134118-5-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516145501.134118-1-arun@asymptotic.io>
References: <20240516145501.134118-1-arun@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handy file that can be generated with bear, and allows clang-based LSP.
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 9c2ac236e..6a6422379 100644
--- a/.gitignore
+++ b/.gitignore
@@ -183,6 +183,7 @@ android/test-ipc
 android/test-*.log
 android/test-*.trs
 
+compile_commands.json
 cscope.in.out
 cscope.out
 cscope.po.out
-- 
2.45.0

