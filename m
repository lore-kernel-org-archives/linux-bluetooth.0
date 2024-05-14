Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B291E491
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719320; cv=pass; b=MSRGA8cnGN8r1sNWjAEbi9okLflTdyRE4WB7QrvNU86+PqDoxlXOZfdj8n9l3D/3LHZAVfTv9qBEfwM4hmQeVpoWtHd7gJa8yRiTve+Zk2m/rfg3T5jnSZVzE4xQnFTx+nRrbqVgXUvmUXBB9tqpHp1Mq5v1rx9GmxKwCV3kNbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719320; c=relaxed/simple;
	bh=AVUzjYatJ02rlV3DInEUUBOTWGL6j4X8R8oL/qyuORY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFSDJrK+GTV78TbxSbujaG7GuiCxfc8WezZH9od2E2lBHdVd1XZYsU4lPAfbCE6qYpDTYSGhVYt5/jdXZgU9/9F77c/MUGvLpxwvinHIAGdE7NN2tbasqct2e4JCt27arFzKum6CeHm1MHCkk9uw6NEz+mrjbiRBVHw6UPx9y1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=IffPbj66; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="IffPbj66"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Vf7ZD2YQnz49Q4h;
	Tue, 14 May 2024 23:41:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1715719317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUtJ/X/0s/LmzrB87rT0R8DAuO6wT9oVaxjR3BOoqx4=;
	b=IffPbj66qaVHE/ZfuOPoYkLLU76Niap3KbOEZwxvwXBcEcO8TXCGpCzu0pWcqaOpUsGqY4
	+Hb14TV+8lnF0aarrM/yNgdCwVw69cCxJWTzViv35DNYhvM9x8Wdd/wbzyM87IuxXpB0I1
	VQAl7PfxlTGgVtt45/+YY7WF7Bsi2xKa6ajMHHoQ7WB4FLqSSzQc6N3MuM4xg1/1RBJuyn
	IQhdZIODtWbXCO2wsVoNy0jOfEjDYZ8xz/7LtKWOs8GvHKTLrXAFc7WWd6bB6XcnwvOSg5
	pqF/pweJ0mudq/+xTFxJ/lxDvDil0WHG9GUDHs6q/l8XLYLrumg8YL/gK4IXQg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1715719317; a=rsa-sha256;
	cv=none;
	b=iq2w5UxXuRfwLcrQ6wPJRBRlaoknKz9vyiGwbIeLyLFEqlHcPmGBApJ2fpOR/2UKLaL8zd
	CYke9I8mzbjNdTM+w8m3np/IbNrGk/oHdjaQKtpIWDk1TcbIUQBBJzPjYzd15JpCDUtcn8
	+bX4WufHXsjyzjrPqmcw1jHpYWbmuJSzzi4wFcFVBrjxeyaOzBq+A+UMQrsraX7PaiqAu7
	ZVvgFFC2sYWNde7El6DG/BIVbKKc9EZ8G/l4t14t9ZYqwGkYM464qGEqEsKjEuA5s97Qjw
	1k8CXO1ei5/4kx2JOCqgNihfRwSxPHcdMpHZKkESDcfc07BRg+hpVZYQV4RP6w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1715719316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUtJ/X/0s/LmzrB87rT0R8DAuO6wT9oVaxjR3BOoqx4=;
	b=M0kk5TTAhSQw7k96BN3dQZI3uVQC78Qgrfj2mxlZfWjRzrdUVh1MXrAq5saG3KoqnFks9I
	AH/et/dIoLvw791X5P67NFu8icEhzNMuYvwLIfc4lvrmkxsVP1dlSvcOpJ/92nNSDeIKzu
	c6Pwaz8RoY8ZrnL856hLWcGJZn4eAkytko18jxytKXfFrrjxxsIpr8oy0SDFHMNFwH7M01
	+X9uFApCJxRCUHojJ9hxlHyxp9g/87PW47rONtAm/66n1rdssBf6WYUGuf5EmIj+rgsl7l
	6rnGXRkGArMKqowKXTyWc4l/egl/IfyWsRRWJTK553TKREXVm78SghNuLmif4A==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/3] Revert "mgmt-tester: update for Poll Errqueue experimental fature"
Date: Tue, 14 May 2024 23:41:50 +0300
Message-ID: <3c7d838afab792b1445d1acd14a3170804895104.1715719254.git.pav@iki.fi>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <d832a406db3b7f8509fdc67d0e9f2775c6ea7b6d.1715719254.git.pav@iki.fi>
References: <d832a406db3b7f8509fdc67d0e9f2775c6ea7b6d.1715719254.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit c777c55ab662db4e9853bb08a6e1e6c77b319e09.

The kernel feature needs further work.
---
 tools/mgmt-tester.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 81636200e..8a4fbc2eb 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9985,7 +9985,7 @@ static const struct generic_data read_exp_feat_success = {
 
 
 static const uint8_t read_exp_feat_param_success_index_none[] = {
-	0x03, 0x00,				/* Feature Count */
+	0x02, 0x00,				/* Feature Count */
 	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c,	/* UUID - Debug */
 	0x01, 0xab, 0x9f, 0x46, 0xec, 0xb9,
 	0x30, 0x25, 0x99, 0xd4,
@@ -9994,10 +9994,6 @@ static const uint8_t read_exp_feat_param_success_index_none[] = {
 	0x85, 0x98, 0x6a, 0x49, 0xe0, 0x05,
 	0x88, 0xf1, 0xba, 0x6f,
 	0x00, 0x00, 0x00, 0x00,			/* Flags */
-	0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0,	/* UUID - Poll Errqueue */
-	0xc1, 0x8b, 0x79, 0x46, 0x9f, 0xb6,
-	0x4c, 0x8c, 0x51, 0x69,
-	0x00, 0x00, 0x00, 0x00,			/* Flags */
 };
 
 static const struct generic_data read_exp_feat_success_index_none = {
-- 
2.45.0

