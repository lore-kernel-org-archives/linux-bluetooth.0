Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A72EA16A
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806144; cv=none; b=T7iPgeodHHp0jwTJfbCordNWyRgv9Szt+jfy09C6GKmlRbtYcyi1IUxE1dHhCLEQMtXSPwtnueImLCy/We26mrC8JPIp77683rkNfijmNe6NafbRTF4OQalv2G3MVJ7ZHjocgZx/QUdvvPSl49npBqmvVOF/Duole2qdH5KCrD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806144; c=relaxed/simple;
	bh=WUke0AgJ1medRbf1gAv73/IftZvZVP8fj1yaoF9sl4A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dqHiiNbprLh0FCzPBqYEl1zUcLJARPw+AQKOZdMToQTOqAbEybAasL57SpOX2cMhfMUIie5gNIZxvFl+kbDIDn1Q7TVm03cbvp8ykfh02i66fI8W0zcULj1BnwIT0RXeqykMp22who/dz+p4v/lA9XylpVl9b/UrGXhffZnAWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DxL8Ya6J; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DxL8Ya6J"
Received: from github.com (hubbernetes-node-4e2cacc.va3-iad.github.net [10.48.173.28])
	by smtp.github.com (Postfix) with ESMTPA id 46BF93C11CC
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 12:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762806142;
	bh=yZ5fZsb3Q0EOW+MXU2kyE4mTB9FdJxD0esOVO/wPw0k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DxL8Ya6JlnOhDylGsp515PyloFbk5dAgbASt4+q6r2HYjEE3pftKdGgsqsIJaL7XM
	 WzolLrTvtYeccZfSthyKpqtlILTS5imQbmyLeqd/Oi4B00lI8JfXhbJXg4KrJuNM2E
	 isvTDGovFVuQT5gjnN2Zo9e7MWRACtevmLiAg++Q=
Date: Mon, 10 Nov 2025 12:22:22 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1021294/384d98-000000@github.com>
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

  Branch: refs/heads/1021294
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
