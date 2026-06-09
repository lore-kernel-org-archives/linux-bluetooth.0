Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A4433D509
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015026; cv=none; b=duRAx+BweCwzkmU8FcPwrqLhIqMa9d4nkPL9dlLxwFOXM5wacBzzMXEpSY1tMjmQVu+XjBebPDE5mrU/Iz2txNnb6U+vvGXTPNGfQeCjBDHa+wRpB76NLdKSeZRexNXIqXyXnPgmHmUpPPUzuNoI7WRdtN9SKO5OT+tO9XqRanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015026; c=relaxed/simple;
	bh=z6xXELvFyRbNAPwXDRoBaNswniZkJZxWaaKdrgLDFb0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwZnLrsw5SgCnm2KAs5ja+2DJUVBr+dhS0Gt2LV/Lt2lQM2JINu0RREqdYJGSoXaf/o+SZ72YnhuceQ6T4cGtVv7Ouev5ONGqZQ4nnCJdnGobdqyFzFMdUHhrjDSTwltEvV38roPXFfR9FP+bFDFI/PBHRL+VmGCDqC40zpoXP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 462F85816F4
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:58:53 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D22883EDD5
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:58:45 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 2/6] shared/util: Better type-checking in _steal_* commands
Date: Tue,  9 Jun 2026 15:50:54 +0200
Message-ID: <20260609135837.476561-3-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609135837.476561-1-hadess@hadess.net>
References: <20260609135837.476561-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTEVlSdXhFUvSV8QQx6yOrxge8LgLVsxPuUsLns/yksmkNx+qdDvLvza5bKGN8WNxSHwt+f8VbZ4lJPoURNdRMWp8SMuewEQUfgBMkY/jbgr+LyXuM7iW1giNJiHgNHw6TWCI3u/pWopj0uku4KXuEzF2U7Jkv7EHtBXrrJV7gBwCRlXQDiK2LO8ylQk6uzIFcjqpCrorpKwg3w0D6ojMjAneIde2+9Xgn2LOidAqfgBRNsXEa58H2+xUe5E0Ri8LlvlWBN+ajBkbQKIGVS8FIytq/3m1RxPUluCTzu51875p3iUUbERbtkhDOOaRjgxLdx7vcvY3Bj/fS1GlcpyS/+RZBFvIYzeI4pdIfm0MYEKd5RuIIwsUbWtR6cK60FWPULDDZWP+bf823vwBRl+zwokLPaWYDMMg31bY2mP0Qx3OpVFigxijpccMVOvsxGQeIF8rHEg/AwXN+PKyzbvfWsiQXj4T2IP9Lx4TGsmiubgx5FM1lmkY+9uE03WFh2DSC0pp77MITVSwYYbtynMsRAvN8tGnnmZagJ7U8hZXjLNAucOvrf5bieZ7bdRuuH5hiSFvMYXdA4p4CQ4H4NCYKzZKYw5ckslc8Trb2ScW6dEaIk2W/OAJ2jctgT8DH2VNTwyptcTRhBPcvpX1yhljrkSb1tgbgVv9JjBwD5lF7cRTw

Replace _steal_() and _steal_fd_() inline functions with macros, so that
we can have better type-checking. This would have avoided crashes seen
in the original patchset, where we passed a pointer instead of a pointer
to a pointer.

Example usage:
CLEANUP_FREEFUNC(GKeyFile, g_key_file_free);
GKeyfile *load_config(void) {
  _cleanup_type_(GKeyFile) GKeyFile *keyfile = NULL;
  [...]
  return _steal_(keyfile);
}

static int open_file(void) {
  _cleanup_fd_ int fd = -1;
  [...]
  return _steal_fd_(fd);
}

This is inspired by similar code in Pipewire's spa helpers, as pointed
out by Pauli Virtanen <pav@iki.fi>.
---
 src/shared/util.h | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/src/shared/util.h b/src/shared/util.h
index dd8e5288f55b..dacbff67f067 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -100,20 +100,15 @@ static inline void freep(void *p)
 	free(*(void **) p);
 }
 
-static inline void *_steal_(void *p)
-{
-	void **orig = (void **) p;
-	void *ret = *orig;
-	*orig = NULL;
-	return ret;
-}
+#define _exchange_(var, new_value) ({		\
+	__typeof__(var) *orig = &(var);		\
+	__typeof__(var) ret = *orig;		\
+	*orig = new_value;			\
+	ret;					\
+})
 
-static inline int _steal_fd_(int *fdp)
-{
-	int fd = *fdp;
-	*fdp = -1;
-	return fd;
-}
+#define _steal_(p) _exchange_(p, NULL)
+#define _steal_fd_(fd) _exchange_(fd, -1)
 
 static inline void closefd(int *fdp)
 {
-- 
2.54.0

