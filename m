Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B3DDCD
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045202; cv=none; b=pOrSL46f1TlTVeZGrLCa94XlxTCDcUuVuFQyxMcaFBqtYqr5VDatpNpy8tFChXvJS1XqAri9LejL3JhewzQM8QLSepPTQV8QTLE5ViZavb84ssu+nVBNzlR3sHYTtt/Xx9UEHqgQhxNtDc39RVU6VZW/Fb25aWwopXVTHXg2e0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045202; c=relaxed/simple;
	bh=6XK30CxGj4/T+MGWpFKNqpjBMwU4IzPAIDllDlKalU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MnSQ9wZZKjve1ajt19yqKROKwoDKRzkwJl2HztVLsCrs4/Iri8D+k2+9EcHhapho6YF9tetIg4Ofz0AiiaSc7jJrsIgoJAoypoKDF6TQPZvcQp7I8c0a0Dckxlb7RvOD5+P8Qyr14Yq2vMzJI1RZlRnO8dcT24+h/yM4uysOXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=ZgDG/cMU; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="ZgDG/cMU"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b1396171fb1so2760364a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 03:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1747045199; x=1747649999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d5lEMQTKWZswfrX7EUGXnBbpqqtYjTHqUpxTRsgU4XE=;
        b=ZgDG/cMUIC1UQ8QM6OTnRPqe6VCLiWwJsZ5YHhtpGuENriHBMo2nt6j8RDpyG2ZRXU
         qE30nINFvprd+vYcHyZkw2N8P5z+g042IXc3NteUe0X7jIS7rcurUC7yKOI+8B6xXH8s
         pZX+cEC+/NDKPFsHM3ZACW3VDl6AbxVsF5+qf9B8hwXfM4pm3tXESJU1FVjAt/VJDzHf
         JfrYWORbbPQs8VZSgqaBklzsH6HUcQP6HXQOazOYGuk6CFnROUhMhr5G+mm7CXV0Hyp8
         enPJjJSYb+uxfjsoezxXOHMEzyK9nzv7geBxlVenrKavQ0Hbz3KAYKhW0agwdvS/ubGU
         i4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747045199; x=1747649999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5lEMQTKWZswfrX7EUGXnBbpqqtYjTHqUpxTRsgU4XE=;
        b=fOmGVFiGOvdu1F3YTtGHWNY1iIBiMQ+TUTay+eVy03uNpQjRGZA6pG4Q7bK6O5eXaK
         QTr0BOqoz7TUDLJ2FD1xf9KUmR/UYFu4ibqWRw7188Kxa35Evq2zyjH3vyQjvXgYpsJ/
         5f1NGAdwLxpH5odqCKrwhCYqg9nyIy7DDoxlc8WMyVfXFpDGC5WRw87llCb84Eo7K6bt
         g1736GxFR5yOtibxqS9kaxXCIhR3TcfywuTjRSzXmG2LxtGuVxtY3gZ0fuKGHMZ1YFY1
         ctg4F26rqdsoit5yoUKQWTU0ynzhNaw4fdGPtTQWPIZJNWlNq9DIfHZy1svei3NeKWYS
         ykng==
X-Gm-Message-State: AOJu0YySIdhn+oTQGjMnxeNgnb6BqGOD8N0J+YEFAMbp6vKaYUZZm3kn
	IdNEFciWpz8LIgY+qflwXDpw3Bk8Uh5T0s9g7axCrX2DWqxNqn4GmuhZiNjlMTKSlSP7kOylA5w
	M
X-Gm-Gg: ASbGncvmtvYTSu+OqymUgLk11Ct5Ogqqm6EYRowQiKNNrE6qDWiCebGKXf6qWoi1IGt
	kBxU7VCG4DBVLJ56awNQYf/2wu6cMEQ78KXNQ332LGRXMe3kU2BsQ8hCblYwLDmGfR+5lyJZ60c
	/053qxfCj7sG69IrdRa3kgIk4aAbjATFjVa67GJON2QhugpB/lMAkqazYk7+3AppXOyCcTyO5pE
	7+qKLdnTgFGWf8s9nTVjJF+iZ5zB77BhB8rftyThUZIozTVcEDfga/SOOCPJaI+5/PJCt2oQz4H
	ebYfMIEPO5Uztc0hZ2T0LvC0qUUpBdTagQPg8/oEqeL8XnR9HMm76biB
X-Google-Smtp-Source: AGHT+IFCGWMZ1fgfXaWkm5yf3u9bOYG2zckgdP23cIIUiEoZrjMML91/Zg/R4xaVTlztolk/NQikyw==
X-Received: by 2002:a17:902:fc4e:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-22fc8b59787mr203014395ad.23.1747045199251;
        Mon, 12 May 2025 03:19:59 -0700 (PDT)
Received: from localhost ([2401:4900:1cb9:9be3:2edb:7ff:fe58:f2f5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc828fc59sm58794655ad.189.2025.05.12.03.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 03:19:59 -0700 (PDT)
From: Sanchayan Maity <sanchayan@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [PATCH BlueZ 0/2] ASHA stop handling updates
Date: Mon, 12 May 2025 15:49:50 +0530
Message-ID: <20250512101952.70203-1-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch in this series changes the stop command handling for ASHA
where it does not wait for response of the command any more. This brings
it in line with the Android implementation and also the observed device
behaviour.

Second patch in the series makes a modification to release in transport,
moving the media request creation before transport suspend to prevent a
the media request corresponding to the release request being NULL when
the suspend operation does not have a corresponding callback for stop
operation.

Arun Raghavan (1):
  shared/asha: Don't wait for status notification on stop

Sanchayan Maity (1):
  transport: Create media request before calling suspend

 profiles/audio/asha.c      |  5 ++---
 profiles/audio/asha.h      |  3 +--
 profiles/audio/transport.c | 22 +++++++---------------
 src/shared/asha.c          | 19 ++++++++++---------
 src/shared/asha.h          |  4 +---
 5 files changed, 21 insertions(+), 32 deletions(-)

-- 
2.49.0

