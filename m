Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA82283FD3
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679063; cv=pass; b=WPDmHKbbpaRrBwbzIlqxLwCC/LW+Ev0rnmQ0KAxJkZW0O8/oHbPkHUSlhsxu1CMDxx+/dXsyXkxyY1dXmaJMC1reewXQbbz79X+WGHAS4XbWFkvkm7gX/sI0Cgm3nnSV8mVPEj//vG6gS6oEMrOPNTs+oIaFnGNBLcoLePhhRcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679063; c=relaxed/simple;
	bh=zsGWCvknZ0Q0AliH2uGp+zYJlpbO+dHA+3xTJwkWE9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLzt8We8fH21YHwW0RcodKhcnsxv+/nwFcgGM9LVd9+HSwQbSAMcNMANBU6JJYGZfiCQNJYeyK6MV+gEy5fE+Ry4IXdkq7l9mp5HbYogArZZCVU4ux7XVnzACxOQNsxfhARZW2YexT8EKXRgIhR64/d1jlNDwIjDB2DlOraEfrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=fVXAu606; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="fVXAu606"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bzCly2k0yz49QF6;
	Fri,  8 Aug 2025 21:50:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1754679054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsVKrWmnVcZ84q7Hm/t0fORLiir8DPkqMUd7DEgoxIk=;
	b=fVXAu606vj9W+2e6LILto+uWnTlWFkas2BPCkVS9h8GoAHjY/k/Gpfa6e0N8sYphKmbhjN
	3wkV48YMAVKYQJ0Ml0ovV35KUZEiwAEvKhpgk6ar/LranXYjwWTrZ093H1/50avgGcKQVU
	lNwQKgCJ5QIdF42cC6o6gNLBBFX+9eAEC5epEiTasxt122/sdOCqth6+V/aPL9Ny3H1BBZ
	EeFGE0J7Vsh4OluCbdITkWNtSxT9WVHkfBz7JaYJa1qcrCR4Skz3XT0SNG7UWvkJbWVLaL
	rrsC1UjNx6wHcI1rqkYLJ7MQfEg0B5y2hmW9c49nshnB7nFCzZYbPsWGb7ChKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1754679054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsVKrWmnVcZ84q7Hm/t0fORLiir8DPkqMUd7DEgoxIk=;
	b=KhNV919imxEL1ccrZXffuoAN+SPlaSChNylln5O0ITGJ79R/G9y7dX58AcmBc9Il851p86
	pvghr9OWZZM6x7QcQre8Yl5Y6jtgMjZ2gW4KhzbgNdk7Xs4pJ/YXhp5RYu++v7mjD3Lsp4
	NE9+nCzTGJ0EiuYoeIASGFQgbZgSSCHgeIMP58k4T4014+F7v2As9A9SK+D5emH7JmQ2BX
	vvDvoNIJ/uMqSZnXk3hmBO90DpbFvS6BXhiTHUzvxu0Vy6O3CuFlaTq8H0SvCWLySqsf1Z
	adrPf5+aIx25xbQdGU4WkbARv3/Xba+x9S19BLZSovPlQ3ntHLKyW7wSd485sw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1754679054; a=rsa-sha256;
	cv=none;
	b=H5COOImtS3Ef9eQeM97J79dgJwMigUnOKmtPd8UoBn7VtRBXTHQSHaFEoOS8w8/qQKpcWh
	CA3eO5UtUtiSYQmes2NEq1XgTO5manBvpdixKdwJBw/qLTmhQNKxMogFbLxfB+xgaLESn3
	buSHMYOcuzdMqOpl9zqULCzddybbDi+VK8H3YLbTIuNkqK3+s29U6qc0I3F+RdUIebfRmA
	UkWS4BC4z0fh9I2IrmgU+XHpAAjHfW+3g+w9CvvYkM3pLRpgb+iRYOwWOfkzFfgbjatIaa
	Na73Q3F8xkoRRDK6ywrExH7UTvwvbczQITLE57+vwU4Jv6tA0lnvPxdi7JCaVQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 6/7] bap: clear server streams when ucast disconnects
Date: Fri,  8 Aug 2025 21:50:38 +0300
Message-ID: <434f6ed736053d57f6f79fa11a26eedf31a07141.1754678883.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754678883.git.pav@iki.fi>
References: <cover.1754678883.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Streams are freed by bap_detach() without state change callback. Clear
data->server_streams explicitly before bap_detach().

Fixes UAF due to stale stream pointers in server_streams.
---
 profiles/audio/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a75919102..c463e6a8a 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3768,6 +3768,9 @@ static int bap_disconnect(struct btd_service *service)
 	queue_remove_all(data->snks, ep_remove, NULL, NULL);
 	queue_remove_all(data->srcs, ep_remove, NULL, NULL);
 
+	queue_destroy(data->server_streams, NULL);
+	data->server_streams = NULL;
+
 	bt_bap_detach(data->bap);
 
 	btd_service_disconnecting_complete(service, 0);
-- 
2.50.1

