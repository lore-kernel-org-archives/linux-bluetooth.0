Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCCB47F2F0
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930569; cv=none; b=CpnPe+AosapuPIP5MoR5E/05Vc2lqwWzGFVXtgB1Vk9KJ1iuqmeSD72FKzXjbfHmS1jNoEeSB1Nwr/q53lb5iygZtp+3Cy7vRkJ/+6RScFW31DbGJ1quPO11VEh93xVp2MSCgWX68AVho8mlCKavhH0xK0VgEnuztze5+L5oWjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930569; c=relaxed/simple;
	bh=S14rZMQbE4ZFBgeOOr4+XozMCMrMdbS3zJWiZ+HqX4A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZSLoM/HTVcbudhMKy8JqblLp/8S+Y/rYJ2eiPWXuB4X+fb9Lv1I6zPwhKOlu0HhCCrbdhe1XFtrRNQBZScMEsFDMeDxGoF/AcOo7az/NoQdsTWOrQN4lwFfXF4LR3LPAHbDMgAl3mt+O/qkpQr1DhA1h/IpB7S4vwYRTv4+w7SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dMqSpUVW; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dMqSpUVW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780930565;
	bh=nw2/ea7b+bdyAhgX6L+0AsASDSYx5m8BrzwlAOxyCSc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dMqSpUVWhJE77Ekty1imj+FBWkeBZR0HYoIjK0FZ/8nx9SThv5xWkrpGJA11inO73
	 Fbq6qwpdHPUSqN9xm1IWZfVSre7Qk6I8UkFwTcmCeFY06PhTD1jwYn0cz7SsXuxKWQ
	 fVKtCjXNv0vKW8XvyclBG2XeCcpg7Wy+c20672ws=
Received: from github.com (hubbernetes-node-6870de7.va3-iad.github.net [10.48.174.50])
	by smtp.github.com (Postfix) with ESMTPA id F29B3500538
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 07:56:04 -0700 (PDT)
Date: Mon, 08 Jun 2026 07:56:04 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107759/2c1a4f-000000@github.com>
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

  Branch: refs/heads/1107759
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
