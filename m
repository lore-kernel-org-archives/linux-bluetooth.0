Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D249EC5F
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342745; cv=none; b=XcS8umV3xc8PtvXR0rEyTdrZFAW9pWbAgxe+RYp5CAXoOW9i+LJ8h4wSuR0Te7Ai2jTjfQiu39w+nijDzfIODlFko55bj/vqwbNg1ycBU4CVmSC3M9dalMOJHerI1Z0hKsmjacZJfvpJlPoDNtMKmr9L86y/X+v765RGr971CJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342745; c=relaxed/simple;
	bh=6B4ynbXhoUl7TiJf6mtShB5ZL2W4HtfxWPE+bf50Ivw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsbCfW08YdJ3LbAMskHGWNUOVnp/tBkafdgSpBzul/9F9g+vQAUr8aW+szHpDoPxS1x18/lOf0lZmzI/G+Kx03Ts2Gun4YX2hlF6wr8qi25n+WW8ZCNG9Qxn6pOb+BzNN327lZvjdTkq6KFMHh1FPD3K0uYF7hzUjLDFB7/zmSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hXaGQ7KL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hXaGQ7KL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790342736;
	bh=6B4ynbXhoUl7TiJf6mtShB5ZL2W4HtfxWPE+bf50Ivw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hXaGQ7KLR5zKuKbblkoLIcWY3XXtEgUZcTdRJAfOezKxMw/eUTpCYQT1gnb3fGm6b
	 7vSIdTMqznYbgAwyT03XhMLvnm5+/r6Hbuj1jSvW8q+AmUUsIx+CEjUaGnoiekJ6Vv
	 teHk5dcNSH4oDe7qqw7y448Rx4b2tlHzDUwFtBEPYHR1eT5MOB9kTTuu4qJ7f7w8L7
	 BxwfhBISMqjukfHo4tefqnxFpfdbOaB4Kv0ro9SjTZvu9DifmP/TMgB9nKZLgUjxy2
	 tW8LT/dR5ZY7sCoHUJHhQS/1nSxVyCFzCVq0WqTdtbEsjskIyPkD+jnznMb8EarTuw
	 JfVGpY+ZxgeLQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 701FC17E0056
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:25:36 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/12] client/player: Add MediaEndpoints for HFP HF codecs
Date: Fri, 25 Sep 2026 15:25:19 +0200
Message-ID: <20260925132528.3361517-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925132528.3361517-1-frederic.danis@collabora.com>
References: <20260925132528.3361517-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis.oss@gmail.com>

Assisted-by: Claude:claude-sonnet-5
---
 client/player.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index ae2ce66f0..88221076c 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1363,6 +1363,18 @@ static const struct capabilities {
 				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 26,
 					240),
 				UTIL_IOV_INIT()),
+
+	/* SCO CVSD:
+	 */
+	CODEC_CAPABILITIES("hfp_ag/cvsd", HFP_AG_UUID, 1,
+				UTIL_IOV_INIT(),
+				UTIL_IOV_INIT()),
+
+	/* SCO mSBC:
+	 */
+	CODEC_CAPABILITIES("hfp_ag/msbc", HFP_AG_UUID, 2,
+				UTIL_IOV_INIT(),
+				UTIL_IOV_INIT()),
 };
 
 struct codec_preset {
@@ -3069,8 +3081,10 @@ static void endpoint_free(void *data)
 	if (ep->msg)
 		dbus_message_unref(ep->msg);
 
-	queue_destroy(ep->preset->custom, free);
-	ep->preset->custom = NULL;
+	if (ep->preset) {
+		queue_destroy(ep->preset->custom, free);
+		ep->preset->custom = NULL;
+	}
 
 	if (ep->codec == 0xff)
 		free(ep->preset);
-- 
2.43.0

