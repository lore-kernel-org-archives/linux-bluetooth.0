Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CD63911C1
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018717; cv=none; b=B6mQSOgdoinrFnDe5BcH9B77wo2yn+61zyxRzJrrRDWbWP6BX5v692P9VHRRVRoCkxnNkp5HpiQrrdyX6m+PVMeANH1BWs975RdddcOHsRgguktA4c9bcrFl8UC1G7WZ+BAk5TaC8LO/2sqq+5FXKjAwiUHLXtc1G2SCfPPdnZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018717; c=relaxed/simple;
	bh=z8bSnW9m2kcJHsX93ezyMwdNAdvkfJtabcKK0Y5Kes8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=A5J5hq/cD3ZpXaByh9gwXNp0YSpB3FOj7/qY0xfJc4rIb7n7ywoRAkrAkDgSx6alhQmzUOA5hrK8RT4oL66N8qVtUjhjLAkt3Wt6+mJ1nLNibSyoaKUtIwcjCxaoS2InqLSnhTY+eLEBMqgWFsyaxLXu5mDPS6ehz9fgapb/BTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bBlq1/KU; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bBlq1/KU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790018715;
	bh=YLIfuVLGvrBLgjY5qIWl2Mlw2w8itJNl+mU8qE2JRP8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bBlq1/KUkBWG+oPbOU6ru74v6AvpqflzvK9/Yh5oE5C+DDFx1dBYicD42npHVqT2k
	 U3iWYKp4JLT7ASUCRukrjf1gf65XG/PR/A2BKdb1ehGPhR1xN54X4tpYgS9D7zEVQ4
	 Pq0XpH8dqNkO+XjVuwlU9+czD8iWTuInYQhq4CME=
Received: from github.com (hubbernetes-node-a33711b.va3-iad.github.net [10.48.182.49])
	by smtp.github.com (Postfix) with ESMTPA id 79ECC7800DC
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 12:25:15 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:25:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1169068/a53f4a-000000@github.com>
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

  Branch: refs/heads/1169068
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
