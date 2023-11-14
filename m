Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E91CABB
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="NeD+QQKG"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160EE134
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 12:12:00 -0800 (PST)
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SVHWd0TyVz49PwY;
	Tue, 14 Nov 2023 22:11:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1699992717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6LRb2yWvSKnzv1ECaPDFsSSbZwIZtkWJdU7+VFnrWkY=;
	b=NeD+QQKGy72Rmd52m9sK2WmWjkuquqzYSSTmBLYNsHN9yEcFA9dfAGgJhsv5uRms7E80ZI
	fU7weqaCu8pHYW4sttw91hOJ7kS/6yIapWy5AH8x3gc4Sn0qlas7POzNIAfF2q5UkIDNYf
	Zws3B1HmcargYQx64y7TSXMuje6VECJvDXuRQ2txEwjX5rv7Kh4IRNN0xnax2EbzLUH4NA
	WF+c7JYk1Lp6cnESozsfwh5d3v/uheJbNnNiP5NNNoLKeFTF2TUpeJLjtsh/fVnDijND/z
	s5tl1ejpqkrzso596MnDtx9EQBoVD5tdNT2InEna1a4SXYh9qk8UWEsAO9eoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1699992717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6LRb2yWvSKnzv1ECaPDFsSSbZwIZtkWJdU7+VFnrWkY=;
	b=o69CShxyv/Mizm9bF9q62ld143u2/K0KMOniM+N9pajNH8Ll1kJW9uCgiwFeofcDhDKdSC
	i6kKlV32G99UrUdtA09jk+drIpj7gPbovY5228x2ViLIrJRaT2uxHs5hRDsjHxcTR+o7hu
	YzZG9+Fr+a2Gk8QjqKN3Ex9aiw9V7w5RA6DAGscCWbzuXg3lltkylJVkvjrhQKlrQag+83
	at7j/hBH4XrfJmUeO22rb3YhAy2bjP1MS9m8Tp+Fed1T+VioDvz9mplzZo21TUlHCOY9mg
	J+PY1AlsPBh3lidazdTB3lyEiL3aEFSJHyegRxQW60FR0VrU/WJnow0+ktB5pQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1699992717; a=rsa-sha256;
	cv=none;
	b=uatbWKt4T1wFJblEeAfW7y9J5w2EDm50xrUqCN/a7GYnErOBH8Ubctt2aZQqws8Vys+d7N
	XdRuK0gDXOxuXA8UR7VqDI/vs9Y+ih78eV1FxYS+at8bUQ1qK4/6BssvdFg7wnHoRnv/PE
	/dMkhxUEHkv2DIn6hiVhEHT4dpwri/XGqITjWkF4Cg/7UlEPHkYZXhCbhiQg6rTQ8dMbL7
	GW3VzLlVe1Tt/52qmIrT5pXRjW9Ze+3Nx14cdxn0ulv7Z08VSUPiUVvjuFtZIFthD2/Q0I
	Rv57000BhMlbScHIYtsB884tS6w3RnVJX+WDLGvu272aS51+rJhyhCR+OGEacQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] media: add Retransmissions in SelectProperties QoS
Date: Tue, 14 Nov 2023 22:11:52 +0200
Message-ID: <f1ac6b52c30e002400c2a0dcb20ead18899695b5.1699992657.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The server preferred RTN is part of the server supported/preferred QoS
values, and should be passed on to SelectProperties.
---
 profiles/audio/media.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 4d9a6aa03..62f53defa 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -995,6 +995,9 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		g_dbus_dict_append_entry(&qos_dict, "PHY", DBUS_TYPE_BYTE,
 							&qos->phy);
 
+		g_dbus_dict_append_entry(&qos_dict, "Retransmissions",
+					DBUS_TYPE_BYTE, &qos->rtn);
+
 		g_dbus_dict_append_entry(&qos_dict, "MaximumLatency",
 					DBUS_TYPE_UINT16, &qos->latency);
 
-- 
2.41.0

