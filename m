Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE62E24DD0F
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748336143; cv=none; b=eCSFlHwm0sUGxAmuy60nLdy+tNJIUF8fErYJJCMot3G9MuzfDMlhrMC/05D/EfX0bsm8lSVLrdNp585kC8ky9MtNObyD6qBahRFR9/VuHJhyhDZgYM6YcfrRg3xY7nUFBjgkof1kVEbbTq2VeGSy+ffSVJ/w2xI+bAjOqcQ2bcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748336143; c=relaxed/simple;
	bh=poAhObx2Ud5Vte1SiK7C4WMMpiW3ppvu7S9Tvuxn8Po=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cYyQQex0kPBBiNcmtYZoKkL+OBRz8RAXGhApfaacQPexFdKQN+3IqTGz5LKSRSYLUYjEirR4TOaU4Ws3erxYgtFqsRoYObfFevd+OHZa+E7dnCL2WluuFEdsN2jDqoUJEtOhrfbaWfPYXbK/2PDetPJGp38GQSyGNkPmVs5KECw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=j2V4Mb19; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="j2V4Mb19"
Received: from github.com (hubbernetes-node-70352fc.va3-iad.github.net [10.48.140.32])
	by smtp.github.com (Postfix) with ESMTPA id E519A4E0CB4
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 01:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748336139;
	bh=EVLBx1v+AreBZLj1jxlVBe77arBwxz8e/LmIFeEIBVc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=j2V4Mb19jjAE6wnWXhuWohipMQ6VdBmEXsOf/Hl82UCOO05HgCvW0J092Hcp4r5mK
	 gyczU9xEfBn/0DH3Kh0vRzLi3dmp7Hrcs+3gir4tSSWMfsUomOl1ygugT6dux/w7M6
	 SYAg6ybaXsoyY2UKSyOsTaPAVzfYg+AS6yva7PF4=
Date: Tue, 27 May 2025 01:55:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/966564/98406f-000000@github.com>
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

  Branch: refs/heads/966564
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
