Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D17D2836A2
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413518; cv=none; b=YMe7jl6O4P4iEW8USHWV8/djZCZP/V0vn8urS0HoDLw1tYmU7VVnxl4/WYzWRA26X0ikvsABilFnC7XWRtJZyxYXKIMn62S5qWrjN3mMvBzxL6RvM3H/VJj2BzIzwLjT8/r2Mt3pItLO18chBs1Zdo/14N98nLFt7erNSw7J4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413518; c=relaxed/simple;
	bh=sfM75phaSaY5qfNrjuDNmEiOngmH6OuJEGanUhZsiiU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HqdzT135Fh4zHHGH6yB+HhQ8BxutWQvMdDakc6IHSGotMh4Fnn2BeIokWpaa31RWXqm4kEEdY1aDCTI17yYXpb42bS8gqIUMTdCV/hHjX25j9b1N7XF3EpCOvUcPNNZD6uihAi/WCJYv9qGMnFV65PwdevI/pmDC3Q5CFdZAa0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HslWs6XM; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HslWs6XM"
Received: from github.com (hubbernetes-node-cf50fbc.va3-iad.github.net [10.48.148.35])
	by smtp.github.com (Postfix) with ESMTPA id 8C5618C05D7
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750413516;
	bh=v0VtH1ZDNKbCZVR8KEjx9rR8SyhXNDXwb25IC9IQ+NU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HslWs6XM2s5tYiRw3TS5bV0EBgxRICDM+6DHdn8ceKM7/Fni6Ju5sWAeu6RqxgvLK
	 yk9Cm76F5cLmFWCa+VwhvPZKSxqyfrRsZr3LARZpn7VgXbcLvYgFZfaj+JXutiW/eb
	 GqyW2m6lWzAd7IG9stMEGI+ugA0RvX7EvbliEozE=
Date: Fri, 20 Jun 2025 02:58:36 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/973184/d8b0b4-000000@github.com>
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

  Branch: refs/heads/973184
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
