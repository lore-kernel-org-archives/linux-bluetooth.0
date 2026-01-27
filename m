Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CCA2EAD15
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536940; cv=none; b=g/LEPJ/TbhWvOAO59AvB87aWQht2mBxxaJoGKGSAnFwb60hZpOU7qlVCMn0ArZhIghxdRfdsdL+DlN4lCNkZmGI7yMZ7hWwcXztP8sk2tJH3mtTwp22uxEEGonHOCcz6+uo9OAMwkki9Y4FEPVB5FHAT8erwRyZAgEWUy+6gUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536940; c=relaxed/simple;
	bh=BsRFMcZRH0WT3Ku1PfBFPQzVrKjPp0voX4s2JcIf0q8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CJpY25supuNVIp9oMszEEhGWmr6dEl0z9+h+8D+Tm9YR6USL41HzhLTzRLD7S+W2DlQ6J4tpS8B8haUksZxK0v2vUZb4AqqXbOnJ8qGcgpbodvDnJOm5T0ZBjdlE4mo6l8kdQNkYx/MqxTmlFXJm9Ogce/W28vOSkWrEuZaV2XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Q57nCxrc; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Q57nCxrc"
Received: from github.com (hubbernetes-node-70fb4b6.ac4-iad.github.net [10.52.177.43])
	by smtp.github.com (Postfix) with ESMTPA id 41F6C40134B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769536938;
	bh=4+7aBvfSRLEjXPSq1LSD1hap3Boc0LTLCA+es6rf00I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Q57nCxrcQv/wFLlUyW1h1zgSNjjKqg990wON1xpGy3NLtVcOjtGSXxoaXrHYLh/KA
	 k0CGdv/0CclpyF7YGUyCY+6gaP+zr9QIVPb8Tju7aoX8LzqRRrK3NHLYXO/cm7oRjo
	 fxqkhqxvD5WQQf3QqYpD1V9UP6T6OYwODxEfup0c=
Date: Tue, 27 Jan 2026 10:02:18 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047685/4df918-000000@github.com>
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

  Branch: refs/heads/1047685
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
