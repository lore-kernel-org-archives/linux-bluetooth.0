Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC643390601
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659994; cv=none; b=M1Guh6Aj8rOej/vEREvT9plyicRL5OdDIsCcpLpLiHQ90e9Wtl0alKw3vAk8tE71QCjOnCwvuX40GWrXby20SwLUV88MWh20jpbw9cYjcK1RLCYwlpZi0GNiPKyskLL2OlHw5RRh2EYk+tSKcAiYKdBSXt/O7UoOaOHefcPvIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659994; c=relaxed/simple;
	bh=WODxTiyknbHwJmlRU2yrjF+kcB+ihCX8USVSvA5J5DQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bjJMH4AgZV8n08u0a8fj5be1O633DUDrnZefDcKULOT0zyl3qXomMEve2nB1qI5uDWAc0fEwOJIqpceKORB5XvfW6i+VrGFIKsaubxC75Haykn4ii1c4CuLbXEf/gZPPb9e3YJj8c7BVAkgrVusXpnb1U6Hf+3gdS9UOA3rzPf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mw1qHrr5; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mw1qHrr5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785659993;
	bh=A9OqlG+KYQlV6t6jTJ+0OpfDC77dsQsYoVDduKjxCoM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mw1qHrr5RCIy/8PKDgAOvGZhpkdFgHwRMu/IN5IDWTmVceo83ZpSASxLOixiYcVvn
	 FavFL8dIm/DZNTynFugGNtLQog26JaegsSlBolmwpg0b/p5DuWIVRBm/eYEJjhwf+T
	 okoXzPIq6a4890MLDkf/hvlivgPMYtIffpLGDS9c=
Received: from github.com (hubbernetes-node-dd7806c.ash1-iad.github.net [10.56.226.41])
	by smtp.github.com (Postfix) with ESMTPA id F3148360360
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 01:39:52 -0700 (PDT)
Date: Sun, 02 Aug 2026 01:39:52 -0700
From: Elman Shahbazov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1138845/000000-51e23f@github.com>
Subject: [bluez/bluez] 51e23f: Fix Out-of-Bounds Read in AVRCP GetFolderItems
 par...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1138845
  Home:   https://github.com/bluez/bluez
  Commit: 51e23fafe1886ad0581b7a0c83b4e99621296546
      https://github.com/bluez/bluez/commit/51e23fafe1886ad0581b7a0c83b4e99621296546
  Author: Elman Shahbazov <shahbazovelman97@gmail.com>
  Date:   2026-08-02 (Sun, 02 Aug 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing

Signed-off-by: Elman Shahbazov <shahbazovelman97@gmail.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
