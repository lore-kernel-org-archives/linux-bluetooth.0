Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF92F3612F4
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577435; cv=none; b=TL59wPCh7RwToOgMz/KRR/3dtxh3YYuC/sk95K/b37ofJunxDvkK72nLiQGlQg4hsSuMKsNFpTYQLGmyAL188BEHw9mtm+oPZcTCvAQJ4E5k340MvtSHOyVoBQYouhM5rNTtV9TjxRvI82rwkuGWje4DG1LYCEmTx89WLNJgapk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577435; c=relaxed/simple;
	bh=Zok7aWXss16OtJlA6YI6i2ccNvSIGBWyv3xjL2UeA34=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eWpJxiDz9WVRCn+PMpQqix+EKSxkSMzjVpgyjjaiuoaKORicOT3Nj9Ur7QiSfXBR1ZxQuKkwiBSW5ykuXsMq+opCtQ8pxDeAsV27cYE1UAltKE0znhqCAS6vkTP1o5Xa1QlYmTDJcd44R/o6nFLFLUqAFo/Sl7XWNrAm5TPwGHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jMw8fTRB; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jMw8fTRB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784577433;
	bh=iFTkftG5Y6aA2B/x1aHyujL8chqk3ZBGmVy/NkCc8JI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jMw8fTRBor3sizhs14gdiBZ+0lJLjOoPw7UOtr4k+9tkme+AIZ3+mnzCTkK0AJZkq
	 Lh5BEqtMT8SqRY6fcWfifBazxzRSUq/yXLTdLW1lH1TYd+mWDu0fwyMqVJ4udD0D/f
	 MFubdlvPwPkdd+eZ7RKDRPgfK30wqeLV57PlS3C4=
Received: from github.com (hubbernetes-node-e3ddc92.va3-iad.github.net [10.48.156.55])
	by smtp.github.com (Postfix) with ESMTPA id 1DE80281294
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:57:13 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:57:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128757/7c2359-000000@github.com>
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

  Branch: refs/heads/1128757
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
