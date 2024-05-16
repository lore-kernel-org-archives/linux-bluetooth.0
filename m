Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A121E487
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715888330; cv=none; b=XkGSCqbskuzSxprBQ9eD2dYvjuoZu4qesQOmw7bdHedqMvOcGxhQE3dySVkULorHxTjQjS7yyXR5qfYJE/QazBBhonfxBunhRDsFvur+6is8g5BN5xFFucPyzdE0hO/oSYEKwWnPfNlvVfQLWo+lwXtccQbLz4WPLnZ0kpMpMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715888330; c=relaxed/simple;
	bh=cY1zme3OLL5/rgC9qKcd1ZwEYE7vRQhSJdR21l+UhPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eSgS3aJzddt95NMMuR8Kwqk8gCy7O/L311GE85QMcKe0Kw0s0q2LO7zLtawhk5gmwtoYlH7HWRU6a7z6Oxx677fwDNmuwssSp4M17N8X5ARvtU0+umi91LAgJJpwRf/euauBqf4esh4IBta6yMsLm/LDDu1M4Ltv6NJ6S2TtlNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=u3qdHe56; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="u3qdHe56"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572baf393ddso5580882a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715888326; x=1716493126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QRi2jSAg+nP+cthCiPfofaTdmkXgXQWiEWeWJYJZoUU=;
        b=u3qdHe56ja38o5y+ux59mgaCKA0iWOswPn+QZSgCGOXGn5AkmUBqYg6E8kHGKCBNzg
         INMdYMFqU2EiLOd1tw2orQzWyid59EX60LVJSkLxh4O5dLeHASGOiJDc88D0Uasp7yyJ
         trVn12kslVlFar4MJAEuIdmKQ1uQTVUEtjsykkUbNAUqRz0a1/j+T2+Kqa+laMK9hx7L
         hDyahFND9Gn5WhdXM/iAALEC+Ww331nwpX7WexqrbmIJ+ZNITRMRzg6XKgP+TzLUlejo
         zIDTQTK0SxDp9+YM7W40TCiTW0gwa1o4BC49c9cXvVT77To6v/vv3NVYw3leFYD8MWQf
         ueuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715888326; x=1716493126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRi2jSAg+nP+cthCiPfofaTdmkXgXQWiEWeWJYJZoUU=;
        b=PmFc0KInEaTGA2VjFg70QWk0Lv6TpOJBUvqgbJd9dc1SYV18zo6BfYrbWJ9fORg7bY
         dSqa3ljXCfbKerJXkj3FXfb5cH6gbZ+uLvaWGjDAsv+VmXQIF1CkkBKsDzgO36Gn93gj
         WfKKupOwJQkfe+i2eDkrLVClHJYCx+RBrBOhdIQ+2pGg4iGO5Ml5ZYgibJUqpsh08Cpk
         r7DM6Gqwhoq9br/qy/C4ABKO93hfKo3yAKN5Q9yHrD1qLwHJIrlB+ofrYU9c7jnepTTY
         3Tcg6ys3TohXv8iX2dgDQXfrmQBUn2OkXN23kZ3C4RM038NbVcLK516RxL/xE5FFtyrN
         Yjpw==
X-Gm-Message-State: AOJu0YwSxWhar2Q1TLnuV0FfotiaeeoKxy3PH1rES5RNe07uRKGEab98
	1RROZ70Riz+yinI5Lzp2J7TVkYmivxRWZrhJ6U8427LYI8mEW8eriuSKzoOufR87/+u0yW6ltJ2
	D7bE=
X-Google-Smtp-Source: AGHT+IG0a+3Fx0xqEUPTkj6xrD8e53lLi/Obq+UZczZu3k8ojIlh3wOfTx3hZqzrmNTQh2/N6ZlPhA==
X-Received: by 2002:a17:906:55cc:b0:a59:a431:a8d6 with SMTP id a640c23a62f3a-a5a2d317577mr1525647866b.38.1715888326425;
        Thu, 16 May 2024 12:38:46 -0700 (PDT)
Received: from andromeda.lan (bras-base-toroon0359w-grc-19-74-15-47-99.dsl.bell.ca. [74.15.47.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cd85sm1031241766b.15.2024.05.16.12.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:38:45 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v6 0/5] ASHA plugin
Date: Thu, 16 May 2024 15:38:31 -0400
Message-ID: <20240516193836.228281-1-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello again,
Sorry about the noise, but there was a bug with the MTU setting in the
previous set.

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
 profiles/audio/asha.c      | 336 +++++++++++++++++++++++
 profiles/audio/media.c     |  30 +++
 profiles/audio/media.h     |   2 +
 profiles/audio/transport.c | 174 +++++++++++-
 src/shared/asha.c          | 529 +++++++++++++++++++++++++++++++++++++
 src/shared/asha.h          |  75 ++++++
 test/simple-asha           | 162 ++++++++++++
 12 files changed, 1323 insertions(+), 3 deletions(-)
 create mode 100644 profiles/audio/asha.c
 create mode 100644 src/shared/asha.c
 create mode 100644 src/shared/asha.h
 create mode 100755 test/simple-asha

-- 
2.45.0

