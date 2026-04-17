Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C693B19A0
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415756; cv=none; b=bpXI0p0DfqOSfs/Ik+0PJKJlU3/9IqdJ3eN3LK7C9GWDEkeKTQvO0lczRoQ1WRv8Em3sKVKIURM+5dAUCc/W8XrqPAkDdlhy9u/M21ooaUSyZdIBew6EHz485SzMef2clNfzXVZiB0IhUOShs1P+CLXCtFVNbiW45kErZltYlxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415756; c=relaxed/simple;
	bh=mrSb7so0gvabDP65hgfLVw1UHTs+PKLHhqrwMoZWzKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+rd8KgMTePGwei942091bg9N/sshid7HWZfVlKeVrK2fowUJq9lcd9pt91FX3v8p2jjpo5wv1UVVJydXnlzHYeRiu+ytUYhKv+kCX5FjZtzA6MRvLxay8TXnmJIOKxDac0cZ7dBmD03aMgmoeD7iUZX4UDO2o4VLnl12Eqv27w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=06VjZ1/o; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="06VjZ1/o"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso4721445e9.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 01:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1776415751; x=1777020551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uL84Jrz0n+NiL06/xQ/SdlnuTAYwIETP2EmCAF9q8j4=;
        b=06VjZ1/olXVE5an9GcX8Guse/jn06YJ4ARXf2XWU0K28hEAFO/JaxRw247cyDxN4eu
         RDvy7UvtPsihL6kmvQostF7pTDbAGE0wgWvLnvtdx+lFmicpgKa8J5KZI5d6EXLYHHUo
         3t1JPvtvRJf6YugBUcUpsOwUxN4NBdq93Rykc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776415751; x=1777020551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL84Jrz0n+NiL06/xQ/SdlnuTAYwIETP2EmCAF9q8j4=;
        b=doac32YBqcb8tAdjSInrmXWExUrvaV0v2epTBcX0BqEbb/Y35gsdddxaFKl2NGEm4V
         lVM8PdfamUIvc1L4kxZARtOR/oycaeqHakXZnJxDobzcA8TK46PIWb7cnRY+fMpm6aEc
         Z1xwegr/N4vS8vN/0teNavSpzNgg72XjYTvSh8EFwA6QwLthGgmR5gOHlmvJh4AED4QJ
         3VKYMnpOtONQU03cDKE+2+nfeQynCchYl0uIyvUiTuw+svflSO5EH8b4x7yVZJ+O/gUC
         I7R9ZVAupOjt7KRpqhTTLCuR87dtFVBnlBNdNrJJpIAe8ykdwJA6LsgY6kRzM3ZahTD3
         PT0Q==
X-Gm-Message-State: AOJu0YxfY2A3i9D2L/s3m9FxiWtnA5sgkRp+pL9kD7FecYJCKcccoxc3
	Q/Q6HuKDL+ADSq0PQKciu3247xEPgekfbrff+fWAGY643vuMFal8rsC3YSDAYqJQVx8c8XdG7JT
	gDX934A==
X-Gm-Gg: AeBDievTz6wFd6TRYke4MJeO+zOoyxwCdSyaBGzI+PG3AEOLofF5nKuqDrBV3Ghx/OZ
	C+z1lN5EmDqLvZtNgPxqTYWHQ1ZlYOs2lWZOcps6xUmTMKm1EiQhZJsfrMkZ1P7ac+sbjjxHlh6
	zgM18R9hIulZzDRwsHC07G3uYXKOO6zHrsFQDcJO8w5j9Wp1oeC6prPqcj7STdM/qZqoQgnGn/w
	FFCO5N2OB+MaHw6ipPXZypjfEqI12fucxxsmS9FS5Vlsj0geGmTFiAIRRl4ND4hRpVlFj6LJ0R2
	t5WZIaCo0/PFWufVg87Fhz4BjQYoh7ZHI9NPkfTM67m+Cwfc3tm55kgBteEWU9vTP2b4afeww+y
	mqzvDIVMQAjKbZuvztllA3FluUEg3i0iZCtTL90iEWmFNs9AsHGzNN+WuVfDqAEJUOXEW8Qyqiq
	PolPIP08LRNW5Mxl3MCPUKmNnU+mlaqGSMekI7/UaUooWxaJoWf+ovLM5n4Nhca4dtATiFQq8QC
	bNsZChxr4T6yfGW
X-Received: by 2002:a05:600c:1c11:b0:488:9ed3:148f with SMTP id 5b1f17b1804b1-488fb782a93mr27639545e9.21.1776415751557;
        Fri, 17 Apr 2026 01:49:11 -0700 (PDT)
Received: from great-eastern2.home (public-gprs181528.centertel.pl. [46.134.48.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc16f8c3sm26315095e9.2.2026.04.17.01.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 01:49:11 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ 0/4] BAP broadcast fixes
Date: Fri, 17 Apr 2026 10:48:06 +0200
Message-ID: <20260417084809.3633687-2-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Those are some fixes I did when working with BAP broadcast receiver.

Michal Dzik (4):
  transport: allow setting Metadata property on broadcast
  shared/bap: run callback after setting the broadcast metadata
  audio/bap: fill BIG and BIS for receiver
  audio: update QoS dbus property after it is set

 profiles/audio/bap.c       | 5 ++++-
 profiles/audio/transport.c | 9 +++++++--
 src/shared/bap.c           | 3 +++
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.43.0

