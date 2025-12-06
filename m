Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D917925CC7A
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765018909; cv=pass; b=Pr1lZFwuRWfTYmTKB4kzgXlxicBfPYs9N8lN6lj24Xt8KwdA8bY4HeE7X7E8hv2EnUq3MSoCVSMAnXg+M5asD4BG56GelSxj/FwLc4h54Omw40TmCasVwAJ0Y17SAWUG5fwJkPfRqzHC+HeN4ckyth/kxxN5Lhvf48ZpgNIm0m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765018909; c=relaxed/simple;
	bh=V/FfHzaWQAImFkhnuuo4e3Whvfk2xMUJnNencE7RPC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpir5zPSW9FHwaLUkwlaiuKjD/BZbBv+5Qc7J4Lq7EtiWoegyz4H2TN4Bj3GskVrCdaAOUjKNUuwg6uCaAMFbFWX0PZm1Ky5nimjpj01c3iHjbTz9dR7IlUjeHBPg9z3VOhNzCvpd2hg3BUBHqBZ9gd7c77aBAkmEEKA54W8+To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=wn58F/5G; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="wn58F/5G"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dNlgD5H5nzyW9;
	Sat,  6 Dec 2025 13:01:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765018905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar84zot/lxlu9QUpGfRLLuIVZzXnNYTSuhKAem8Nv1Y=;
	b=wn58F/5GTXsAOuYUTeMoQXdst63XdyPNpQMSG9tJ6wpvrcGajbMOTQhFsn/yP6tAV0+atx
	vqTPFHWz1fvBquKUCIVjOkpZpZlAu+bnyxZG3qUhZ6znQYX/XBUkw0K/OZDwwTF2+OvBVT
	VIkebi4YLBrD5qxLVCPz2EXX+d/2KDY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765018905;
	b=K1Juv8P4KiOJAntc4KAyOnZzEyGH4UpFnJkVjKM1eeQYm1eiF09IYIaPL47PD52DoMIVTR
	FBjzl78Xl4Nv2z5uKdp6d1zPCefwg7YKGiNyyE1nKfYWh0DRdtZ1huB/w80ZCaTRIYuYMK
	E4uJNEo+ji1ZvNT4OUB6w8MTwnNtQmU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765018905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar84zot/lxlu9QUpGfRLLuIVZzXnNYTSuhKAem8Nv1Y=;
	b=XvtBCBHx0ErHXbKOrEitvzzhWMOvKfGJxLTEYtu/FkgryVenjsDw7cGLBpHG6v7CQVKKgr
	NAyYBXUXrCN0cjCa3iE0WVfS2l+q/M8VfrCl5E8Z0bHRfVZESK9p7UwRpPjx7f3bfSJGTR
	Iqg00FtUZMBKX1QFMeSq7Vpwf1chPdk=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 11/11] gmap: remove service on device remove
Date: Sat,  6 Dec 2025 13:01:27 +0200
Message-ID: <3eb321c98638c39d7a0a0c8db207c25a4dd1e9a2.1765018766.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765018766.git.pav@iki.fi>
References: <cover.1765018766.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove service on device_remove() as disconnect() is not necessarily
called on device remove.
---
 profiles/audio/gmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/gmap.c b/profiles/audio/gmap.c
index 810bc783c..cf9b43ca1 100644
--- a/profiles/audio/gmap.c
+++ b/profiles/audio/gmap.c
@@ -138,6 +138,8 @@ static void gmap_remove(struct btd_service *service)
 
 	ba2str(device_get_address(device), addr);
 	DBG("%s", addr);
+
+	remove_service(service);
 }
 
 static int gmap_adapter_probe(struct btd_profile *p,
-- 
2.51.1

