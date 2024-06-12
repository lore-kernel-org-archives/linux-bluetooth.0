Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF1181322
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209266; cv=none; b=lSM/4xxTaN6q9Zn66JoNxg/WGr/ajeQSJUp7jgdH2IswukH9sQemCxQn6BAfSeEjxV/cRQ2zV9ViWR5W89S6QP34KTN1DicXHh8QKsUMLwPvhDkbHr0GoN92P7vkx+ubqmrak3mA7d2Fu6lyAwRMdPzipMhmS2NixEOtrQKyuew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209266; c=relaxed/simple;
	bh=tWxTnaRYFMMgUA1uoZkjyI7l71MDLnDTsfG6AnAy/Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CeZXd/oS8ketxbYxLjUBx7uG9OqVts6GPAT8c2L6TlnJYl2nmNxkZMtchjadYG5/mPbIbQIUd7ZLrN3QXtgneU4DgTWHKIOcCuIV5TiYYC26AuEUeIUgz1MBiZF6KVcu0fdGCweM4Cdhs2XToOzrcbGuxM5PW8ozjYKyz2mjzuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=IXOO+2ew; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="IXOO+2ew"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-797dcb558ebso111903885a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1718209262; x=1718814062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BJ4Urr2hqS4mMt0vlDSjQ9WOcUh1GOV8mx3C64mOQdo=;
        b=IXOO+2ewRzlGSgR0hfied5BG7x4IjX0MQBDSgSpzU6R+C4ApXPu+y71N/jc9/NJe4a
         9ae/JN4qK50IPmEybdSBD81YYYZbiJEGLNvQs4huIyM9TG0Vg7LRZvydmPhLu2GAcTtM
         qamL/L4HRtpYikJlPEFQAvKjGBipDAfmH0F9U2MX2IZs3k6G/khLuWf0/mUjuiQGqrQT
         CY/Ib3vPZUYGnPKzOO4FpgWtLcduLxIWcBq4Px+hlsNDJ9eDumy7CYVBZte8hPAWFYts
         HFjVlAGhaZpllosyqzNhothWt3h7iRG7/B3EyysaaiHTgDBv0PGjH+aLNMdJHhVZSFTb
         k6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718209262; x=1718814062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJ4Urr2hqS4mMt0vlDSjQ9WOcUh1GOV8mx3C64mOQdo=;
        b=Jm61B7MegKC+nm//5VF5pksUFESLradm9FOoEmpsf0qdy51t4hQ8kchBjj8x/suLd6
         S2UqFZOUl143m2rgo8uHlBeboYyR7cWSV41Z6AzONMXQQ0JQGK5Ao1LRofVXSul4In1Z
         Lk/2jPwKCZdt+Rt5qT3ZvHQGqF2tDPKvm7Bw3Crh2f+QZ+xAXG3d9Ed0Zz5X6EEdi1yS
         ev8S6R9mbOEIvTNIZAo8GEkg8n9jpIkQCcpyLmtCyRbgerqki++v/ik4SUNXC9Tdcwhq
         zPpiiufGQzTTDwBaLbpyo/BmcUWmHcG500C/fh9k+krpz1maFhR9cCYjK3mhtQSuzP6J
         SSDg==
X-Gm-Message-State: AOJu0YxZWMCfEIrLPQhChJ+V8T1nfElVW+VBg4g9gR4oqJkoSB5TEXSD
	e2TzIesKW+wSk9ZA/cVAX6zIqYlocTdoKVktqLlLymO4aODtLNCesz9bBYjoRCoTkppFo3kDgUB
	x404=
X-Google-Smtp-Source: AGHT+IEKefnXALYFF2Scr9UVNNvhpKkP9++W+bObB92C9sD64z5hdPzsjj1efaNPg5FJUBUad6J0pQ==
X-Received: by 2002:a05:6214:5908:b0:6b0:63fa:c42 with SMTP id 6a1803df08f44-6b191a64578mr26769196d6.26.1718209261682;
        Wed, 12 Jun 2024 09:21:01 -0700 (PDT)
Received: from andromeda.lan ([70.27.101.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b089aa106csm21899616d6.127.2024.06.12.09.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:21:01 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v10 0/3] ASHA plugin
Date: Wed, 12 Jun 2024 12:20:38 -0400
Message-ID: <20240612162041.689679-1-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,
Here's v10 of the patch, with some lints fixed. Also recapping the
rationale, plus some additional information on testing so far.

This is an implementation of the Android specification for streaming to
hearing aids over Bluetooth LE, ASHA[1]. ASHA predates the LE audio
specification, and has been supported in hearing aids for a while now,
so I think this is worth supporting as these devices should continue to
be in use for several years.

I've reused the MediaEndpoint1 and MediaTransport1 interfaces at Luiz'
suggestion. The flow is slightly different from A2DP and LE Audio in
that there isn't really a negotiation step, so the endpoint and
transport are both available on connection.

Also included is a script to stream arbitrary audio to an ASHA device,
which is handy for making sure that the implementation does work.

I have tested this against an implementation on a reference board, and
various folks in the community have also been kind enough to test the
WIP patches on various devices, so tested devices include:

  * onsemi RSL10 board, reference implementation from the onsemi
    forums[2]
  * Signia Styletto AX
  * Oticon More
  * Starkey Arc AI 1200

The current implementation is written with a single device in mind. My
plan is to take this to completion along with a PipeWire implementation
to expose a single device for playback, and then do a second pass to
support a pair of devices.

Cheers,
Arun

[1] https://source.android.com/docs/core/connect/bluetooth/asha
[2] https://onsemineworg.my.site.com/onsemisupportcenter/s/question/0D54V00006r9FUVSA2/dsp-initialisation-hangs-in-bleandroidashaod-code

Arun Raghavan (3):
  src/shared: Add initial implementation for an ASHA profile
  profiles/audio: Add an ASHA plugin
  test: Add a script to test ASHA

 Makefile.am                |   3 +-
 Makefile.plugins           |   5 +
 configure.ac               |   4 +
 lib/uuid.h                 |   3 +
 profiles/audio/asha.c      | 525 +++++++++++++++++++++++++++++++++++++
 profiles/audio/asha.h      |  38 +++
 profiles/audio/media.c     |  30 +++
 profiles/audio/media.h     |   2 +
 profiles/audio/transport.c | 201 +++++++++++++-
 src/shared/asha.c          | 359 +++++++++++++++++++++++++
 src/shared/asha.h          |  63 +++++
 test/simple-asha           | 166 ++++++++++++
 12 files changed, 1396 insertions(+), 3 deletions(-)
 create mode 100644 profiles/audio/asha.c
 create mode 100644 profiles/audio/asha.h
 create mode 100644 src/shared/asha.c
 create mode 100644 src/shared/asha.h
 create mode 100755 test/simple-asha

-- 
2.45.2

