Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BFE248880
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 May 2026 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777713077; cv=none; b=BrITjeNduwz7XS740GBAJMgjW0iLAvbuTPTo7HGS6jOpSpG1yoi2Lt6/gZshnsNAP2RsUPHxtE+/9ZwrL6BD9Gb4kMfsBd3/lns3Kn/Iewd92nUmqz5tdPkTZEhUnKr0e6OfpOP7fHYE3f291NtFMshbZMlnvIHvvblkUMQR04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777713077; c=relaxed/simple;
	bh=v14eEbeyL6h+3a9rgFuMKdqZ9iw7YsvjPPUlGMFepIg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tGyxlD/TfT11qiwZob8qrtePGWhiprMelCN3LlzC7/I1FVyIy2aSkSYfw1pTug0kOGNwIqJooXPlrnu7q+K5ms8IUPrHtEGANXHIKLQ6G6MPTiW12dWbpj+OtInvD5YhUM9hS5G0KcHbpeasNqGQB/vx5NY9NGpR2waKAHKzBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FgylA7yj; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FgylA7yj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777713075;
	bh=3u45Pyh2yutT28tNBNBbbpe2/37ZExLiAK1GF1/9dOU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FgylA7yjtzOhMBZzpxAj8Y9zsicW2d/P3Lmf7h6hqYulXWO1VLqSqB038ljhqdP4/
	 AqAHkL346G/Z5Bwz33oTzzHjXcjkINdPX0jwn3cAA5uAGUTQNDd9lX+4LnsOt1kjnN
	 j0RPqP+J1vCdcOPkcW56L23eJGOmNoOOzknKCp/8=
Received: from github.com (hubbernetes-node-5ac7122.va3-iad.github.net [10.48.168.21])
	by smtp.github.com (Postfix) with ESMTPA id 241625010DD
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 May 2026 02:11:15 -0700 (PDT)
Date: Sat, 02 May 2026 02:11:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076276/5d6a4f-000000@github.com>
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

  Branch: refs/heads/1076276
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
