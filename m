Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73E33936B
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733731; cv=none; b=mF7MyBnkXqI3bTk5Ui5Ummbtbk8FlqxkolCBUNmV5HlOySSQ/sP00qxwhIO+LVPYpLQ/ojxirm7HOzeCJJIbsz0VCLi86KbN2iAW1SAGcHLErmFGvSTjX6l36WKl6N4ydLC3KHV8DBduMez+SbbKOvxTV8N44t7DH5zCi31JJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733731; c=relaxed/simple;
	bh=p2gjXD9coqUT1QdKPAR8M3hTn/76wdAo+db5eEpN8UI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=izMXKMjS4xbhpqYsho14tEZY5/z/pXnphXK0Fkq+kcl9YGePD8tCCE4Oolx0t1yggygHGUrD3eJRi4I/+EHMdVvSxmxbfqE/w2e8KVY9vu666YnpeMf6sJVhJNMKLqdB+eiYHMnVn+m6BVgPdka5WdixTVqrU34ZXxjO4qUabVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ietCX0PN; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ietCX0PN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786733725;
	bh=TPLZIi3JsW6bgQR+wm8+m68w48Hx3LKtAXWrztw2xj0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ietCX0PNNiqnW/AlhwpH5PMvyde89RVyhv7tnmQGoCPawFUGZbNp/fCw4aXVUv6+m
	 vzynt3DShmgNYd4KPmrqTWvV81dqPIY+4oELnRMkIs9OBuZKluhHEb86UCjmqFBiuD
	 3l50Aw+tAtS1vO6Lsf/uQ9/mIiIhgOKZQHckHnIk=
Received: from github.com (hubbernetes-node-290f9a5.ash1-iad.github.net [10.56.186.32])
	by smtp.github.com (Postfix) with ESMTPA id 5D73A600BA1
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 11:55:25 -0700 (PDT)
Date: Fri, 14 Aug 2026 11:55:25 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1145281/3a78ed-000000@github.com>
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

  Branch: refs/heads/1145281
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
