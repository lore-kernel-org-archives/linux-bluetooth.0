Received: from cvsmtppost106.wmail.worksmobile.com (cvsmtppost106.wmail.worksmobile.com [125.209.209.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A4225A38
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.209.209.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717258; cv=none; b=AydfAxNwnPaUMUa67lBWhVXiXSqcAgbAD/qaAJ7R5kKNMMjDDmuKOpG/q4bVumuM/U2+hHixQDSa794BpgULguiKBP1JNZ7NKVIvb2gK/VsvptOjpAjYHiz/RoftZ0TY1TuDhEQJNz0ns3iAs6T6q3zSfdOA3BeGN6rWDip4gsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717258; c=relaxed/simple;
	bh=GQ7bPS8h14dBDjvfqkuzhy0JivyTKixuTM5YQP9RLtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XYp7EGmXFg6+iHMu1LkfsoYhYJFKeZxGlSzTWmF584R/Gx9b+DRoZhH5vZS4GyNOWBxE5lgQfzunqljSOtzlOe12c4PjnJ45MZmP59XfoAbYZWQ6fa/kwmNWapba80xKPVtqSu5fmtOWlHVPsd4nWXwvW372pF0Vcj4a3J7+sGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b=tn6aNhG5; dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=Kpsy4VGF; arc=none smtp.client-ip=125.209.209.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b="tn6aNhG5";
	dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="Kpsy4VGF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1783715431;
	bh=GQ7bPS8h14dBDjvfqkuzhy0JivyTKixuTM5YQP9RLtk=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=tn6aNhG5yCTzlhx9kFa2VrTHEoODr784I2UBsZkWrQXbLoTCWNK6Lg/hUIUQKajx3
	 yGEBCIAa5ihkvfrLzs0cuC881oL9TCA67DmGo3UghMBwFu3UX/ylZLIDJnaXNL6P7l
	 1Apm2tDBL64vgG6sg16S9pHO9lHr8uWTZRb2XUTNGIjfop4VlCJrJtN/dkXA2RHzYi
	 7048H9U0aS/tPU2KCyK67HNqvNNeVCVKXkKA6u0HhAcGc0rYgq2lTQIA3qouiUR0IA
	 /LeEEXcEbW+8eEL7Q0WonFQJgcQs3UZoTouA/U+U2iLm8EcPvCpEj3uEOtcqodqQYd
	 w/xMldfTPAF8A==
Received: from cvsendbo006.wmail ([10.112.11.111])
  by cvsmtppost106.wmail.worksmobile.com with ESMTP id uOj++KDUSgiEf0y-7ShAqA
  for <linux-bluetooth@vger.kernel.org>;
  Fri, 10 Jul 2026 20:30:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1783715431;
	bh=GQ7bPS8h14dBDjvfqkuzhy0JivyTKixuTM5YQP9RLtk=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=Kpsy4VGFFH34HsEw/z15ZXuzBGoMvKvXeLSeW0BqNk5Rn7C7oVB/mlhjAx2szRh1g
	 zwQrmNnNsr6hOa3YfytwodfSLoxSQS5foOPne/xuv6oJIwKj2TzvB1dnzCtXlapEib
	 tljjmKnx+b2Z//+0VNhQIks2IS7roB1ZwHqjpWJQ=
X-Session-ID: JiYleQ0vRZOPdjtO4mn9Ng
X-Works-Send-Opt: 5sn/KqgmKAKmKAFYFqMXKAK/FqMXjAumKAgmKxEmFxudKoMqKNmmjA3YKxb9Fob/FxMqFNwYjAg=
X-Works-Smtp-Source: ImY/FoK/FqJZ+HmwKqgq+6E=
Received: from s2lab05.. ([163.152.163.130])
  by jvnsmtp402.gwmail.worksmobile.com with ESMTP id JiYleQ0vRZOPdjtO4mn9Ng
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Fri, 10 Jul 2026 20:30:31 -0000
From: Jang Ingyu <ingyujang25@korea.ac.kr>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: Drop dead !skb check in btintel_read_version()
Date: Sat, 11 Jul 2026 05:30:29 +0900
Message-Id: <20260710203029.2423768-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ingyu Jang <ingyujang25@korea.ac.kr>

__hci_cmd_sync() returns either an ERR_PTR or a valid non-NULL skb;
its internal NULL cases are converted to ERR_PTR(-ENODATA) before
return (net/bluetooth/hci_sync.c). After the preceding IS_ERR(skb)
filter, skb is guaranteed to be a valid non-NULL pointer, so the
!skb disjunct in the subsequent length check never triggers.

Drop the dead !skb subexpression; the skb->len size mismatch check
remains the real guard.

Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5e9cac090bd8f..5361c1a8c8452 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -460,7 +460,7 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 		return PTR_ERR(skb);
 	}
 
-	if (!skb || skb->len != sizeof(*ver)) {
+	if (skb->len != sizeof(*ver)) {
 		bt_dev_err(hdev, "Intel version event size mismatch");
 		kfree_skb(skb);
 		return -EILSEQ;
-- 
2.34.1

