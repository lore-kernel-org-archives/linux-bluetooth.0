Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652DF2E9EBB
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769693752; cv=none; b=ROYi0Z61tgw1/2vIyBVn/LsbpgVt7x3r6k6aZhSm9JS8QXOlgQqjVycNvm43eE4AbMFMokhT1w4kNpPTeJWfCHu1xrgEIP51+wp1vY6HGe92sB6t2Y330nA1HXdO8DIZtqNCWTQ/zOO0QqWA91P8ZpiItmxsMppMiP2jw319/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769693752; c=relaxed/simple;
	bh=F66pwKuUF+nn3872odwhRpib3Wkp2VVzONjrngqkDCQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=I2WuggFhBtO6OkRzmJAXrA5MMwr6LjJebN2mbAeaDXf+F9U+xYb0Lz1r99Hrt/SBI5QB0SAG10N6FCXCXuoWE+kSlhOF2SO74yq90D31P8BzrfLtmVslVBix//xEPg2gciOE264iblXDZdrnqQez0XyDvQuUbwfdbvc6l8KOV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Xr8dHdLo; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Xr8dHdLo"
Received: from github.com (hubbernetes-node-e051eb5.va3-iad.github.net [10.48.145.17])
	by smtp.github.com (Postfix) with ESMTPA id 43CDB3C1090
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 05:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769693750;
	bh=CnYzWX8Ojo96jVqi50y6yJUpAhxLlN0KLdm7DKIuddk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Xr8dHdLoypX7+k73CJ8ZoU5TqPa5lKJBhi1wHDxpkLj0ri7UeCq9e5MbX8tiJTJ/Z
	 lKl2Xw26+i1pwsEq1md6ExBQbJg6oTwvS7wJAeUjHlW2mdnqIAjiye1tS5gJm21DOu
	 QeR9Z0JOHDneL6PAfILefLt37gUDupp2ZX15eDz4=
Date: Thu, 29 Jan 2026 05:35:50 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1045811/36aafb-000000@github.com>
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

  Branch: refs/heads/1045811
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
