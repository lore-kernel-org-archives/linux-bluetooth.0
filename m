Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6C6346AFB
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754269; cv=none; b=ukKF78WHjPkjTfP0Fw21SpRGA18VY8VSdurvdXFQiLguiIAtj3wkwOSYbrDOvAlRc5ZFiXY/JDv5KDQOzmGsO9W/zkK50RNwxpsTiOL4YrGzVH2wnY9l/Zmv3hUi8pjSFoUFy0OPXXtx5Y+p9qc8olXvKr2rH/V8kEUgsTSB6bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754269; c=relaxed/simple;
	bh=DYPvFmJ600caiGFluzbb/uNydwjIQ6ZUFRwR/sxIbmo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RiEGo9BmPh4pC2lyy+F88mKJaMyzSDCToBdqE5JVq1sj8HbsrrAHZ6s9C+BIsSisAxXRlnUePjxo+p+pYRpUa7bKX6s/cZ4tyhRKKx+GbwIwwVcm9BqWshnx4m0xYY5zqVEzU1m0ew32TeyhO91amI2rav0vc3ztj4+NSnNPa/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RShNjvK/; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RShNjvK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787754267;
	bh=cgMl6Q2/SGyYzkTxDK48bJuL0fU20N+uS9fLGTfVbeo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RShNjvK/lHWpKGAnONl1DsUnROpnmFi8MFtMFR6jyPwHh0Hkudgj3gCODT7BDqEJS
	 Gs+uaCejHy567yDeE/gAVEGsjoWAsmKTCgiqEuqShWE8Ex5Pqkq38k/8BmpGdbz/rv
	 dhe50NQY4Aix7T72246cRsD4s+wXHc3wcOiIRTHk=
Received: from github.com (hubbernetes-node-a51eaa7.ac4-iad.github.net [10.52.184.36])
	by smtp.github.com (Postfix) with ESMTPA id 255379414C4
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 07:24:27 -0700 (PDT)
Date: Wed, 26 Aug 2026 07:24:27 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1151364/b41833-000000@github.com>
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

  Branch: refs/heads/1151364
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
