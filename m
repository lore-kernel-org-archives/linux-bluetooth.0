Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F01947774
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768160; cv=none; b=E5eJLczSuvVlX9FpsXbUyw6XzaF0RuYLt8VudLNHsOxkSE9yne8j41X4tbDvcGnI+k1K4h79wJHRhJzz+9UKHbEL3HOxpNKlGdoqFph39snrdozfo5Hk8SH1eu0qkMy0jmUvU7TI+Ok4vhQLbU6JzIKuGVKawJNPN/mPOYSScUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768160; c=relaxed/simple;
	bh=CAquu6St9+YE/1js7fAfthjtnyafKD0QqkYrZLGZyVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fXSBgqk0tt+MbXdbk8LwnOQPmUsFneWKX+dVpC+51MmQyXNkLiopimqXGDnBfBwhzey8MkNiLJn/+GIPWcbdjEwp0G/+vrocNUrFFaKmctAVeLos3Po82kXFMNgezyfTPFIoShid/otLBq/b8kFaPAqtQAYV/MTurTXLyaZgZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMw99xJt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMw99xJt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD0DEC433F1;
	Mon, 12 Feb 2024 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707768159;
	bh=CAquu6St9+YE/1js7fAfthjtnyafKD0QqkYrZLGZyVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LMw99xJtzqZTC5ewyNSwUdnLDir28dZ5JKDG69WuSyaFwhwBJmcH5eyfTlLRRsiSZ
	 gpn3V3jdCTDLXU7yhbEfOjUiAcMWZw29tqwbCRlae67nYaUGmcSrFb/dUElImburV0
	 hTf8e6rD6BX52NGO4VtYVcn8pFr3gmeBLlURwE08sePHajbp4/PG8yY5jTgsqs2Mgd
	 6iylsRQ7LwghudAgDbMPx1DfSXlEyWeDh4/cLf3nIsW862907FRgq8n5803BHNteas
	 kW7gJocI3/SbzFqRaw/YlZN7N2bT1H57BrK6ztLm7fPzw/Coy2NPsYorWwCAvtqqa0
	 c0Az9ykjHkHGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25C6C4829E;
	Mon, 12 Feb 2024 20:02:39 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 20:02:37 +0000
Subject: [PATCH BlueZ v2 01/10] Return at least the title attribute from
 player_list_metadata()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-disto-patches-v2-1-8bab1bd08f4d@gmail.com>
References: <20240212-disto-patches-v2-0-8bab1bd08f4d@gmail.com>
In-Reply-To: <20240212-disto-patches-v2-0-8bab1bd08f4d@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sam Lantinga <slouken@libsdl.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707768157; l=669;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=bHLjtE0BG3PUYg6Jf5Zv16cafv879d0HdvZOTdHzrz4=;
 b=lPBdaDdiQpidYd3FrEXZfUvhbbag4qQnneh3NTvUU1h3AliGylEKB+1kEq0S7FyDiuzNgM6Rk
 P4sznH5RHq2AWWw/dc1KsyovnQo3mHWoaaKai7N4c+mXcd0ukyW6A1L
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

