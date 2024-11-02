Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA11AA793
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Nov 2024 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730579414; cv=pass; b=buH9XGriGaKkeHenHX6jHB/nXucqtTncwWwBIAZzx6x6odCWjVLeUrILMO47I360gh2FZbcrmcdN3t+T1vrG/YgcvvbtsuYpWU4Ltk43Qslx9bGF/3COWs8xnWoOwThh5gvVCej3mKoFCxpi8TGm5+P+SdLspl0x4rzZ3iXBnHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730579414; c=relaxed/simple;
	bh=UzDq7T5IF23M5BfBfCTqkemCONjEvUTdTR4k0vuJ/bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYy40wQC922GGh40BR/ygODhvKa4M2Mf3EmWUm+ARwdFTPoraiD6pxtOSESCUDfXKnDw31H+N/Bdjpad3WrQLgkos/0RfGqS9rZFAShxib+yez22TSxAzKffBy1VHqiJb7Xl0NB+jXUGdRQ9WenIaGgLD4SzmgUt54hDniIhOWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=lsE+zl9M; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=f0WCVJZK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="lsE+zl9M";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="f0WCVJZK"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4Xgq974hm8z49Q57
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Nov 2024 22:30:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1730579403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwGZdsON4Y0EJBEj6MdVtBBmXMTpI+xKsSSmOHUjjmA=;
	b=lsE+zl9M9DEbPW3reNBYhwnULUrKXz26o6jwfwVcGZPC1QgYwHPTKDvg5p4O7fAyf5qIKR
	1eSfbdwHWmGRHPfsbh4HsojW3ud0MQdQndte/Dt+ab2JDt8gZm/o1Np2XjFO91X4bpTYsq
	05gnfudH7E13QGTfkdiIka17wi6D0IyDCpbcx3DJZPxhGwoNZqMWOM8X7QfGSliWvIEb/0
	t3UoLvFlNzAysqaOrM3j9vJwZS7MHRS+NtMaqQEST7iV5kzMab3e+bg7d0NZ1qvLi7gt/y
	DV9D3xmJc5vLYNj2HIuZyGeyVCBREcTPbngfro6f+6m73Wi5DVhDmrhQi5kvbg==
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Xgq8z4Mkcz10G0;
	Sat,  2 Nov 2024 22:29:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1730579396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwGZdsON4Y0EJBEj6MdVtBBmXMTpI+xKsSSmOHUjjmA=;
	b=f0WCVJZK49fD9jxufwvGFnnblHt+fBeIhAdZB/f6o8FTxZq/8CUlH9fE3Q6PGZWJsDp5kb
	ORBl0M28TfvXMe12mm00rOl5ZHI86CI4tPkN4KKhiG+j40722y7qias9vO6HXwoZxODLJB
	MsrBOOx/Y1NusMnE1DS328/EnVcm6Ro=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1730579396; a=rsa-sha256; cv=none;
	b=lGQXsgIKftDDd+2epdY0fGHd2v3pwhTW7vqE+bV4MvugxZAfBkbOkslDFubEIJtMV6i8zP
	XEQPF8jpLYy4lMBTzrmhA6OBUS07cPl/b1SopGgPA0R15PkBNofCWuOBrBdxvV98nLX8m0
	rfv/p5E4KqZiNrUSnjYMCZhv179tSdU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1730579396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwGZdsON4Y0EJBEj6MdVtBBmXMTpI+xKsSSmOHUjjmA=;
	b=XfN+FcUj+F0j+ScOEJETgMLTO5cr2CL15wXWmQw/BETzHl4C0qwmhCNfo4jktos8d28hqc
	caDJWnfb7RR1sjRr02GXxs08QsNuCIRnNsGsihMkF1Wc6nw4mKdiIbknzWFOx2RjJG4mvt
	VnVX2WZU0GR7pN6A99cnL9jCrGeS4Ec=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/2] a2dp: don't change setup sep when it is reconfiguring
Date: Sat,  2 Nov 2024 22:29:46 +0200
Message-ID: <76f3d83f9a0e869db3b880e4ceb3fb3bb6b08856.1730579026.git.pav@iki.fi>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730579026.git.pav@iki.fi>
References: <cover.1730579026.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a2dp_resume/a2dp_suspend are called while setup is being
reconfigured, they make the reconfiguration use wrong SEP.  This occurs
if transport Acquire/Release are called while reconfiguration is waiting
for CLOSE_RSP.

Fix by failing a2dp_resume/suspend early without changing the setup, if
it is reconfiguring.

Such resume/suspend calls would in any case fail, because
avdtp_close(stream) has been done, so avdtp_suspend/resume would return
error.
---
 profiles/audio/a2dp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index d6c97e7bf..37332abca 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -3132,6 +3132,9 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 	cb_data->resume_cb = cb;
 	cb_data->user_data = user_data;
 
+	if (setup->reconfigure)
+		goto failed;
+
 	setup->sep = sep;
 	setup->stream = sep->stream;
 
@@ -3190,6 +3193,9 @@ unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
 	cb_data->suspend_cb = cb;
 	cb_data->user_data = user_data;
 
+	if (setup->reconfigure)
+		goto failed;
+
 	setup->sep = sep;
 	setup->stream = sep->stream;
 
-- 
2.47.0

