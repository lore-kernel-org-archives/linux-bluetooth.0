Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2397352C34
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577433; cv=none; b=RzRzuW7pWj58pOiczsAHVugT7mjw+WEoCDuw4czpKZdfJ4SPXxuTPSmuuP1oapUgcTBrs0UjGbnC1p6Dr3z8K9S8MzRoaszgdKbVWLeIGobCdsQDx5WMc6yPScUqBXxEHvwfuJMx3Qck4bXO2WgC/0tgsbPeq0eA8cQPXqDqbj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577433; c=relaxed/simple;
	bh=7mHjUQ4bpwMRCEIOh3duCcqJa1o898Va8ijldP2ItMg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MGVKFBCYVkBksd6V6YFLvrLLzR09Ucq6Zym0RhuBzUgaivpx0kIKehYIdFxZ0cq3/iFmqNT2TNZf6Q2bnaZG1MqDnOmvxP8NJpQzVEN/bKGGxu6VRgVQ+TtpdFeH5Br1qC+ce/8tcmqJOgDgVzhAdWy8dYSfqlpVEjn4Ip7C1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DxeDfR8K; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DxeDfR8K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784577430;
	bh=W5nTcq4HOQUX/5zASYsMQvd/ougREbK35Yojfhg1HeQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DxeDfR8KVoHWDIubQ7ep8U2WMH0z30apxihl/a2AE1XzCQRy8chE6iAyHhC2O3nXE
	 kNXtmnEtyebjbSuGE7SOQrkLfat2yukvLrOZQptUHs3b/qfIQS6SSVlEgSg5Q9siHa
	 2Q6SJUg86IJNQfB0hCzVv/DxipV4nT8Ge5p+CSXY=
Received: from github.com (hubbernetes-node-a691a83.ash1-iad.github.net [10.56.128.15])
	by smtp.github.com (Postfix) with ESMTPA id DF5B7601098
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:57:10 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:57:10 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1129413/0e25b2-000000@github.com>
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

  Branch: refs/heads/1129413
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
