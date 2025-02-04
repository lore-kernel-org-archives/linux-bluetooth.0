Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ED9202C36
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738651273; cv=none; b=VyD3htNi9kYER0r17+3MkCydzvU0NT5R1JKUJrG+Zsdr30Il24n4MUwNg+Z/qDRCf/GDj/spcsJQbfq5teIKIVOGZTtmFOc1iEBMhuFQ3HdpLElPN3UbogwrD7Gw13zsjAz54kocry86RIws/3Y8JI3Zsg3plnkCyBPHOOt22lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738651273; c=relaxed/simple;
	bh=vXLptqfR+Aos1bFLg3qbhV9Q71qpn79BLeKOn1om2m0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=URImqhwr2gDWSXeb9hqu/eNl/Y4DOr3TXdR2GrCks/ZC1SVKZL14xsWlrZYsFrwPCk2iqZilpIarfmhgAAoqiGyycnQkqvs/G4G+Q7Pb6wxxkUC+GjAzi2YuKqVxjUYJsW/OM5hU3ezghfBAQ/rlHgygElx3PypWi9EF5voINZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=xMNHQgb1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="xMNHQgb1"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso6600284a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Feb 2025 22:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1738651270; x=1739256070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t+z54uvA4hNTm9iXnRgRg16TDKd/PvOEml0RVKZnVS4=;
        b=xMNHQgb1a/zfyuxKlVHALrE9bd/wS9qVwfG3LsXy4Jl1Xhw4pyYwyw96vClJU4igUY
         Y0awWCopEjupFbkMlMgoVUvUsxfH/5H/+OWaHRzQIIstTZb243IDmtV68CnsRYWWUbli
         fMdItGiGeGbSZ1vsEQZQJfMe+9q8XHSxnxE78+HTY8TRqe+If5IjpG9T4ttG0XbtzXSn
         G4LiyTBsLuqeCFr3rtoAl8cgLSFwtJBmKZakFZ5ozzA38KARxkP2KM8a/c4qcz8Tlan2
         BGZj0rjevVHjZ/n6R4HD9TevJscLiiy4ca+Mkk8s0+qIGtyImQki7fdnQYt4yXPeszW7
         hOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738651270; x=1739256070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+z54uvA4hNTm9iXnRgRg16TDKd/PvOEml0RVKZnVS4=;
        b=tsB6LnI+o3zb1EV1SE6H1z7Yd4xx+0PvxG+rTaRFmNTLAKCy8xzwFyFzsRfPP0ehyF
         zelIfarf1nMfV/8+Ttzn7vFhfJKfDGcKxg7m8jKCKjqXBBEQ4RbrH72D15Q3Kh4DXZEg
         /j4aPbRUqUi3XlDxFimvnXR3dvz9BBx16tv+LMrRZaZ25/XYxgRnqtMIcAYPANihh5hw
         VvzrnxoLCOsE+UA8FJ66IdENaxFFuv+RNOIyWQU3NYVWd/lR2ObimRxkicsSgMW3Lh42
         Mbm+1iiQT8DQgxtAcM92NwsPJ1sjb7awoOijXjPUursodAbIv3bESADUwOaNF93sTlSZ
         45Qg==
X-Gm-Message-State: AOJu0Yzytc6wHoZh24pIRx79jr7NuqqdhviZHvvVyvoHY0eHx8mpcHpt
	1TGT5j+fnaNmlvXUjxVI/m3SDkprfF08WxJN0AR2h35AnF2lEoFqCKX3f78FNe6hbfEY0Nt/LzB
	M
X-Gm-Gg: ASbGncveSVfoQ3/QUyag59BlJKPZGiB4XqbjtMwtuQWmaYi3TtoIJN7rBDqv8bpA607
	+CLeJu4iPJw38414J2B2oLRigUEA3sBS8WtqDTEtu7P/pJsTGzmnjXaVbBNS6Fk+/nBJFT2lwQL
	OnGUCCHWXr8nz2bTfARZFoj9oQ/+OX3VfXkpYOTECBwjZvi8cOPjzgNJyCEhU0Y8lS1d6hVCxIQ
	DSszC9CReyb84h3IhzcnGev7JCcdlPGGSoLSbdLUeMVjeJ5U25DhJIFJX5a7QYuE6mczI5Bi1d5
	ppIycCg1a3Jw7WdhFZxppg==
X-Google-Smtp-Source: AGHT+IF7tOIC53riiEVGgOnrdobyu0qfaXoDuEgpOy+u7HITk4/e+5Xl21DrjOCyZZL5jxbVBy5NpA==
X-Received: by 2002:a17:90a:390c:b0:2f8:4a3f:dd37 with SMTP id 98e67ed59e1d1-2f84a3fed3dmr31560085a91.16.1738651269817;
        Mon, 03 Feb 2025 22:41:09 -0800 (PST)
Received: from localhost ([2401:4900:1cb8:94e9:54ba:1973:453d:16b0])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f83bfdb81bsm12433955a91.49.2025.02.03.22.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 22:41:09 -0800 (PST)
From: Sanchayan Maity <sanchayan@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: arun@asymptotic.io,
	Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [PATCH BlueZ v2 0/1] shared/asha: Add support for other side update
Date: Tue,  4 Feb 2025 12:10:53 +0530
Message-ID: <20250204064103.672327-1-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ASHA specification requires that the status of the other side be
communicated with the start command. The status is also updated
if one of the device in the pair is connected/disconnected after
the other.

https://source.android.com/docs/core/connect/bluetooth/asha#audiocontrolpoint

Changes since v1:
- Fixes the below build failure.

In file included from ./profiles/audio/asha.h:16,
                 from profiles/audio/asha.c:43:
./src/shared/asha.h:56:22: error: ‘asha_devices’ defined but not used [-Werror=unused-variable]
   56 | static struct queue *asha_devices;
      |                      ^~~~~~~~~~~~
cc1: all warnings being treated as errors
make[1]: *** [Makefile:10783: profiles/audio/bluetoothd-asha.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:4693: all] Error 2

- Link to v1: https://lore.kernel.org/linux-bluetooth/20250130090158.266044-1-sanchayan@asymptotic.io/T/#u

Sanchayan Maity (1):
  shared/asha: Add support for other side update

 src/shared/asha.c | 165 +++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/asha.h |   6 ++
 2 files changed, 168 insertions(+), 3 deletions(-)

-- 
2.48.1

