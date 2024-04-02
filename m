Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF8715B13E
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083790; cv=pass; b=bYBf5K3HNIDLvYhflQqWXk+Jp1lv4QTdmqOY17lXaxRizlwgDaUoErhDPFZcwxsgITpJ9K2SCnQfPSUaJvGRqTxNZwQFjCckVV6vjEdI8tYGziobrt/C/FYWNvyHFPGr3wkKzEK6i3OhQ0b7lBb3cPbEKwiHcuyQtv0MJnFvdjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083790; c=relaxed/simple;
	bh=Rbylmd5Rutq4+i7hfKxure17mD3Xd1qpj1qB5aB12wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBf21RuQORmnCF4/d6IqqLN+K1d1EzHD0qHMTVg7nScC9UkawuyoiEBhOBgwy56CF5kSe88hLixRAmmHo1JTQ3kFvjaQxVUmJy1Vf2XhAFcotgzvvV0QzTl2CsMMsxIMUdv1cOdYzdMc+MgLFchqAty8RHPM1LiUeLbZyRdEYo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=DlPgo7Ec; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="DlPgo7Ec"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8H3f19Z8z49Pxk;
	Tue,  2 Apr 2024 21:49:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712083758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQHBUQvSEBJ4gmBHTLJ902z3SIHMiTvD4BQrU7DmKLU=;
	b=DlPgo7Ec5JtS4p8GImLw858h5EGskMD/ZA9IrayIc8Og7HWHaD4V4A4MM3z979i8oETfb5
	IsYflFUBufmv/nL+qz5CYRFS/mwYrRJcQr2r59y+ncOP0BacNZbapJTxw/WmWEQKJq6J+d
	jnejwwccXivdD5qYRtgzuuKdcQE/TbBPJJC4wTuk4BmCFz8Ppm7XS90uuMye56Y7dVTYQn
	k/NMyVkHqvtKZ8E4XHS16GWOAJsEJX01fp7Ix8oo4g3DqxuyOEYt4KfcQVfSIQVd34LpY1
	MRlEtGdQ1TIDJjL6uoV814hpRwzQQI6DClKaGG8yf/n1Xcsgwy6veMvCv2KwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712083758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQHBUQvSEBJ4gmBHTLJ902z3SIHMiTvD4BQrU7DmKLU=;
	b=koC30W9jtSVBavrVOvMU4gUh388YlEmMDBGU56lspK8kSdEviE5d75qhNoXEpUUYCG4NE6
	328WWlbALxrfx2B2S8FhSSS997u9eZzH1kRphf+1NK7gPyGvW5JlSrB3lrkT5SQFXvtPyF
	4JfUmpxmiIEwlSc0vi1WpqgE3XxxzO8nf1NlFsCsNSw/A7fvjXNVejHYqXCuiLrE2/8pCn
	kiSP2btY3u/Q9x/0FJ6svjfAT2QShRlXzsRy3wY+E1RTv78xWcM+OfhaWM/QV3j+II0kdk
	5DpmjmJTRNj7fT8JRRbDQM7TzZQDOMvV37EC1ZGrv5qHJpGdfpgMdlEOMSWs6g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712083758; a=rsa-sha256;
	cv=none;
	b=udpKsmyFwff+EeIk8Y1C3fI7ortS/siZ1VB3VtV8RG7r/EqrX6pgVmZU8w2EGej603Zn5I
	c8U9qSPM+E4rFFQ1MEVtmJl2diWcUFdyBvX6IIZPaLIqAsBdUt2YAJWUjd72/KCYQAJY8w
	dkA695U+2vuUh3K6VmfGZCi8f0FgAtqhRYYrD/h88l7lD2pspN8cUeKVrsIknFQ68A4vJ0
	vxedY3N24+5W/UaI6nh5uW6HIPKLyYWzCQ4ju0x/wGHEhCBWIMDWZmekQO4jDN6bUf0wlh
	AtaSMGDAEjTaaoZ3DG7TWkCa1uV/ETbemh32wnqCkZxMsR2HobGA7v4taFTY0Q==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 1/7] lib: add BT_SCM_ERROR
Date: Tue,  2 Apr 2024 21:49:08 +0300
Message-ID: <1fd56079e4aa89aa1056a3cf185610a683ee02ba.1712083655.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712083655.git.pav@iki.fi>
References: <cover.1712083655.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new CMSG type used in new kernel TX timestamping support.
---
 lib/bluetooth.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 75dc960c8..a4ed65d0b 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -141,6 +141,7 @@ struct bt_voice {
 #define BT_PKT_STATUS		16
 
 #define BT_SCM_PKT_STATUS	0x03
+#define BT_SCM_ERROR		0x04
 
 #define BT_ISO_QOS		17
 
-- 
2.44.0

