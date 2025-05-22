Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840922980AC
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927151; cv=none; b=AaNQnGgRY1PAsL0I3zCvobK1LfadS3P5VLGN2BSaHVRkgc5lbNPE60rvk5dIs3Qin5R4z1QXiho8wWws5Swv4XhrGzTzbebIMYbmMqFb3PgZQvtfAWxD4QzzSZL8AszXAvh2vVDn99Pix656ulzR3OS16wjmtIa8hB0ZLpvrzFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927151; c=relaxed/simple;
	bh=/utdp54tXOv4Qt7nacwjPwW9+7ksjAMjiwy4WHEFqLM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=keHofY6IoilmJNUrVtWw+QdMhdieviVSjku1zAqyp9F2akPMGwa0n51eqM7lX7NINfR9zbp5W3ro05Tar1lRFehSVeawjRG95pUhc6ezUt26KbzAQY081be602S/ZKOnWgTHO3X/VSHoRqC/oGFvNP7pfPFT85gVIBXW8KO/N2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=klSKPuyy; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="klSKPuyy"
Received: from github.com (hubbernetes-node-40a867d.ash1-iad.github.net [10.56.200.88])
	by smtp.github.com (Postfix) with ESMTPA id A0128921241
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747927149;
	bh=CI1x+yQqks9BMK7ynDmFbxcpqaXDA4F1p6KK7KySRGE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=klSKPuyyRqE7tKSfPBQdQ+L5r1T/KP/sf6MeA08O7RXa7YE/43wxvA3zBgglskQHb
	 +4BqqRI0grygakwaPZ49aM9gsi1YUKtuWgljHhuW1xBt+V5WtArWVlwyu6p1w9ZY69
	 1d4bXBeP2yUxbo2ufL7qkT9Eoc+kzH20AerfYJf4=
Date: Thu, 22 May 2025 08:19:09 -0700
From: George Kiagiadakis <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/965442/000000-81ba8b@github.com>
Subject: [bluez/bluez] 81ba8b: audio/avrcp: fix crash when NowPlaying changes
 whi...
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

  Branch: refs/heads/965442
  Home:   https://github.com/bluez/bluez
  Commit: 81ba8b2bef4e18cc161ac117ffcb74eed24bf710
      https://github.com/bluez/bluez/commit/81ba8b2bef4e18cc161ac117ffcb74eed24bf710
  Author: George Kiagiadakis <george.kiagiadakis@collabora.com>
  Date:   2025-05-22 (Thu, 22 May 2025)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  audio/avrcp: fix crash when NowPlaying changes while list_items is in progress

The media_item objects are owned by the player and while we keep
temporary pointers to them in pending_list_items, clearing the player's
playlist destroys them and we will end up crashing in the next call to
avrcp_list_items_rsp(). The crash is racy and can only be observed
when skipping tracks very quickly in an Apple Music station (where the
playlist changes on every next song)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
