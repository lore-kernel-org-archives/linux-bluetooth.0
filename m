Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DE32797A1
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853260; cv=none; b=LlSftv6I6VHcaAxipgkfXRpLpZL2+t9gxB6Le6wKUsZUkr8M62hghsfi4a1y3m9B6ruQNcsiFdMHtCdd0rjh4rPgisEIILS7kTfMKMOJXIaxx6AY5l2rb/qfUpdReN887zOkVn1mqcT/GgfctwSHPpu/SMpnziigLjnOfGnnvLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853260; c=relaxed/simple;
	bh=DPdd9CegBnL8QOIlbweHlmP0vz7ieCLRH2C1juvArWI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KcmLwhReZ9zzJh5nKhCTWHRBQWjqYW+tfp4avTjuqQD/+eNaCz0RblJS+d7Dggb3O0xEbem6aSde2PAn2PSg00JdcO412jy9NJ34opUEyHysHByJ7dExvOeq/LCV8hAbOES4C+n2BqaLHosLzlKGcm4xKt1zAK0AoQxiQ31Lj60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=luezR82G; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="luezR82G"
Received: from github.com (hubbernetes-node-d0871df.va3-iad.github.net [10.48.139.13])
	by smtp.github.com (Postfix) with ESMTPA id 007F64E0C31
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745853258;
	bh=ZDbnYGlhc+OwRbcHx2j3NDCxlWAWGas6+RnohM2+QCg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=luezR82GGTSQwo35Ma5o4SQj2bmOQAV/6l5AjQhGTLLH0OlGIsKkBY5ivTa7huuxF
	 zLqLiUDmEhuy3efDx+6z68OOffg7sjGCv1cupDG+Q8iFOAHIR6oXE1KvcWZbAHvaJB
	 z+DlY7kyR2MMATBG/I5BAz/OpHg1cjB90suKqCG4=
Date: Mon, 28 Apr 2025 08:14:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957173/defba7-000000@github.com>
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

  Branch: refs/heads/957173
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
