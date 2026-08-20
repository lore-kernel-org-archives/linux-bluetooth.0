Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BD3E5581
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230699; cv=none; b=f2+RxpETzm4aU87V3OHScQOKBnq54/Z66O0SyMt+17zN0ZxSabnBzxi4eRN0/G+ZZmEpcuw8oaB4Xmuib9I3AAMGaoMJBPYCeGer0trl0e8ovNL8bADdRdrtZkwyHGJn01aljLRsEVdIYklmiDfLu+ONIzWn00jLWhDdbe5lCJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230699; c=relaxed/simple;
	bh=F5rq0CqaD/lPPYF5BYi4zNLM+xq81c0JB5CkpKteoIw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kv0YqyLA5O74tScm7byHytwq5Lm0ReeM9uX6JTHi5tGT+pa0WmbLyX5airBiKZJgDnNNt4s+vzLqPbnQ4gDC137YsGqmUSDfROxvfHx+lIT/9TwxaJSU7XJtpvf1OTj8iBVwQp4b2LJYXtnsCBbeLLMY6tiEyfYjF4CjvWPBhBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RSg6BdAo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RSg6BdAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787230693;
	bh=F5rq0CqaD/lPPYF5BYi4zNLM+xq81c0JB5CkpKteoIw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RSg6BdAoPuV5F02nfg4mkYYayz/uC368PBjmEC6PjgDHPmzroLB80e/IGbS9YWOXv
	 C5DyqPyoXDrOwAwEGGkVidSryfFfQTckp3PvexUD0DHjomTzrtbt2bzlJhGWYs+CuZ
	 3x3Cz0R+67eVzuvih0sDG1bQoS1MlNXYMmJR1OmiYRr84tAphO7SJufN1CL4uKfbqT
	 zVoQt3DRNK8KVuUXxQQnmqa/9FZ4N/EMnvfmqAAWnzydrrKd+EZN5T3eQ3lX9cV/4T
	 MjgaqLgyTfT9k5PK8KebdHc1u6HepfyvwSx2d/pqlf+FECi/LaZYG1XKwq2Elohdey
	 e5QiWIje+DKPw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5EDAD17E0D69
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 14:58:13 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/6] client: Display SecurityLevel in device info
Date: Thu, 20 Aug 2026 14:58:06 +0200
Message-ID: <20260820125806.1253547-7-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820125806.1253547-1-frederic.danis@collabora.com>
References: <20260820125806.1253547-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 client/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/client/main.c b/client/main.c
index 069e20485..0531c9de1 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1918,6 +1918,8 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "WakeAllowed");
 	print_property(proxy, "LegacyPairing");
 	print_property(proxy, "CablePairing");
+	print_property(proxy, "SecurityLevel");
+	print_property(proxy, "EncryptionType");
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
 	print_property(proxy, "ManufacturerData");
-- 
2.43.0

