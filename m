Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F4F3AEB26
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156728; cv=none; b=DXHYgxcP7u++Thoij5B0crCSg/XNXZWEe7Io64GyrN3nxlKQurDKsZhisE4m7bzCM7ti1pA/PfslWqS/d0uZnxersNugSDtIB5bqaCdQwCMxTfI6RQ5EWHL98fcioATDjiegMtiBz/3zxdpP6rbQFkgNNtNB8Wplm8gok9qgUvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156728; c=relaxed/simple;
	bh=7FlAotYxF/pAR51SdUWgRlQzlO9JcPbq4/y8gpI67io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BN3f74CKWOyoRaYWW+nfU4+IujjM8g+0X8f6LJvSM66xIm3CXWcyC0zr6eLAaLYRwR3fPMzUVoIM8fDcshNjLqprlP4A1vIBbyJidHKHNHE/yIeG0YQu6YEmZOZP70kDF7ps69GraX0gygSsjkIEQPSLSOXsiv6rY3rfEzCi2MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C40/ubPy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C40/ubPy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788156719;
	bh=7FlAotYxF/pAR51SdUWgRlQzlO9JcPbq4/y8gpI67io=;
	h=From:To:Cc:Subject:Date:From;
	b=C40/ubPybTfzork/nDAaFdL/2pV0O39+ebd4XEJ/uRRZO7jeIYKEMn5Z2pZ8QX1Eu
	 bC+LK1F2ZoJhEUejc56wHJinOt1nVEsJ9AgyJlpXpD1fTh8sdbBgIT3oDnJuADKlf0
	 BQTyOgHnZpEu6m8ZoZ2qvmONr2G8GrJWkGzfe3oVTbMDdW3ArRyyrYDXt5T98Avnp2
	 kH4d2cBPKrM1KI7VAFY5/rSk8bLPFymVXF62t02eiM+CQHG8dqnmpRnHVjZ5zRcdhR
	 PIpgnLCqyqeDVWxh8ahwgH5K8mjTRtVUawCsgd6GxDaFJVV8i2w0BEqkIqWKDi8RvU
	 CEEtnzuTd0VyQ==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8971A17E04BF;
	Mon, 31 Aug 2026 08:11:58 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghu447 <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH 0/3] Add MCS fast seek and track position write
Date: Mon, 31 Aug 2026 11:41:41 +0530
Message-ID: <20260831061144.7767-1-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches are needed to make MCS PTS tests pass.

raghavendra (3):
  profiles/audio: Support MCS fast seeking
  profiles/audio: Support MCS track position writes
  shared/mcp: Notify unsupported RFU opcodes

 profiles/audio/mcp.c   | 63 ++++++++++++++++++++++++++++++++++++++++--
 profiles/audio/media.c | 27 ++++++++++++++++++
 profiles/audio/media.h |  1 +
 src/shared/mcp.c       |  4 ++-
 unit/test-mcp.c        | 14 ++++++++++
 5 files changed, 106 insertions(+), 3 deletions(-)

