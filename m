Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B13295D9F
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800019; cv=none; b=jJ2bdzaJy0otrkqAm7uppVFjFmNncjwgwBepXfTw8kzne2SeZOJwk1mBEFksUe+v2iSXmtG4b45HknhSfQIybela3awxq9hRiDC96RQrvgA2W/xhcqw+gybclbPALkno433nkgqBNIuFJE3rGCRoZ8pjIYQ2nyQJSb28MAAQHjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800019; c=relaxed/simple;
	bh=BKdhJcMa9RgGyaSefmEXq+ZK1TrMS7YP91BgR3XX59E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kn7gi4jsu5J4QTcIhnJeiCEhY04L9l0mz87zCIMoCwP5u8ExVYYfjM4GUE57UsbHYvDFnJeortSdkAJcBEVWbtTHfxwlleW3bjbG2/qyL7A2wU68TNp7TiX1jQDe9/mN5629jW1GIxkh+dgqyfjDeiYNZBny9RVVNtaL5+s42Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UgPPM8Mr; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UgPPM8Mr"
Received: from github.com (hubbernetes-node-c1fc992.ash1-iad.github.net [10.56.173.14])
	by smtp.github.com (Postfix) with ESMTPA id CDACB92004A
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746800016;
	bh=K2u+ivklouvMvLmPlDADHAzamqG1figNtoINC0VY7BM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UgPPM8MrBANK5mmm8ot0euZ4IItOBCrEqAqPMAHRLNSHAUQQstrMa2TbS6bhY5cXD
	 G774gRBRnPkh4at2XSyhbM+OjSzYmq1K8SG2sgy3mKXRN3P1jyAvOzhY6IEeer0Pkk
	 rWueFrNggyZF3UJVgSGuCboG992Zaj57gwJ0Pba4=
Date: Fri, 09 May 2025 07:13:36 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959160/0ac9f5-000000@github.com>
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

  Branch: refs/heads/959160
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
