Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0339730DEA6
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849124; cv=none; b=NFyWXO3leHxut04eqWseflf6T5abjxVeLqf7gZ2fiW68ix69yFKTIk8TXsHlybPmVmeEa/wNKq/fC2ApaMddEUFpgUlLv7jus6QTfao96My+d4l/6YRbaocFVA4vDxoo2bJMH7D70kqZk8q3M19x9ZtnUxGlmS9oAG6AlEdV9MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849124; c=relaxed/simple;
	bh=zXCixXuz7oZMNMCHXE8UIKUsypMfD7V02VbUWcJxJRg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ntydU24M2C8U3sk13qlRB3Wv1IhMn5NVFgePsx8hyW5DPo68ZlyVsxWpB7chmzJHwaJHFqbqw+ofuFODeBTd5LYX/i6H6WKBGFNg87VLgYOVaXWQwHoMsh3Mxhlqag5cyingoZcDs0CsxfE7DJXqoB4zBQMZsykSWq9W6myBSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=ii/4xAsr; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="ii/4xAsr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791849121;
	bh=Ks+lVb3SAPOpyQzyPUKD48qMn8LGKlnpsInWEr+raR0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ii/4xAsr7BTgZlQ+pSrYseUOuc5qbrv+JrtKpbWzcHiE7zj7ypNfa6fEc8nupDBc9
	 8dknve+VXyNq5dw1kUgG0RAbp8rrcN3y1xyZQYsYBYBe8jBSjJVyJueLVPbGAZ95AO
	 znKB6uICrbsyde9N+AKAJfx+FnNLu+gW31YB1BLggdtoBWV5YlPCPLUUfw6vX1W3c/
	 HOGBMgc65H4KHxYn8dP1N5QCRAJ5G/nmqU5y7oEViDwHOLlDE+KVRQA+GM40lb9bp5
	 SL7cksCw9EsX8pCZmVnS5TgoNaUOntbK+in6MX5RdB7eecZ4opKVjJnbNdalozWGuy
	 R+ZvPpdMqHAWA==
Received: from github.com (hubbernetes-node-6b3fcdd.ash1-iad.github.net [10.56.159.44])
	by smtp.github.com (Postfix) with ESMTPA id AA563180A96
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 16:52:01 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:52:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1182787/0034d2-000000@github.com>
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

  Branch: refs/heads/1182787
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
