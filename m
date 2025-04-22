Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF077197A68
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 05:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745300769; cv=none; b=LjBJBJrokZU8Z1hPdEXrP5/eiap1V2C/Gp4/7nrh9Mc2AtYmbzZtYUKQSks1IX+Rioc18njhCG209whRpqFTF6iz1d4zREpFi3GbBlL8t5IIoh8Qju/Okf1PBHX2NKBGomU4YcoctzPwuVmp+9uWnUibkvxfMYZKN2wCll6pdnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745300769; c=relaxed/simple;
	bh=4NrqRU0i++WPbo09QLmh/bh083riAvDs7+M0ztJAFmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEa1BMYyVa2x1qVg5UoQAQwoB8Gts7LXuB35gjc7aw1ygyfSjYGLd6q6MW0JwSaR/0cPMhMljL2xq27YKriBXU+Qxh/jCDwIbZlvuUZCAskt0MvhvGyYTrjICFSXGny5eP9dzmDPdaQ0zwurvZj1edQcOyx4lNDs7vP1XIK3vwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=GvYxci7w; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="GvYxci7w"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736b350a22cso3771243b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 22:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1745300767; x=1745905567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElmSjXBN3UO3vri2yvuO0hJf31Tc2kUar9IaXcWvQYY=;
        b=GvYxci7wGr+ghuQ4wD7dkWAoeh2WpbD824We3Mr8YNaNpHRPQsCdvsaXsUEB0TiGXh
         B5DdT6daOOJFJlTF7FTH3WYSnQThRFZWM/yX6Lb+6ZZKyDHoLRJwZk6PwHyVPpQYAP1u
         CObJ40gdAzgPs3w07/gn3Z/kq0+0s7D67k8mIK1TnjDxMnoDXESEsma7TWK02vsln7jm
         w7I9X2WshtQ/d69eQpenyw+TDjLctL96U65fObgWyojV+NcLw0Dx51IRKM92Km0GBk9s
         CfB8lpDS5l8IjvntOUfAsaPkRHAipq6cBi4tEHcKuGDN7lYNip0zVydFvNeuRimjtxz0
         wMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745300767; x=1745905567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElmSjXBN3UO3vri2yvuO0hJf31Tc2kUar9IaXcWvQYY=;
        b=t0uBz7S37UAeNf7pz2+f2zZ8VIL7DrSqrXc0viXL/zDbavTHoPHJAytvISZFbgNeLJ
         dFAmR2VSji1aZOVuVc0oMkj9STz0zOP+vwDrUkitqdqt62U9I0jy79Fwj+su2Q4nH/qZ
         6FzHuLtdrCVrjtJfI3PTFLfrrk52swgIYL0gRuyyj0eqSip26mLBX1YBLaojUyI8SYjN
         18+TltwTebu36zEJXTpPnc1APPDLiZ3b/1J0Vx0va27OYmSNwuP1uIouK6/47/xAiGx8
         PpZwixc4FYE2D/vX2aXrEnPPkTfscr6UnKCO0KF1ELxm3VGsODgZVQtvm04pYI5v4+oT
         6hyA==
X-Gm-Message-State: AOJu0YwAL4N4j8/FvbNhlryJFNL7EMVPlJVWFAXvBVYjiF8m1CVADu/X
	DoLs8sgh2EfQatHlOLNAkWnJDSv8DZQnJSo5QA4Cy9Bp2u52sZ44SdmzXCkZy3/KUABQMbILweX
	P
X-Gm-Gg: ASbGncsxM6HrdKJTFC+XiAuM/om2zvbfTacGiKPboBTbxhnCAb7UOyQ8mUhCba1Yygy
	R37vkmS+iE5nqsPqy9vSmDVk4qTrzDZvQ6zWyVN7TT60S3PesMp3YAbOjo4PbK+wwTBF+iJuQtL
	qAFlnDck01Os3r6d+EGRVMJmOS8zg7ZgFzE08SI0Hm601MMg8RD1qRF/R5bR8gCNp7JT7f5ra0L
	SZD5rpxmXJLTEkOVKUm7AsYxxytLGTCxvemd6g4Zy31LolXPTeZk2aNm5s7of1LrbPeKTbHgzLe
	bX9tXrUf4GAeRKV/O2xRf/hWuFoKzFRtC41n3RV+jol+Tg==
X-Google-Smtp-Source: AGHT+IGZMcPn/qr/BncXPsKlKHqOMkcT4ElaT4jRmEc5kLtQalqyZXgTJ3DBze4eixTt29i6cyjoMw==
X-Received: by 2002:a05:6a00:2e84:b0:730:927c:d451 with SMTP id d2e1a72fcca58-73dc15cf6dbmr18406039b3a.20.1745300766723;
        Mon, 21 Apr 2025 22:46:06 -0700 (PDT)
Received: from localhost ([2401:4900:1cba:4d5f:668:74ff:fe9f:7991])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbfaad0f8sm7893121b3a.138.2025.04.21.22.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 22:46:06 -0700 (PDT)
From: Sanchayan Maity <sanchayan@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [PATCH BlueZ 1/2] profiles/audio: asha: Reset state on disconnect
Date: Tue, 22 Apr 2025 11:15:46 +0530
Message-ID: <20250422054547.132400-2-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422054547.132400-1-sanchayan@asymptotic.io>
References: <20250422054547.132400-1-sanchayan@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the issue of an ASHA device failing to re-connect after
getting disconnected since `asha->state` was not set to STOPPED on
a disconnect.
---
 profiles/audio/asha.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
index 10115b92d..df283dd22 100644
--- a/profiles/audio/asha.c
+++ b/profiles/audio/asha.c
@@ -478,20 +478,21 @@ static int asha_source_disconnect(struct btd_service *service)
 	DBG("Disconnecting ASHA on %s", addr);
 
 	if (!asha_dev) {
 		/* Can this actually happen? */
 		DBG("Not handlihng ASHA profile");
 		return -1;
 	}
 
 	asha_source_endpoint_unregister(asha_dev);
 	bt_asha_reset(asha_dev->asha);
+	bt_asha_state_reset(asha_dev->asha);
 
 	btd_service_disconnecting_complete(service, 0);
 
 	return 0;
 }
 
 static struct btd_profile asha_source_profile = {
 	.name		= "asha-source",
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
 	.remote_uuid	= ASHA_PROFILE_UUID,
-- 
2.49.0

