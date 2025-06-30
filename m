Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0EF49625
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270574; cv=none; b=V7gSPZjUsJCGirYtArd0OcmkBviMqG0/Pr8oTPzADlfp/+iwOU58j5qMiA9vvCXuc6COWIfRjDvOzzJMqj2DCNrFok9H4148YR7AiNZPC48Q0CkfcySxmdgXPANG7JVfj9gwmFsafWTAFJBbbYEtQDvklIYl67X7+1R6TTIlAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270574; c=relaxed/simple;
	bh=X2unKFiKul4A0ubbaCDf/GNKDuc8drVAb6uE9Rr7Jsk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EHIIewDpLmv1qBcpwScErM8xeVw2svSGsbKE2qDy+CKlZq+S+oIvsGrclcSwZMAe0H2veVdTVAwlkndZ2YaaXAVwEFxsN4fcgpjadcBzMWEMY5scHj5j5OR/+OTzfDysNkyq+NFMt1lzmvgqAqZelVZLiWcyLrjRz1ODJZOhDp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8KUcioh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8KUcioh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2D96C4CEE3;
	Mon, 30 Jun 2025 08:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751270573;
	bh=X2unKFiKul4A0ubbaCDf/GNKDuc8drVAb6uE9Rr7Jsk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=j8KUciohEYsPPdUOggS8Fhh0zVcRCYr9xy3NGFeFqmo6/dLAese2utYDDj885S4w6
	 zCphPK65oBq/VbdDXgRPeevLUNh4Ad9xbZFIY2I56OylA+r7eIIX/sYXgca9DsKdkU
	 hTTL+QPlNHOGwnRkiu/l96K9bIfNX8Exz3PZQx0iKjYMrrUtWky8S6V7TG7umgzDC9
	 j3ZqBbqIab2EIrcZCflPmxO2gTIeW+zME8zP2McGIrzuhi5SSRV+yS0nLSPRlAVvcd
	 dXwexh4xaXfoy7tzHw7OhV1sZLgIPX1URIf5eg6cLZ4Zjqj2j0cfTbhlKGQ9P2pxNg
	 E2WJsSQI1zpWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2519C83028;
	Mon, 30 Jun 2025 08:02:53 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Subject: [PATCH BlueZ bluez v2 0/2] bap for big sync lost
Date: Mon, 30 Jun 2025 16:02:38 +0800
Message-Id: <20250630-bap_for_big_sync_lost-v2-0-1491b608cda5@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ5EYmgC/4WNWwqDMBREtyL3uykx1Yj9ch9FQp56QY0kVmole
 29wA/08M8yZE6INaCM8ixOC3TGiXzKwWwF6lMtgCZrMwCirKWcVUXIVzgehcBDxWLSYfNwIf1Q
 N17xpjVKQt2uwDj+X9wVqetsv9DkeMW4+HNfbXl7lH/FekpJQ41oqqatrQzs5T35Afdd+hj6l9
 AMfd+6XwwAAAA==
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751270571; l=707;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=X2unKFiKul4A0ubbaCDf/GNKDuc8drVAb6uE9Rr7Jsk=;
 b=0LAxtze6T/2DlZKt8pESJfdlSgjmbaocRFZTJnakISWf8jrMoFt1lyeE/wQfL/dzo0SOOOar5
 Zba1HjeBs8BAohAsGMiFX6sZo7is/ftD3+w5NVqHsHgAuzPOuE0D0hz
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Signed-off-by: Yang Li <yang.li@amlogic.com>

Changes in v2:
- Add state check in stream_disable.
- Add type check in stream_io_disconnected.
- Link to v1: https://patch.msgid.link/20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com

---
Yang Li (2):
      shared/bap: Set stream to idle when I/O is disconnected
      shared/bap: Add stream state check in stream_disable

 src/shared/bap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)
---
base-commit: ae1b7f6ba805f82742bbc32ff275e268248ef9f8
change-id: 20250624-bap_for_big_sync_lost-63476c679dbb

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


