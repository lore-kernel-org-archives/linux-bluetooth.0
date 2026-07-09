Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7F3330D22
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611037; cv=none; b=fn0CDuihZWlYqFOdgGigxNx5+zmFpJVcv685x75CCGQVMt8GSdQcTdScDUsgu+EkvlmbLcYZvAgmxvasKn1f8qO3z1M6ueVwhX9BleylEJJECuHZvHVwQbvmzG4hDNyQRbBbvhmeFCyKS3npm7D313rOYNI6j09WSBUrWxd9how=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611037; c=relaxed/simple;
	bh=yHsnxRna7s4M1Mx4KMa/zmvRT4BJVNlDkbwxDwS8UII=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TnGcssniEalTlqw/2iekk4/8KDt6pWRlS9orp318Ah7fyeAw7f6faj+IxiCW8LqVXXMVJzkpQompsGDAKp6NvrxGj6uZN18ihVn0dfLUAKM1swgOgV90R6D9CWRpwp4nPJVjI/sI7JxwPWamwhFvFjAzlCBaDVSvHaMmeAS3Wxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdUN788u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdUN788u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F4B1F000E9;
	Thu,  9 Jul 2026 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611034;
	bh=c0OAfExBAJ6gvLuqFsxPVFr1lr0os32S+XBP4AvRIT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hdUN788uTjq5SExjH5yBdtbmkNK7Awb2pffladsvhaQOjysQ9ZhJC91jhjxmerkTa
	 QX0kijhHXD40EvGluO/Oe36B3igC8MGfW7jvwGv1T7YrDgKFe0jOaavwhrxh/sq38S
	 4wlsLR+KVQydU5mT1iaYtUskFD62JbX3iGqXi5ihQ1N6FhALFiVvdcmOHurFvjoung
	 dhZ+OqI6aegvZxwdgKdwsGJftk5OnvPEnDXzf9kHzW+0s53JBg/qpSwFwdInrOB+97
	 NjTyCUhLllpu6DhSlrEpBcs7tuS/ScWKNGWgSR4XBVTDVShSr+l9ppbdx2MOx0XQul
	 SyVf92VE/3wSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A6139250E0;
	Thu,  9 Jul 2026 15:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] adapter: Fix crash on UUID discovery filter match
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178361101314.3546291.13415893544947831209.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 15:30:13 +0000
References: <20260709122704.351232-1-tomcatshoek@zeelandnet.nl>
In-Reply-To: <20260709122704.351232-1-tomcatshoek@zeelandnet.nl>
To: Tom Catshoek <tomcatshoek@zeelandnet.nl>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  9 Jul 2026 14:27:04 +0200 you wrote:
> is_filter_match() looks up each discovery-filter UUID in the queue of
> services parsed from a device advertisement. When that services list was
> migrated from a GSList to a struct queue, the queue_find() call kept
> GLib's g_slist_find_custom() argument order, passing the UUID string
> where queue_find() expects a match function and the comparison function
> where it expects the match data.
> 
> [...]

Here is the summary with links:
  - [BlueZ] adapter: Fix crash on UUID discovery filter match
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=82af2beafc39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


