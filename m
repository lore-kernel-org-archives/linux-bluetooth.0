Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A91A38D0
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440497; cv=pass; b=DXqsUVPjNHIWcM2FViRFenpRGeSDWhSzMVco8DGVZc04fQb+KpTj171P5td/f161qIuinA0l1dzoALY74zMJPIUv/D7eVrNGOS4k8762if6J5ft29eA64mwQXvXOtIc0YcX2dTazdz7SRg601knDrbnHjOCDEO22HEds9+2BkQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440497; c=relaxed/simple;
	bh=K+u0oLtWLd+fmilQfy2XV5Q9USzIQs1tly6O35BIZ+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2sXglnFHJLj57Nsxx/GkSZwLTZM0BSJ/RmBBSRFfWnkC6OkulXpUqma/bedfh46dDl8yu4ZKBB89FDhSIXDB/Ymui8T220YzDDZifPRzzlQq0Gbcz4jEC26ZVpGWBadlisM+MfnCKHhGdFD/uPMA88CwHraRqxeQvD8Ji6mx1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=B8hcOs5F; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="B8hcOs5F"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TwbLH1B2pz49Pv3;
	Thu, 14 Mar 2024 20:21:27 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1710440487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbJSH9ORtrrC1U4ANhQMwZfXmtBmrQ/6M2eokaZ+tVM=;
	b=B8hcOs5F2idyKd9SwfLRnBHflemwy0PFZ9BRnrZoERLLEUsHApKE8kHVplPDuWUzHqNWsm
	0uaywo8tL/sdolVhK7shfZrxunBjuIvHq17+opjBGc07eVpJeAfaJxxP7FgqxXJB6YrFqG
	AkEsCyezoWGaM4PDLIIklwp2JHU1mUYPMDx5nRHqJjnjuuQIq4VoDnnwBeI/K33T/dtEc+
	bvOUaIZ5UDi1JQbj+Hynk0blpxHGqdiLvUk7qq4NFxCAiyjvbc5dqTQgi3hp4pqlWlJjod
	Uc4hE3lX6nT01DzsEfDKPs560klAnKWaPhbTS92w8FxpDJjznz8OBfLG4nP68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1710440487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbJSH9ORtrrC1U4ANhQMwZfXmtBmrQ/6M2eokaZ+tVM=;
	b=L3iUAz+7FBc7F3CPzNoXmitbVvQyt5LpcCgM14CddBa7WwOxzdcNXrAP/GdMlvxSWPbyZn
	udHIWJGrIKTzfoY4E6WUJ/qC/YaYEtpdWzKDqqG0//HGkEHMlAofZtpMdcVi8joS4Jc4Zn
	CDHbRcwgPQSmZ8SIdYFcJfS8mH0R7EChBcepg7100WwEj7SQ16nqzfA5RhNHSBpiWO1bML
	FXmHspI3EymHQJ0X9CF1WIIdOpo4F2ylrXR9i9nbun7fcJ4mvQa38Apl0g7TC34jfoiUCi
	MMRd6JF34FS1fp/wx+gKYuFJO8IWO89fyOtVpU/33iC3SwpTp5mPDsOuGpsDqA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1710440487; a=rsa-sha256;
	cv=none;
	b=deDEDPTIKX1nxtjkiBEZPIGHjlv4EaKKpgyQN5IXhXMH0Q7lME9MqtUEPPzizWT+ejv0Uo
	rgD5uhIvx/RE5n/4hnbiz83ORr0M7KKO/atfGie8njt9DUD1cpy4C4HSXtOQyowzpiHSdv
	3bhV32uxOv7keaJUu19NmDXCD0wpfx5N+J8khOy74HjkuAI+Jh+bpxUC0/uaj+lxUZ/cQ0
	vlUq+9S/JWrRPgZMVyTk32q0ifDUwEtMbG1Bbi3A77Ys513UCVuqr2/AwdTezVTiC25gLu
	8vIHm5nIokhWs4a2E4O9lVC4gK50O5Ui+jV3E9vKELgBAMIPq6osmTu6GCrneg==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/9] lib: add BT_SCM_ERROR and BT_NO_ERRQUEUE_POLL
Date: Thu, 14 Mar 2024 20:21:10 +0200
Message-ID: <1e611b09ab57ce0ba42c377a75f12a6eaf70e133.1710440408.git.pav@iki.fi>
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

Add new CMSG type used in new kernel TX timestamping support.

Add new socket option.
---
 lib/bluetooth.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 75dc960c8..7c310a69b 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -141,6 +141,7 @@ struct bt_voice {
 #define BT_PKT_STATUS		16
 
 #define BT_SCM_PKT_STATUS	0x03
+#define BT_SCM_ERROR		0x04
 
 #define BT_ISO_QOS		17
 
@@ -239,6 +240,8 @@ enum {
 
 #define BT_ISO_BASE		20
 
+#define BT_NO_ERRQUEUE_POLL	21
+
 /* Byte order conversions */
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define htobs(d)  (d)
-- 
2.44.0

