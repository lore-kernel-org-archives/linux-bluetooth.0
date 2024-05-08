Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7A41292E4
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183178; cv=none; b=GbiHjdtAjnGBhREm25E8M3iGEwJnokH1TG7FKKicwUt8ZKWmb4MppSwr36o0FwhAyq0zN7QfCdgjmvEgxYexEUHM+K0/NI1Rb+8tFXtpt9mumScIlpMMAYbs7G+VB0X9s/wTs8XhAnU65FCcW9QzRRYsm9qXDcRaPVE2BDhPXDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183178; c=relaxed/simple;
	bh=7TAVVFG+yvXXVIkMlqVJ+BcyraU9juZnjsZsFlYnaw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ce7Z+1tWre+5BblQGF5cF1r6lv8goRGmiQaYLueF0RsELT9z2oOsgQ+wtKrJvq0HRN5ckcIy77aCI9qeaaDpdbsn0hFN7cJ9R8MokWmgzeNtKbLhXpggplO5A6QwrjlqJtJnu5GxpDIZHwZqDJEuWF/1PnRfcw6tf+f5XSb5JSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=GRsAA2Zx; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="GRsAA2Zx"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43ca9047bd2so7380181cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715183172; x=1715787972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5UbzPBRTRiDLhFM8NCxYxpmABq2A7M0E5WG9xInU6rY=;
        b=GRsAA2ZxkQk3fpdtqoEwQp0J7NzL2VeYKWlKs9LeVeVPqHFKXQnhoFsm68ToLFqCgP
         4Gwseld4F5+ZxptbZI/NUwanrDEsNyTLsvt6rLgCSKEzVKIia6Y5Zk5JirIk9HJJD1VS
         n7/eq0G7hS1I+FQlxdbGhK8d8JOSk7FugV3/IfNnw10eEF+/VDOoR6+NwwAFVc59pqhO
         Ztybq22yJP3ZhGzErK5kxNDXRWyzuZSKVqK+UYsnTsK78bpf8zLt22mSqxs9SyrcVfne
         6dp/XTmgw7JqooMLO9KoPMfIgdJfR/98s4BoAMqGncvznbUUlKdYDPJ1GtZsoCdhmdnI
         kUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715183172; x=1715787972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UbzPBRTRiDLhFM8NCxYxpmABq2A7M0E5WG9xInU6rY=;
        b=Bzi37lnJwb8xw0cVjB+1mK5+nYsT7HHWhlGieru2IkSt2lxzy3DvjTlnxWoJ5RxStd
         K3JhDvFZu4mNdLqYoiYGW1mJnJT9Fz17Gm0JlFyiZAWCSCIutqcFVl2WkBl0qY/RNB+P
         BQedJdue1msxAbNSRqHmoeD0oFEHVoAtcqOrfonapJkqT2s8GsFL4ASKAfjWzs9pKz7i
         y2avr3deH1OOEOn0T6ECqClLEUcdPZCf4BHm3NHmo2/kUCx69twBWdUW89zcFVoeTgWK
         NORPQByo/I61BSlhGx0LSqfbqO97qinpy/gRSSVFRGtvl3EnsRUh+SZbObDf1iwEF5dH
         Dz8Q==
X-Gm-Message-State: AOJu0Yw2MdavJATt1npVFMztiRWHLzeHLAqWneqUy5d48xqYehc7gNN3
	0cdeAbOYejPq7BDN4ZIwEF4uKNxdrgJ4tQEyZCj3QIWtsNWVD2M5vAydd0lr0xb6bIuzbf21AFX
	l
X-Google-Smtp-Source: AGHT+IEuyxvrBtcKo2L7nRTQMdRey3rhmd4Zo7Djuu8JZvJrZdtD2oYjphJFmbXfjhpv0b/7irrp4w==
X-Received: by 2002:ac8:5d0b:0:b0:43a:c90b:34e5 with SMTP id d75a77b69052e-43dec2a3d43mr338221cf.34.1715183172047;
        Wed, 08 May 2024 08:46:12 -0700 (PDT)
Received: from andromeda.lan (bras-base-toroon0359w-grc-19-74-15-47-99.dsl.bell.ca. [74.15.47.99])
        by smtp.gmail.com with ESMTPSA id cd14-20020a05622a418e00b0043791f7d831sm7756513qtb.63.2024.05.08.08.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:46:10 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ 0/5] ASHA plugin
Date: Wed,  8 May 2024 11:45:59 -0400
Message-ID: <20240508154604.276763-1-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,
I've written an implementation of the Android specification for
streaming to hearing aids over Bluetooth LE, ASHA[1]. This predates the
LE audio specification, and has been supported in hearing aids for a
while now, so I think this is worth supporting as these devices should
continue to be in use for several years.

I've reused the MediaEndpoint1 and MediaTransport1 interfaces at Luiz'
suggestion. The flow is slightly different from A2DP and LE Audio in
that there isn't really a negotiation step, so the endpoint and
transport are both available on connection.

Also included is a script to stream arbitrary audio to an ASHA device,
which is handy for making sure that the implementation does work. I have
tested this against a reference implementation on an onsemi RSL10 board.

The current implementation is written with a single device in mind. My
plan is to take this to completion along with a PipeWire implementation
to expose a single device for playback, and then do a second pass to
support a pair of devices.

Cheers,
Arun

[1] https://source.android.com/docs/core/connect/bluetooth/asha

Arun Raghavan (5):
  profiles: Add initial code for an ASHA plugin
  asha: Implement volume on transport
  test: Add a script to test ASHA
  gitignore: Add compile_commands.json
  gitignore: Add __pycache__

 .gitignore                 |   3 +
 Makefile.plugins           |   5 +
 configure.ac               |   4 +
 lib/uuid.h                 |   3 +
 profiles/audio/asha.c      | 835 +++++++++++++++++++++++++++++++++++++
 profiles/audio/asha.h      |  38 ++
 profiles/audio/media.c     |  28 ++
 profiles/audio/media.h     |   2 +
 profiles/audio/transport.c | 173 +++++++-
 test/simple-asha           | 158 +++++++
 10 files changed, 1247 insertions(+), 2 deletions(-)
 create mode 100644 profiles/audio/asha.c
 create mode 100644 profiles/audio/asha.h
 create mode 100755 test/simple-asha

-- 
2.45.0

