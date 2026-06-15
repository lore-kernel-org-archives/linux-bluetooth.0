Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A78B3033DE
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547020; cv=none; b=k26dYY1/fPeg6OaT6JnYvWIl27+UcyACfl0Cckh73rQhRk7NdYLcyyin5kYw7no4kpQatcj+qTdGOsS0X+zGvAB1kXIaGJDYMcy9j9zeiTLQvfdFreEGKu3BTLxrcuPmRJ3eHMGx3dlv/6bQlbSSE/+did3QZCL9QLCWGI8WxTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547020; c=relaxed/simple;
	bh=YM27xBD/Kq9qAEKfShC6l0fpWqBi6yHhqsrj3SK4128=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OL3kN1UQDj9pVymgeRq70z2ZAjPjaJoWE4RGDZepfLr0bElTQxREDCeXPY19g8YGvytt96BeBmHeMX6c20kSMCp8L0l8s2EbW8x3PpzrFP6pIMUBy/EpXamDO453Eh2CSGbONV5O9lDruUfuLVDNP8xU+gdxZFAS5e1yp9+mqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hkogj40c; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hkogj40c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781547018;
	bh=SWyCfadkp5gdHU7O5DnAEnFIkWJjjsKk4oAVCqMX/Nc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hkogj40cmF7eh6o+rSuIdGxc+YGhc3tx2HdcxWCOC3J+MX+1XSLyw7veyqJCBdgMs
	 WwcnHS0pICMU1zBI0zmTq+LP1TKc2feBKFjqTfVY/0Ye1qc5ZmQUT01fXNa84vUYAQ
	 Nb6DuiZH2hwd7ebykJIr1QN2AJ2iiGasCalnnqcc=
Received: from github.com (hubbernetes-node-4978b05.va3-iad.github.net [10.48.12.63])
	by smtp.github.com (Postfix) with ESMTPA id 94F125011BB
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 11:10:18 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:10:18 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1111249/df5403-000000@github.com>
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

  Branch: refs/heads/1111249
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
