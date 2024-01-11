Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2EA2837F
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HVMUdvQ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704980404;
	bh=jV1P8haOArA3cYjyOSXuH6XfZyVAAIyJr8yPYrWPBh0=;
	h=From:To:Subject:Date:From;
	b=HVMUdvQ0cQP4dV8FMWvePZ3wqYH8hpVQtNEtVt1alnAslH05SLYvwA+Uinqmvh1ax
	 53KnpeD8xe+iaSZVglzlfp0pBZxOUKXXCPpBPJWg+Vqzzw3xbJn90clJOT0ZbBhhgA
	 v2sGl/ZSRWAzbygPRmf4XvS7cZjvjUBrAxXhG5ZXOoxhCZ6vP+/yh1cmT6lWXAFjD/
	 0xbjktZj/ZZn2ZNLBSe8vS7BjlrGjy4efgCxMFBQO3/9Z7TKhT4wDDdFQuTa2kcRpa
	 WKvfpuY4pDPFwlQxN/BoHz1ot290O4kRtb6wJmUF+QKyG4ZVCEil7UWBg+KvNdHOji
	 whjteucDZyVvg==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F30CC3780894
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 13:40:03 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 0/2] Fix gatt-db munmap_chunk invalid pointer
Date: Thu, 11 Jan 2024 14:39:53 +0100
Message-Id: <20240111133955.65686-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

PTS test GATT/CL/GAD/BV-03-C published a service starting at handle 0xfffd
and ending at 0xffff.
This resets the next_handle to 0 in gatt_db_insert_service() instead of
setting it to 0x10000. Other services are added later.
This could end-up by a crash in db_hash_update() if not enough space has
been allocated for hash.iov and some entries are overwritten.

Next_handle can be replaced by a last_handle variable which will not loop
over. This can be replaced by queue_peek_tail() and computing the value,
but keeping last_handle will avoid this sort of lookup.

Add a unit test to check regression.

v1 -> v2: Replace next_handle by last_handle
          Check empty db using gatt_db_isempty(db) instead of
            next_handle == 0
          Add robustness unit test to check that gatt_db_get_hash()
            doesn't crash
v2 -> v3: Fix line length checkpatch errors
v3 -> v4: Update commit comment to explain reason for keeping last_handle
          Split unit test to its own commit
          Rephrase db setup comment in unit test

Frédéric Danis (2):
  shared/gatt-db: Fix munmap_chunk invalid pointer
  unit/test-gatt: Add unordered setup db test

 src/shared/gatt-db.c | 19 ++++++------
 unit/test-gatt.c     | 73 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 10 deletions(-)

-- 
2.34.1

