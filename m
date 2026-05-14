Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1738A73A
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753164; cv=none; b=ZKvH20kQTgswx9nS3fwS7XHYsIx79lgD+jsVSy0pOlIb6aFluh9IHuQ0NL6TDz1LTCXh8aHo5QdvvdV97IhNquaQifHFuGfqElo3gFlExp0KtK1xUofDHuh/0VW/7DOvYFF/QReosZIaTAhg/x621zYZmZZ+6yW3CP8A/C+5ujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753164; c=relaxed/simple;
	bh=QB2dTXzUu8DcC3PLDgIOhf6P/k+m3AkMCSAMxJADxEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuBAoYIAHIFt2ZpBFd4DOSa2vlAITSKxmiuNXSCOFXVtAcz6f1ED8FbM0IC+iS2ZW/q3jx8ooQn0LyI0nZDAHLByQDq1IymoIcMRsQSpyn4NUA29Q+z246TJyebbUF9QmtZRPBbF1RJmZMj7xg9mK4bPzWC4V9eOBpD85MOIu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nSu0V27L; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nSu0V27L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778753161;
	bh=QB2dTXzUu8DcC3PLDgIOhf6P/k+m3AkMCSAMxJADxEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSu0V27LzLFc55ky1n5dWMdWekwjALIDn50iG42FjG/9P62/W508wdOiSeWVaWIqm
	 tKFQcTdpPredT0ypbqc6wlr9iU/OgiViGEBIShsVrLUjrR/F/rn6lB2gjMfOMns9uH
	 itNW/U4ptikZnisJA3dwCNjiRf65ccO5upeaf4KY1xCAPdMOEoDqO1USkIU/Ri65zo
	 WytMN/GZD3toSlH59ZHwa8pUn1xQYO+0LX3BXkNrZ7OWB1RPTuxSggRtBUjMPMZ3/s
	 RiClSwVcWipMi23uOaANvU/TSZe7rix8z69bQJDlIUacDnMsUFAnsXBqGFkZgoCxZg
	 RkHuLxIMPMz+g==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 96FFB17E0698;
	Thu, 14 May 2026 12:06:00 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ v2 1/1] shared/bap: set QoS state when CIS is lost
Date: Thu, 14 May 2026 15:35:45 +0530
Message-ID: <20260514100545.54572-2-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514100545.54572-1-raghavendra.rao@collabora.com>
References: <CABBYNZLcvmErUXHUXnAJOMv+saSP7aodVtfRV0QnL2-yXg=z2w@mail.gmail.com>
 <20260514100545.54572-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

This is used to pass PTS tests BAP/USR/SCC/BV-167-C
and BAP/USR/SCC/BV-168-C.
---
 src/shared/bap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 78ba22259..60710a806 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3028,6 +3028,10 @@ static void bap_stream_set_io(void *data, void *user_data)
 		else
 			bt_bap_stream_start(stream, NULL, NULL);
 		break;
+	case BT_BAP_STREAM_STATE_STREAMING:
+		if (fd < 0)
+			stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
+		break;
 	case BT_BAP_STREAM_STATE_DISABLING:
 		if (fd < 0)
 			bt_bap_stream_stop(stream, NULL, NULL);
-- 
2.43.0

