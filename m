Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BAA2EA154
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202988; cv=none; b=avydZKxNlrlPnz8Ri+a7FGq+uwNKvRSpYC+0WXfTYO7ZfEdIOaSca6SI7ElisyWGFT+LmZ5ddLzIU7302wkWKOinJJSRgMZGaR72F9ZT7uAY58qnTqFtxWyn4vHCTAlvl5wApOZsVHEl1vrMK6Qukzp7/D0L7iIg4MQ70oHouo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202988; c=relaxed/simple;
	bh=A21oLT6voKmEy4QhK6bO22COtFjN17IHEF6OYtKutG4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ndjhFLRmsci2KmEaTvTvd+F/PqkCQzbMmunX8oQq+2lE8MpMEPyOF3eJyLP3IeSaVU0YtnH2RzuzHfTW4p7VE373pcnHxyJzaEjvSmHGAR6XfEtHutr4kjLyTO8AFOFr8oEAgf4SJb6i73QyzYDI8+mDBZqDWSokOP7srDujG6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DUh508qM; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DUh508qM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784202986;
	bh=jo7wS6w20Zsuq3xFOn/9MBf32Qb8cpkFA68nVAmlmgw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DUh508qMM2+svS1o5U8gSuO+qzeNHhzcMSQ6ymNkYvoMLZZiQcmOQy/B1aTCZ6Lpy
	 yENfm6Zm0xpJEPZqYJF4aI1t0nLXY2fOGVQMnFPQjwS0ObpAPNI4AVhIJgMb0EagWy
	 eU4aFL65u1lYqV8d5w3lXiAnD6ll7lBwxuxQdok8=
Received: from github.com (hubbernetes-node-b0c5c78.ac4-iad.github.net [10.52.223.29])
	by smtp.github.com (Postfix) with ESMTPA id 2605A780C46
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 04:56:26 -0700 (PDT)
Date: Thu, 16 Jul 2026 04:56:26 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128714/9ce798-000000@github.com>
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

  Branch: refs/heads/1128714
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
