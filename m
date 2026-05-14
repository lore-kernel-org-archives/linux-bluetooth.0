Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29E3A5E7C
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778757887; cv=none; b=Bnt1xnBqOtILO0Xcv4NrV/fh1mh4uKYvbu0ttczI+wVvIHGB8WjwS03VGUIYnWBUqa5d0oC3Ga8jd7bXzWrBOoDgVP0v/xf1w+Hv+37qlV3mK5axYnaBrlUe6Ejst6nVAIdRGXTRDbQ4Lg9MnhPsbZtb6gzpvtS/FQR3gOKurNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778757887; c=relaxed/simple;
	bh=7LXFfyIDWzVwBBI/5rBjySPyagqNwaYwXPk5WJDsMZU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=C0WO7HkzJlHsQhM6oDatr4te97ideKzXzQ48pgBa7hNqFXrvtoiXOnzy4KDFWW4m0cTtTiBIdIpKdBNpmJJPx85OlFetMydsc3XwUhd163rwPUGc0meUbbCzkMspBcm8f/uX9gvf+xHNtsgGaqPOpCw1fMXXXHcsmC8ceW1kO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=V3UIM5gf; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="V3UIM5gf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778757886;
	bh=CGBO/uwr94RVIiWx5v2uvC2i4Ni2+wc/TmD0MelzZRU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=V3UIM5gf2Cn5strGHD7Xg8nMcIX3SQeF/Zx1DGzv3myaIcr5jbpat7XU+soU+eX2g
	 6qwkoBVI6NJMkmHT9rWL2spYhiAJId9j4cry5bqSm590fb4OEEhN0ReZmQKWvh4Xo0
	 VZpo3QnSBNKAKXkZktlgKyJihI12H2TVoEqkoZJI=
Received: from github.com (hubbernetes-node-844da97.ash1-iad.github.net [10.56.208.72])
	by smtp.github.com (Postfix) with ESMTPA id EFA28529214
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 04:24:45 -0700 (PDT)
Date: Thu, 14 May 2026 04:24:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1094333/f91af1-000000@github.com>
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

  Branch: refs/heads/1094333
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
