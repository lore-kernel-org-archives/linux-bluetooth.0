Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE220D51C
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614138; cv=none; b=uH2hs322F0syhVVibYG1dY7YWt18Ss5/EXP+1y7O3GZve0To4Lc+vHatq1Gxs3Fvs9oX8BrfHoodtGeR76zsrLjjEsPj8EqdaFnIyfOled8qE6G8qFXFHhaDguEOmaoaGLLSM4G7ZZU6uoZBNlaSxOVRkpaTt1TBqZqDEP/FQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614138; c=relaxed/simple;
	bh=S/jvxeB1kbPWJmKwztw9gkDMneuCrmmG121cY1zAm2c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VnLWNPX6GKNKZ+5qvnfmZ+5urJ0wExnqXgMRAbDUIHsPtUPH4ccpQPPixPcDYrNLNUpi8fqPHIaglUG5HEeaQSpft/8WZSwonB1/k08nuAnyyvs8oLzP29NEgb3kzpMPHd/imErsO1k02MmGAkKxd8ZbYpnWRyo2QebNaBG/rR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jUX5XRvZ; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jUX5XRvZ"
Received: from github.com (hubbernetes-node-7477040.ac4-iad.github.net [10.52.179.55])
	by smtp.github.com (Postfix) with ESMTPA id 83E3B211A8
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 07:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755614136;
	bh=LVJKVUxlpkgdOJIHEkLJMOnaqaqyp3nr6WArWP+0nKU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jUX5XRvZ2g/JdogPrqzhoFduNl3RJNy42bW4UysSJXYPR/A9SSslm1URo+qnKr2/9
	 /VZJW8MV2MXzRFR5Yos4APYlFPBu1SNZnqzszhayduNkE0x+o3Zo2efRiqv9NUTHYf
	 7NKvd4NfJxtOAXV9IQidWUaorG26MpBCX8jjkA+w=
Date: Tue, 19 Aug 2025 07:35:36 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/990970/1663ae-000000@github.com>
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

  Branch: refs/heads/990970
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
