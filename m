Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641072AD00
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791751231; cv=pass; b=f+u0FCZR4TD76IZPhQhNh+nBuQDg/92qNVI3nAFbsgY2ynp1CdZavFZ1TAa68wPsD/K3YRCDM+lxRfp8UDMjTaPdK3QkivBoAPBz9QYOrz5a65885MFr5AvMiGSojzGpp4xVMkqn6+mKnqgdTKknBv+t8HycnnobxRohZxiwwOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791751231; c=relaxed/simple;
	bh=nYoOZ6jN1MupPKRljh7ECkk1V9SXSI/FXONXjpLOtX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dYIqCVX1ngA/66f8whU5g6rkMIafdVTFMLHErBWYnSKSlvYVzcEy9g/GQdTvWzPPJpg6ZnGmXx2zNE2waQkxK44qOVcla6HXZS92Ow0P+0MiY1/yECuw5h6NSoHCzu4X2gX+oIBb/rN0x+BaZ0qadBHiyXGAvh1SgVkLU0p17J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=alMbDzPh; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="alMbDzPh"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4j2stF4lB7zyVR;
	Sun, 11 Oct 2026 23:40:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791751221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=flpJGRZb8BJWkTRJ75TMfL2XM5gPKJaMpcudd94es0E=;
	b=alMbDzPhnBDv6sXFA3nOcJc90qFTBDtN0mk0N3aCQl/Jwu9cuwIsx06i0vNgu+Y/iAbKKQ
	d2CF9eZJ2l4mFktQ7WKhp5Q4X/LsU+4wvu+N0QNk9s2EmHycGSVziJMoUASDCxm3hN4XF5
	twtJ8y7hMnkw9X76a9FiXFU53mWyovY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791751221;
	b=NRtI4kgjiSkUK9TRsLBNWU4Huf5a0p6nWudYBCJr8E9AyjGK0lb1Gi1DAzOOSXBj9nETUD
	HINpZvDajU8NeP4t6thuY8zobslP/9ECX/R5j/GIweuYoWk9YkYblVUurO9Q8zc9WxB9uY
	DNnca7IGN9AtNPGkBT9Zc8TFD8fTINQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791751221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=flpJGRZb8BJWkTRJ75TMfL2XM5gPKJaMpcudd94es0E=;
	b=Fthvc9cJyYeGFJmxcaV/MvAOlRdcg6clgxJ2qjWipZljIfPYuFb61OYPv/Pc+CifyySXeQ
	rMjUhGEOb44yDeuiIBDfR2KNKPu4e7WLTPDi42535nH7fiBlAD7IbpvQpEqnZUOL74IZH/
	sjLX9oNWiiaCsgqJufrAH755D5dJmFo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/5] bass: wait for PAST listener readiness
Date: Sun, 11 Oct 2026 23:40:14 +0300
Message-ID: <cover.1791750393.git.pav@iki.fi>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The other kernel patch series adds POLLOUT as notification when after
listen() PAST is ready to receive.

Document this ISO socket uAPI and add tests.

Use it in profiles/audio/bass.c to indicate PAST reception readiness
only after kernel indicates so.

Fixes test_bass_past_transport_* sporadic failures.

Pauli Virtanen (5):
  iso-tester: remove IO sources during teardown
  lib: add BT_ISO_PAST_POLLOUT socket option
  tools: iso-tester: test PAST listener readiness
  doc: iso: document ISO PAST listener readiness
  bass: wait for PAST listener readiness

 doc/iso-protocol.rst      |  81 ++++++++++++++-
 lib/bluetooth/bluetooth.h |   2 +
 profiles/audio/bass.c     |  66 ++++++++++--
 tools/iso-tester.c        | 212 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 348 insertions(+), 13 deletions(-)

-- 
2.56.0

