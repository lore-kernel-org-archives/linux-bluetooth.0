Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE5628C036
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007861; cv=none; b=rXhpBfVtzGe8+RcHer/zs0bwbpvss8FAcYvYypFdWdwlF5nQqkG2KQ8JguHoNp8qGvR3YbGexFXmk5Op3WPe3J33/xT5xdbRIgu9rFQnCI3Z7CnoSzDpq7xVf7JSuA5DKMk7VlliXzuhijEEnvmslCNqHnriy/PgNWtSKu3eGi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007861; c=relaxed/simple;
	bh=wVdzjectZ+qR7BIFEIG4nF/re4NwpuIiUFuKzBwAw5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B68+VDctz4mYWKPyxrFeexcWfJpPBRgqifRyjJ9qbga8yk7hWu7y8MIPIvCNPkCI3vxDpTIGGNK5vbwiGQZuiqJGAs+s4/rn3hxvyQsVC0oNevUDi0bHuNHS7fisUP14DhIYPwH55qHCgl/aELSWYPB4fijK0/UolHELIpzlGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AWe7knS7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AWe7knS7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755007856;
	bh=wVdzjectZ+qR7BIFEIG4nF/re4NwpuIiUFuKzBwAw5M=;
	h=From:To:Cc:Subject:Date:From;
	b=AWe7knS7EX579lbQlwWKpXKhD6QPzGAU23iWEKDHPYxx2yNY8RoLgT+82nOx2jZMu
	 UzoEK4El90+J1KvOJj9nLCLHCX9e/LKUmztkV2j9yttpXvEwOSfZOhtjPAg24goeWg
	 /SiaeCTjrCZ75kvWBhkFCT36MCGgqDQ1N6CPchrdi1qp7axJFw5peAww5LberjrHF6
	 xiwb6l0WOy0CX4201JUJ+wzGQcsB9rn67xK3rc2NP+YzM6ER4i0cz3k9KdVNbY815p
	 kAzu8xBDKKL949+M/VBNEyqX9WeG8UaF/RnZKtTieFoyfvDD3jR0Ft38vTpcMT+hQ7
	 NG/MdLdH3cpew==
Received: from ryuzaki (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 44CA017E046C;
	Tue, 12 Aug 2025 16:10:56 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH 0/2] Bluetooth: hci_event: Fix connection state issues during suspend/resume
Date: Tue, 12 Aug 2025 16:10:26 +0200
Message-ID: <20250812141028.509783-1-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses connection state synchronization issues
between the Bluetooth controller and kernel during suspend/resume cycles.

The problem seems to be visible when using devices that very quickly try
to send multiple reconnect events without waiting enough for the host
to fully resume from suspend.

Fixes the issues reported in https://github.com/bluez/bluez/issues/1226.

Ludovico de Nittis (2):
  Bluetooth: hci_event: Treat UNKNOWN_CONN_ID on disconnect as success
  Bluetooth: hci_event: Mark connection as closed during suspend
    disconnect

 net/bluetooth/hci_event.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.50.1

