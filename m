Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188651C067
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753253; cv=none; b=rcYQMDbLhV/fBVZEOndweIChry0Wajzof0sZjbC2UZadBOgfqKttZlG9Q+T1tDywbynFMS02UddhwzOyFQHhqvF9SJEjJa9Nqc0aHcO8WcMrVykuKVJX/vfscM0MEWBgLgWQnmlP1xXugAO52CBos/HLft8MQOVg26efFCODkjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753253; c=relaxed/simple;
	bh=dIMb13qNvwDpsPBw5IwYA/s6qwhKiPJe3dAOuzauOEk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CRlExxFgiwNUb6aub/6W8IE814H1zZvAecmeUhkFvSLVg7ODnLcXl+ZRlnbPl6hk9IDU3mu3D8GfqmUsofTjp6oBjtOXTZ2xq3KlqXA+tcPy3Bvw6kEXZqJOYlhMnOa/xQevHTRtyJGJh64SswxBUoUto4tPjqYk2KPARVAAii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R8UOLXpz; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R8UOLXpz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789753246;
	bh=rU1I1lOtThaETaZUKzUhwYwDUor8XGT/bvxkbcP53e8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R8UOLXpzkRQwh6T0TCg6iJHs20w62BR8h49vQBaWCJkOeiTIe1IGVg9BELaKQK05J
	 RnatOMgzMewVfJixGIGUAMU3lGB1eLB1vsd40Q2mCGAVJN2gU5YBRurPkhGtDH806G
	 hDVIDfFEH1MtYT+PXuEDFj5ClBXJNfFwm+QQpwxg=
Received: from github.com (hubbernetes-node-3a6f848.ac4-iad.github.net [10.52.161.23])
	by smtp.github.com (Postfix) with ESMTPA id 1F5027808D7
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 10:40:46 -0700 (PDT)
Date: Fri, 18 Sep 2026 10:40:46 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1168010/46235d-000000@github.com>
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

  Branch: refs/heads/1168010
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
