Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7E145B0B
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871321; cv=none; b=XcRci7G5F3TQiAwlyRJ/RKvTNzZBuBZs4559dZPZQ1SefOxMIVmXbEske/6oJT7yA5mtRJ3UBZWzFXwdwrKAmVv0dxYEMjnWxP0MdKF8Mpd3Yk/pA1q/y10SJJdxNBy0OceOh/KFOtCqiXQbBLHwcNDvZKZY2RU5McW8xj8+q7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871321; c=relaxed/simple;
	bh=L4jLJ7Q1la7GhlLshX+L5XQocGu3DXg2NAga/TRMuLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ok6N8XDDJdugSsoNXfYEvtD+cjOb3N3cDTwEqlmkWB6OnZMzhGxsiba+AH9ZOsZ4fhgkQ/qJYzFpT8pCeEPi+zxtsRvqedwjoqtUdqtgswRTqIsxPqlwWchdwnqUXjW8jTNTn43coLLb1l0n3HpfFZptBcNltQsFROZFTdvMRxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=IcV59WWH; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="IcV59WWH"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e37503115so2613421a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715871317; x=1716476117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wmCtmVNEXpgrtNBrcvR9CW41gUYFOc3+DIiY94reqE0=;
        b=IcV59WWHrYraUVZRZ6VMOYFkvrcZABB+2t97JNTNKnJMTQxqIvRK7X1Eqywl9WyaSK
         amHfL6Aj+6RpoF2eItbEhuWQ6hUfzUzkGOPryf6E2ouUjfmlaG/3AyuBBlGeyo8FlHkL
         0s1DJqUzSXmar4EeVbmpQtjh70s+0Ub7Vmc5QCu7vxm0sOmbTE/FeeIy7c0K2R4DGz4I
         kPrNtkAuoELdOElnJEiWUj4f3j/ajJd/eo046gdeR2mB5UWtR6nvHxp4p1hamJGE0I4g
         SkrY1UNAqdbThG70WtvzZPIWByoV9GcC3AWWLS5crYwNS/ZNSgLi184mRFCuhCfR4oPU
         wmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715871317; x=1716476117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmCtmVNEXpgrtNBrcvR9CW41gUYFOc3+DIiY94reqE0=;
        b=TD6oUSOH27MCot6pgdxWtahSrPWrI+JDIv0cJg/TZe5Q+upcytgJ3lF72c7+7CCY2n
         WSpUaCCC7d+1L30SZl2Kj6eBHEj5CzN/orpGzyuOWk56+/6lq1CXZtZxod7cqSZlHQ1B
         CATg2xr6uuH1zPwt6YKJSlFNeYpffqE2gcgKMCz2iMuphLMuVGMqBIEh+zYuK8NNTYIW
         yVR94fZLjALhLY9NS2ZFV2EFvCEqRnLs/XhXX0uvFANx1vMuA1dtpt/C3FqTZU9twknG
         7ppRW/BGVjAG0XazEzvyhi4wTHcN6bClIQwKLam0wWK7zCQTXqkB/woKnQIP2kfZhKw/
         TOQA==
X-Gm-Message-State: AOJu0YwVQDafADhmI1g+bmLrEukzeT1+Ll7C/eTvLeaK8gGjbJ8/o3YP
	RYeXZ9k6wniN7fIJeT7MdcITJIugaWvV/RasO+Zo5AFX0JFNoISCBoB2K3XztmgIE7OJArDsCqD
	VkFk=
X-Google-Smtp-Source: AGHT+IEbOLbc+RLbziEFnjxz2qgj6qcj0UjcZ3Yf9BQMGrw+LOBsi61sLwhMKi9YJmM6SXPiapuMfA==
X-Received: by 2002:a50:d4cb:0:b0:570:1ea8:cd1c with SMTP id 4fb4d7f45d1cf-5734d6b0e0amr13616852a12.35.1715871316585;
        Thu, 16 May 2024 07:55:16 -0700 (PDT)
Received: from andromeda.lan ([74.15.47.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574b6f6c53asm7484372a12.16.2024.05.16.07.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 07:55:15 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v4 0/5] ASHA plugin
Date: Thu, 16 May 2024 10:54:56 -0400
Message-ID: <20240516145501.134118-1-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,
This is v4 of the ASHA plugin. The previous version used an MTU of 161,
which does not account for the SDU length in the CoC frame, causing
sends to be fragmented. We now add another 2 bytes for that, which makes
sending cleaner.

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

