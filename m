Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DADB15B131
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083790; cv=pass; b=dcbHJObQC044/en5vnu9skDzsmBPUHQctpUYIqaZv5cgMC+0chnM21Vj6htO/s1HsB8h99SWb9GyMmQcrwOqENjRRPbCFRNW274a8YPlwjN5oQBev0Lf/OHD2ICakQpQsT7ln+3jc2vvJCGQ493B6sM1BeLsQIl3F683BNJ5YDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083790; c=relaxed/simple;
	bh=TY2fqdnHm/1qXm5oAZeAZQByaO0VJhMajIR2AvaXsms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbcbOXxak2rGf/8jvOModVVD5Lbj8KPMOwXuhEikn+E5wi69DFjGDI9g0WXUjpep7aoDLmj3V/Bf7xYnfxBq27rDUAISEwvUvKDjCBW+NPhuWMhlfKFHyhBeUAM1IQn9/CUdE0Y/qaWIsECxelddcLONyyWoQ9UYlYPDoDixMlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=RtYDUWRF; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="RtYDUWRF"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8H3h0Wljz49Py3;
	Tue,  2 Apr 2024 21:49:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712083760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMCfKk9RH++FCunQyWDEpkYQewc5l2UzI2FcSnTVpG4=;
	b=RtYDUWRFgMKxsGDJs01mlhq73jwB5wr2mmEO5QMExXdqPciMClzoKx8Ke5oKt11dujdEgV
	ZPxYFm8KvK0q3OXOf8LJQlaCv2yz52oHTJiV/P305MprgvRcEACBTJtlVxh8MkVPB/1HmZ
	fR/0iN32LNOJylLMj9POJC78wCiqObdH6BT4B7S08Lq/sn331hSjxL042pTihUGY3Ebqtq
	Rj/kl7nEdl6KmLgXbBPvW7qjVmYTUqykGyxcNfhf11woTTfmf1c3zx+yMyUO6Ru2zwTJgP
	J5mW7Pz3RzGOvQgBpwFtGZ5W6zTMgNB8gCFU4kFFk+9C2OGXwsUVmQK0/oRRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712083760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMCfKk9RH++FCunQyWDEpkYQewc5l2UzI2FcSnTVpG4=;
	b=VjWmwrLhFvOtlaNPYzdUhynaLZCk/VuisHSr7Z6HS3cl6g8+MF7R71O98+/twhn/BlpE3H
	yuUPJUStkGAzD9X1xrNxbB1y+ssUkhMVuW0Fk/S5KBzK9rsT+PSZUzmlCbvldWrciXT/Xp
	SdPS5z5vtqPmQBluHg5xiXjJ15GkQkWwZeQXkoxSVP+k+rGhiVxEOHhW39OC0+vPhF+IUy
	uMAWx462avaYVoi5OEzVlqI6H80Ec+pAIvAC69VyTeleaM4fR8w/QI/PDBQsZV+eAsEyrX
	5iBgiZLxbYbYfSClbslLg4P7sngudNTiRMJZ6j6BJ02WZa8apxKfIfWreB3LgA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712083760; a=rsa-sha256;
	cv=none;
	b=RhAbaiRERya2XCnC/w83YlSk3drMtWxQjFC19atXsZvUnFclR/RWjQXDOfd8WxzRI+QYAU
	EO937GnldV5wjQUGB6Zn1ONcOXpkL9gybYPeNJDnuqAS74erb9JrIVo2MYbugj1FRVGUtE
	91D1lO67QaADKiogjo+ppx+ANC1nEpwcB8VUye6hLYkoK9cA/CYr1Byrj50f92Y/eh/IH7
	7+eOXcHoL76ztg4RsWXpC4acDGY/A0ehApwhPvWd/lX4x1eLa/NhJEc20A56J8m8bXEX0P
	7sgHASyPjoK0QI91iq0QpZN+8pY/cS2/BUoWryPaokSBEcpvVZ/A8i4esOhjCA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 4/7] btdev: set nonzero SCO mtu & max pkt
Date: Tue,  2 Apr 2024 21:49:11 +0300
Message-ID: <b7c60508919066c37d35bf721ba60526150086b1.1712083655.git.pav@iki.fi>
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

Set nonzero max pkt count, so that kernel can transmit data.
The request & accept/reject flow is not emulated yet.
---
 emulator/btdev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 0ad6b2793..a63136fad 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -148,6 +148,8 @@ struct btdev {
 	uint8_t  feat_page_2[8];
 	uint16_t acl_mtu;
 	uint16_t acl_max_pkt;
+	uint16_t sco_mtu;
+	uint16_t sco_max_pkt;
 	uint16_t iso_mtu;
 	uint16_t iso_max_pkt;
 	uint8_t  country_code;
@@ -653,9 +655,9 @@ static int cmd_read_buffer_size(struct btdev *dev, const void *data,
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
 	rsp.acl_mtu = cpu_to_le16(dev->acl_mtu);
-	rsp.sco_mtu = 0;
+	rsp.sco_mtu = cpu_to_le16(dev->sco_mtu);
 	rsp.acl_max_pkt = cpu_to_le16(dev->acl_max_pkt);
-	rsp.sco_max_pkt = cpu_to_le16(0);
+	rsp.sco_max_pkt = cpu_to_le16(dev->sco_max_pkt);
 
 	cmd_complete(dev, BT_HCI_CMD_READ_BUFFER_SIZE, &rsp, sizeof(rsp));
 
@@ -2764,6 +2766,8 @@ static int cmd_enhanced_setup_sync_conn_complete(struct btdev *dev,
 		goto done;
 	}
 
+	/* TODO: HCI_Connection_Request connection flow */
+
 	cc.status = BT_HCI_ERR_SUCCESS;
 	memcpy(cc.bdaddr, conn->link->dev->bdaddr, 6);
 
@@ -7173,6 +7177,9 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	btdev->acl_mtu = 192;
 	btdev->acl_max_pkt = 1;
 
+	btdev->sco_mtu = 72;
+	btdev->sco_max_pkt = 1;
+
 	btdev->iso_mtu = 251;
 	btdev->iso_max_pkt = 1;
 	btdev->big_handle = 0xff;
-- 
2.44.0

