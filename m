Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43F121C165
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747985219; cv=none; b=Cuj4lI/Uh76lw5BgwIzC8kO1poR6oyhxc57LIYxcIV1y1RRNfdHQO4vrN6/goAlDmZoeKs3fcIkmFv8u0jtwOvVaTSYKR6JJ+72biCfD4xRf0ZyjaNGn1rknoIWPtMWrChE8d/IA0QmyiZd9NXE0JYDLdRIsumaZAnD07eT4yyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747985219; c=relaxed/simple;
	bh=gMPhv2EjuENxbmAmgoPUY+4fJQ0qcJb1+Vn9841bydk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mU+RwHPihFbtF1dtPS1eCsyd8m4EFFdwhmBSMcTPoYWPIMA/J1XuPVwOuU5SRxSeMyTKHmkero/lkDfIFhZTRDRduq8BaDoM/H3+iIeIJKDhwTjY1N3kP39170zNuL8ODNylcwaCW9UME6MEaqQUxAOQ6/1y7/53auHgkmVpVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C6wOrimY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C6wOrimY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747985215;
	bh=gMPhv2EjuENxbmAmgoPUY+4fJQ0qcJb1+Vn9841bydk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=C6wOrimYRJhE4/Q+EInvcp+PZ8uqMNrQZIJUQoNsf4ncuTvc57jKKlh+9er52ZQ7L
	 VuFfE2DHwWg4KdHSInsFlUs9/iRrWuZfakCVclyUM3Es0PN3e6IjuqvZUutbPC8AhM
	 epP/6oHGLGtp4IBgeswkte9qrcNuT9n+WMSpspqdPOBjv0k7AyjozHMNe8flLUC5eP
	 TJxebw5/u8t+sGOYmlli+adilK7IhBjOZ+ZAP+rKV6m1YNFO9rK6oUI6fwZET+1kEm
	 z8h3DRnST30M1Z3oevb5HvZLaLS2OMHrBeSAsg8fkBDEXWhzq15Sgvv8UbS6wObRi0
	 N9WEXN6SCHZdA==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-aF44-1001-83a4-18CE-8675-8031.rev.sfr.net [IPv6:2a02:8428:af44:1001:83a4:18ce:8675:8031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B2E1E17E1569
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 09:26:55 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/4] lib/mgmt: Add MGMT_DEV_DISCONN_AUTH_FAILURE define
Date: Fri, 23 May 2025 09:26:44 +0200
Message-ID: <20250523072647.689324-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523072647.689324-1-frederic.danis@collabora.com>
References: <20250523072647.689324-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 lib/mgmt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 6af82fc4a..2b45010d1 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -870,6 +870,7 @@ struct mgmt_ev_device_connected {
 #define MGMT_DEV_DISCONN_TIMEOUT	0x01
 #define MGMT_DEV_DISCONN_LOCAL_HOST	0x02
 #define MGMT_DEV_DISCONN_REMOTE		0x03
+#define MGMT_DEV_DISCONN_AUTH_FAILURE	0x04
 #define MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND	0x05
 
 #define MGMT_EV_DEVICE_DISCONNECTED	0x000C
-- 
2.43.0

