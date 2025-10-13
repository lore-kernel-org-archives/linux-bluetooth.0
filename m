Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99637221FBA
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345873; cv=none; b=p/nrPn+Np+HF1wze2wEsX/ZRrD8HfYpiDi9LEuhG2orXdssSScxjv4sEZYX+93ymKu+GhMysLvrQh2izmi7mYHQIkWhDjceSYDLok+n5Fv55ZDN/OV76aU13SBG/lSstKHDnGqvKbx/e0OXRHaRr6Wj3aTfwPJudSDHdo2a7JTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345873; c=relaxed/simple;
	bh=j22+cCZ6ImBcxb2+bHJ4ySihW8RVm+rL+K7N+OtOtkk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XoouYQsC7QFKYwtc5y2ddCupc0ktVA2LZNyX47iZYtnZx4ir7Dea1MO1SF7kth9Nrv484xw7DjfT93csGBaDEfQtuZWrNIvTVp3qtsU3mi6DOZZOjT+tpkhO01t4c6MCBDsQPC+ovAEHVsoGrw4mrR+bWB11CG+DMeDrHQt3dck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E7jaOCYh; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E7jaOCYh"
Received: from github.com (hubbernetes-node-b9bcdc5.ash1-iad.github.net [10.56.184.35])
	by smtp.github.com (Postfix) with ESMTPA id 8BADC9211DA
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 01:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760345870;
	bh=WdHATFMJT2wMUl7UgmalQw4F8FNpOsGsbWYpQUw4HHs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E7jaOCYh/7T5PQv64XUEakfJX1TYwEbUqCY+Lmny5oyVWYMZtwKCYsnHnQln6/6U1
	 KVFCr/Cf80gCKyvWpXJtbv1yZUi3bmIuT3rdKu2/WLj83GkNZDRYxfpvUiJgN97WLQ
	 h3pW8TGxkwR2RziJc9MQagCefNg8zD4mIGkrFPs0=
Date: Mon, 13 Oct 2025 01:57:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1009682/d81ea1-000000@github.com>
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

  Branch: refs/heads/1009682
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
