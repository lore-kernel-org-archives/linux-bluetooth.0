Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7CB1F5EA
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763914651; cv=pass; b=jxU0uSZEEs4Q1moBj1CLOQnqNuZ/SensdcmT6kmXgFmf88tzGN7PJ0wuFvvcxHo8YTmCpmJEnYEb7GTSoQZ5Vh+hrvY9UBxgYZ6Yvqn2pdmPfHeFRxS34NV1JSiLTomG2EsL2mSe5z643wvkHuOKp1q2attXnyd+WG9SwnoyS04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763914651; c=relaxed/simple;
	bh=HzrI10NsOK4w7UGKqfU5pRaOwzq0qjwi5pqlHFZBrAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6LCsloBApRzoHlGq27dyHJZ4MHrhONWp0XCu+J4M7c6GdAW4XG4eU6VbBhn3/ftV6NlMaP+6EGNyp0lAoIWNh1uPbLmyVACWqr/jx1DkWkcpZaQo73If8LfdEMJr92usbkKZECvP2X4RGoed71mHeakSgj8uyTBBsigq/DhmZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qJKmQKpQ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qJKmQKpQ"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dDvHM5v89zyQc;
	Sun, 23 Nov 2025 18:17:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763914640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h7afYoFDSNHfdXdeJaf0WQl7u95E6/coF+CpX0aGTWw=;
	b=qJKmQKpQZDUJpfMWDbQkssiPvSzcICj4kNwjVgE3NVEpr4OCsJbYyXxzuvaElU6uj+nd11
	4F/8xHeJAOxQ6g21ymXeFXw0aR3SmjFokExaYU6NhmI6iHgfbmiYVsT4OOZXPJXbbbqMQX
	ynlwzR/pudAFmjWDdU6xA72olmfOobk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763914640;
	b=Fb6Pujk5R1Hhiu5ckjc+oDIvK2ZQYZp9t0zcjqpr7gv+9cLkv0APj0FaYpUrX2x4N6UCFP
	WAjCsDxtpLE27H6juWKwpLO75+XUrRCjG8nfy+CkUxvnnQS1YzG2YTUdYSsW/xNLBLqeRp
	WgR4CPjc4NchpL4IMZw492cICnNLdkQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763914640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h7afYoFDSNHfdXdeJaf0WQl7u95E6/coF+CpX0aGTWw=;
	b=o3jHdQ+4kKewbwioQToIY87v3Wzn/l1eHhAYJsZyloKiUGZKQuLtkcXvwuzhWe3sReaDw7
	oNiq7/pOXhwFYc6f99YQqHZnnA6F+f2HFRoqKiX96HCxLfIXRZhabAC6mh54gKqGHSx2nu
	zCjph6OfzzBYSbVAQt0ZDhoIfQXmiJs=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 00/10] Add TMAP & GMAP information services
Date: Sun, 23 Nov 2025 18:17:05 +0200
Message-ID: <cover.1763914558.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for TMAP and GMAP services. They contain only device
audio capability bitmasks.

Expose the values from remote devices in
org.bluez.MediaEndpoint->SupportedFeatures

Not sure if this should be org.bluez.Device->SupportedFeatures instead.

Sound server can use theses to determine which mandatory capabilities
devices have.

Some boilerplate maybe could be avoided by putting these into the BAP
service, but did them separately here.

TODO (maybe later): advertise local service values, these could be
configured either via config file or endpoint SupportedFeatures.  Maybe
config file is better?

Pauli Virtanen (10):
  shared/tmap: add TMAP Service
  test-tmap: add test for TMAP Service
  tmap: add TMAP profile
  bap: have unicast client wait for VCS & TMAS
  shared/gmap: add GMAP Service
  test-gmap: add test for GMAP Service
  gmap: Add GMAP profile
  bap: unicast client wait for GMAP service
  doc: org.bluez.MediaEndpoint: add SupportedFeatures
  bap: add SupportedFeatures for MediaEndpoints

 .gitignore                      |   2 +
 Makefile.am                     |  14 +
 Makefile.plugins                |  10 +
 configure.ac                    |  14 +
 doc/org.bluez.MediaEndpoint.rst |  99 +++++++
 lib/bluetooth/uuid.h            |  12 +
 profiles/audio/bap.c            | 146 +++++++++-
 profiles/audio/gmap.c           | 203 +++++++++++++
 profiles/audio/tmap.c           | 203 +++++++++++++
 src/shared/gmap.c               | 402 ++++++++++++++++++++++++++
 src/shared/gmap.h               |  70 +++++
 src/shared/tmap.c               | 302 +++++++++++++++++++
 src/shared/tmap.h               |  39 +++
 unit/test-gmap.c                | 496 ++++++++++++++++++++++++++++++++
 unit/test-tmap.c                | 378 ++++++++++++++++++++++++
 15 files changed, 2387 insertions(+), 3 deletions(-)
 create mode 100644 profiles/audio/gmap.c
 create mode 100644 profiles/audio/tmap.c
 create mode 100644 src/shared/gmap.c
 create mode 100644 src/shared/gmap.h
 create mode 100644 src/shared/tmap.c
 create mode 100644 src/shared/tmap.h
 create mode 100644 unit/test-gmap.c
 create mode 100644 unit/test-tmap.c

-- 
2.51.1

