Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B4A28E0F
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Aug 2025 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754161133; cv=none; b=qG0pWmE7cxC2R+8+PJVZ6dfK4hA4XZZzexrtdhRcjgDgs2mEBsxsI9sqjv21BaNabZs+lvHTXD2biuA5k7UKzWsF3NZtG6Y8Q7zxx1jlHPe4IFMpUF5lDtFflmVF4EwPoy/OwqYyrKKBbwPa7ayWScRxHOMGkBOrd8QjD6rKJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754161133; c=relaxed/simple;
	bh=Yzf5S8IZ1WJnc+4W0XbSV466sW9oRnq+OPOmW1BMnSo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=koVTQBlZDSJVXL/tWc78oxjtj2J9goFIqKE91SB+jVwEH/GLCSkfkBw+iHalrBcwy0/ZtRxFX+JVfHy1JHrJzWsIo2YMwkr6UJQ8XEDE+YPkskMvVjQm3uKXzvvjsfqsnCVaU/gXlBbVtospa6EUAnbffdoZ3EzEGab+gtsYD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jvgyNolt; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jvgyNolt"
Received: from github.com (hubbernetes-node-4151e64.ash1-iad.github.net [10.56.206.77])
	by smtp.github.com (Postfix) with ESMTPA id 05B67920BF8
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Aug 2025 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754161131;
	bh=b1wF2RyNnboU0IEGwPVlmcFYXmAVnqkHYjTsw/ObsNk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jvgyNolt8/i8ll3pczgj29UTV4TikB5W0+Nw1pKMDCNXCGRUmKTySssbGXGARIcMA
	 TIhJf3EB9BGpQp4/pcA3GxJZSSvx27kBYvQRC8QI+BJW/hW2mmOSwPWabacDxv8UCI
	 BnasX7h6fTujtBZQCiEIEQKxB+oTlzHMwlbi8hlE=
Date: Sat, 02 Aug 2025 11:58:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/978771/037065-000000@github.com>
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

  Branch: refs/heads/978771
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
