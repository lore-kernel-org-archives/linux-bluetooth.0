Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EEB3271F0
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539258; cv=none; b=jkiJG1ERyKV3ImZn8NQ8bbElvOQMcxkP2/+T9SJCEBhuio3Etq4AxVu9SCAG4HLxGQoneR/BVVeaGejcPZsFg281GCTXV8bACxHhyFqvMvoVCFITX3XYU1r05YucwZwIgSGMQzwl3won6ozPM+FlFdwGmCudK1KdlqXUdeWR2XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539258; c=relaxed/simple;
	bh=Ax+gTsMPzN35lxc4SaUojWG9ekhhiFdzAl3zYC/o4dw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ka8brplYGJ/dO+70Pmh0aa27kxtr/zdmyfqmn54n1YGnSTztICCz7U4ADlJstBA8v0ReERXi9J1zsCGZwY2IG84TqSCc6Q0Zsmut44EdMsIylZYujJXzm/aZJivDuCT8xLPAnj+m/Aofb4Z19CUWyB7iuxh7lftWEkW3cRfVdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=deRtZTyy; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="deRtZTyy"
Received: from github.com (hubbernetes-node-f46e65f.va3-iad.github.net [10.48.124.77])
	by smtp.github.com (Postfix) with ESMTPA id 3E9DD3C11A8
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769539256;
	bh=4Xo3qsiCGm3tGbOZXxQEa2hm6vE1A93Q4+1v9nA4wCQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=deRtZTyyQC7mLsQJuBmRCBmeeYBW2nac3ESalVmwvP8R2gb2UgTXrRmqgKZzjI8L+
	 nlfO5rbhlhFuW5+f4XgcwG7AC72QGYnT5UaT5gcWpNJ0kfSLTCjPhAD75YDFww8lTv
	 rMFQEedVR11ze3cpd9HcwnLRTu1Aea3vDeiZUHEI=
Date: Tue, 27 Jan 2026 10:40:56 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047701/a15b57-000000@github.com>
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

  Branch: refs/heads/1047701
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
