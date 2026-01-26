Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30D61FC7FB
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450552; cv=none; b=kevaVUQu9qFib9q3Y05y9urWiw+2zlPWR8PUiYHHG9WjtCug7soONm968j1MYF7mqxSHKe93TNGotMkVy8sKcNNZl1SvpJQCxsoFXp2nwXgp/XnL4Cg4Put+8affQdRoMOB9FcxWDbstUYRWdh/Cbfr80JNcoNy+v3P8pJXRiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450552; c=relaxed/simple;
	bh=8rsqK+Wjeon44sgpzPUYGCO5PNu0pk/vYV5Vt/rtPl8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ReL9HbR1APmeO89v2zj9NcmDlTZdkgJe8hMfpCHaaxD/zE4OFYVA9bC9kWGEkdGTVSY6AjNMavysvNRj5xr9Sf/O2Yu2mSUkUKEkf17/D+Wuov1WxFHkxfP2EmnqpcXAOJMt/q3D9KaKO2f7MyjYbY0OoAMX/JuzNEYRE3oMpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XsWbXfrE; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XsWbXfrE"
Received: from github.com (hubbernetes-node-661189a.va3-iad.github.net [10.48.13.82])
	by smtp.github.com (Postfix) with ESMTPA id D9E8FE0D26
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 10:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769450550;
	bh=dBUmSmwPo5Yf7nH/TfHrDrrJWlyMATk16xKUN1Lm1io=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XsWbXfrEs6mcipk9q9PR/Q6ZC9IYf1sOEKqXzp3/ynLYnImkTWyp8T5+5TVdS80pe
	 yAAwj2um5DQL5MJTdwUf20Tl/l0JexXI5zLIAbRDNudEQ5TAkDICee/tdF5J76Iv2y
	 HhK9KxCj6IKh4cbhWpU0RdcJCW4HKihPFHjwA6mM=
Date: Mon, 26 Jan 2026 10:02:30 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047158/72e7b1-000000@github.com>
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

  Branch: refs/heads/1047158
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
