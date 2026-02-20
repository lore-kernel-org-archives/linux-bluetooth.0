Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937F61DFDE
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771621372; cv=none; b=AjE9bKcpNTA4BjY0b/nmT4VGOXzUtGReSGa6Gceo8rKO/hrD2n7m2qDe8Wlv1cvkkw/tG58J4PnQS9D+u/EeeGB1+Zndv6Zl7mfo1DVcs8hOskEC99z4F8Wnw6Du6kLEIzSQJOEdPY6QI8rNV3j2KpDtshvYmlMWm1kFvBWNLQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771621372; c=relaxed/simple;
	bh=NJxQAKybhdpWL2h4Z4aOIFgzbGylWTz8cxq44U62wQ4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CIa9trfCFjKe9jlY183jd9fBste3rONLlxIyaubJxTxqRBJmXAXkaFN88caD+Xi9OVSPesHI/jdBhU06IiTTBBya8ZXCh0UQA1CHJyYBYjshdqgp7Zd0TSO2tOb36E1dDlmEJNQ4pGWbggK7c/b7JrKqQjwDpqA9iEsffa6zJr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=M+rCTjbq; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="M+rCTjbq"
Received: from github.com (hubbernetes-node-7fb70de.ac4-iad.github.net [10.52.13.92])
	by smtp.github.com (Postfix) with ESMTPA id A37D620B31
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 13:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771621370;
	bh=xvhMq2//+LtJDePKCo2oWIeLJQRMMw5P7g3ockVGz/w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=M+rCTjbqwrxsZRdVgnGrH9KsO+yXDLEuRwZZ14HN/RF0ykqomgI22RE+r3H9wP0E4
	 RfstHllMQlzGxA3X0IPrVzRqRx38tGDsN1fvfgvdMMpeb50DNy7ukMnwr/tZu8kqdU
	 5VG6jv6OGFWvcGpA71YtxbeSyqpcs9GEx3vebnTk=
Date: Fri, 20 Feb 2026 13:02:50 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1055977/791df0-000000@github.com>
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

  Branch: refs/heads/1055977
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
