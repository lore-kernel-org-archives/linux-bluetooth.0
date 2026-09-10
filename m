Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B59453FD37
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058910; cv=pass; b=YFx2e7dDqD3p0AY1UMVtYpYAgt9pPpdzyoTb1C9fV8pbusznQnFSY1KmSDC+j+JAQChcSP8OiwH2EFvzNRF9VeCvBzH8jOtbnBwPKRk/1BmNFAerGAPgW0VPAJyQ4u0JONvHOfCe/en1Q59SSLR5p1E57M6E5mm+9tUzoSDZohU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058910; c=relaxed/simple;
	bh=0G41SccU29ThK6JzXSpDBxCeRZXh7uUpd7KiyynpBbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jl/kbMulyAGkFTVKbglWJKcYw6MI6t7JPxjjA73sdr+RlDDtTMEeTA3mjlTToJ78LtCON+/z+47OrWmPmwjqltdePx3VtaSGotMyIyhaiCWI+PsDr2p95idWAv76HtPcS8uAp6HveqC++2pTQ0pab6BfrlWhncenWQfYpllNypQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=g2qfIOQ8; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="g2qfIOQ8"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hgkBg2F0szyZl;
	Thu, 10 Sep 2026 19:48:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789058891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2oELHq/VFKhnF+BdVxr1pi8s7AvFgYMeb8JXb/Kwc/4=;
	b=g2qfIOQ89IbVtsYJ17ByRyw/GO4mFlZb7CymTlY9D4xhmfM6zLi9wXgtS0e1rPwF2CsFZ4
	70O6UQgiTcRG3ggBeqSr3bkOGyUNI37RuBaBhhv0Tgl8YhwUbsp4Jez8Uv6OhqKeLnRNxH
	J9l1LNqlcCt3SsAssg/wEBuTxYaYRPk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789058891;
	b=ElT2VMiLtQ4KnlYKjqRr0Pa7sG9j9l77V/fI8od/mPXcf6ckSSBHl77QajSyOii3QwyMYe
	jzCZBL+HjRBFd5mmQeI0/hcPLDag+udikFAWQv3Ux6yTvdYNAaWh7wyUwjrGt0xJUuID4Y
	C+TR+sJqyank5RLLzIWCU5YEl0ZZzOM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789058891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2oELHq/VFKhnF+BdVxr1pi8s7AvFgYMeb8JXb/Kwc/4=;
	b=tSJyfvxlgbyOZhnfvVUaqdOuJ118qmX3B9O0j8TMgo6CEUDz1XAB40GYZxgiGia2bsVGQO
	rtu8DlsNJqb367OUDB4JNd7i0yRQhLinDv0pFT2SjHsAluSk/GViTDL2VsJanPgiXbiNaP
	xadvOZ7spHjeqzxmlyN+NxxloUbk3XI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/2] test-runner: use virtio-fs by default, functional test speedup
Date: Thu, 10 Sep 2026 19:48:05 +0300
Message-ID: <cover.1789058875.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use virtio-fs instead of 9p, which gives 3x reduction in CPU time for
functional tests:

Before:
$ time make check-functional
real    2m9,736s
user    1m29,570s
sys     0m32,715s

After:
$ time make check-functional
real    1m35,703s
user    0m28,938s
sys     0m7,453s

Wall clock improvement becomes more significant under CPU load.

Requires /usr/libexec/virtiofsd installed, and CONFIG_VIRTIO_FS=y in
kernel. Enable that option in tester configs.

If virtiofsd is not available, fall back to 9p as before.

Pauli Virtanen (2):
  doc: enable virtio-fs in tester kernel configs
  tools: test-runner: use virtiofsd for filesystem passthrough

 doc/ci.config       |   2 +
 doc/test-runner.rst |   3 +
 doc/tester.config   |   2 +
 tools/test-runner.c | 210 +++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 203 insertions(+), 14 deletions(-)

-- 
2.55.0

