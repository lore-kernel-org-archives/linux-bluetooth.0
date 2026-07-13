Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C469430792
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950648; cv=pass; b=DEe0l6mSZV+kW2IqQX5fTUhzxcnTPxKLzJDpvi2xeyinxZGyLKd6Mm1QtFZd0M3xkDsZAdKrEEOAg1voHytym7WsoJkjqfO42aWy9StAK3EYb7yYt+qz7xaB8fefid2dqjaFrfpiFInSJg8+rO2gN5W8SuTdVOCJ4Uqywonwqfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950648; c=relaxed/simple;
	bh=QW02zCJv+hZDCgmRxWLAiJQ1H+U08GkiI42OsgZAS9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xn92vvf46BfWY1J2I1NgQm+fxZzBq6I1YroDV36m1YCsAupGdExdCbgW0AbmCRMAX8EiY1+GruskOSAcRh9cuq0R4LHzRCABqdZGUU5QIruJzfFDfsQZ8W/+9IFRSKRJTgVhTYb8DPhIkyA2i2o7me5u+gwN4EiwCSOA52lqnwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=U0vn8ESr; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="U0vn8ESr"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gzP2z0bsWz49Q40;
	Mon, 13 Jul 2026 16:50:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1783950635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVvBXJaStbLN5sMGY1HCEloI5ppjhXDEX+KlmQmN3Oc=;
	b=U0vn8ESrlexpVtcnAsOoRTUJyfLrnMV2cP5Cz3irb6iRDI3ZYkvhIfMk7M1Exo0DahAkyS
	3MYrV/FEqyvHDFWBvIEMnI74H5X2+7GJ1sJcu/htfd8SmzCOgFi7rMVhDjy3AM3sULdhqO
	CKiLfZJuh8yuYBgj4jqReSwi5G8yMoVYLB4mb632JRg6xpAI1Xkh5ESfDYateq+S/QIY9H
	nAv8BJEFUYC4ly0mG0L34qR8hbASXidWXDsUMTJdfWIlAemydNVyz9yxIw5VRfCoCV0O1j
	KTjhpd8gto7b58kq2z3CowOUDvzJXo1KtPy73FaE4IxjGISqOmMal9bno/GCyg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1783950635;
	b=V9v3tMjqopqOmgFExwFRaNpXVPW/Qfx9u2hWlX3Tkmx7dt4yItMxYvnGmAwfS60y/N/XmY
	2bABR7CEqYEs5Ft4y6Jk8klWtNkSSy66GS1N54Pgru404AW1fko7/wItrwev3dQd8yHn3q
	8HF+2gg8kc1N/Xp0necsCQKm0mdUpZX2FolfWUnNOm4A2zvFLvtLCsxqX8oNRi+jmNbu0O
	7PVXEBepkpczskKR8XDglUal64Lzmaq0e1KE27OGKiTtiyCOIy5LJyi3qOS/zUmyKojS1o
	4MHUUTXx4AhM4DXEPzduHO/gogQBBLqIblikxJ6eGrvCnvx4t4kcvCxm/ICoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1783950635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVvBXJaStbLN5sMGY1HCEloI5ppjhXDEX+KlmQmN3Oc=;
	b=UHmx/d85jTXW7Ap5TZiBHVrfUeBuqkL0Lrs9/s6MM/tEcK5COAFut6O91KrbXIwqvvay0o
	PaDvHKeVSV26yrqeQFBaesLSG86V0Wp7Pl3oWacNeHRHAlxfiwiuSiyjtAqCMrBvvQDlVS
	sDzbEEKp+tT1iS2VVqbIjpjx7D8/PFbN/nylUwKt1F0KhDOTax1QXOqjH9+pLrA+vUi3Wp
	boOfEnYrKgQ8NvmbFs/XVW7k0GElO7xHGerWD8m6e3DGgEhOxdAA3BCtFU5HSHXAuHBD9M
	AKVwrCSRieWEbVMo0J5pKWU3OJIKH83oxCs6STPpyAC4Ftd8LMHFB91LxVf2aQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/4] tools/6lowpan-tester: fix race in Client Connect - Disable
Date: Mon, 13 Jul 2026 16:50:24 +0300
Message-ID: <bf8feaa62dfd990ab229bb4a2e4507b23b37fa4f.1783950503.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <acc2842d415b9bef95e60243695463fa7953bf71.1783950503.git.pav@iki.fi>
References: <acc2842d415b9bef95e60243695463fa7953bf71.1783950503.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's possible client_l2cap_disconnect_cb() is called after 6lowpan
disable on connect. Prevent failing test in finish_step() in this case.
---
 tools/6lowpan-tester.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/6lowpan-tester.c b/tools/6lowpan-tester.c
index 95fdf206f..738714d68 100644
--- a/tools/6lowpan-tester.c
+++ b/tools/6lowpan-tester.c
@@ -648,8 +648,11 @@ static void client_l2cap_connect_cb(uint16_t handle, uint16_t cid,
 	if (cdata->disable_on_connect) {
 		if (write_6lowpan("6lowpan_enable", "0"))
 			tester_test_failed();
-		else
+		else {
+			data->handle = 0;
+			data->dcid = 0;
 			tester_test_passed();
+		}
 	}
 }
 
-- 
2.55.0

