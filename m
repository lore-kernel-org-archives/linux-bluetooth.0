Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579C1D63F7
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Sep 2025 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002744; cv=none; b=Erqooh35pbx1ZxX6Tvq/uQL/anAa07CqYjgJTCyCfya614mGej1/whLHEJrNvw2FVGo+Qc85G6OyNxePOHeuZAy/ghbaniv/miEkgBthji1MTVOP581UWqu+7tExbSJrg1EfHDphfVrj0mNf0JWn1KimVqYFlO1/DyTXj9AHFOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002744; c=relaxed/simple;
	bh=7s9D2FRE9fUcEZ3gs2uAFSdicEVO8hXtfUMKZF2b7yg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=P/sAQZdK7ce3tPjmYa2eGNGA9vQjhd36mCWfyDz5S+eQtg7+ZUnIEuAA1wdnCESrhLoaa+STqijaaA4/JV1gENN/QnqoRB8IqNNtpvRZTq8tUXawVLjjWUFXqcaaZ1iIhztfNmZmHUsp56No+HvMAJscQaq/RURRtlq8n2lnqOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RnRyWo3b; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RnRyWo3b"
Received: from github.com (hubbernetes-node-50ab028.ash1-iad.github.net [10.56.224.71])
	by smtp.github.com (Postfix) with ESMTPA id 8B8F56007F9
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Sep 2025 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757002742;
	bh=gBalesB1JB9xLO/Hxv8qKwDRZmCKaw3oi5mRlrHeK2A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RnRyWo3baPl9ojE5fmIVrmYYM9fe5JRevHQxCE02NjiJZzu1waTtCO7BzlNEpE1Ys
	 nstpvfudPC5kH1Q1H7+ZogMDbm+kQeTEoD7omlJpwl9XntXC/jc25mY2X6z+0zd5E8
	 uQX6nGWPvlQZvxM0lHIJZbNvyWVWqt5DZbrZf4PM=
Date: Thu, 04 Sep 2025 09:19:02 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/997681/29795b-000000@github.com>
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

  Branch: refs/heads/997681
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
