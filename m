Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3D75349D5
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889055; cv=none; b=oqB11di+mHutuWQf7kyjiu+2QjiWStVDXtgUx6/7TXE07PLKxMZStnK1COeHTw1+OwzMXaXPO1VGj/3U3yEyPmqGx6cFqAvaNXAJBIMyM9qX2ZGINwIZgeRO1QHzjGG2e2PZ24NUzoJvWxVE6SmPSwIE+kGd0Ur34CIs5QXiezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889055; c=relaxed/simple;
	bh=5ULnzBgz+HZtBkQhgUVKE9M2B2Uufb8BFdMV5IEzfOM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqjX7U0YbL+f3qjyI8jtr4PeSaSohQcmRWHtW7oCWkgQsdFiEVNl5dwKmYlX+FGiAa++cucmSQuxGta0BRM1rxwhm6JegKW1Cn+NG3I7WwQjAybtZsNWISI3EzektkxLjOVAOx2/8kMo2l4HxiazrJ2XOUQFzebsmHJe4ugbJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mpycO26R; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mpycO26R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790889042;
	bh=5ULnzBgz+HZtBkQhgUVKE9M2B2Uufb8BFdMV5IEzfOM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mpycO26RvSkS9nXWjiedjW2VcjQnGvfH/KUcqa5sGg4SAwKULhjUxoTv9vVWBs24K
	 P1blFYP/CyFSn07pds+Uju6NApfatuzWPAp13vSFbaBqLuWp+n9JFiyMjtClJEwG2G
	 L8YPmR8IDk+1b0WHVcG6tIJ0gJjv3qDdSWyfcLUs6QP2F8e8Rt5kaUcyz5Whp2StHY
	 1a08tLiOV41t/Z9sVlW6NNUGfqs4IcN2SrM6/c472LtbgoGjcPmi6Cd9XwBBE5EbvI
	 FMaK+5Q4m1YaOvRgoo0rOi196PwNO0U8WWP/jYIgg1fd/AZQGT3TIQp6TC2YN7aY2x
	 m/AurSTJSfT7g==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AA2DB17E089A
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 23:10:42 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 06/12] shared/hfp: Add send tones support
Date: Thu,  1 Oct 2026 23:10:30 +0200
Message-ID: <20261001211036.1760396-7-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001211036.1760396-1-frederic.danis@collabora.com>
References: <20261001211036.1760396-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis.oss@gmail.com>

---
 src/shared/hfp.c | 18 ++++++++++++++++++
 src/shared/hfp.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index f9fa53ae4..dffad6fee 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -3017,6 +3017,24 @@ bool hfp_hf_hangup_all(struct hfp_hf *hfp,
 	return true;
 }
 
+bool hfp_hf_send_tones(struct hfp_hf *hfp, const char *tones,
+				hfp_response_func_t resp_cb,
+				void *user_data)
+{
+	if (!hfp)
+		return false;
+
+	DBG(hfp, "");
+
+	if (!queue_find(hfp->calls, call_active_match, NULL)) {
+		DBG(hfp, "hf: No active call to send tones");
+		return false;
+	}
+
+	return hfp_hf_send_command(hfp, resp_cb, user_data, "AT+VTS=%s",
+								tones);
+}
+
 bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
 				hfp_response_func_t resp_cb,
 				void *user_data)
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 77ada40b6..11610018e 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -261,6 +261,9 @@ bool hfp_hf_swap_calls(struct hfp_hf *hfp,
 bool hfp_hf_hangup_all(struct hfp_hf *hfp,
 				hfp_response_func_t resp_cb,
 				void *user_data);
+bool hfp_hf_send_tones(struct hfp_hf *hfp, const char *tones,
+				hfp_response_func_t resp_cb,
+				void *user_data);
 bool hfp_hf_call_answer(struct hfp_hf *hfp, uint id,
 				hfp_response_func_t resp_cb,
 				void *user_data);
-- 
2.43.0

