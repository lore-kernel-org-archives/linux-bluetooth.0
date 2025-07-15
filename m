Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B721CEADB
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590518; cv=none; b=LeRkn49cZF1m+Hzv+N9LNAo+QF3WCtbSu7dd7ZpQlnXjbnqDarstT7zVknwPC6Gmkt9SftPLcqrkswmucfLxIeDSjUFkMjPsmFc+xYDhAXeF1nB0APDN1nLvGYGiVjF9AV/XSBQegTQAns2XmTqJXCJ9BtvAYbpgjiQeoVeI2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590518; c=relaxed/simple;
	bh=+zvu/oD4znnpbN9rZCBNaeDE8vEpUWu7XlCB47Eh7Sc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XM+9aYhwIS/6bXKkrtzQuQJLD7BGWT7zPTLZGOutO+dol5iJo3mKztRBFOOJW/+Zvo3MKYV8h/CumBz/YqzTLqSvZ+XQU8aP3eHMERojB6AM35AUXpaeqNhOFUb+pu6oW7ZYEwugDakFYMPv0tf7mTF8HdFRMmeN51jN06RxH/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=W3H8/3JU; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="W3H8/3JU"
Received: from github.com (hubbernetes-node-2732076.ash1-iad.github.net [10.56.176.59])
	by smtp.github.com (Postfix) with ESMTPA id 560D7601362
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752590516;
	bh=Gyd20vc19XzjJDIVTBlLPRdtnamDKOY+yX6HJNkrPhM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=W3H8/3JUGJxLVRUTu0554W1YQ6y7P8Uot8ECDURy9lqrOoixovK4aIQeZm4BLShU0
	 ybQ5C58wwxTa/lL1WJJeS41n5jFnDekE2e7AC+UToaEkKjnLOZN8exnjjhrm5aAvWq
	 QQ3/Xav4A/yiCltjxTFBxGfg1eu96nECAooqu+zk=
Date: Tue, 15 Jul 2025 07:41:56 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981661/ae801e-000000@github.com>
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

  Branch: refs/heads/981661
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
