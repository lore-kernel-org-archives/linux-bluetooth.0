Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330952356C1
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211369; cv=none; b=e80H+SoaO7wf7nSqLOAfVp3QdwjeGzc77Ydktg8t1nVIGabNBvS+P032LCgJoIBPVgqb1NXdg5dHRMPod3PrfR2tlHhELNdwcIt9/5amZmXU2cpFOC/2pwCspI+TFKQeQjE0FjEP0OkwlBzZ3LnHVv1MwzbWXrJot7rxjdjqYrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211369; c=relaxed/simple;
	bh=xneAZzXhO4J7EyAqY+8OVHePYPsvIxYpj0dK4CMjBZw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Xpi6+BXKG5VHs8wYT99pBIg8l1hRssR4Q5roabYFJnhECYAFInITCpAM0RlflH+jT453c0f8lRBv92K5LKxeBCttZjcg8waz8EMe3/JIAb33bwuUpP44cB3Y7YMLqMx4yqRwJ9UURV4ZeTRTJDs4ptqr59GsJ4I/hU5PTLld8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=k7964HZF; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="k7964HZF"
Received: from github.com (hubbernetes-node-4edcd0a.ac4-iad.github.net [10.52.12.57])
	by smtp.github.com (Postfix) with ESMTPA id 3826B70012B
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 04:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1742211366;
	bh=cz9eHi4thW8hZA3FS4VpknTF5TGWNIWSmQYEbf2P3mQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=k7964HZFD5RUSWo1GLGDRqdVnFTo6daYLLmhoTFKTma6VYfNk2A9OCbDWsHcBoOWm
	 TeXnke9Ehxsj7dNZQCwhIM/Bcbxv+Y4nBZc8DoyVp6+Z++dDCdCjCVS0tC4m9OXXgI
	 XjfecOq3zEx3/qWiChBOB8VhVdFta39JsPNwyq8Q=
Date: Mon, 17 Mar 2025 04:36:06 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/21d45d-9590cf@github.com>
Subject: [bluez/bluez] 9590cf: Release 5.80
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
  Commit: 9590cf12b23207af2a2cc212d808339d7ac85963
      https://github.com/bluez/bluez/commit/9590cf12b23207af2a2cc212d808339d7ac85963
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2025-03-17 (Mon, 17 Mar 2025)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.80



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
