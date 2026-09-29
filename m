Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6033F44C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665115; cv=none; b=UwvRvxBF+xiVVWlvrnCzXmOqgX/swSsGRckdmC6tiSgzdkdpFeGXlgBEG29HA+pOc+wV+7uY//2Fi+qqOcALTS0VhNDFb/8NP3fxelHn5h/9dtST+x8yQ8m4kqyYyqlvgFY+tKqdtZyZcWnLMyrBbe+C3b1u+kUVOYe7q57DY14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665115; c=relaxed/simple;
	bh=AJB1hVvqbdFleB3gDVyH4PMusFy32E4hcrL0eJGN09g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VVoxD1HKubc+k9Dmjg0bWDNfsvu88M3LnmYSAW/AHXwcStQ/TXunirbhqrCyrCobxy9emUQX5zGgX6eHfY2h19OLdYEYw/K9umooiCnfFsPoACOE5s1LNOLYfsAlLoEi64OJQqGHIHJr0+f1AdYjQFwc6z7lNOoLANbZYtXebvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=UNU5noNQ; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="UNU5noNQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790665112;
	bh=721nNjvp9v4DOe0fjezoUF1R5TNpCq9Y8u1I3JulX2c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UNU5noNQDnKKbvlYJtFSnLEt80UKe13RY+litakMZoWhmzd4s3cmZtc0078YAGqmV
	 Ya7G7XQ7y7DRVlbhJclrqWtXKRsexYECP1N7vujDJpXK6vsaFQYCOhQKUIyNL+YH3G
	 cNnr8ZUtmRtr4HmnUiR5dyz5PKwWUmlx3GYCpPbPkDF0d7JyAWkBOFhqh9ADG+pvRo
	 QTJbZuQXq1cUfh++9vex7Id1bWL0zELHGOuEYc71KYHGWppY+iqnRBPdvByoGD9o7i
	 XnyFVt9YKT83gAD3n+Fa9pHWKWFBXOirL9VhLuW49gFRsZKiQ7lFMOr1zKjRlOSLpc
	 3BBjKSlWi6l/Q==
Received: from github.com (hubbernetes-node-cd5de9e.ash1-iad.github.net [10.56.188.44])
	by smtp.github.com (Postfix) with ESMTPA id 82162360734
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 23:58:32 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:58:32 -0700
From: "Seonggon, Cho" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1175715/000000-b0e1cb@github.com>
Subject: [bluez/bluez] b0e1cb: mpris-proxy: Line-buffer stdout
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

  Branch: refs/heads/1175715
  Home:   https://github.com/bluez/bluez
  Commit: b0e1cb166c363cdba07910caac8f8d436ac8cdf4
      https://github.com/bluez/bluez/commit/b0e1cb166c363cdba07910caac8f8d436ac8cdf4
  Author: Seonggon Cho <jmsmg1@me.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

  Changed paths:
    M tools/mpris-proxy.c

  Log Message:
  -----------
  mpris-proxy: Line-buffer stdout

mpris-proxy reports adapter and player changes with printf() but never
flushes stdout. When it runs as a service (tools/mpris-proxy.service)
stdout is a pipe to the journal, so glibc fully buffers it and nothing
is written until 4 KiB have accumulated or the process exits.

On a system whose Bluetooth adapter went away and came back every two
minutes, the "Bluetooth Adapter /org/bluez/hci0 removed" and "... found"
messages reached the journal in bursts of exactly 100 lines (about
4096 bytes), all carrying the timestamp of the flush rather than of the
event, i.e. up to about 80 minutes late.

Set stdout to line buffered at startup, as bt_shell_init() already does,
so every message reaches the journal with an accurate timestamp.

Assisted-by: Claude:claude-fable-5-1



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
