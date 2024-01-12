Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DBC6A349
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MjICnexj"
Received: from github.com (hubbernetes-node-e7db897.ash1-iad.github.net [10.56.157.37])
	by smtp.github.com (Postfix) with ESMTPA id 0E8291007A1
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 07:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1705073818;
	bh=mOxXBjzSTL+VKUy69i0T/mARjKkv6j4m89Pnx9dK3UI=;
	h=Date:From:To:Subject:From;
	b=MjICnexjdvj4rTCsCFIg54DLNyFJ68dwTt8jEBheI2FcuNFihZ4AG42mf7ktJtjBg
	 99YAwfhSMezY2a/TkcCmEiqSJmOt9LbLb9p6KLx2wnfHiK3/RevzR8XIzzBJ5hX441
	 b584K3T77Oh+Xach1psFcqDMrjZ6DhVRkhg51VSI=
Date: Fri, 12 Jan 2024 07:36:58 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c85546-ba5a1d@github.com>
Subject: [bluez/bluez] dacc69: shared/gatt-db: Fix munmap_chunk invalid
 pointer
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: dacc693732634365251328159d44d1dc42bd37c5
      https://github.com/bluez/bluez/commit/dacc693732634365251328159d44d=
1dc42bd37c5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-01-12 (Fri, 12 Jan 2024)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  shared/gatt-db: Fix munmap_chunk invalid pointer

PTS test GATT/CL/GAD/BV-03-C published a service starting at handle 0xfff=
d
and ending at 0xffff.
This resets the next_handle to 0 in gatt_db_insert_service() instead of
setting it to 0x10000. Other services are added later.
This could end-up by a crash in db_hash_update() if not enough space has
been allocated for hash.iov and some entries are overwritten.

Next_handle can be replaced by a last_handle variable which will not loop=

over. This can be replaced by queue_peek_tail() and computing the value,
but keeping last_handle will avoid this sort of lookup.


  Commit: ba5a1de8f8826ea55175c12a7b1122b145f350a1
      https://github.com/bluez/bluez/commit/ba5a1de8f8826ea55175c12a7b112=
2b145f350a1
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-01-12 (Fri, 12 Jan 2024)

  Changed paths:
    M unit/test-gatt.c

  Log Message:
  -----------
  unit/test-gatt: Add tail setup db test

Verify that gatt_db_get_hash() does not crash when services are added
to the tail end of the db.


Compare: https://github.com/bluez/bluez/compare/c85546cba715...ba5a1de8f8=
82
