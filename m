Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168A9405840
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930568; cv=none; b=aiYM/KKCXLPpeA/v01W6DyEozmALq4gDbwr0Hu18W7uw3z+rfJEKfTB1vGBd7dGg05MABcUoI9PbBKacE/GsGwKmhbE6LXnPtUwpgLf4qQZblr9Ls8WJRhjcvXCOTsBCK2pw5tc0m/SMEgrhQKnPbAKEa2B6vKjN0uMRDwSCgcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930568; c=relaxed/simple;
	bh=oZ0iC7CUm2tAuOIr+FfjOrZIqubCkICrOa8v98zoHsY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iVuf6EYqZnPjOi5Q99RQ/wiI2RF1zb6osX3F4RZRKJl7BicZ/WECfQx/5B98EtePZF54daGMd6GxcG5tfEHGnyhemgRx4fbG/oR4AryaccOY68Tg2AURotx9D6uRuopxpYr8YKqRP082n8RqN293EnySxIOWkeXaurW/o1tFY/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ao5fg2ZN; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ao5fg2ZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780930563;
	bh=We51bYPRkVzoXRo6EkjUgdz/hRWKoJP1D8lITVkrveQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ao5fg2ZNiGuNpXlGh7QdGd0fDHS/YxEMddRlQ3yu8dZNKRqHXcUH/+w3272chcBuY
	 Fldl/tzrAuHJ1ZFonefuJSIQytaHjEVE5JG26VDMr1YAay0WXpTO9Vg76XpY0JJ7WA
	 k8zB4n94ZlBmRahuzx/JL4eJKPTzq7knvHivnSpw=
Received: from github.com (hubbernetes-node-fb76070.va3-iad.github.net [10.48.168.35])
	by smtp.github.com (Postfix) with ESMTPA id 20F308012D6
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 07:56:03 -0700 (PDT)
Date: Mon, 08 Jun 2026 07:56:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107770/374f7c-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1107770
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
