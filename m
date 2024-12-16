Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DDB6F2F2
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374784; cv=none; b=oKGrWqrJ7JWHu64jhcWJcXCig/3dH9Cdo/plwiqacbr63UdRj5KG7Y8j46jt7FYj9Kb/Ky5ZNpWC07BGRBT2eXxGQkT7FnO4mNUSINNraw70KQu56NE2bgZ1jdNt44rhjxLPrgaVzXi4t+8UJwSinFiMfRwXpc6wGET0vWpVi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374784; c=relaxed/simple;
	bh=R61vrVbfWfAizz08oLCxrVE34q9pAkUmZ0k/IO7xPiQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bE9rJi8nqHitXURa+CHlj6/GSAOPaEay1XHetPUgmx0M2h8/9Z3tA7UbG/eejKj3S5NHxb6cmcRSUfS4e1WUNMrNi9szo3uKEd+7lHq9FoNrA2vS8bAnKm++2hwvWH79vvncqHkWPcQyNnO37G4ahmqGLKPMhoMjncuW2DzXdQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J9i+Lwmk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J9i+Lwmk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734374779;
	bh=R61vrVbfWfAizz08oLCxrVE34q9pAkUmZ0k/IO7xPiQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=J9i+Lwmk2i1lgHXPf0b7Kyo6GWJNZgGNEemHoyGui0Txufjb4ULubhPPhEI/x5RDt
	 HyCxAmV8hm3lpzpq57M+f2uyOiakftAnnzoAy7RDyeLhA+nH0CVx/PXqTp0GSmkMji
	 yhYzXo/KkHRgZqf0pajjP+raHVgpJUSEhKEuARK/SfV5O4F3cjABrL3FcUmWRYL4Dh
	 mdEvbMa2tNsLJFufVuRkJpOpWXNuTb/AubDgGKTWUxIOuaHohdVMzqxUFqQI9Urvbl
	 1qLS4s2LKaLFErKh3kcIC1y2lvAYhnQSwYD35fnGTNz+QyHiaIEcGT8TfnUm7QfYBk
	 5iSXl9+nHlW8g==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2B9F717E37EA
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 19:46:19 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] sco-tester: Add test for BT_VOICE_TRANSPARENT_16BIT constant
Date: Mon, 16 Dec 2024 19:46:13 +0100
Message-Id: <20241216184613.135538-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216184613.135538-1-frederic.danis@collabora.com>
References: <20241216184613.135538-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This test checks that BT_VOICE_TRANSPARENT_16BIT voice settings can
be set and get using [set|get]sockopt().
---
 tools/sco-tester.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index a56cb9153..6fc26b7af 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -527,6 +527,34 @@ static void test_setsockopt(const void *test_data)
 		goto end;
 	}
 
+	memset(&voice, 0, sizeof(voice));
+	voice.setting = BT_VOICE_TRANSPARENT_16BIT;
+
+	err = setsockopt(sk, SOL_BLUETOOTH, BT_VOICE, &voice, sizeof(voice));
+	if (err < 0) {
+		tester_warn("Can't set socket option : %s (%d)",
+							strerror(errno), errno);
+		tester_test_failed();
+		goto end;
+	}
+
+	len = sizeof(voice);
+	memset(&voice, 0, len);
+
+	err = getsockopt(sk, SOL_BLUETOOTH, BT_VOICE, &voice, &len);
+	if (err < 0) {
+		tester_warn("Can't get socket option : %s (%d)",
+							strerror(errno), errno);
+		tester_test_failed();
+		goto end;
+	}
+
+	if (voice.setting != BT_VOICE_TRANSPARENT_16BIT) {
+		tester_warn("Invalid voice setting");
+		tester_test_failed();
+		goto end;
+	}
+
 	memset(&voice, 0, sizeof(voice));
 	voice.setting = BT_VOICE_TRANSPARENT;
 
-- 
2.34.1

