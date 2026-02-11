Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C421D3E4
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770834977; cv=none; b=Ez3FQiPJcj68/hsfgpfc7HL+HpAeKvlhlO7iSd7fo0fgnfWHXJ4cev7ql4MvuSP5z0AnZ0W1Xt9UDpDFHE5MPpcXdz8dBF4bSEYYbPOqw+YHFBAgEWnrDzof1cWLler6UaKzsaYZk4GkRNh0JNzUAw+1DWjm6HGXYzwUzXm55T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770834977; c=relaxed/simple;
	bh=uc5XUfspV0bMMz7nwRDniuWJYuKGfW7aji/WyBujojw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hSuko7gIwAaWWXEGu0uiXMu3lzCR7/MjDuAurmWayWqrMomMZWp7BNHvfrr53uk/y9UuWgmIlOWasnoHg/ZCUMEqhdOiZRpMdEX9t7Cb09plHuKz+c3hKb0xWBLACiyxFvvef/SlGDoGxbIzwtAAEn17QibVzNbd75BED3kd9Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QzrsoWLI; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QzrsoWLI"
Received: from github.com (hubbernetes-node-d1858ff.va3-iad.github.net [10.48.175.34])
	by smtp.github.com (Postfix) with ESMTPA id E00393C12DC
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 10:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770834975;
	bh=37pP50Pi+OJJEQHOjabElrrtsP61AvnVuhcmTaIMD4w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QzrsoWLIC2HprQ7zsdi5GkK1EHe7D/hhvDLrxAOuK7V5Qszz383qbkphEm6iEyp1e
	 HzV0+Azf7xEy6H6FSDYE0NKnHVBLc7CsuGhvCt/EyO46J6CB+GENVAbXirN2hTjUyt
	 KRzM6/81pUC3CZsSS/Jyo07Cdw+7l8kepCPV/Fy4=
Date: Wed, 11 Feb 2026 10:36:15 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1052893/83b74b-000000@github.com>
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

  Branch: refs/heads/1052893
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
