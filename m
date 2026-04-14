Received: from out-36.smtp.github.com (out-36.smtp.github.com [192.30.252.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70621322C67
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199174; cv=none; b=L95JeKdvNi9U9V/r1tDrkDehxmk7axVwZinwENeIPN9pqhPk4gT2PSN7rXP4BfXzmHcia+RmP8WWLhu6QDkD9XxxEAS8VwKHv62OsoH2mgGo+0jcqabJvk4bqruvtPgT4Thl1D2OGRDizt1wQ/nWYsx6i9T9NF808RfJFkMxabY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199174; c=relaxed/simple;
	bh=PGDkSPh2kY70Fa3zUdK8apkHYNhwplhoaHYkGswiK+w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KXog53awOQfPrRqZjvXYGIjI/qTU5z64PtiQlKkI20wHUUJFB5l5unxr0XLUXnS9S4mkmZUUuZDU5HN57GsRiowZF2Kd4ggtSo0HbDhA245s77VJAM0bjLiYEjPKYhai17BQX4yae2cF1/9cg2E3aaUVRE2XRWMFeV1wk3lNGbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OSJrRS8A; arc=none smtp.client-ip=192.30.252.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OSJrRS8A"
Received: from github.com (hubbernetes-node-b0c5c78.ac4-iad.github.net [10.52.223.29])
	by smtp.github.com (Postfix) with ESMTPA id ABB0570114C
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776199172;
	bh=LVDYnJMgnR5ZQAD+j0XjeQ194xWJHIcZO1CZIYhg7cE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OSJrRS8AUPUK0tSWP5LOToeSeNY/5xh1ad4EBTiCi7GJ/WuBTIlJSDWCrOsvW6+1e
	 RDkpLZR7QxNerdZ0WYYbTZBRyWEmFEC1Ml+29MBdwdi5NFOaSuLpct4VUegB2GyqrA
	 sLhUzFR7PreQahb2eB+7I2+WZ/FQKVlNZ3ffzVWc=
Date: Tue, 14 Apr 2026 13:39:32 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081219/64916d-000000@github.com>
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

  Branch: refs/heads/1081219
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
