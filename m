Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E8023771E
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764360169; cv=pass; b=RaEVbfgJxSmjbq+mkKGUbWugUI7fd5+8DFr/rcuxv/Pj0IdfLPYi3+q0VCDU9RTOQAhUjBZVowLttCjiXiricIIj9uod3NiuHAlw8U/HUU0QrmwWKFe0yonvPW+c/qTJxvpd0NbYRr2rFQyb4YQx/CKTjDq+EfRGITryoBi/cJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764360169; c=relaxed/simple;
	bh=1bdBVoONPcEn0kpLco/QX0lC9DQv/U7VhLTWfRgqbeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R72TBXNWqn9JRsyrPhkQaggixrdxJrcDyPLbTy7QT3r8KAlqhNa3WSG7alxbdwC80MU0jO/YQflKWp7AYr+IELtcEmtIzJcW0bj+kkjbvBBuPH5VcghqjarnEliOxnzueaEByU91G7iVKU2f2NNDbJLcABPo2ZKzah41vfwVdX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=HOLi+Flm; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="HOLi+Flm"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dJ43264JDzyQH;
	Fri, 28 Nov 2025 22:02:38 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764360159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2jJMTDq38nnM0GVe3fmFlj0K+SV+NQay2l0cCBTLMxc=;
	b=HOLi+FlmblOlxfhwhDQMllckhfMGexNqRavJDs2Frnm3b2fjRsSqpd0J+hhnwM+ZQOuGQ+
	B68CE81oueOB58pMPVh61s1CDfjAXbzEkduXpq515+5/qoTqL1/h/Ikvs9Sgh3INnBXEeF
	SOhpPyJ+iNNUni7MemyO9CHNuhw7R7Y=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764360159;
	b=gt38POTDFVHbd33aUiYi6ZYwVuM+oGeRLIEhE0ww2SzfUlDOSD2RVntpFBJRveIKrCBPYT
	ugbSAYo7XtGC2ex76le/oZnyK9Z8fHwptFbvmF6wJc0m9BxMTUClaGHTUwgW6OEyJxIYc4
	98Ixsxf9lGoTfXxG1sCxubhMdkkJmSU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764360159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2jJMTDq38nnM0GVe3fmFlj0K+SV+NQay2l0cCBTLMxc=;
	b=mpGJjyPqBHFVGQVJ8KWjFm6qefclMwiNAh0N1m7wvfaUY9rwf1+vSyCDmDQ/B7DVXOiM3e
	pY5EsI5b/8WD75ewPalFdhVrzSnrMKbrVM/J4m+FH5f9VpzpSSqiS/fmqJJkjbAsQqL6Ea
	ej7rpIgm2XrmKgUdo9/uVoo4k0ueBPE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 0/9] Add TMAP & GMAP information services
Date: Fri, 28 Nov 2025 22:02:19 +0200
Message-ID: <cover.1764360140.git.pav@iki.fi>
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

v2:
- Rework the service wait to be general mechanism that also determines
  the service autoconnect order.

  This is now slightly more involved, but this sort of "soft" ordering
  dependency must know which services the autoconnect mechanism is going
  to start.

  Sorting autoconnect services is one of the ways to do it, probably
  makes sense also otherwise, and we could insert service conflict
  handling at the same place.

- Make org.bluez.MediaEndpoint::SupportedFeatures per-uuid dict

---

Expose the values from remote devices in
org.bluez.MediaEndpoint->SupportedFeatures

This maybe could also be org.bluez.Device->SupportedFeatures instead,
but MediaEndpoint looks OK too.

Sound server can use theses to determine which mandatory capabilities
devices have.

TODO (maybe later): add way to configure advertised local service
values, e.g.  via config file.

Pauli Virtanen (9):
  shared/gmap: add GMAP Service
  test-gmap: add test for GMAP Service
  gmap: Add GMAP profile
  doc: org.bluez.MediaEndpoint: add SupportedFeatures
  bap: add SupportedFeatures for MediaEndpoints
  profile: add after_uuids for ordering profile startup
  device: use after_uuids in service autoconnect and sort also GATT
  service: add btd_profile::ready callback when after_uuids ready
  bap: have unicast client wait for VCS & TMAS & GMAP

 .gitignore                      |   1 +
 Makefile.am                     |   7 +
 Makefile.plugins                |   5 +
 configure.ac                    |   7 +
 doc/org.bluez.MediaEndpoint.rst | 108 +++++++
 lib/bluetooth/uuid.h            |   8 +
 profiles/audio/bap.c            | 163 ++++++++++-
 profiles/audio/gmap.c           | 200 +++++++++++++
 src/device.c                    |  74 ++++-
 src/profile.c                   |  89 ++++++
 src/profile.h                   |  16 ++
 src/service.c                   | 100 +++++++
 src/shared/gmap.c               | 401 ++++++++++++++++++++++++++
 src/shared/gmap.h               |  70 +++++
 unit/test-gmap.c                | 496 ++++++++++++++++++++++++++++++++
 15 files changed, 1730 insertions(+), 15 deletions(-)
 create mode 100644 profiles/audio/gmap.c
 create mode 100644 src/shared/gmap.c
 create mode 100644 src/shared/gmap.h
 create mode 100644 unit/test-gmap.c

-- 
2.51.1

