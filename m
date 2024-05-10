Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9151416FF36
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343258; cv=none; b=G7fjBqD22ES7IPQHtmeFFK1Y/gslvCEPuhAmTEcqmK0JXPeUbgZs8arTJdSAGEVVumnFYAj02XnSL1G7hA0Fs8pfcm0Jz36gIAywcwLVo6f/L8eZ6ttSmdycE/C6N30+hBl1V5FiamENw/OlFDK8LJ9RpdNQedffflNIw8TpSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343258; c=relaxed/simple;
	bh=fVvu1kVLHA9vVPjO9GD5raAV6dYPFeKU1uN7kzOM80Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vsnj4qWFTLJ4mfkO3oCzuiP2OuOdd2OScFazIFr9400xX9tdYDJ4k2aUribe/PAz76HQSrqIojiJNSzxr0Z3v3elGvbM3YXngitPkDhXeC4NInILL3TljdlimpwMCJLlg7ht1f+L3GqLlSqOebaq+WpSUK/JKXOqfELJvXwgICs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66A8960018;
	Fri, 10 May 2024 12:14:01 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 19/20] avrcp: Fix uninitialised memory usage
Date: Fri, 10 May 2024 14:10:29 +0200
Message-ID: <20240510121355.3241456-20-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510121355.3241456-1-hadess@hadess.net>
References: <20240510121355.3241456-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: UNINIT (CWE-457): [#def35] [important]
bluez-5.75/profiles/audio/avrcp.c:2550:2: var_decl: Declaring variable "name" without initializer.
bluez-5.75/profiles/audio/avrcp.c:2567:2: uninit_use_in_call: Using uninitialized value "*name" when calling "media_player_create_item".
2565|		mp = player->user_data;
2566|
2567|->		item = media_player_create_item(mp, name, PLAYER_ITEM_TYPE_AUDIO, uid);
2568|		if (item == NULL)
2569|			return NULL;

Error: UNINIT (CWE-457): [#def36] [important]
bluez-5.75/profiles/audio/avrcp.c:2583:2: var_decl: Declaring variable "name" without initializer.
bluez-5.75/profiles/audio/avrcp.c:2601:2: uninit_use_in_call: Using uninitialized value "*name" when calling "media_player_create_folder".
2599|		}
2600|
2601|->		item = media_player_create_folder(mp, name, type, uid);
2602|		if (!item)
2603|			return NULL;
---
 profiles/audio/avrcp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 36ce01a14eea..752e55be37a4 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2555,11 +2555,10 @@ static struct media_item *parse_media_element(struct avrcp *session,
 
 	uid = get_be64(&operands[0]);
 
+	memset(name, 0, sizeof(name));
 	namelen = MIN(get_be16(&operands[11]), sizeof(name) - 1);
-	if (namelen > 0) {
+	if (namelen > 0)
 		memcpy(name, &operands[13], namelen);
-		name[namelen] = '\0';
-	}
 
 	player = session->controller->player;
 	mp = player->user_data;
@@ -2592,11 +2591,10 @@ static struct media_item *parse_media_folder(struct avrcp *session,
 	type = operands[8];
 	playable = operands[9];
 
+	memset(name, 0, sizeof(name));
 	namelen = MIN(get_be16(&operands[12]), sizeof(name) - 1);
-	if (namelen > 0) {
+	if (namelen > 0)
 		memcpy(name, &operands[14], namelen);
-		name[namelen] = '\0';
-	}
 
 	item = media_player_create_folder(mp, name, type, uid);
 	if (!item)
-- 
2.44.0

