Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D86D2773F0
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770098; cv=none; b=lhW2vUG0WAq1kFPdumjPK+mEGfv3HlsBCfUNkYc81XUu6YGb5Kd9a0AfgKSPW578DlFMgIgFXk/YALRQjK5fZ1hpmu54VcE6hHAtGxzlXPrjPHZlc2Bne69HrjC9qCtWRE2DJEY9w43GnPmD98+2FwnksjUGvCRV6BZXxy0HvGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770098; c=relaxed/simple;
	bh=cxl6rEn2K9PceDjtOhePRTOAvjehGHKVYCB7hQExRTQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BJOVeXlqjN6oX5x4yGDrtsbwoMCDz22YuAxu+YT8QmEHQEGvAMGAzitxpYPHP9CaZdvkwU4Sg1QpYfmQqI0wpWp3ss+l5fMSq8jmzesC/+qHbFRVjo/UE+KyyS19EKmHB8lFaKTGNedetWWv5AViQlCC1QNUfCwnE71ighLQGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NO74ypV9; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NO74ypV9"
Received: from github.com (hubbernetes-node-8e358e2.va3-iad.github.net [10.48.219.68])
	by smtp.github.com (Postfix) with ESMTPA id 1E6518C113E
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761770095;
	bh=jF/7lz/HBy14PX0Xk2y4uWxYwes92glXrxyh1bTSPo4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NO74ypV9v9YFjLY75u680EsQG6/ikIla50PRIzzqbTQWS4XigO5DzxlgZgnB2gNq7
	 bmt/Jg+SVjI/+scjFpFR7rxdI3R3lGdXHrNPuqFy+0LEmassx/sfNSOZiGY+I0HbbH
	 CI3VBnxah7q6mK3B8BKfltDk5Oak+xT7NAGqdbuk=
Date: Wed, 29 Oct 2025 13:34:55 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1017464/000000-802172@github.com>
Subject: [bluez/bluez] 802172: monitor: Add decoding support for LL Extended
 Feat...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1017464
  Home:   https://github.com/bluez/bluez
  Commit: 80217266537e6e557617d03b61a60254e985b18e
      https://github.com/bluez/bluez/commit/80217266537e6e557617d03b61a60=
254e985b18e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-29 (Wed, 29 Oct 2025)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding support for LL Extended Feature Set

This adds support for decoding LL Extended Feature Set introduced in 6.0
that adds the following:

Commands:

 - HCI_LE_Read_All_Local_Supported_=C2=ADFeatures(0x2087)(Feature:47,1)
 - HCI_LE_Read_All_Remote_Features(0x2088)(Feature:47,2)

Events:

 - HCI_LE_Read_All_Remote_Features_Complete(0x2b)(Mask bit:42)



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
