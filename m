Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9623F48165C
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043583; cv=none; b=jvbghdGsfa3e+Umogt9HxsaYDgreUkcXc6QFp9i86brP7fFF4OQiWQamGCIM8IvszwNSvwxkZ0WtS1wHIE3B8IZvD4A2/alt85z2fobqX2JJhQCuKY150GAtvvTi2+nu1FjBHHWN73Li0rZv50LYKRK1EYkjP7pRp9pPAwjd8c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043583; c=relaxed/simple;
	bh=cFTNBNxZCQsFs6cQj6bgY3ayOVb/Bro31F+NzxgXqGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZshRKqgKvE0Z4ZwOdqHikkUh/6qBJ0DCGWoQrSe37dKGY5E9TjdXZRAYdQUyckaMMwqPtzyW3U8AA2oOnYY8dUNvwR7hogx7uiWn1WLUtbwE0Iz8fhZ/OtJTcKehN6msF0i7BGGHSOKTcIHHP5+JiH5t64KmSv1FUHU2F1s+cu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDKx7H66; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDKx7H66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789043580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qi0iMJdk6ujIdjzYq5AskcwA+qNgTXiPT5rTXwXCVjY=;
	b=UDKx7H66kbeVm0hujQ4zwfKn6axUEqAVeM+naVUXLzV6BLfKcxzXzUpcAr6PDvkChRw3ot
	80E+XsUCf0TXBKgil81xLvUua0l/2FP8ZYCR8aM1UHidE1y/EtVh6xpw5feKe1rahp7iNM
	XgZaHQoxISZ2RD3FKggY6JkdFmfyS1M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-oJmSpFahMGOZOXBCcZamWg-1; Thu,
 10 Sep 2026 08:32:58 -0400
X-MC-Unique: oJmSpFahMGOZOXBCcZamWg-1
X-Mimecast-MFC-AGG-ID: oJmSpFahMGOZOXBCcZamWg_1789043577
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C5EB195420D;
	Thu, 10 Sep 2026 12:32:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A0D21800446;
	Thu, 10 Sep 2026 12:32:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: SMP: Zeroize raw key data on the stack in smp_e()
Date: Thu, 10 Sep 2026 14:32:54 +0200
Message-ID: <20260910123254.408963-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

smp_e() already clears the AES key in its "struct aes_enckey aes"
on the stack before leaving the function - but the very same
information is also available as raw key data in the tmp[] array,
so this should get cleared, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 net/bluetooth/smp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6091c47cb0028..637bf134dfbd9 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -366,7 +366,7 @@ static int smp_e(const u8 *k, u8 *r)
 	err = aes_prepareenckey(&aes, tmp, 16);
 	if (err) {
 		BT_ERR("cipher setkey failed: %d", err);
-		return err;
+		goto out_clear;
 	}
 
 	/* Most significant octet of plaintextData corresponds to data[0] */
@@ -379,6 +379,8 @@ static int smp_e(const u8 *k, u8 *r)
 
 	SMP_DBG("r %16phN", r);
 
+out_clear:
+	memzero_explicit(tmp, sizeof(tmp));
 	memzero_explicit(&aes, sizeof(aes));
 	return err;
 }
-- 
2.55.0

