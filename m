Received: from out-30.smtp.github.com (out-30.smtp.github.com [192.30.252.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F843F20E8
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869551; cv=none; b=RgQQQ3XcCe/p1fwPUBWqahy/J71ajN4FTFUeogCroqDuVjDrpxQYtN4l3jkUPkyPu43jRME8Q124G3PKuYLr9Myva05yF91AgT3nsAqYS61gkYNzvzVboXXhEiTk+gh95D0EFrLBixq7itAoGFHNa5l++XVU/mSuPZXu0u3vKwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869551; c=relaxed/simple;
	bh=jKFC8BnepWETHdS6JyxeI4kqVrq4vFQcpE8AwONTF2o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lZlteUF2QNd8OjpUwxBaNEJerNghpXeKML+1zMdufip2KC/UoDCT7y1e5oNsNSvmv0zXoTkqpjYnv90XUhBolRuQtX2OFlwrtyF5KI4zPzFyS61H5qFxwqCqbYWrPL+u4bm9qpuW4kTGXBbRDZFosY6FuadCMMT0BxHHot/Oueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=M6R++Jyd; arc=none smtp.client-ip=192.30.252.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="M6R++Jyd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785869549;
	bh=I3meHGPiVL8Eef5wTH1fDkp5sjkW/zVBYIf1X8NiKeM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=M6R++JydodpS9rrPKp/+H9nH5Ir+OTynDHrHiDuqIBcbhWVNi6YJG9uiz+lvx4+79
	 T6DgpPW2781kupe+3xkNVmAuitDQN6RSYTuGOgQHxdNNoRIFNOswUwG1TXK9t8V0HQ
	 4A3E28ULpzyuNEt6eSRztzYTJ2sEB6LOovMCYTGE=
Received: from github.com (hubbernetes-node-db0bb1f.ac4-iad.github.net [10.52.222.81])
	by smtp.github.com (Postfix) with ESMTPA id C94B3320793
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 11:52:29 -0700 (PDT)
Date: Tue, 04 Aug 2026 11:52:29 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1138148/31d59e-000000@github.com>
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

  Branch: refs/heads/1138148
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
