Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ACE77626
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440500; cv=pass; b=lyyGuqiLQjMjc3ZBUgBwsX9wspIrKs9LW4np8VruAHlfa9wxz9J9br1Dfvfs8G0Z7WEG0xBgiXfEDAxOJBpCnt3bZvE5zejyFOA0iSUFKPdVkElU0SpgWD9vaYXiGCPYtVNCuw3fP8BRVrq36XhGqjyEU2BuzdzLgkha2IZr4/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440500; c=relaxed/simple;
	bh=SI2L/BY/+xja5cZSti2rAP6ySA6EPIsm3IH0CbzMyCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTXtuUUVNjnyf/1kpSjW11goK7XbJHxJpI/qnX49N+IGHSph8/bA+JoE4EmzjQCkea5o4I9f+rBJwF3mZsQ7SkiaOxxB5TwXSMETupb1nHMnlG0MZdfCSeCZEqQsLU0DWIobm+hFlT5ATgIMr6UuVo3ZLTjY9191Eb8oESwOdWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=KaXRu9QT; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="KaXRu9QT"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TwbLN01yrz49Pyp;
	Thu, 14 Mar 2024 20:21:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1710440492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLFhzfdhZUwusV8AXnmOoKbPCZ//+DwsOZ8N6ZZvG00=;
	b=KaXRu9QTBPykDF9UJzOXiFTRKUUAC0KlvE28YGt67LvEZnIoW6zmI4ze/k3MpO1s6ILmvo
	v8WrevqzVPfaQMgZivwo8QjpXNd1jJXbGTs9XS1OEMSeeiEYYaUC4HYHKwRYbFjT3xBT/U
	zCp0VH2IyKnG7Euk5Tc7PKLmM6wNgUO3Epghmr6hJ+Xdp0ecXgoYAeU8OUKrshGwQ+/I5T
	eigmUC+jSAmOT/HMzXgXM5LTp6fPQBIB176c/wZMIs4kjl5fa1IRiOvwnU75vmL85VXHQd
	/a6L+3ta3FNC0I2fmngUPNv++3gt9RKmyDx4fXgwlmiSPm8DVzZO9Yp7WfCSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1710440492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLFhzfdhZUwusV8AXnmOoKbPCZ//+DwsOZ8N6ZZvG00=;
	b=DkHQYb3VSIBwHb+1mZIZt2eBEjw8vIpDgYJ1WCvjnLgarGGBZ1LAdFJNa/MZpp9i6E+7fE
	kEgSvAaxuakVrZuu98osMdn2WbJcA6Y58vp3doLRqX6+Fe4xyV338c4fYeqqfeSKK3Cm3W
	8XLqilBhe/jX7WVjrnEYF00UHGM8Css6D4wawihDUGtANGIDuPsKb/Lj5tSdJkMYP8ef3/
	u1ERbP+VsPx/UwtMrxr6SDRC9vakuB+VdcLiPLXmefCyTH8+tvy4FJVU4gJ2KzaGSBx5+d
	Cg1ktmRr6XWd0StZLUN4MAz8cJGEaTPqyKnTtTU91Xfcqg2Zo7L5z35QjVW2xA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1710440492; a=rsa-sha256;
	cv=none;
	b=XFUHNRqlGcGbmmbrPBRk3fAnF8Mc6wQWMwZGjWoGvR2wq/geks3xNufTyuBa1ufft9VRKi
	OusRhn/cmIV+zOe4uOan+NP/COZv+Ao3274CvvuoucFs+kxpH6xhbLlzg7VCa26Au5A5yp
	CerhJELkr9ZFTkjWZnH8iWu/y3KLMwBo7lhEin4dJcBw5x+q/lmeTqJxI0GBm7iNdVyhNj
	2QwmqDdpg2juoIxljMiBIGT4M/zWoKjBL7PeLMIVBZG+UhfXcpRUQJEVGMGna63LN6sp2w
	rnQhFiTCnd/9F+8qYR7feGKPQBFTzrdqPWBEb+xL0BdAgs4K2iWRTCSK/BDfVw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 6/9] shared/tester: run test with given name
Date: Thu, 14 Mar 2024 20:21:15 +0200
Message-ID: <c49b98ccde558527a7ff2ade4c84b37f2c4d9b3a.1710440408.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710440408.git.pav@iki.fi>
References: <cover.1710440408.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add option for running a single test with given name.  Useful when some
test names have a common prefix, so that neither -s or -p can
distinguish them.
---
 src/shared/tester.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index a1ee5b687..280f509b9 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -112,6 +112,7 @@ static gboolean option_monitor = FALSE;
 static gboolean option_list = FALSE;
 static const char *option_prefix = NULL;
 static const char *option_string = NULL;
+static const char *option_name = NULL;
 
 struct monitor_hdr {
 	uint16_t opcode;
@@ -285,6 +286,12 @@ void tester_add_full(const char *name, const void *test_data,
 	if (!test_func)
 		return;
 
+	if (option_name && strcmp(name, option_name)) {
+		if (destroy)
+			destroy(user_data);
+		return;
+	}
+
 	if (option_prefix && !g_str_has_prefix(name, option_prefix)) {
 		if (destroy)
 			destroy(user_data);
@@ -829,6 +836,8 @@ static GOptionEntry options[] = {
 				"Enable monitor output" },
 	{ "list", 'l', 0, G_OPTION_ARG_NONE, &option_list,
 				"Only list the tests to be run" },
+	{ "name", 'n', 0, G_OPTION_ARG_STRING, &option_name,
+				"Run test with given name" },
 	{ "prefix", 'p', 0, G_OPTION_ARG_STRING, &option_prefix,
 				"Run tests matching provided prefix" },
 	{ "string", 's', 0, G_OPTION_ARG_STRING, &option_string,
-- 
2.44.0

