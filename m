Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2274E020A
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616795; cv=none; b=E4Pn2xyZKZxloIT/C8dBPqZctxFpouV7XUrzTD/0mHiXYPkSebDjcLnSEax31tf8DyrPb0bZY2rXXSpk+X3v6pTaLi8mCGLROxTrMcqhip/qPYzPELnsjN45ZPmWamp6D4UFowZlhb2WytNAKrwd6gplihwzCwPxM3rIzui5s1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616795; c=relaxed/simple;
	bh=ncqkUYW50ac0++iN6nTDr/JlZhpfLWfwrOoC6057Ed0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRLNdx+zDIASJG+2Spa/o11QBEjR3MW+z6vKHfcqa5yZPrhwaUfkPKb+RPTKlepMF3lFNaQjpGSDNkMMzp8AxE9WZlpQNoEEy/965g730rjACHDqUzl4YxPs71unmhO1FmoomqN7Vi0//4Q762TA1cu6nXRPhFvXnu47OGm+Ya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dffM+fW6; arc=none smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dffM+fW6"
Received: by mail-vs2-f38.google.com with SMTP id ada2fe7eead31-7b2eb9b9809so1646528137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790616793; x=1791221593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gFs3sSjC3QU/qGM/StIg9u+W7HIgI8p0VPqO4E/7wSA=;
        b=dffM+fW6d2HB90WVamozxowYqhLlOQWyCeUQtOrWkXmIQ2dlY0LpZYD+beHm2hX2Oo
         6E05JWjEsVgKHkKsxq1OYoq/b64L4mrNtPyT8Gqt+6JmYHh0aWv3RSOzWnS9h3jNGVIi
         s4E67/WqlRuNdqe3X928ZAMaSVJ+0ndm27PyrAy+iji2C2gfR2xMXSozxP7cH3Pz2cAT
         6HETTLd3LjiJ1XRdR7zkcXbXBfqckFEHkLOichBVwyicFkVGk/dG65zDzGPjM3VzkkXR
         KczSDwmRBMrcvO4d9DIgnflwydWuAfzxj7eGmV0LWTVQAYMoe5jNrs9Qd1QIWRCu8VQ+
         NdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616793; x=1791221593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gFs3sSjC3QU/qGM/StIg9u+W7HIgI8p0VPqO4E/7wSA=;
        b=al3g22FqPmMeB1bDPZq6UQNZrGGf9b+7xRqWD6a04HgbmJcCSsjn6DdETqEIpfl82L
         jh8ZWkyLtSsSPSKwf9Zg5+xXXSTxeKYu226aRQXewBn5ZaQYklr2mD3Gtoj+8jDoSAKy
         X07ZcLXprkPYB2Tiov5hheBhmlg+Sy84LlC/JftBvnM7OGxJdH5xnkc3gmMEyqjSeewp
         bWPEKXopzPkGBqURvW47mbXNgn6x64TwOWvo676Op28WdhiUGg+ott7oqAXG3FwpaNoy
         6GNrSAfUE9Wb/J/wyj3hoj7ioPcdkXC4IEkgVu3k+rcZewJFOp8qSKRhCVGjW3HwE3lT
         ChdA==
X-Gm-Message-State: AFq9FYIsByilt0ddRbjnG3uiZnxTZ2Fqlc9cq3AP5ggY4f9t2nHpRMtL
	ubZQo79Hp41+svJAnp9u3SHENLhMn4fhc0Ry9pd9sZi1j5EtTv0eeJhBthcBJ3ZsAW0=
X-Gm-Gg: AYBFou1F/fu0JF9PARCi1JcjEirxUJulS1JcJSoke90rptWQRXZoP4IDVOAktDRxmPl
	MRy6lmSBA1Yy61G0rKH5jIUwQ+jRwYK//rjfNMJoqrX9dqtbNLqYbkf3OG4dzJz+On1DnXLT8mT
	6rjWWIAepQaBTpx+1n/eeG0howjtmtooFTOcOUz6ogAxhT8h8HEN+ana1TlbaaakkLfx+5D3fm8
	j0xN48xeJTOCu/SHVRpk+Cab1DLDSCOoQyS/1d/4R8sJIv67yx3pRruQB3g8JjlT6OrdlQbEQUo
	2xn6Gb+vxXAr5WRCx5t/qTA0MNXjrX7rPuuZjCHQnzej1gdz3LdN6wK+zrmkYC2aB5RTkFibrOm
	CD+IXu+RafhbmWquhD0LMASZnCqy5RE6XozMxbul13H9l/IaqjBxtRpTYgG6gCFF6kZ9tnS4uFM
	CGWnTIoBSPG21SyLOK0Csx8h4S0HF6zesuT1EBkCwuuEEO23nVH7hIF47qMixe+QzbjyJw6ebdU
	6fICLv8ruGwc61lrXv4z5LNFYAs2z1SzRKE/7PNsrK0VnaNUE0XtFr4dd3/XK93uA==
X-Received: by 2002:a05:6102:38ce:b0:7a3:3d26:5c67 with SMTP id ada2fe7eead31-7af1e4f2ddamr4984838137.24.1790616792245;
        Mon, 28 Sep 2026 10:33:12 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm10038880137.7.2026.09.28.10.33.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:33:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 11/21] shared/uhid: Keep reading when an event is not available
Date: Mon, 28 Sep 2026 13:32:30 -0400
Message-ID: <20260928173243.1073509-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928173243.1073509-1-luiz.dentz@gmail.com>
References: <20260928173243.1073509-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When the fd is non-blocking an event may have been consumed by another
reader of the same fd, e.g. multiple instances of HID over GATT sharing
the fd of the uHID device in unit tests, so keep reading on EAGAIN
instead of stopping.

Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/uhid.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 36a16c331e83..20c55f63b82a 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -169,7 +169,10 @@ static bool uhid_read_handler(struct io *io, void *user_data)
 
 	len = read(fd, &ev, sizeof(ev));
 	if (len < 0)
-		return false;
+		/* Keep reading if the event was consumed by another reader of
+		 * a non-blocking fd.
+		 */
+		return errno == EAGAIN || errno == EINTR;
 
 	if ((size_t) len < sizeof(ev.type))
 		return false;
-- 
2.55.0

