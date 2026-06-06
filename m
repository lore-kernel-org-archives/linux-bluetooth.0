Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A1279907
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780776151; cv=none; b=KPTv8Q1Yq+w3e88plIO4a+3nMPjSzWMUcVJL3qiY1pondj1KlLBiWQeOQdY5eEnpn1LHO6JYcSHabGZEwAFpEX5q/V3LFmMHlYCUgfU++IxSzJNppSOMC5F8n0mzSJojQYfZ7d/82BtoxhI3gOK5yc75g5x1zLAhWlc+o5uGAWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780776151; c=relaxed/simple;
	bh=9T0JcB1AQaMpjJo1s02kov7uBryaTFlChXl1YyiPXt8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Wvku3r+POFTwxUGmDuaPlRjxamUHsX7/wpWgC2bqqoyfEZJffvvO3NalFGfIPvNjhVH4q+p58+HG4mbHN/XQgAQ3jEHuoP3HCPbM+mIZHC6GC5EVbgWSQ/JUi8vnlYfoPsNZeL/WjA2gLTFFNCBFxaCMi+xwnpBYYdrZF4u8QMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Mz+UuP3K; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Mz+UuP3K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780776149;
	bh=9YjMSikCZdZxtMKQ3EzJtco30KnKY4NPVCJCQtWE6pY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Mz+UuP3KETAr60fIgCTrr754Xh2osrXMR4yRe5T3lzL6ESR4pc5liEh7MUrA/fbbF
	 qCfuA0aw0AH3qNxuzk+AZHPJ6PFkOHKpi6n5/cVQFt6zKPe0LLKmUHutVHTRIH/UIV
	 FnKJCChZpFUpdvtnV1hbmnqZjB3ABPkXAyiNh9GQ=
Received: from github.com (hubbernetes-node-ce1b63d.va3-iad.github.net [10.48.200.34])
	by smtp.github.com (Postfix) with ESMTPA id 7D6F7800FA6
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 13:02:29 -0700 (PDT)
Date: Sat, 06 Jun 2026 13:02:29 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1091217/27dcd3-000000@github.com>
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

  Branch: refs/heads/1091217
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
