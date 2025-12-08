Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B931B2EF665
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765190594; cv=none; b=L7/dm2qVGIGu/Kh+GFFfGKBAn7kC0HZQBN27IL/XO3y3gBp42E/q21t2T9NjI+Qfbh/2o4CmWplUeTfuLbH0m1u+LEHyL+wlBqDJZqPA5hT8DySOZwjZP2tKw6YO9qON2vdF8dBgScTT9LQlp3sUh+xf0fA6qjTU9e75FNUJYos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765190594; c=relaxed/simple;
	bh=gzC1xg0W5zPi74fqJhw7sO48YBVeZ1ePhptHp9YxF0I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PUxGzZ5iQmZ3SZvQbKrhnlmwFaANfHawP9jX+UNDpAdrQno2qqbhjKooIxSHw3/YHHiq+eA5WbgISaAA1Mje6/u7C/bAMMkc5pKK+Cr/DKBCWLkQduniKSH+4MuLNjzFGvbkyV8KClYIVPYE1PYSHKXJ+WQ8XKadWCaCr6OznSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kAhUM46z; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kAhUM46z"
Received: from github.com (hubbernetes-node-004ce96.ac4-iad.github.net [10.52.182.41])
	by smtp.github.com (Postfix) with ESMTPA id A1CAD6401F1
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 02:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765190591;
	bh=K0tsIbFy7IPN5bF1C1ouFktg5VYbAUpZ1ymOsbDKGCU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kAhUM46z5xCgV4212XmnRc4bA9fSH5KntTLUxD/p9HgMtmN0W6NYpltidTZ62gmTH
	 ftsNFUs3q2Ijsn7nH8tOD9T62tq6+x8lxmth2dNa8JWwHO9imQ6WtOAMLj1wL0Mklu
	 JP3IChXbbVOdKGBzUGuRBBLxDitZ2K1VhU+ClP4E=
Date: Mon, 08 Dec 2025 02:43:11 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031333/000000-c8dc51@github.com>
Subject: [bluez/bluez] c8dc51: gatt-client:Implement error handling for
 DB_OUT_OF...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1031333
  Home:   https://github.com/bluez/bluez
  Commit: c8dc5108f66464da7423b7d99f4766f6d5ef9231
      https://github.com/bluez/bluez/commit/c8dc5108f66464da7423b7d99f4766f6d5ef9231
  Author: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  gatt-client:Implement error handling for DB_OUT_OF_SYNC in GATT caching.

Add automatic DB re-discovery on receiving BT_ATT_ERROR_DB_OUT_OF_SYNC
error code from ATT operations. This ensures the local GATT database
stays synchronized with the remote device by triggering a full service
discovery (handles 0x0001-0xffff) when the database becomes out of sync.

The process_db_out_of_sync() function is now called in all ATT error
response handlers (read_multiple, read_long, write, execute_write,
prepare_write, and prep_write callbacks) to handle this error condition
consistently.

Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
