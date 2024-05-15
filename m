Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9E15B0E0
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715804179; cv=none; b=XkhKbjz9RJJ3VQhkgbIoXtk83L+9mIRURl9xE8yHmkWjI5FmMP3BxrVRZosrk+wwY5MbHDBuXT0mUCKB+gyzW4jvKKo2fG/6uwV/mjZzIOMGP17/BE/vv/gmCwNfL/n5354zArMd5oRJtGnqyURLnDdwk/QXVXHXhIn84S+VUNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715804179; c=relaxed/simple;
	bh=A5WAuMoCa+cfy6pjs/Yq0/4ihIWGGyl6xhSynq8yMqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uRbDl+yQb0r9juwPIpNGQKFbBwuWiwVViqqHBN+c6SBqqoNhMwKTth54S5NRq4hXQ47moZe35EjVe42yDdS0g6cEUSU7Qs6Lph4q77Qp+umSkWVvhDyk5IBJMGF94SSjt//E3QwwbBPjnBwzrTM52hAxKLYpYfrY9MpZ6Azdjuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=zBllCJX2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="zBllCJX2"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5731ffcc905so2634583a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 13:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715804175; x=1716408975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4CWCqkupJnwh65ncAXkPaZhS3oY21ZanDzCmV8H+ti8=;
        b=zBllCJX2FJIcPuabyei5nIvvcQGquSk9+yvLi4GvblIbFEui8anrK7gNqbarhRrxYF
         JH/ET+1WXkEn5L6ZPtog8RcvTbjoExX501IDFY7DXsaBu2wNTkLyqA7T/IhaQ5G9fOQc
         409N431mNZa75jHGQviAtsodtsf8NtShDrWnIFk+pEy29TbXXsYEp15AYbUKdMafkHoH
         lRmZy12z2Nu1Sv7mBRcJaHwLXbwEA1jlcUvhajF42qORO9vfRfIn2GU9m8MMu+p8eCb0
         CeUJTm+siI2UOvMYgRnOKB14wbMsveBigmWmCJkHRXt6vZSDfpdXB5qQAUzQUXWIqbUT
         o8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715804175; x=1716408975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CWCqkupJnwh65ncAXkPaZhS3oY21ZanDzCmV8H+ti8=;
        b=RQuYGwn6IZBbc+gK55vGbyWaNYsLf1poppHxIPozeE6F58aIyTf3u6CkcvyFA+G9bR
         bbSHENPLmunQ4heVKu7Xxj/9TVLpjLKc7v82uQopLGdNLPFph7tBXoKPZSCFPax/xk63
         O4qnvl4t0LbUkeZ6aq0208pvY87n0uUbwmPDrjo2MJ7hTTdAhZauD8+/Si8CaegfZPNu
         c3xP6+ULGnV2DpsjTCmFMZtcjUS07ddYGNPmC7crS/aH49fIpZalIsGB6Z2YgKsxxSst
         GZ8jlodISxJlF/vcbHndyIapp234B39bsQeF/89QR5hqVtCqV9if/4sC3Mv0ceYmx2fo
         NOdw==
X-Gm-Message-State: AOJu0YwabWkY0IdZoSyhxNhnwjNlYtDlpZRq5BkpcMHJn5SoZvgmC0dm
	iz+gr0PLoUJn/w1tU2mNQgtyLsL5JDOHxGoffbG17RyTLXNf6d68nxogOvahL460kq1MUUZyev7
	E
X-Google-Smtp-Source: AGHT+IFt6pgYHbGaq3dHTxTCNYv+sTZ19Bj9EfNl42cOahqZtzSJI4bN7PGn27Ehpy9JyFuzsOXtCQ==
X-Received: by 2002:a05:6402:3185:b0:573:55ca:8f15 with SMTP id 4fb4d7f45d1cf-57355ca8f51mr10558229a12.39.1715804174746;
        Wed, 15 May 2024 13:16:14 -0700 (PDT)
Received: from andromeda.lan ([74.15.47.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5743065dd09sm7457142a12.64.2024.05.15.13.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 13:16:14 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v3 0/5] ASHA plugin
Date: Wed, 15 May 2024 16:15:47 -0400
Message-ID: <20240515201552.1831618-1-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,
This is v2 of the ASHA plugins. This fixes some of the issues that
cropped up in CI, and splits the profile implementation and plugin into
separate patches for easier review.

Cheers,
Arun

Arun Raghavan (5):
  src/shared: Add initial implementation for an ASHA profile
  profiles/audio: Add an ASHA plugin
  test: Add a script to test ASHA
  gitignore: Add compile_commands.json
  gitignore: Add __pycache__

 .gitignore                 |   3 +
 Makefile.am                |   3 +-
 Makefile.plugins           |   5 +
 configure.ac               |   4 +
 lib/uuid.h                 |   3 +
 profiles/audio/asha.c      | 336 ++++++++++++++++++++++++
 profiles/audio/media.c     |  30 +++
 profiles/audio/media.h     |   2 +
 profiles/audio/transport.c | 173 ++++++++++++-
 src/shared/asha.c          | 505 +++++++++++++++++++++++++++++++++++++
 src/shared/asha.h          |  73 ++++++
 test/simple-asha           | 158 ++++++++++++
 12 files changed, 1292 insertions(+), 3 deletions(-)
 create mode 100644 profiles/audio/asha.c
 create mode 100644 src/shared/asha.c
 create mode 100644 src/shared/asha.h
 create mode 100755 test/simple-asha

-- 
2.45.0

