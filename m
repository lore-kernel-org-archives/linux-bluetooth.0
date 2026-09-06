Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742F63537CD
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788684562; cv=none; b=jujINPTSzVLA9BRtHkqS+bKTc4K9n0EEd6PtOHZ9tdrw1Eok0nQiKDLUa5by8TQazCRW7hUjvuFaQt+fqEyqoJih1zKoyf/YAedeAnt/3ctZ2bdR5DvtjBnOxsBk+/VvPY2XGguYDnlRcYEqtHus18JeZ2SVe661QtCmO/uyjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788684562; c=relaxed/simple;
	bh=zkuvV300SBuunJXJ5WR2VDjeJx1hhinECmlSfmHgiMo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=M2hKdj5IbSEORK6JU+G5lpdqXAOamqp0dKg4jfCgwkFofr214fmBJV2GDueyxFtcRRmqN80zWZ5iVy312f0GI84RDWlReZ7OO2J0/VeF7+aXhETtk2tg72yuNqw7TQO0Tgz0mq4BbbPESWK4QaY4GsQJ+MyBt8WUCbpB/4rHbEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GCzHWoxP; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GCzHWoxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788684560;
	bh=Fo/DuZgMjH0EbxGPMq8/bs8momTj/2G8cHvBissrzf8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GCzHWoxP6yhiXjxRMTvf28vUlL6YQgYw3QOL15/YWJ7ToCC2QsDDGBhdqQVuc9pRV
	 olsPzMRq3w7nRBaxaBYRsmWB50FoBq5rNF8hc1g40A2V8exMxTe0VVjEv74c3s8LuI
	 r60K9xKyIT4AZ+JKcz3+ZhnpNItNLh9NwKznbbQ8=
Received: from github.com (hubbernetes-node-e63b45f.va3-iad.github.net [10.48.70.92])
	by smtp.github.com (Postfix) with ESMTPA id 6AE78500DDB
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 01:49:20 -0700 (PDT)
Date: Sun, 06 Sep 2026 01:49:20 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1141938/325365-000000@github.com>
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

  Branch: refs/heads/1141938
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
