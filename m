Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5646B2D9ECB
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 05:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777008352; cv=none; b=L8jSEabxCsg6qcpitLgi7wJy7LChWDNOx/KUVa7A/SI3AfmR3QO2weAtzLROgoKlYC+BJLeqGB4/q4WN8PzqdgYNkPT+3vhG+whPQs99fnfcIqPHSw2rjlVxva24wC2d9yLOLlPj9BzsmzoTlj6cpcY6cUuKmKgyPf3Pf7qD5rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777008352; c=relaxed/simple;
	bh=b6lbDpdND86Fxhj7Afqr3pBbs+nhkWIxuclsmQ+uGBc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OY8Jpiqe0KESHTD+eZlJZZAq00Cq7GEWFqK7KSF5iVrcL57hAulxeVuV3csbo/GWG3lvtK9UXRilmrvpP3SaqhdiSOFh5IB84v5zuWI3NMyqd6xwjbyCzxA++ZRkMNm9QHZk899gGh9tWqANmzPGgHeyJw3j9gAmGqHps8z2TmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FfOfeMHX; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FfOfeMHX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777008350;
	bh=9nn4nefG5So6MkUyt9sFjiYjbjRr5i6XsaD4JS0u/+0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FfOfeMHXBAR1I8LJFg0XDzNvYEdRvaNnUch0uwE5cOiWXnN3AIKdmGFWC6K3Iy3Qk
	 lJiaY2709nlIctJTzZLKbnjMYfuIa1VEb8rX766yHOBoh69/YSRdQtCS1apyhlJJqE
	 xAiq9YUR0jKuCbc5kYtRlSg8t04tUgibUdn7W7Uo=
Received: from github.com (hubbernetes-node-c237d22.ash1-iad.github.net [10.56.184.41])
	by smtp.github.com (Postfix) with ESMTPA id 875A5521105
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 22:25:50 -0700 (PDT)
Date: Thu, 23 Apr 2026 22:25:50 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1085008/000000-f8f5c8@github.com>
Subject: [bluez/bluez] f8f5c8: src/shared: add custom CCC callbacks
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

  Branch: refs/heads/1085008
  Home:   https://github.com/bluez/bluez
  Commit: f8f5c8829c8ee2b41d70f4fcdb71b44009b6afba
      https://github.com/bluez/bluez/commit/f8f5c8829c8ee2b41d70f4fcdb71b44009b6afba
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-24 (Fri, 24 Apr 2026)

  Changed paths:
    M src/shared/gatt-db.c
    M src/shared/gatt-db.h

  Log Message:
  -----------
  src/shared: add custom CCC callbacks

Introduce custom CCC callbacks to allow interception of
client notification subscription changes. This enables
stack-level handling of CCC writes.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
