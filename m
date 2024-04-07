Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1F612E48
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Apr 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712503128; cv=pass; b=iCeG6syq9x/d+ZylbyU3hxb84KR7TPByah4tu1WtjMFL67+UIdLTQ9jau+HNaITCMdL09pBb5giUwvSzN/t2QbQSGH4V2J1VTjxJhgJsRN9qKGusMvCfPc+1Rvk0x/oRqZkiedK9y59kTnODJ6TJKZDpgUyygAvSHZ02RPYSbs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712503128; c=relaxed/simple;
	bh=AnDkPOtpfsLUqO5g6XJ74kh282XH6RDvhB0iIpcXSeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MO4gp1WjEISf7U1aYVOHpcAU1V/KfaUYEYmoVsLL0vYXOwuFQjCpF8WJpDEfte+sWP26CnLmkVC6RAWgBps3/crOr0H69mY17FSNCs2PbF6DW6mB9rD5zLTTDuQnxmYu+xiSif+5m2GsiTnKsI2M96UcTAkJLuXC8CA+iYVllWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=HTqpNrlH; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="HTqpNrlH"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VCG8N0NSSz49Q12;
	Sun,  7 Apr 2024 18:18:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712503124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNLLr0NQi2kr/SMLWRwgdU/Jenen+0NCeqNkRe2weCA=;
	b=HTqpNrlHyIn2QKIabHcfZvi7FpXiryPKjQkin2QZ3HNEVJ+1hs8LPbMpZoZ0do4clwrD5K
	MJBYZ6PWA2YVq/68hP4yEx3HS0azShNt7dzvmg7daOmISz21nyLMjhS4ZHzfIeqhX2TkCK
	fEb8evoqUXY/XlqJQrio+/52c3ICH2IqfkrArXcK7k64eyQfKP2BMt+LIZmda5ZpGIz+5c
	9smdIL9jJ+5FKnAh3LCGgiitIgl/83btvaPjhSpGUKuGnJ9K0aVScwngY+W3lfYS2t4YnM
	UHzLFiaSxsow2UOBebAhtcBpenwpE/exs91/A4NZMRlyduDDxx7rNwbWwZs8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712503124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNLLr0NQi2kr/SMLWRwgdU/Jenen+0NCeqNkRe2weCA=;
	b=jGUWfqUvoPVaPbFtrrdGaK7vE5OUxbMWLbDXEuwSY0Rnmuc3bSBdZmbXfG7qXkXBjWrfNN
	PbB9YtTbOQGfYUdmB4fjUIWBS0a1jzIFmuvaaKJ1ATMAKIhTeV9YcRhjZ/VIuK+53XRDfF
	pZ8MdXhxmGaFPtGaDZC2VsDCTkoLOxQvErg7gHX1F+qrlpcFZsmh2IQfWMNgBzpOrNcEug
	eagvLOG2bKSKuWGshZuJGWf1rEElDV6klXR7pWFJPNJ4W7NXTkcLUpFI1Eo6R6+se+7ipO
	dcJqWf8hZh9frIlnQ3FBE5sCOVhsQowd9GXyCd6vh7Ge97j6rcylTIZbq3U44Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712503124; a=rsa-sha256;
	cv=none;
	b=pgPEBBONLeEb5jiexpDZnqygNQ+3szVcV/wa9KEBIOQ/nkAShegfe4CJ19I63LQs4HWL4J
	+CWjKJQ6adYT8NI9wJ62zkw4ZhVX/PijSA9y88MMH68PQagfTyR9YVoCDvM9mhyvAGRadE
	KeNCzwrsOhx9VWOlCdtaji8FR0/fNKn5DiKTjKYobTOlCVg7CyPI8IN4h/BQjsKRoFXVRU
	BvTTboLWY25ypUuJN8pXLSkK2P9GUb7SIexfzRwQIHbwYtKlmm7OpyeONI/fB0mF2jvQ71
	Q5SnZrSkl++t26PNJIPlryyisC6FSj9EFcurKhGCstZMSdWe+D9pljGbLf46hg==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/5] lib: add BT_POLL_ERRQUEUE socket option
Date: Sun,  7 Apr 2024 18:18:34 +0300
Message-ID: <b6b6d1de2e58ec4fcb8c5265753bdf0bb41796c1.1712503074.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712503073.git.pav@iki.fi>
References: <cover.1712503073.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new (experimental) socket option.
---
 lib/bluetooth.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index a4ed65d0b..073ed875d 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -240,6 +240,8 @@ enum {
 
 #define BT_ISO_BASE		20
 
+#define BT_POLL_ERRQUEUE	21
+
 /* Byte order conversions */
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define htobs(d)  (d)
-- 
2.44.0

