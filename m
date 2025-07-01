Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBAD1E1308
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751402265; cv=none; b=YsBDkD1COSoDYpMUuG/4RP5TTsAXxEiGnh0Sr1CUSgUHvNsLuG2chXKe06Zg95CkNJR3m/bvG7GoQi74PpSg9JJdY2Civjz5nYU9rzlowAcny79KW4WZ4QX7SClqwBz1W+u280+ki5FpamFgPKK0tEZkT9EsCHDmVZsanKeD1mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751402265; c=relaxed/simple;
	bh=bBIBFJvHRKtqfUBkJ8NeJtU6PAqQY3vD0Z/haGamPjM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pUrxdRPEFDCwZ9hoEiguvjfx7kmD1KJeO98NkuykVEcVg8EbhfDAAkpWp9G5LbTrOQxcdPIra7YfBt76gU++RHzsFZeV3oaQTyllsEucfutVAT1n8VXpcdOUeA+Trab0TKqwntdIHcAJPlTmKdtf1qOS21M9uZPKyrPii2+zOPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JjwPWFGv; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JjwPWFGv"
Received: from github.com (hubbernetes-node-6d0b3b5.va3-iad.github.net [10.48.222.13])
	by smtp.github.com (Postfix) with ESMTPA id 87B42E0BBB
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751402263;
	bh=jKTJkCmNp3NpAVpimfjOm7u10fia3qHBuxL8iubtSnw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JjwPWFGvLI5eHjzM5RNUoPbAnweeg4xLaVmx0v4KI4w9GIpvov985hEDDQuVmyeku
	 DVtT8aCQiQegKV3euAGmsnwr/ylvz8JIgwc0GI4+zbOOj38TDcVUp2DOA99ciXD2lU
	 IJ7M4bZIF2coItHOEVJEwZRowZszPjHRqk8j4j8M=
Date: Tue, 01 Jul 2025 13:37:43 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/977912/000000-03123e@github.com>
Subject: [bluez/bluez] 03123e: error: Add dedicated error domain for BREDR
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

  Branch: refs/heads/977912
  Home:   https://github.com/bluez/bluez
  Commit: 03123e8bb69b0ae1a7617bb08a5cc98e3d64ccf6
      https://github.com/bluez/bluez/commit/03123e8bb69b0ae1a7617bb08a5cc98e3d64ccf6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M doc/org.bluez.Device.rst
    M src/device.c
    M src/error.c
    M src/error.h

  Log Message:
  -----------
  error: Add dedicated error domain for BREDR

This adds dedicated error domain org.bluez.Error.BREDR for BREDR bearer
and then use it on the likes of btd_error_profile_unavailable.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
