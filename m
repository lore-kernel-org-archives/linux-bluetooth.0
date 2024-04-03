Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA112152DE9
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168816; cv=pass; b=VyjtxEp6MecdCT8PSIf2+2mLoY7u83XX+i61KVUS6RXzrxJ25leC4RNkc0p8mIEuP6IP3HGm5drTmO5d3Tg09yA2PvkySRymOWpX37dqERUX3laP97CU0ndEawT7fScy1UUNPNvtyFvU3pB4m9NoRTXZO50TqukWdoPmz1R0400=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168816; c=relaxed/simple;
	bh=Rbylmd5Rutq4+i7hfKxure17mD3Xd1qpj1qB5aB12wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKYokB0n1mmcT2eP00IXNuR9p/djjMPf0lrQ3e3kNQ3DPdPIBt7LN8zhwbRyAVYfP/vgq1PZrv19D4a5a6qOQH1EBhvyD+CsvTgswf6MffOHzCXiVC5w3FQP0aCXwcNoW0kMqS4PdHDpOJ/ATudp0Zlnz8ixkvqq+FGOWmP3JOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Uwpe+gzZ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Uwpe+gzZ"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8tWC2tDSz49Q3H;
	Wed,  3 Apr 2024 21:26:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712168807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQHBUQvSEBJ4gmBHTLJ902z3SIHMiTvD4BQrU7DmKLU=;
	b=Uwpe+gzZPziT9TPVHcfaQfb8Cas61UYek2yqMkzop1oUthbAXGbWUWy4lR0QaOdKvm4T29
	IySjhAM08BZfy2CvdIoqeHJuZC6Ozu3nReX8qkAJYnZZ5ou3pvOVWy03k+C9jLmNf3pAeZ
	DON9G4rMcRLLr/3r6/rpBK6+Ih98XTKEwhy8J4SUAyCPlNcmTuarh4wl0dZot0+U42eCpK
	ijMkDD4IZAeCnt85H+KxY3vdGSyqgDPxLbixtXsTpGqtxl83d5fezsm2LkfpYh79T9ytR4
	mLlx+LuY2LMiea7Ga5dDlAueA4klx16X7Vdb2AZsv0ham0ooRY4TyTiD2U4hVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712168807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQHBUQvSEBJ4gmBHTLJ902z3SIHMiTvD4BQrU7DmKLU=;
	b=KUtfvNhTRRkgOJf55Qs+iNPJK1qUh38VpV9v78lUrZ2IVPS1jtyWzVRSPHLmLSxsmEu4fA
	0hojW9m00OGFPAXmMComynwFWB58XKsA/ExaIJQ67tDtaEWSHuW5/EVvhiYqRcJUcvgEDk
	HSMhWobqZPdPF8RlukWiUlOllTe/UK0YlcRaY7pGI9o780B33i1/qzZIpFU0t9IsyDPnrN
	8G3V7DDpQkz44kn9Kxgo1uJBMGiWE0dXOqKVXopnunM/HhKhxJ/Xbit/aTJ1h8vFVDa5Lw
	Lk81hTMKBsuZ/01tuloZjsQNxgupAmqCJSrRP8Vcl+WOTnBbbDYBpwQ1wd9M8w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712168807; a=rsa-sha256;
	cv=none;
	b=ZtMrRdpRM202gzEaKAtmdJGRmiWIIc9gHLADWq6tV0CIoJMLZdCum/akg2Xcn8C488Munn
	kKfQdcEJahx8uu/GOBhQQBWy/W49nxGY1oQ+xKa6Hyh/uoKTYmFwBd70v+4nIbtxg5qQEs
	t3MKbASlBdvHlhOnbB5FXjBCOCcN+/KnrrelSOtqU0MRBX+z1HW9TG7JYzSZeC7WsGBYZc
	VGmUKupF0CIzFVY3edAdaIcH0lxWXUf4SKKpP52YYpY/388jc/qyFTpnHZjCe4FmAou7Dy
	8crl8nQ6f6cRMOpQMvZzwKC9a5lLtScNV/bGed24DBbiDVQ+0VjDT/W7gqWLGw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v6 1/7] lib: add BT_SCM_ERROR
Date: Wed,  3 Apr 2024 21:26:31 +0300
Message-ID: <231de55e44e48272c02dac8ee735af9316ec46e0.1712168788.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712168788.git.pav@iki.fi>
References: <cover.1712168788.git.pav@iki.fi>
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

