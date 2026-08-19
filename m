Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11727443A8E
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132400; cv=none; b=QfB6vZDTUGbp/5XY6kZTOevMeEP+ba34rSrT+Qkpluz7YDx/RcEY+u8pt6ZMHZ/TOhQNjqE4pxeGnZCfzZzBkiuNuhZKebcluvajaWofxrGvg+0kSAHU6ccfoUy/e/+ZermzmR+uWKCWN2hSqJO4f0/eKdAcbB7X1MCFUMC91zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132400; c=relaxed/simple;
	bh=2VkxWwzijT5EPw7ZUkbyMBGU7xRpLPQbrN5gby36EdE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gHN/ocZQALtGwcs35fOimfAgEo9SYSocb7LSOvQAcvgHup44j0Omv1TbRv9ssG+ECjwqxhlswTaR3ZQqWQLnilLTeiDvRfq7k8IuM3VtPAstR11mfESkJgTDfFOcV8CmjQDlTMA/ETR1+6wPRpZwaKZCqKMwIGXPFVAXaA06IWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Z44mAo9P; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Z44mAo9P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787132394;
	bh=UE21Hs4x85HOGqawc0IP3Jz0R7Imk61q/ycJ2ydzMEI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Z44mAo9PoptK5sQK9Pq9uv+3dNq3MtPRiVyOuQLFVnn1AZLyZCZV53tkSlOvu29YT
	 Av33cLkN+A88Vg7372x2kcOFN8KpSrj9GLtnDwZbO178D6PlFFDGgVDSlA0HAeOsIA
	 rydhsRHf9nHeejI7aMrYIGK/bzBaQKJBq3deQm0c=
Received: from github.com (hubbernetes-node-0c1aad3.ac4-iad.github.net [10.52.161.13])
	by smtp.github.com (Postfix) with ESMTPA id 96828740C90
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 02:39:54 -0700 (PDT)
Date: Wed, 19 Aug 2026 02:39:54 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1148340/000000-dc5d10@github.com>
Subject: [bluez/bluez] dc5d10: doc: Fix typo in test-runner.rst
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

  Branch: refs/heads/1148340
  Home:   https://github.com/bluez/bluez
  Commit: dc5d10adcdb446484a82b993ceaa40ebc655ce03
      https://github.com/bluez/bluez/commit/dc5d10adcdb446484a82b993ceaa40ebc655ce03
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M doc/test-runner.rst

  Log Message:
  -----------
  doc: Fix typo in test-runner.rst

s/lunches/launches/



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
