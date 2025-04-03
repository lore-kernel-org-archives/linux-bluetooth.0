Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1641B672
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Apr 2025 03:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743651468; cv=none; b=OvIAGBjYq8C/Jk5DexmT+3eTrmduKHGp0P61AxO70RVaToNs/IxGLPJM4VSJRgCiA7aK59czTcnesYXr4sMlfCSdxgAWaoOQq8oYQPKHGssoEf2izHrPsjm57bjx1/EMG1G/NLqMYcpYGx4soptnpWITdn0EhBCX2XnV1vpRwpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743651468; c=relaxed/simple;
	bh=VDuFQn45MbrFNzhyR99JCAyDA0xzti2Yk2pyVybfqt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LM0Io3ki/gFkBMvJETdB2RnHo8vaJ0xuqW9s29qed2HKIuFEHwkaOzaCUtagp0/84OXgtwJrkXYxHqjyTsRuy/coPVPg/HJaP7wq51i3GwDulQvvURtLz0iwraJ5ClvoNpdIX3pmFVDa0oEyCuVw7M29BGmBj9UCtIdLZA3EdPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eABf4Pi3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eABf4Pi3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36C40C4CEDD;
	Thu,  3 Apr 2025 03:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743651467;
	bh=VDuFQn45MbrFNzhyR99JCAyDA0xzti2Yk2pyVybfqt4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=eABf4Pi3Bthr/nX1UD3mqe3FXTex4HpRwPSDoni78WXcS7BvK6iLV7BOa+X3zb/df
	 I8UOmk/0yvBTj8R+oNO9lIM3MRwxm273fTLbiF4Wuvef1y2Tb+WaKdxBBDuaUHbNk/
	 Dzaz62rYbSfzGoKQKO4FSr1zT7ySiynZmw01cc1sRZlUcQ0k+WKU28DV/60VS7R3zC
	 jrC9n++jzdC26RUTKP3rdD+BJumZVPO0QC1mxdeZSYfIEMryX+rrPVr3X8gVUUL9lH
	 uLDmZ7i0qx4yQL7/NsdRch8DGYx3ZtuYb9vhlVc3T66N6qc/r5zSDJJSGGbjAtSbyA
	 xC609TjNRE88w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AF6C36014;
	Thu,  3 Apr 2025 03:37:47 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Thu, 03 Apr 2025 11:37:44 +0800
Subject: [PATCH BlueZ bluez v2] bass: Set the service connection flag when
 BASS connected
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-bass-v2-1-7925bb16468a@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAIcC7mcC/1WMyw7CIBBFf6WZtRigL+PK/zBdDDhtJ2lLA0rUh
 n+XsHN57j05BwTyTAGu1QGeIgd2WwZ9qsDOuE0k+JEZtNStbKQWBkMQXaelNKYngwqyunsa+V0
 ydzDLi74w5Hnm8HT+U+JRlfO/E5VQoqa+rS+NGhHbG66Lm9ierVthSCn9APRI3nChAAAA
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743651465; l=1169;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=/oUaFNQ9t8b1iPPgrFaYLuEADjVumJlRJxChQ0j/KrM=;
 b=c4YzSA5IL2+JAoCgrorUlXBUjLadnz99nJM5RGBTkkeEa+PXD575gTEGiTEvYsbgvFLzuhc3k
 EwylsoSekhEDLtHmQAk4Vf3t45EaFjAxQVH8yYCTQ37O9Har32bWGcS
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

When BASS serice connected, set the service states to
BTD_SERVICE_STATE_CONNECTED. Otherwise, the device will
timeout and be removed, triggering the automatic termination
 of BIG.

issue: https://github.com/bluez/bluez/issues/1144

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v2:
- Set the BASS service connection success flag in the connect_cb function.
- Link to v1: https://patch.msgid.link/20250402-bass-v1-1-3e753841faa5@amlogic.com
---
 profiles/audio/bass.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index c36f43277..c28d9d1ad 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -321,6 +321,8 @@ static void connect_cb(GIOChannel *io, GError *err, void *user_data)
 	if (bt_bap_stream_set_io(stream, fd)) {
 		g_io_channel_set_close_on_unref(io, FALSE);
 	}
+
+	btd_service_connecting_complete(setup->dg->service, 0);
 }
 
 static bool link_enabled(const void *data, const void *match_data)

---
base-commit: 0efa20cbf3fb5693c7c2f14ba8cf67053ca029e5
change-id: 20250402-bass-66200bb7eba1

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


