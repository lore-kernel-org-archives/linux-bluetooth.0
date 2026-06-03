Received: from out-40.smtp.github.com (out-40.smtp.github.com [192.30.252.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8183B585D
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502291; cv=none; b=oKwHeXYqGl2NZUYlKbjxGIJ15AMhmOaLQQOqA7F3NcEfsenQR0EZGiBKvlFuWH/99JZbSJ+k747uOW9LA/sKAC1sw4TFDpsszBJh5+h3rlov1HO1TgM3qiZu1eieKNfcBWbLNjVK9w0bf3RrsNRlesLbkQaFGZfIf8gdHNzy3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502291; c=relaxed/simple;
	bh=hrz+ZH9RCugeGCzIajHcg3hVcOdxu01mc4qEAB/bE5I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Sf8a+zzeKD3jaRnewhMGzled2PhdX8BjqsHOdkUWfHlMJ7d1ip1QyibL+1CDrzdw0qCtfUI7/wLMpYy1lzJfaffraMFGxtSCnvPIVBCKNB85IYhMKcY8S28wYHS/0BWkl3o8d3GLMKOL2NmK56wHtaszXMV2yp/e7Jcl89/MIGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RsOrUfXY; arc=none smtp.client-ip=192.30.252.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RsOrUfXY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780502289;
	bh=rx8aYBHHCrTCDyQqUokfmq9LlPAi/tXuBzAFAZGNyLQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RsOrUfXYOU7IFHfD/ifX6sHv1NkHBmKOpSsiLDco4nWccuXIQqq1nyAfSClK82+S/
	 H7FxAjpWBlMeTUEhd+ZQPu/BffDBExfThUvk5QI8/BI55uwEZB0y0llpdvedZMTxpT
	 9pDmfzE0N73Uhmi6fK2bJVImtC95Fm2qnJjqUJWQ=
Received: from github.com (hubbernetes-node-0722a26.ash1-iad.github.net [10.56.164.17])
	by smtp.github.com (Postfix) with ESMTPA id 76AD692900B
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 08:58:09 -0700 (PDT)
Date: Wed, 03 Jun 2026 08:58:09 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1104846/c3ed9c-000000@github.com>
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

  Branch: refs/heads/1104846
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
