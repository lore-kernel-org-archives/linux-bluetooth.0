Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827EF3603C0
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071985; cv=none; b=XXoJxuebH498YWUB3DaBS1G+23boGNe9HgHos3lN148TRG2BXDj7y0t0C/cGujTsboGw3C5OhdQJw5r7AxqPxfrbAEsD9LR9evecHfP+jgxoe/hegeISmGmxRDAJz/6124HGrKOow7hKdmkazZPS0geXGj+ATt8Gr34h08TTh2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071985; c=relaxed/simple;
	bh=b9ZBV8ZqFNM8e72IswoS/K1qNUTMfM3TQCVEhQF65lc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MuSemV4NgxPGvG43Fpv6KhfmbTY7OTocBgHl7UW/K8C5HGcZ9ZEmtes24vdB/ft1iGwDpqdfsy/fIDl8pwQpaLtrAc90YDaaFl1nr7FJRRUGCtQW9a1Qyna1hRiYovxxx3B9P1PxpvNRFT1NC1sEH6yYLOY4QStCgMn9qoMMxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fAgYba5m; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fAgYba5m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780071983;
	bh=/Is0dT4eHbAFt5c41hsf+lvCjQPFk8KEeSlCB+8GwHI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fAgYba5mTvFG2rle4Vcum6KAaF1I3nmC+r/ASihLhHaFqm1j930BIY9FfNI1O9Ed2
	 ohL8HjM2QRjuqnaIHzlZOP+aG5quD1tYd7aRn+MVj19GiFoPTu5p0fEGEwF8+sHpLF
	 JQNXr6DroFowU05XIvnEiBcnoz6F7tZg0RDW+Rlc=
Received: from github.com (hubbernetes-node-16682e3.ash1-iad.github.net [10.59.99.15])
	by smtp.github.com (Postfix) with ESMTPA id B9241181083
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 09:26:23 -0700 (PDT)
Date: Fri, 29 May 2026 09:26:23 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1102048/516271-000000@github.com>
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

  Branch: refs/heads/1102048
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
