Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE2222585
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765018903; cv=pass; b=UBzDpoQd3ipWcHKD5HyoXoWos+Pi2+ltMqNnS88P4ZvUJ2InAHX52O9gbOrnQrEsQmfQDzIyoSpcCNMBkQRTGKk9ohYh2ncRvFDJFapniZQgw/PWjeRNYJKr2K3l3oAbmyLfe2PCgTIY/QA4QMk010bjSdavZ4JLjGEgQhy4XqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765018903; c=relaxed/simple;
	bh=2DasQTNGxYzQBpu0sQnGTBqGtRL67aUQ7yw6M8nNpsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYnwbS2EJeJw7IvXK1imW6gfHMeAMRcEOFSGPO+bCDPcsmqWUlfBieHD0pRWdaMPJDIdnf5i5Ad8RpCsO+zG9fqH5Bt6tx95q8EDXGMDNNBh56vLyj2YHce8G8p6B4nSQWAPKhwohxaB1t4dR1vfKNfZQR1PppbGb11WQtI1ZGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=uwOrt0vz; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="uwOrt0vz"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dNlg002k8zySY;
	Sat,  6 Dec 2025 13:01:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765018892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vTN9Dn9yGOjhxM6nU7j2G0l65VRQpeqXHSBW33SohQE=;
	b=uwOrt0vz+J2a3xXDDZKUZOBnMDyKarlvpOLK7E+JCRQPoGlIh5XRWAlgMVx9/qV47cq/Jn
	wEeZj3W9f1sIt+GFLEykGzhAFNlC4u51vTkEG3/SCT5IK40id/P1XzwqJRmrWImrGpY34E
	tvaVkNPQtXjuwhIx2EOlgmxmG2q/mdw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765018892;
	b=EiBYT+395PhB8h2sMbplOqmDD/mlr9sC9SLvOtHITMez7XyxTrSKYQZmpduypLm42K6una
	zb4xgyUT7ZKnIE1HXzhlWItLJ1OFL2EPPn51yq5gpQTP1EoK27nbm3qspiGCsUPcjXNBdK
	Ku0EtikXWHl7H1EUyoNM9DLbSAC+300=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765018892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vTN9Dn9yGOjhxM6nU7j2G0l65VRQpeqXHSBW33SohQE=;
	b=X67l04czK4jLzzBeOP/Y/WYHVk73b27CxY8RATNjtFWx2qHD08d6gj1ZhkmYpkN8pQ7G5d
	87opP6VXB49x0E/6KL7uQ/wf/sTTNEEayOrwcfeeYqZz3lFPMFkWD96KgccUbx/aBqrhEM
	ud+8WUU7P5X9yIhUCaASwtsmtXpTnlY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 00/11] Add local TMAS & GMAS servers
Date: Sat,  6 Dec 2025 13:01:16 +0200
Message-ID: <cover.1765018766.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse TMAS and GMAS features to expose from
MediaEndpoint::SupportedFeatures

Improve handling of changing TMAP & GMAP features: set the service
inactive when there is no Role set.  For GMAP, we must also remove the
feature chrc if a role is unset.

Also do some minor cleanup.

Pipewire side:
https://gitlab.freedesktop.org/pvir/pipewire/-/commits/tmap-features

Pauli Virtanen (11):
  lib: move VCS, TMAS, GMAS uuid strings to uuid.h
  shared/tester: check size before trying debug print
  shared/tmap, gmap: add macros for feature names and listing
  bap: use tmap/gmap macros for listing features
  shared/tmap: deactivate service if setting Role to 0
  shared/gmap: deactivate service or remove feature chrc if role removed
  test-tmap: test removing and adding role
  test-gmap: test removing, adding, and changing role
  media: parse SupportedFeatures from registered MediaEndpoints
  tmap: remove service on device remove
  gmap: remove service on device remove

 lib/bluetooth/uuid.h   |   3 +
 profiles/audio/bap.c   |  36 +++-------
 profiles/audio/gmap.c  |   2 +
 profiles/audio/media.c | 160 +++++++++++++++++++++++++++++++++++++++--
 profiles/audio/tmap.c  |   2 +
 profiles/audio/vcp.c   |   1 -
 src/shared/gmap.c      |  57 +++++++++++----
 src/shared/gmap.h      |  45 +++++++++++-
 src/shared/tester.c    |   2 +-
 src/shared/tmap.c      |  14 ++--
 src/shared/tmap.h      |  15 ++++
 unit/test-gmap.c       |  89 ++++++++++++++++-------
 unit/test-tmap.c       |  15 ++++
 13 files changed, 363 insertions(+), 78 deletions(-)

-- 
2.51.1

