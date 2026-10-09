Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A374E4319
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575610; cv=none; b=lTmNqQf2Zzvmwq6Mj5O5KV4lhIjCtJJiKD/O/OwnwbayO8OAgSAIZ25FBX4TPhzZmq/6AMOIkjHjfuf5QoqEcHkcEofV0h+RKvjR/kWp8YwnPCpOR+M8kzFDltjLqWQd1qz8kydOSi82DQwMUNSV4SFZnXqa04bbc853bDJ1ZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575610; c=relaxed/simple;
	bh=M2aOzDvgZKhkiK/s27+A41h9KiGsIZPRiQa/zSXImB8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nhulyGAyjra1qHaNawRiTHH8qycU8qubqyqp3M5OieWbNwUnbz0BXOWwBJy/7SHzXuSLwAo21aCwuvCbLjFivPMvSdnHLL2ka+xHi3jjjZl/FQG+zbvp3ZXh1n3viAUPZPIszVI7V783GUaKiw/IXilOWsIkezHKgqbw7yOF+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=GKQg62Yl; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="GKQg62Yl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791575605;
	bh=uActavfuO73FruN7+RFYtan47atFSZdL+ZLHFGHYPro=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GKQg62YlSpXKPOrN7iEzMNG3bH5Mlh/HQWtEr8oPyLb52sfFphVrI8VugLiBhf5/v
	 02q0F13dObV2jSKoW3o315wKg9/aE9izjvh1Mk1QZClVV/IynqFF/oLJaI+vyF8tkj
	 l4vqNbhGfPO5nJYb0rl/ziZj107ISt2D8VaLH+P/HyCCzqXkA6TUuAM9mss73PKGvy
	 jqApSh+POBDD+XYGR3stJ9ZtSz+gvnwqKMEr6kZrSmh+iYSK1wejo5BRGyZtNlpcuJ
	 V0ImP2xWrb3lujesWzIfkYAm9m6Gs33YrEixSeViPukL9PDnGH2tLbn2MsD4dsFOh2
	 uK5VPSOdLlW7A==
Received: from github.com (hubbernetes-node-1180a08.ash1-iad.github.net [10.59.98.31])
	by smtp.github.com (Postfix) with ESMTPA id 98116520C59
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 12:53:25 -0700 (PDT)
Date: Fri, 09 Oct 2026 12:53:25 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1181777/fc88f0-000000@github.com>
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

  Branch: refs/heads/1181777
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
