Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA2A2046B3
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743516967; cv=none; b=CpubiqWDdxrzrsDQcyFhjwv7UegOhg5eLTM7LNILVEsLf0+Va67Y6HkLwn5O4eLbdWx3SpxnO96gRz+i9Pr3RuDtDX5X8NyHIMivYMLc6MOGiLewVqWmHcoyOFFXU29PJZY5EAx9Gu4dPKUN3qO+66k4lodz6rievYfWt+NVJqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743516967; c=relaxed/simple;
	bh=rZNc+BqW4UkW8vgokFdsT6Yy/DiJtXwOtDx96AM4qoM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bFNPce8Ko+fKvQeVWWPbAZ20k4h5fjqY9IZMmGve9V/k4xseTKXyjKilMmYIK+SHP1ZspiMYXQAogYMt+dzVfMVRM6pvgpoV7jNSmQgIQfs3SA+c2Lk9t6q4p3lrsSRDXuAeVjfmqLTQcd2QKwxr5EqyAUtXjdGRgtl24IvolA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=F4M2H2lG; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="F4M2H2lG"
Received: from github.com (hubbernetes-node-10aa7ba.ash1-iad.github.net [10.56.209.121])
	by smtp.github.com (Postfix) with ESMTPA id A6B07920AEB
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1743516964;
	bh=vjDv03C6sEXJa3BZbkNG+JMnK+g1Pi/hxOpTk3KwmdU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=F4M2H2lGaGazLP947pXVz4+yjVbgWYWR4ICGvsvXkd3Dw1ZJuhfsuu4Gi/xM1dU5D
	 dzA9Ader4tvH9C6dpLlz0WE/ECe8KyihuNkGr7a2Wb7LP9IxQIL/H4oCYBQD3C+xTQ
	 wqEQu0ge14XbIYe2gP19c8yxOCJJj+QJM7xfqkus=
Date: Tue, 01 Apr 2025 07:16:04 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.81/000000-a70843@github.com>
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

  Branch: refs/tags/5.81
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
