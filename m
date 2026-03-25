Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253573264E2
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472781; cv=none; b=pBsj03l6AIjAUtfQzuGsZi3qGb4m/K2j8drAVQzq4OirwNXEQzi964XbvOFzV4WQBIEfz6apwkzetEVr53sttgMwFtpyf6t/917h7ckLc9Fs6Qdop3xbn1BgQazGzdU3XKc8qTU3wqnaWU8y/RgOfwEPTD9PE8hiuGgBFw6VriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472781; c=relaxed/simple;
	bh=7Tp2u+ofthHNpplKMs2y1MpJkX3uvNpdlvHCfC+8F9I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aDu7sdQsJ958v/YTNlvSTmSOS003P0FkUI2Ga2pXYP20c221iRid+TKpf8rG4aQ4MOIv2W0x6V36mK+WCfgk2g+8OR8eyugNoPsXEqQc+IGrWH0CBT3c/pTluXlTvA/KQRBGQvkno3BM9joBTz5Jmt9khjABonUdYX+UrL1/On0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HJzQ1w+f; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HJzQ1w+f"
Received: from github.com (hubbernetes-node-8dc292f.ash1-iad.github.net [10.56.173.25])
	by smtp.github.com (Postfix) with ESMTPA id 4674A141268
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774472779;
	bh=glkDCwV+cd0knEY64hiJ/J4rdB4B8uYVAjEeotlhBso=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HJzQ1w+fdCoLo2W0IRGGix1puWTkG1pLoc/xRc9CQPNv1InI88kcEfzKZuSJJZDl2
	 TULXe2jmw163F+3wjcBbHadr5GxBfDf+KDHdFnkrEBxNKH/DyirTMGYFYIDU1y8AiP
	 f4njIjRLleOeUyPgyrqcH5BUhQh//D2RJJO9++Lk=
Date: Wed, 25 Mar 2026 14:06:19 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1072496/67b764-000000@github.com>
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

  Branch: refs/heads/1072496
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
