Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44B25569
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013493; cv=none; b=QwLomrgn319nOFIWabyXVKUp5JyQql3PWqLNX+49C/ZpdwaWUpoJnbwD/lXmQ7DB5H9vfds/dCCyP+kGiRzlqQiQWzFuvJZxzwxuitv8WUdW4PhozhXI+bMJy1tzL8DfGOs+tVZyoBNoHYCUdIwuLRgJ5mNFFUQM7+IQqQrYixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013493; c=relaxed/simple;
	bh=R5099vQaF5VfqDePe5MMv1vNdZJ9WtHrbBL+7qSn+Ds=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UtWp2BQouGmt+DMQg1BODQZMbDcLFBPrhSKYNxNUTdGIg8SToY5UiXLO0bDUvnetxr7sGAJzdF0gOQa0f9zxKOXiuqnY7azYiEWfE2A8WVd1Ckkc+xBCEaxL37HSTS6oVXG3+wXq7HH31Wzx1r4A9kx7U4IksQfow9BnOnxApmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Rh3MvyQO; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Rh3MvyQO"
Received: from github.com (hubbernetes-node-5c451ec.va3-iad.github.net [10.48.209.69])
	by smtp.github.com (Postfix) with ESMTPA id 016724E0843
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1715013491;
	bh=y6XvkVotNUuDKIF2hGJj652tsPztq//bo2EjmLXu8uA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Rh3MvyQO9f1n9pKjjex0it4I3Z/ur+zbesxVeX7z5VM3szeirY5PCqH+7/IXb617o
	 GYuWVc+kcxHYmZ5C3u8wSL+xhkOaNW3Kc0aW8Fdr4CDGi2BL8CdlokmHLlm3+oXRri
	 HKqNfQvXvFaj+ZtE9HLERQqmdIbhzPSfrPc5aPbo=
Date: Mon, 06 May 2024 09:38:10 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f34cc1-78af54@github.com>
Subject: [bluez/bluez] 78af54: clinet: Fix unregister-includes command
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 78af547e94d9d87d1f06ce0868e947f75af06fb7
      https://github.com/bluez/bluez/commit/78af547e94d9d87d1f06ce0868e947f75af06fb7
  Author: Naga Bhavani Akella <quic_nakella@quicinc.com>
  Date:   2024-05-06 (Mon, 06 May 2024)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  clinet: Fix unregister-includes command

unregister-includes command takes two parameters service uuid and
included service uuid, since the space between them is missing,
the menu option is not working.
When two uuids separated with space is given, it is throwing error.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
