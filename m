Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846EA3F412F
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690099; cv=none; b=JZq+Ycz++9vQqbbVOwVHGWVkMemwKUvWTxnYc4lQBLAccHr5AhxBkay/zB2t+UKk5OnZbMYt5zjF65BrtCycQmyajgd8Z1ywKytWslOWsm5YNIZuJYoVD3E9tIkVoWUROCZT5gF1kQa9omJovViyQ6eQSBcV5eEk8AsJg8hPXfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690099; c=relaxed/simple;
	bh=P096Iit3Pq9QqlNZEjTZNO6+6l1tEpsE92aD49M31oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6NsAm7RvXGNkvpIDstO13c/3b4kuF5ABZyC5JgNu3Mm9E9BnK7nTyBGwJoilxQi/p6ys2IWwuUZ+i6RAzS46U9b38jhOWgB5ub8dNH8zG++ZTzFm6ljnHSnBF3tkyPj4x9PCnKveW5pQMz/cff/1VGQVbhr/Y86N2q8SqSo0Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PNk+jRPe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PNk+jRPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778690096;
	bh=P096Iit3Pq9QqlNZEjTZNO6+6l1tEpsE92aD49M31oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PNk+jRPeRwiMBQQLjdpuXGjKT9OjF/IvBpZkiu6GO4MOMSHH8o57jjJAUWxDvJsYo
	 wNaaygubjKB592pi3HUZPlYlIQX1zqN3id1Z6eM9EES/RwlRUvYhJCEbucJ3i4is2L
	 0Ge7oSQUMgVliRHFlafRT353a7PXoCLPaJdo70mOzNbngF0zNEhq+Kvs3rDoaffIln
	 loggS9KOWeqbSAse0uxPhIXd0pYiMISWk9HmAPbocgnNC5yB/xwj1GRwd7YUH7RcJw
	 ubIL6wOsaVIsBUIQCJNJdaYV3V15x8XZtiAYUTD7u7dz+ZYLQ6lzVZT2xPKf15RoXp
	 sR1wnQCJSS9OQ==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4AEF017E12AA;
	Wed, 13 May 2026 18:34:56 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ v2 1/1] shared/bap: set QoS state when CIS is lost
Date: Wed, 13 May 2026 22:04:35 +0530
Message-ID: <20260513163435.11344-2-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513163435.11344-1-raghavendra.rao@collabora.com>
References: <CABBYNZLcvmErUXHUXnAJOMv+saSP7aodVtfRV0QnL2-yXg=z2w@mail.gmail.com>
 <20260513163435.11344-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

This is used to pass PTS tests BAP/USR/SCC/BV-167-C and BAP/USR/SCC/BV-168-C.
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

