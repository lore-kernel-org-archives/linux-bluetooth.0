Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE812BF24
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511507; cv=pass; b=fkdaI/fmliX1aCs+4wYKR0XbvK647pByP39aL4BSanUIS7JaPKYDFR5QDAVhhWRdJZLtEHLwPSM5juaMRjnQNpRrERjHxX61dzR5RdHCCZmPAFPdUh4MhNyCtRzksaiX9zkxQfEy7YalfBer3mDyTXfgyfxQm26hrhzC5e4YFI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511507; c=relaxed/simple;
	bh=ZO7C/p7WvKQjM19YuQuWUbO+bhve8cn/LPZOWDYAP3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dye/WDUPfwfwz0sPK2DLjs0EKScQZcWnk1Lf4HGUFBK9N+vICKR9noLjZT/66av1MIFidt4R7gOssHlJBYTYvMz7pdgdkDXOLLZKciGWggmMSD886C7GeWmynTWJGEje2EZYUdr8Ax+/0byBnZH0qtK9EPnlDakm3ESGFrl+JJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=o5GTEgOY; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="o5GTEgOY"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bgp8C0XZJz49QFd;
	Mon, 14 Jul 2025 19:44:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1752511499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtopgsqEmuhsnyicy1NACcKFCaz2sfWh6dF+low/axY=;
	b=o5GTEgOYo9CpGrLWGjShkIB47XkOp1SsEC5L9klTIEFGLNotEDfVQrMAvFqF62tLu8sRxQ
	aFH7+1PeBe9JqvDC3uglUJ0tucRwgfNpVKAo8gi7PGPGCxcJYDt+ytly+5j1X7fS7YE6RE
	uTdM3HF7K/T93Z0HGBHASb5Zvb7119JUQFvLdpyJjIt8lkWAq9RIOK3nU33M/3aKn1pq/p
	MRwZYc5pExpzHT9LrhLCvHEvaqUrAuCj5UTV0wRa/2eT5DR4Z2GkXqtTwDbW8kK2QB/i5r
	Ff/C4Nu0UXWp99lOhaU0VLqcHRIsXISUHZ53D5GxNuIUM6rd5pRjTtpc0Q4sGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1752511499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtopgsqEmuhsnyicy1NACcKFCaz2sfWh6dF+low/axY=;
	b=vVQ1MndG02soacB75mSSUXTBPQEatGwzZpJMoCApUQKQ13fBE/iUVKr1fjEKm6jrH1qE9+
	gjqc2lpbwAtDM5VhRDJv7+Qoon5pkA1LdhLG1/Vy2h3e6yvhvAqU/J35Dz2r8Z/l8cslxz
	lyZCuiOXuGpHbFAjhDUCbm/PvKdrf1OyDahbsd+2vL7Cb5JPM6LW7YAwC6ICV9FQVQWjIX
	dtdbuQSn76qr8XLk0V2GeJUEZV/5slXl95p6OQTLTwj0KenRlCmVo+BFVm0hq05cIDJq7g
	OFyRyg7bovM0FWPhLWpK63BU3jt0iYhCywBjO9CYEJh5cqwojVKOTg858VZSPw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1752511499; a=rsa-sha256;
	cv=none;
	b=t3gPHGjEikZ/Sp3GiSZ1AiJClITJkp3JGEoAHeY4CRZN/aKQiL5msZ/G8CbgobxNxm80x+
	T7QgtysgOBOngwnCa2Q5zPgVV5FEEu/D3qnflrbDqM6Go+fJ6C+7J0E7wyfxHoYMFm+tQk
	xIhcGqTGLLe6QilcUn43/hak5Ompmkx1gzdyfmSkrlwiGw6dxlYvBaXiMNOsworFiMzdbj
	opToFyGwCOgSr5IOVZMqlt8SIgVbMWTGZgFSVve5+CEa5zKtwKxWld2SUFlQAi0kyOUhnN
	a9y+1v8mg5G9dl7lYiFHZqntmRCTjsJ+zBcWysjzgZhGss2+hqMpEhbg1Mio7g==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2.. 2/3] lib: add BT_PKT_SEQNUM and BT_SCM_PKT_SEQNUM
Date: Mon, 14 Jul 2025 19:44:49 +0300
Message-ID: <7488a1823f01ccaabb202d268946030b5cc4f8c0.1752511478.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2ffec6539fe38318c713b48985aaddda9671f258.1752511478.git.pav@iki.fi>
References: <2ffec6539fe38318c713b48985aaddda9671f258.1752511478.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Socket options and CMSG identifier for ISO packet sequence numbers.
---
 lib/bluetooth.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 150679d72..88a5d8b66 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -253,6 +253,10 @@ enum {
 
 #define BT_ISO_BASE		20
 
+#define BT_PKT_SEQNUM		22
+
+#define BT_SCM_PKT_SEQNUM	0x05
+
 /* Byte order conversions */
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define htobs(d)  (d)
-- 
2.50.1

