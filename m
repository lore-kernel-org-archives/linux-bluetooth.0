Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647546EC6C
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065849; cv=none; b=CX0AfxKNgi1CJLEM/jfJr2gRwgY8KOMYoxb1FtaSiuYhjwTLhZLTNR49FxVa2CStk70j20EQIeMtZl424ZeZ1siX4zi4s/iDh/h1tFh3QfNEXoIFib++/6Uhnv4/oNbKc6z5KW+kGElxs6n6Zr2MlISq0kvsmHq4cxg7KLyP468=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065849; c=relaxed/simple;
	bh=KFbf213gLGZgZumHugQxAI+CpcTRDmIdrjU5oOTVkU8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ops4lduSk+t2OQHhLM+jSQIsmkXH/rei5KxRePuoeKWeEEugeoWIInYYRVipqhKZrrZOyFYgT5iDz724OxKnazunv7d2SNX17FTpzO0PRYpt2KKLM73EKEPmbVG2KW0iHuxts7iP63ZAEV9EIhfN70f9ZUC5TAI5A/MXld5C7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Qs7k/+Yd; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Qs7k/+Yd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789065846;
	bh=L6ryJtHOAEPXyllE78BIaIyxwUsCGHskWEiMDn69Ujg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Qs7k/+Yda00mlLIqzL2ASbZU8luaOjH01jJQ2uzgqtQySiSUhR5e/bQQJDbLcRWVj
	 K4lHVBqm7+VIaT3CaDatuLgJCX5rT6x/+Q4T4V8vN3DW7abjr4dUbIO95Fr094Xbz0
	 nPq7KCkqOv0M7O1I+ieS0cQ8lfq+MrJrQS6+pL8Y=
Received: from github.com (hubbernetes-node-24c95b6.va3-iad.github.net [10.48.66.87])
	by smtp.github.com (Postfix) with ESMTPA id B226E2801A8
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:44:06 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:44:06 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1148981/88cb39-000000@github.com>
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

  Branch: refs/heads/1148981
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
