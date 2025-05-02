Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB425D1E2
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202369; cv=none; b=f8kcell9HY5oibtG3wgb2Tn4RZf+O7gVJK1phYYLjk7A10i14KTayC1rFwvb6GGnu4leQOqemOGeX7CpS8sihoZQALLwSZfFTztkC2uWTXYkn8NY2z+RBgZCMVcpjYEJvNZwb3FK3Oi4drYMCaU2pVl/o/Z3RGb06rVhEVAhUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202369; c=relaxed/simple;
	bh=4rkXhusN2e21cXQXMPHURZL0dI9fwIzlKttN7n5OTEo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Xl1o8R+LmL5Rbv5FhpUKmgo6tG+WYddWvlIl54CYI639z9ySqkdU3vzc5PscLEI8Kzu1QnGYUNNeq3sroEEhXRL9LZjQ+L6350rnGrkcDhDGHKZaYrK6VPXjeHkcReanD/myjqFkcsCK9HnqaCPkx+x3o/5t0QW4lQf8Nf0Ds4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awt1pAG3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awt1pAG3"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4772f48f516so37625301cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 May 2025 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746202366; x=1746807166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSl5tJ+EpvPndRm1ooKXyHKcBSIQMvZH4WS2IT897a4=;
        b=awt1pAG3Ld+2wliWVIRiaWJY47szxjRiWv4VVeDhTLILeMwpX1q3QvbfyfWES8mPuZ
         gZc1kGnOxJRH1FFDYlJReZiX8FTc8SpR69XZzXt22I56u/eGKrOSsddxLctu1Ja0aim+
         MawVtrFNqPHCGEj+0gPTgBY2kC3CUQ48ZMZKgSp3ZcKr43XO/NwCBHVQTVG/K8R9TWpx
         zdYN79CPh1oZfBfTRasYM+nYmmoEdS9fvoZZzjcQ3y7xqB9sMpSzC9GMJrofbjj1AFFn
         b8IScWjlAR0Sv+GcQUmO7f87brMRxKy75LTocC6fdoE5rCmvOpR9G2Cmw50ONb6ypK+B
         1GHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202366; x=1746807166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSl5tJ+EpvPndRm1ooKXyHKcBSIQMvZH4WS2IT897a4=;
        b=VP2eTLc06bFGhiBIm+t5XLx5RCygDJiePN2g77kVnrjtwCpN1P1Qmaxrr7Mj0jVrFK
         NpF4SHR9ld+ijStfzTefEKmuqPOmS4idfswkS5bV+CgPUoAb9FotlfkMylrJxptxRFfg
         oeQ9ot4fA5uRNcYTZ7y/SO0eTb5AO/pjfer4nKfumZYS143t12GFvmXUciiA/L4+KucW
         gYmAAppLgS4omF0/MDbId7Cczp85Ey5Puq0kxsDDNHcMgM8OcmG2XT1y8hoe0t+8JgmR
         7Pr1aqX4urPnQSUZs/PDET2lK59YYbajnTHu1mEKfuQK2t8DlHnEGlnSwlLagsVKOTbT
         uxOQ==
X-Gm-Message-State: AOJu0Yw5k+M7y3dKSEkZ0diK3cuiBO7Y+WVdWaynn8mEG9SCdX05uj+y
	zUssox8Ov8xM0KqnMg0yfhNUhE5eLtOFaynx2nR/GdwLJxe42RaYgKnxdjew+Fc=
X-Gm-Gg: ASbGnctLX/X/ZpSFpbO3AMM12FU5Ly1VWwodeFt/L+Guok/gKrsAeOuezK4ArPIJkEN
	7Uv9ryNuPUFtsyr748AKg7G+Y7Jx3AAHKU2jwUAWnF6k39bAN0E6WWMW9E2eQ+ljg6EwbifvnbL
	t/01oZSJiAu8Iq9EJxjojXX4sp+z0EAZp8IWRxbkUf3FTddR5xCyKujg/SlRMuAlzFLo8BIZa2N
	tNN6KO+7Nsqn8ouk0RPcYt70sLsRQ+X1PR/0+j9v9LSDXa3BjX99Bbcwmv2tsDVSFX0d5kuxKhr
	VICN2oU7JT6E4QixJBx6WWH/vtXu845EDzx1CeHrEEP9bcfAQ4kRdIA8ydnj9iib5aRt6KMqfs7
	ZXiZOEyuo0q59DxsHSY04
X-Google-Smtp-Source: AGHT+IEjXxQrZDctKNtqIGAiopCVosBHEa4aNTVQbKCWQIb41wChYftrTI/pdSSLI7ZNt5ySx2Fr+A==
X-Received: by 2002:a05:620a:2697:b0:7c3:ca29:c87e with SMTP id af79cd13be357-7cacea24688mr998963885a.21.1746202366476;
        Fri, 02 May 2025 09:12:46 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8780afe9e73sm327737241.3.2025.05.02.09.12.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:12:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] mainloop: Only connect to NOTIFY_SOCKET if STATUS=Starting up
Date: Fri,  2 May 2025 12:12:43 -0400
Message-ID: <20250502161243.2745492-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the handling of NOYIFY_SOCKET conditional to only when
application attempts to set STATUS=Starting up which means it is
intentionally requiring it.

Fixes: https://github.com/bluez/bluez/issues/996
---
 src/shared/mainloop-glib.c   |  1 -
 src/shared/mainloop-notify.c | 11 +++++++++--
 src/shared/mainloop.c        |  2 --
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/src/shared/mainloop-glib.c b/src/shared/mainloop-glib.c
index 7d4b057bf6ec..042119baf1ad 100644
--- a/src/shared/mainloop-glib.c
+++ b/src/shared/mainloop-glib.c
@@ -33,7 +33,6 @@ static int exit_status;
 void mainloop_init(void)
 {
 	main_loop = g_main_loop_new(NULL, FALSE);
-	mainloop_notify_init();
 }
 
 void mainloop_quit(void)
diff --git a/src/shared/mainloop-notify.c b/src/shared/mainloop-notify.c
index 11989512e013..5100a4e89285 100644
--- a/src/shared/mainloop-notify.c
+++ b/src/shared/mainloop-notify.c
@@ -111,8 +111,15 @@ int mainloop_sd_notify(const char *state)
 {
 	int err;
 
-	if (notify_fd <= 0)
-		return -ENOTCONN;
+	if (notify_fd <= 0) {
+		if (strcmp(state, "STATUS=Starting up"))
+			return -ENOTCONN;
+
+		/* Auto init only when starting up */
+		mainloop_notify_init();
+		if (notify_fd <= 0)
+			return -ENOTCONN;
+	}
 
 	err = send(notify_fd, state, strlen(state), MSG_NOSIGNAL);
 	if (err < 0)
diff --git a/src/shared/mainloop.c b/src/shared/mainloop.c
index b71707cae4fa..9a2e1eee6f97 100644
--- a/src/shared/mainloop.c
+++ b/src/shared/mainloop.c
@@ -65,8 +65,6 @@ void mainloop_init(void)
 		mainloop_list[i] = NULL;
 
 	epoll_terminate = 0;
-
-	mainloop_notify_init();
 }
 
 void mainloop_quit(void)
-- 
2.49.0

