Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB842F5460
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473414; cv=none; b=RVgQUVChPlIzk1nGvshQt+Do1X0HjS0JwAHlqWXtR+VAttB+jKAV2693vPBrrxRY3xt1hs4N/FOmPc2EER/Ju3ZXn/6wSM0E6opfS+irT8rCP2hq6BrUzXVBf04wxpKLCwquWcWUqDraxyrSZpu9Z4a20C0C5651S4OlzmdU2Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473414; c=relaxed/simple;
	bh=y1ebhXQshilV4Q3ycoOro05ND0OGgLvp9P/TKKZTrFc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eHe625YvKl/v/YsqpDDkL0Wrfmjaiw1rT7+uNlUw6EKJwICjZ5FRjYvqgw0M6RxqjEtvOdeqo1534fXZL9KOILdYlDuTJjCxJ3VP+2wOaXvjOWqwdvAYtX0wwxJVzSaq4zKq7J5DCDPBnJ68zkYU/GCaSNCQuvP+ujK3X/vNlmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAMfyYgg; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAMfyYgg"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4e9a7b4a412so2988948137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jul 2025 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751473410; x=1752078210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tGadUCVwNNT8WE0o5GTKQ9Wt3rpRzQNy0qwMnAN7g8U=;
        b=aAMfyYggYwU9wV5XEwvIKg9419jjSo7EUIITrHDap7WzaywL56bd3SKSn76F5fWduk
         ssYTgezg4T17D73mr2bs8IDvxL7q30RAN+fLdtePlpNgz9V/321AvU0r6f6V3G5k37bn
         dgqEw8b9r+kvbSK7PLtHQAYmXftfMJtzVxVuHPFKqmUEP8RhU5zwWYEtzaJA03Oj++W0
         /zGcG58Jg+9H/7xDLNUguaEI0bbPTBUWwYPHGg78MIQWXk5ewGd326Brj1HsdbnvMjvP
         jfrrgSe4P9Q8TGMnLN6tDX1s/ah3V1Q8z6bUM3AlM+a9QdxlkqHWl2QBr4tdM1gETkUY
         DprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751473410; x=1752078210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGadUCVwNNT8WE0o5GTKQ9Wt3rpRzQNy0qwMnAN7g8U=;
        b=ImGyIar6YRkNcxtYGxSlbHNv02xX5cX4ZeKJlJ55/spJCVidGYy2YhM+vdenYag2OJ
         y/KvuO1a8fTbwO8G0O2BRHCL0ndYFk4UE1X0nyeof8bxrUXPS4CsP3lTNYGdTy5Rlwyu
         LITqk8BRxpgy4Uqvibx5vfOL4X8v73Rtw3MOrUGs24/7nwOBWuJobpdeGoCqFy6espDp
         QGx0uZCM7ndJaN7UVANKBpdT+wvYYALANOtn8dhmrsCLNOj3dGLETXhXWQnzG01qMhzu
         dag7lPHYiEFiIJu+B2PNXg72BNN1ttTzq+begAeCBYqq9PZ6rw3VVq3fJwsrE3iy8qt0
         NdNA==
X-Gm-Message-State: AOJu0Yz9kfFCkYXSOoQN09ZYsMBKxljA6qGnXHlFU9REHjbcdFkLfZQk
	d4PtplnlVXO6Rcl/f45I+TNTZvjudSwFcbTQ85ut3PAbfD0hKHJAZa9vnCx0BwFYaGQ=
X-Gm-Gg: ASbGnctBFchw+qbZjrPujZabmZ+O6MR3ECdLe5VIfDuG6JIhCKclsekFW2aagTcEtdI
	QwgOYbQQjQWewIMEziGdqG/K+pINXlJJi2qe7XAPKp9y2xLj6Qh9VfrSrulcbUBe7I6073eku/N
	pSlgY17Ncp4es0no2/pzzkg/aXSFAeuHxbzvWPiAa6KEHy1P/g8C0ec/YSHD9cU8drmmUoYH0Fs
	NFcT4RN6xoU2ORuurj8nz1aG8aZcOWFXhaBZpA3HTMECe6AIIM9lDpMFlaw4YoKrf814Uu1vT/j
	eZggBk2eE2I4D7EAQOaShktqPN5/50EfaKdq5bHyZbB5QmCgmveqgHQbqMYu9MmJrXFs1mOVCV+
	zOfEIN0VynYuGZzDGK0/jN+EomffYu7Y=
X-Google-Smtp-Source: AGHT+IHAuVGfXpb+P/WpE9VpqbYd5miAz6jHxichuVcJYK7VlunEHOmB7iC8DBSBy87fwsQMHsBx9A==
X-Received: by 2002:a05:6102:2c06:b0:4e5:f673:7da4 with SMTP id ada2fe7eead31-4f16110a759mr2393868137.8.1751473409880;
        Wed, 02 Jul 2025 09:23:29 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4ee4c7e774csm1932811137.8.2025.07.02.09.23.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:23:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_core: Remove check of BDADDR_ANY in hci_conn_hash_lookup_big_state
Date: Wed,  2 Jul 2025 12:23:26 -0400
Message-ID: <20250702162326.1373840-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The check for destination to be BDADDR_ANY is no longer necessary with
the introduction of BIS_LINK.

Fixes: 23205562ffc8 ("Bluetooth: separate CIS_LINK and BIS_LINK link types")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b47c74080b9e..4342faf43484 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1350,8 +1350,7 @@ hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16 state)
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != BIS_LINK || bacmp(&c->dst, BDADDR_ANY) ||
-		    c->state != state)
+		if (c->type != BIS_LINK || c->state != state)
 			continue;
 
 		if (handle == c->iso_qos.bcast.big) {
-- 
2.49.0

