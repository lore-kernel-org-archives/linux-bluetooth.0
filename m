Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A1136664
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706139866; cv=none; b=eMUYQzWU296lUfzuTMtVhkXQRBmPLhprpkKgXTy9OAMbi9/Yjh9eI6wWs7eDwpP3mkpOcN0GSPDXLrj2o+4BGA9I8pGfYp+91ffgttkUfchSlk3gJqkg5IF9EsoSw1JHRkGCi/qK3AfXvDUGzLzidxBStrDP4Ptqp1MSsnQd58c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706139866; c=relaxed/simple;
	bh=CAquu6St9+YE/1js7fAfthjtnyafKD0QqkYrZLGZyVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLka8iDNhglJTsV3+N/UfpPnS+ypMqe5fKByRohFsvMdytFiWE+CV3bnXG53hmNG43MoiPiMLAdhmems5P52tiKPT5QMCUHAHLhiVP33x96zLiZjGCcvMRkQ9gLOqU7XeOCk2ThZgzmhZcB6q0VwdoPxR6Q8iiPzmRyzYHjf1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2VBMA8n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2VBMA8n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FE67C433C7;
	Wed, 24 Jan 2024 23:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706139866;
	bh=CAquu6St9+YE/1js7fAfthjtnyafKD0QqkYrZLGZyVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r2VBMA8ngkV+KTuLlCldxEnxPBG/MklETgPkKTR2J9RxpqCqL1Z5FbnqSdluO9Aju
	 rVEUjY48c+Lgy8blGfEVnMHsTcCSwFOMEMmf2ewulDoIcQwZCeRB3Mlb8kL4ef3dN6
	 4m5bMCQG9y+dIA5Fy60fVLXnihoIlKEKaGkZbwk7TOwG9iBU+LLm11ImX5ulxLAM/D
	 HZNloYJ2ZEfjbds3hFWEi6WaXwm5dr6PjPdlMncA+RG2Z4/TUYYCfXWfmz3MJp/r5K
	 uxwoJu4O0CUCwGoU00FwT8vPqzb281gFf+dM6Ml1lc92XSypYLKdl/w3n1blKBa1XH
	 strNa4khh7P2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEF5C48277;
	Wed, 24 Jan 2024 23:44:26 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 24 Jan 2024 23:43:56 +0000
Subject: [PATCH BlueZ 2/9] Return at least the title attribute from
 player_list_metadata()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-disto-patches-v1-2-97e0eb5625a3@gmail.com>
References: <20240124-disto-patches-v1-0-97e0eb5625a3@gmail.com>
In-Reply-To: <20240124-disto-patches-v1-0-97e0eb5625a3@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sam Lantinga <slouken@libsdl.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706139864; l=669;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=bHLjtE0BG3PUYg6Jf5Zv16cafv879d0HdvZOTdHzrz4=;
 b=qEzrX0iEvgFW8dbFzlXNy1TkJfsjRtbIJ9hNER84Bn597DR7apDT71vdoiNQF50Hg7Dn44kND
 9e8w8jrrjsMDpMdcVXUnkImkznHH1x2ZmkhX9YrEg9mLnD6C74v1Kl4
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Sam Lantinga <slouken@libsdl.org>

This fixes Bluetooth AVRCP certification test AVRCP/TG/MDI/BV-04-C,
which requires a valid response from the get_element_attributes command.
---
 profiles/audio/avrcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 439fa27a9..36ce01a14 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1210,6 +1210,10 @@ static GList *player_list_metadata(struct avrcp_player *player)
 					GUINT_TO_POINTER(str_to_metadata(key)));
 	}
 
+	if (attrs == NULL)
+		return g_list_prepend(NULL,
+				GUINT_TO_POINTER(AVRCP_MEDIA_ATTRIBUTE_TITLE));
+
 	return attrs;
 }
 

-- 
2.43.0

