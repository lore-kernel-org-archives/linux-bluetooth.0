Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5831A27F16F
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217822; cv=none; b=BCjnFDMnOJbOaSNDGsGjMeM4YTZPQ4/u1kcIn7Z7GI+o34pG8wME64zmoJ07LKXdbIJHou74E4XtefIJ7p0UZQfp+VmIkukWMQvPmhKjXzLqQNeQo6yqGLQDVKcA+2R/CXpSbu65k0jHGVfpWXX6FzbqrdO/rbYu+uBSguOv9ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217822; c=relaxed/simple;
	bh=K4VkKPps5WOkXlAm3Y5VuSo6MiomzvDhcNVKPHdWWMY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mrQGTotCL+SlF5+m5yZw6pPSQg9yjdL1+NRisabUB2CDbzO+9e6ARxoJdfcZ+Uium6zlS4VWg/3DGFKIjtYG0dWl6f8GULV51jv8pfx+0/EC3LdBhRk/gMiZDjsK9HkFMN9VHb9oyyYjI5FsTpMS6wVCZ3n61DmpDh0uaSeB3hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PtmiJAH7; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PtmiJAH7"
Received: from github.com (hubbernetes-node-1ec4deb.ash1-iad.github.net [10.56.182.35])
	by smtp.github.com (Postfix) with ESMTPA id 6142A600B2D
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758217820;
	bh=MyG23wHzCf7BJP5s2ZRv7WeIEWxtMOuhwBBn2cvy0Rk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PtmiJAH7iVrQmT41Pxzx5NyEdDxHhzRafsVVFBIOl9R9sjKE3dqWget5J1uCh/ezj
	 3YkxZHNNm9MX9aruGiYfA2fAKC33BVB5IDXc3paTp9BxBmd4tg4qRdv+wj/xfeP8Yb
	 pL3Fu6FVPOoOjgSA94WbTEcnoHXINsTfzbxnUfYA=
Date: Thu, 18 Sep 2025 10:50:20 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/61d3e4-da5daf@github.com>
Subject: [bluez/bluez] da5daf: Release 5.84
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
  Commit: da5daf532409812c41a237a6a6126868f6867079
      https://github.com/bluez/bluez/commit/da5daf532409812c41a237a6a6126868f6867079
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2025-09-18 (Thu, 18 Sep 2025)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.84



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
