Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5CF30C357
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943837; cv=none; b=VCCLSnh03RiP1+eFEafEYBmyRajdWU2nVXvKytWnRtMp4ury7CpaY7ygNTwlDc6RpmqSCp5bSdUfZ7/3k0sbFaoTbko2CQ6k5ldZ9Obf1lxT9oSDoZiQePjF9gy9SQTdV4Dlrn40ob8VoyYl8JQG2mmf7XZkXhY/jbN9kGQNpfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943837; c=relaxed/simple;
	bh=EJOnFfbr11QOHeS+/fNo78RDanRaCRJcVuEsojtO/GE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fBqDlzVJg54/jVKVhPDot1HEcNFKXXoI8xnhCo5DuWhYa3tXyUHyXGHdDYbEGafO3XBhG3dObnKmg72g+X6LztvGnW+wQa7g3BuXywZhLMtD79EOaYelpGSi0ID7tMrUl8g7mvMoyf/K1chiDagUANT0h8FSTW3B4g2TR7k3b3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XdCFJwqv; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XdCFJwqv"
Received: from github.com (hubbernetes-node-c2f3284.ac4-iad.github.net [10.52.182.43])
	by smtp.github.com (Postfix) with ESMTPA id 8349621377
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757943835;
	bh=NWZiL1xtk4JBmdVIBTkcv3B59Y1I+X/RMzdLxCwvS28=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XdCFJwqvBXWqa9/FSM5L0T5zRcq4Rj/xR2n+FE35IaUEPxe+uJyAqU+3wM05vBDCj
	 uU6eJ6sUL+pk2qXJxtzz2rCSuDJ/GXSbqgw3UCz+k44KlmFa2KuxCFxG9olZpbjMWn
	 c9/6Vh74IjbOFogmTIBfXOtnmxRAsX23qn4KuZ7Y=
Date: Mon, 15 Sep 2025 06:43:55 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1002338/d4b7bc-000000@github.com>
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

  Branch: refs/heads/1002338
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
