Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3777413C9C2
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221631; cv=none; b=OTqoi9HpEbiH3YvUgxa0Q7OEdqVDebGyD+ueAcp9iBf+hgom2z+xSTgv4cw0RFUOk4eWBWkrzJHHzipy/S+u5G6irWO3OJZks7vGPUsWGf2sg6+v/LvzO6KV6BLq52p6HNWSj4rBDA9D2THeAxsTNkKSJLOvYM34h1FBr3QCdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221631; c=relaxed/simple;
	bh=qAjHfwyiiuZ4qReYDCJzOnUMU5WebwbcTQVBgCesjfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BCkrFYRVuvdApehvh0Xmyf/ECNSyhF7w6BU/HMUAlNE2xqO49OthLQWTknxN4oHWdBzRpyjNu9CUJPrYmxSTojqS82Vy5TffdO5hubhDnY97coAPAg7vGPwr8qD1Qb281ClC6RjkRQGZN97ahEJc2OkuQMKflb3N18LgXLsHcAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=XZ7E0+FH; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="XZ7E0+FH"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43de92e234dso4867761cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 19:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715221629; x=1715826429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JIGR6rL4FJT48GF4E4Oj4HN24DPO5RDU6sjq5aUgVAU=;
        b=XZ7E0+FHSHD53FpcSe/58VXrDGlFhfRywyXF8ceIjk1xd5wP52OcTLKTfRRVojJmBP
         LNXbLq+QTIFFKXnXn4r40y7rN4IAQHlhBe4bMhmiFAt6lSvyy25mO3mxiOWNazTea22+
         EK1HqT2gh/M2JFVRUoLG70y0rLYHTz+XUlsT0EPodVW6NgTgnLqVRx2vRakr6+6/wlx9
         MFPU0SMDsi1wKL7Mdv1BzTePARjAb6we6MxfeuSqdnjs3/tu1/ngATev0A+VBPGaw4X1
         xuxj6SzVGhKlxUYZSm33NtPEaKmnA2GagyloyQyxaMwYkXj45ESPOo69kj8wAUZcc/fa
         kjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715221629; x=1715826429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JIGR6rL4FJT48GF4E4Oj4HN24DPO5RDU6sjq5aUgVAU=;
        b=NRcUm5HVqcvgomP5oQ9Xd+lC2bP6JBIHMjv/D+bKRJ4gzLDwux5DyAE2J4UgvhpkdQ
         noUMA6Y7Y77R7rIBMEgMdmSdkKaZb2U3XuoxHtiRIHxk9KQgwcWjaPAmvTr6jjBazjlT
         4Ya/QJVYPAqI9684Q0x94B696krBUqLTIfERN8lBa0NIYCGtEaAMGGig+Q+V37NXmwRq
         cGB3jlExXJGGG55fnqwaKUXB16DjRqFrsTrmk4iDUQ+RwKNP+HoJp1GvFH2hyQcrqnNY
         TL3DwjrrXDpfSwpe7AsTg7nlkC+Rx3zqhJ5+1kHWqIsKXdzhd6jEAXqWPu8eMKiUAAlD
         k9IQ==
X-Gm-Message-State: AOJu0YzQvzbT+xsU/39kAO7AOI2w7HdbxK7IWPLOXYrCMEShsZfGNc54
	kFU5TK8kO4Rkd+OVRuSSYKsjQwnjVDcMizqwhGpFzt+a6n5OSSWQIuzAWkecuEBcQ+GovRbg4UM
	N
X-Google-Smtp-Source: AGHT+IE9TxmAROEGUd6pM74AwHZQIq1W8t4Xrdy+L2Sc0wG3U9EBMyY0FM4rzES0pI9+7RPdqAGuVA==
X-Received: by 2002:ac8:5fd6:0:b0:43a:bcd9:5d71 with SMTP id d75a77b69052e-43dec073df2mr23981121cf.11.1715221628701;
        Wed, 08 May 2024 19:27:08 -0700 (PDT)
Received: from andromeda.lan ([74.15.47.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df56e278csm2091761cf.93.2024.05.08.19.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 19:27:08 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v2 0/4] ASHA plugin
Date: Wed,  8 May 2024 22:26:36 -0400
Message-ID: <20240509022640.451351-1-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,
This is v2 of the ASHA plugins. Incorporates feedback:

  * Non-DBus profile code moved to shared/
  * Internal API exposed from shared/ has bt_ prefix
  * MTU is now the application layer size, rather than L2CAP packet
    size
  * Coding style fixes
  * Squashed the separate volume changes to simplify fixups

Arun Raghavan (4):
  profiles: Add initial code for an ASHA plugin
  test: Add a script to test ASHA
  gitignore: Add compile_commands.json
  gitignore: Add __pycache__

 .gitignore                 |   3 +
 Makefile.am                |   3 +-
 Makefile.plugins           |   5 +
 configure.ac               |   4 +
 lib/uuid.h                 |   3 +
 profiles/audio/asha.c      | 336 +++++++++++++++++++++++++
 profiles/audio/media.c     |  28 +++
 profiles/audio/media.h     |   2 +
 profiles/audio/transport.c | 173 ++++++++++++-
 src/shared/asha.c          | 499 +++++++++++++++++++++++++++++++++++++
 src/shared/asha.h          |  73 ++++++
 test/simple-asha           | 158 ++++++++++++
 12 files changed, 1284 insertions(+), 3 deletions(-)
 create mode 100644 profiles/audio/asha.c
 create mode 100644 src/shared/asha.c
 create mode 100644 src/shared/asha.h
 create mode 100755 test/simple-asha

-- 
2.45.0

