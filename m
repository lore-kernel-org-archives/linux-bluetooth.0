Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155A37C911
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941976; cv=none; b=kZUVUDw2+NJYpBJzIrjfQozxtVgeD3RBx1NSLcMlp7kcX3WezYkoGzR/7Whu2027wIcGbolpaA38tvC4Ld3DPLLdCJ329mRyYIVEpjIT1tqMqGYoCub81sHaHcrKLtk7D3arG74DRx1FyCClL+aMWXuo4qPFSBwN0TH3RhIQnK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941976; c=relaxed/simple;
	bh=DbpcEyLwQ1ozX8b8CvMfl4UlDk4yVjlLIJbPuW81qbE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gNTdIbi3Qeomk6gO8aAFrrClQuywDvWM9P9uHTC6xKlSyh81KtVHsfEOkwUdZ7RykbyltQChxAJ7zfPxkwzKzB7jCU/FtYFfnOGh+1rgorvsfjqiDGggy5LUnEBT42qrpmCJDH1Y4yoT1GTPrqTALF6GCBWPyx6+osXxMXBZhNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mFVSSeMi; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mFVSSeMi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776941975;
	bh=8FlqfjXHfcPsydq2AY+8BwEU6lgbQjlPGuPh9Y5b30A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mFVSSeMi3G6nuxsh+3rbXqNK9QegyYAVJ4v2FMAsnwmuLDx5YEXDUtDWhKy9ndQPG
	 6lCYYoFOeTujwDABAdRUePnUxgUpDaDNrRWLfs0SLr8lXt0KRW88hS1FXzs86/uVkv
	 nZL3OBoZYsmILdScrduM4lKrROlQTl/aYmeMsEZc=
Received: from github.com (hubbernetes-node-55fa0bf.ac4-iad.github.net [10.52.202.116])
	by smtp.github.com (Postfix) with ESMTPA id 029939410C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 03:59:35 -0700 (PDT)
Date: Thu, 23 Apr 2026 03:59:35 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1084559/f44f8c-000000@github.com>
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

  Branch: refs/heads/1084559
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
